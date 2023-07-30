/*-----------------------------------------------------------------------------
 * Create  2023/07/30
 * Author  kouta kimura
 * -
 * UFIB DMA の処理を行う
 *
 * v1.00 new release
 *-----------------------------------------------------------------------------*/
module UfibReadDmaUnit #(
	// variable parameter
	parameter pDmaAdrsWidth 		= 18,
	parameter pUfiActiveAdrsWidth 	= 24,
	parameter [3:0] pUfiAdrsMap		= 'h01,	// Ufi Block ID
	parameter pUfiDqBusWidth		= 16,	// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている
	parameter pUfiAdrsBusWidth		= 32,
	parameter pDmaBurstLength 		= 256,
	//
	parameter pAdrsNullWidth 		= pUfiActiveAdrsWidth - pDmaAdrsWidth
)(
	// Ufi Bus Master Read
	input	[pUfiDqBusWidth-1:0] 	iMUfiRd,
	input	[pUfiAdrsBusWidth-1:0] 	iMUfiAdrs,
	// Ufi Bus Master Write
	output	[pUfiDqBusWidth-1:0] 	oMUfiWd,
	output	[pUfiAdrsBusWidth-1:0] 	oMUfiAdrs,
	input							iMUfiRdy,
	//
	// Control / Status
	input	[pDmaAdrsWidth-1:0]		iDmaAdrsStart,
	input	[pDmaAdrsWidth-1:0]		iDmaAdrsEnd,
	input							iDmaEnable,
	output 							oDmaDone,
	// read data
	output	[pUfiDqBusWidth-1:0]	oDmaRd,
	output 							oDmaRvd,
	input 							iDmaRe,
	// CLK Reset
	input	iRST,
	input	inRST,
	input	iCLK
);


//-----------------------------------------------------------------------------
// UFI Bus Read Data
//-----------------------------------------------------------------------------
localparam lpDdrDepth 		= 256;
localparam lpDdrBitWidth 	= pUfiDqBusWidth;

reg  [lpDdrBitWidth-1:0] 	qDdrWd;
reg 						qDdrWe;
wire [lpDdrBitWidth-1:0] 	wDdrRd;
reg  						qDdrRe;
wire 						wDdrFull, wDdrEmp;
wire 						wDdrRvd;

SyncFifoController #(
    .pFifoDepth(lpDdrDepth),
    .pFifoBitWidth(lpDdrBitWidth)
) DmaDataReceiver (
	// write
    .iWd(qDdrWd),		.iWe(qDdrWe),
    .oFull(wDdrFull),
	// read
    .oRd(wDdrRd),		.iRe(qDdrRe),
    .oRvd(wDdrRvd),		.oEmp(wDdrEmp),
	// common
    .inARST(inRST),		.iCLK(iCLK)
);

always @*
begin
	qDdrWd <= iMUfiRd;
	qDdrWe <= &{iMUfiAdrs[31],(pUfiAdrsMap == iMUfiAdrs[28:25]),~wDdrFull};
	qDdrRe <= &{iDmaRe,~wDdrEmp};
end

assign oDmaRd	= wDdrRd;
assign oDmaRvd	= wDdrRvd;

//-----------------------------------------------------------------------------
// UFI Bus Data Transfer
//-----------------------------------------------------------------------------
localparam lpDdtDepth 		= 256;
localparam lpDdtBitWidth 	= 32;

reg  [lpDdtBitWidth-1:0] 	qDdtWd;
reg 						qDdtWe;
wire [lpDdtBitWidth-1:0] 	wDdtRd;
reg  						qDdtRe;
wire 						wDdtFull, wDdtEmp;
wire 						wDdtRvd;

SyncFifoController #(
    .pFifoDepth(lpDdtDepth),
    .pFifoBitWidth(lpDdtBitWidth)
) DmaDataTransfer (
	// write
    .iWd(qDdtWd),		.iWe(qDdtWe),
    .oFull(wDdtFull),
	// read
    .oRd(wDdtRd),		.iRe(qDdtRe),
    .oRvd(wDdtRvd),		.oEmp(wDdtEmp),
	// common
    .inARST(inRST),		.iCLK(iCLK)
);

assign oMUfiWd			= {pUfiDqBusWidth{1'b0}};
assign oMUfiAdrs[30:0]	= wDdtRd[30:0];
assign oMUfiAdrs[31]	= wDdtRvd;


//-----------------------------------------------------------------------------
// Burst Transfer Counter part, for Fifo Read Adrs Side
// ※バースト転送は UFIB 経由でデータを転送した回数をカウントするので、
// FIFO Read Side のみにカウンターが必要になる。
//-----------------------------------------------------------------------------
wire 	wBurstRun;
reg 	qBurstCntCke;

UfibBurstCnt #(
	.pBurstCntNum(pDmaBurstLength)
) UfibBurstCnt (
	.oBurstRun(wBurstRun),
	.iRST(iRST),
	.iCKE(qBurstCntCke),
	.iCLK(iCLK)
);

always @*
begin
	qBurstCntCke <= &{iMUfiRdy,~wDdtEmp};

	case ({iMUfiRdy,wDdtEmp,wBurstRun})
		'b101: 		qDdtRe <= 1'b1;
		default: 	qDdtRe <= 1'b0;
	endcase
end

//-----------------------------------------------------------------------------
// Burst Transfer Adrs Gen part, for Fifo Write Side
//-----------------------------------------------------------------------------
// DMA Adrs
reg [pDmaAdrsWidth-1:0] rDmaAdrs;
reg	qDmaAdrsRst, qDmaAdrsCke;
// DMA RUN
reg 		rDmaRun, 		qDmaRunCke;
reg [1:0] 	rDmaLatency;
reg 		rDmaLatencyRst;
reg 		rDmaDone;						assign oDmaDone = rDmaDone;
reg 		qDmaDoneCke;

always @(posedge iCLK)
begin
	if (iRST)				rDmaRun <=  1'b0;
	else if (qDmaRunCke)	rDmaRun <= ~rDmaRun;
	else 					rDmaRun <=  rDmaRun;

	if (qDmaAdrsRst)		rDmaAdrs <= iDmaAdrsStart;
	else if (qDmaAdrsCke)	rDmaAdrs <= rDmaAdrs + 1'b1;
	else 					rDmaAdrs <= rDmaAdrs;

	if (rDmaLatencyRst)		rDmaLatency <= 2'b00;
	else if (iDmaEnable)	rDmaLatency <= rDmaLatency + 1'b1;
	else 					rDmaLatency <= rDmaLatency;

	if (iRST)				rDmaDone <= 1'b0;
	else if (qDmaDoneCke)	rDmaDone <= 1'b1;
	else 					rDmaDone <= 1'b0;
end

always @*
begin
	qDmaAdrsRst 	<= ~rDmaRun;
	rDmaLatencyRst 	<=  rDmaRun;
	qDmaDoneCke 	<= (iDmaAdrsEnd == rDmaAdrs);
	qDmaAdrsCke		<= &{~wDdtFull,rDmaRun};

	casex ({rDmaLatency[1:0],rDmaRun,wDdtFull,qDmaDoneCke})
		'b110xx:	qDmaRunCke <= 1'b1;
		'bxx101:	qDmaRunCke <= 1'b1;
		default: 	qDmaRunCke <= 1'b0;
	endcase

	qDdtWd[24:0]	<= {{pAdrsNullWidth{1'b0}},rDmaAdrs};
	qDdtWd[28:25] 	<= pUfiAdrsMap;	// Block Id
	qDdtWd[29] 		<= 1'b0;		// Null
	qDdtWd[30] 		<= 1'b1;		// RW Cmd
	qDdtWe			<= &{~wDdtFull,rDmaRun};
end

// module UfibDmaUnit(
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