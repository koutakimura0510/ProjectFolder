/*-----------------------------------------------------------------------------
 * Create  2023/07/19
 * Author  kouta kimura
 * -
 * UfibReadWriteTester
 * UFIB の Master I/F を持ち、Read Write 命令を Slave に発行する module
 *-----------------------------------------------------------------------------*/
module UfibReadWriteTester #(
	// variable parameter
	parameter pRamAdrsWidth 	= 18,
	parameter [3:0] pUfiAdrsMap	= 'h01,	// Ufi Block ID
	parameter pUfiDqBusWidth	= 16,	// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている
	parameter pUfiAdrsBusWidth	= 32,
	parameter pReadWrite 		= 1
)(
	// Ufi Bus Master Read
	input	[pUfiDqBusWidth-1:0] 	iMUfiRd,
	input	[pUfiAdrsBusWidth-1:0] 	iMUfiAdrs,
	// Ufi Bus Master Write
	output	[pUfiDqBusWidth-1:0] 	oMUfiWd,
	output	[pUfiAdrsBusWidth-1:0] 	oMUfiAdrs,
	input							iMUfiRdy,
	// CLK Reset
	input iRST,
	input inRST,
	input iCLK
);


//-----------------------------------------------------------------------------
// UFI Bus Bridge
//-----------------------------------------------------------------------------
localparam lpSfcDepth 		= 256;
localparam lpSfcBitWidth 	= 48;

reg  [lpSfcBitWidth-1:0] 	qSfcWd;
reg 						qSfcWe;
wire [lpSfcBitWidth-1:0] 	wSfcRd;
reg  						qSfcRe;
wire 						wSfcFull, wSfcEmp;
wire 						wSfcRvd;

SyncFifoController #(
    .pFifoDepth(lpSfcDepth),
    .pFifoBitWidth(lpSfcBitWidth)
) SyncFifoController (
	// write
    .iWd(qSfcWd),		.iWe(qSfcWe),
    .oFull(wSfcFull),
	// read
    .oRd(wSfcRd),		.iRe(qSfcRe),
    .oRvd(wSfcRvd),		.oEmp(wSfcEmp),
	// common
    .inARST(inRST),		.iCLK(iCLK)
);

assign oMUfiWd			= wSfcRd[15:0];
assign oMUfiAdrs[30:0]	= wSfcRd[46:16];
assign oMUfiAdrs[31]	= wSfcRvd;


//-----------------------------------------------------------------------------
// Burst Counter part
//-----------------------------------------------------------------------------
wire 	wBurstRun;
reg 	qBurstCntCke;

UfibBurstCnt #(
	.pBurstCntNum(32)
) UfibBurstCnt (
	.oBurstRun(wBurstRun),
	.iRST(iRST),
	.iCKE(qBurstCntCke),
	.iCLK(iCLK)
);

//-----------------------------------------------------------------------------
// Pixel Data Generator
//-----------------------------------------------------------------------------
reg [pUfiDqBusWidth-1:0] 	rPdgWd;
reg [pRamAdrsWidth-1:0] 	rPdgWAdrs;
reg 						qPdgCke;

always @(posedge iCLK)
begin
	if (iRST) 			rPdgWd <= {pUfiDqBusWidth{1'b0}};
	else if (qPdgCke)	rPdgWd <= rPdgWd + 1'b1;
	else 				rPdgWd <= rPdgWd;

	if (iRST) 			rPdgWAdrs <= {pRamAdrsWidth{1'b0}};
	else if (qPdgCke)	rPdgWAdrs <= rPdgWAdrs + 1'b1;
	else 				rPdgWAdrs <= rPdgWAdrs;
end

always @*
begin
	qSfcWd[15:0] 	<= rPdgWd;		// Dq
	qSfcWd[39:16] 	<= rPdgWAdrs;	// Adrs
	qSfcWd[43:40] 	<= pUfiAdrsMap;	// Block Id
	qSfcWd[45:44] 	<= 2'b00;		// free
	qSfcWd[46] 		<= pReadWrite[0];	// "0", Write Cmd
	qSfcWd[47] 		<= 1'b0;		// 書き込みデータは、どうせ有効なので 0 にしておく。
	qSfcWe			<= ~wSfcFull;
	//
	qBurstCntCke	<= &{iMUfiRdy,~wSfcEmp};
	//
	qPdgCke			<= ~wSfcFull;

	case ({iMUfiRdy,wSfcEmp,wBurstRun})
		'b101: 		qSfcRe <= 1'b1;
		default: 	qSfcRe <= 1'b0;
	endcase
end


// module UfibReadWriteTester(
// 	// variable parameter
// 	.pBlockConnectNum(),
// 	.pBlockAdrsWidth(),
// 	.pUfiAdrsMap(),
// 	.pUfiDqBusWidth(),
// 	.pUfiAdrsBusWidth()
// 	// Ufi Bus Master Read
// 	.iMUfiRd(),
// 	.iMUfiAdrs(),
// 	// Ufi Bus Master Write
// 	.oMUfiWd(),
// 	.oMUfiAdrs(),
// 	.iMUfiRdy(),
// 	// CLK Reset
// 	.iRST(),
// 	.iCLK()
// );
endmodule