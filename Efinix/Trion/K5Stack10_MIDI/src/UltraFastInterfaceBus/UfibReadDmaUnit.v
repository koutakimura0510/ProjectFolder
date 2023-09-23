/*-----------------------------------------------------------------------------
 * Create  2023/07/30
 * Author  kouta kimura
 * -
 * UFIB DMA の処理を行う
 * 読み込みアドレスの開始と終了を指定して Enable にする。
 * アドレスを +1 ずつインクリメントしながら RAM に命令を発行する。
 * Auto 機能が Enable であれば、アドレスの範囲でサイクル動作を行う。
 *
 * v1.00 new release
 * v1.01 iDmaAdrsAdd 追加
 *-----------------------------------------------------------------------------*/
module UfibReadDmaUnit #(
	// variable parameter
	parameter pUfiDqBusWidth		= 16,	// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている
	parameter pUfiAdrsBusWidth		= 32,
	parameter pUfiActiveAdrsWidth 	= 24,
	parameter [3:0] pUfiAdrsMap		= 'h01,	// Ufi Block ID
	parameter pDmaAdrsWidth 		= 18,
	parameter pDmaBurstLength 		= 256,
	parameter pDmaReadDataSyncMode	= "sync",	// async or sync
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
	input							iDmaEnable,		// Enable 後は、DmaDone が Assertされるまで、"H" を維持しなければならない
	input							iDmaCycleEnable,
	input	[pDmaAdrsWidth-1:0]		iDmaAdrsStart,
	input	[pDmaAdrsWidth-1:0]		iDmaAdrsEnd,
	input   [pDmaAdrsWidth-1:0]		iDmaAdrsAdd,
	output 							oDmaDone,
	// read data
	output	[pUfiDqBusWidth-1:0]	oDmaRd,
	output	[pDmaAdrsWidth-1:0]		oDmaRa,
	output 							oDmaRvd,
	input 							iDmaRe,
	// CLK Reset
	input	iRST,
	input	inRST,
	input	iCLK,
	input	iACLK
);


//-----------------------------------------------------------------------------
// UFI Bus Read Data
//-----------------------------------------------------------------------------
localparam lpDdrDepth 			= 256;
localparam lpDdrBitWidth 		= pUfiDqBusWidth + pUfiAdrsBusWidth;

reg  [lpDdrBitWidth-1:0] 		qDdrWd;
reg 							qDdrWe;
wire [lpDdrBitWidth-1:0] 		wDdrRd;
reg  							qDdrRe;
wire 							wDdrFull, wDdrEmp;
wire 							wDdrRvd;
wire 							wDdrRemaingCntAlert;

generate
if (pDmaReadDataSyncMode == "sync")
begin : SyncDmaDataReceiver
	SyncFifoController #(
		.pFifoDepth(lpDdrDepth),
		.pFifoBitWidth(lpDdrBitWidth)
	) DmaDataReceiver (
		// write
		.iWd(qDdrWd),		.iWe(qDdrWe),
		.oFull(wDdrFull),
		.oRemaingCntAlert(wDdrRemaingCntAlert),
		// read
		.oRd(wDdrRd),		.iRe(qDdrRe),
		.oRvd(wDdrRvd),		.oEmp(wDdrEmp),
		// common
		.inARST(inRST),		.iCLK(iCLK)
	);
end
else
begin : ASyncDmaDataReceiver
	ASyncFifoController #(
		.pFifoDepth(lpDdrDepth),
		.pFifoBitWidth(lpDdrBitWidth)
	) DmaDataReceiver (
		// write
		.iWd(qDdrWd),		.iWe(qDdrWe),
		.oFull(wDdrFull),
		.oRemaingCntAlert(wDdrRemaingCntAlert),
		// read
		.oRd(wDdrRd),		.iRe(qDdrRe),
		.oRvd(wDdrRvd),		.oEmp(wDdrEmp),
		// common
		.inARST(inRST),
		.iRCLK(iACLK),
		.iWCLK(iCLK)
	);
end
endgenerate

always @*
begin
	qDdrWd <=  {iMUfiAdrs,iMUfiRd};
	qDdrWe <= &{iMUfiAdrs[31],(pUfiAdrsMap == iMUfiAdrs[28:25]),~wDdrFull};
	qDdrRe <= &{iDmaRe,~wDdrEmp};
end

assign oDmaRd	= wDdrRd[pUfiDqBusWidth-1:0];
assign oDmaRa	= wDdrRd[pUfiAdrsBusWidth-1:pUfiDqBusWidth];
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
	.oRemaingCntAlert(),
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
// ※UFIB 経由でバースト転送した回数をカウント
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

	case ({iMUfiRdy,wDdtEmp,wBurstRun,wDdrRemaingCntAlert})
		'b1010: 	qDdtRe <= 1'b1;
		default: 	qDdtRe <= 1'b0;
	endcase
end

//-----------------------------------------------------------------------------
// Burst Transfer Adrs Gen part, for Fifo Write Side
//-----------------------------------------------------------------------------
// DMA Adrs
reg [pDmaAdrsWidth-1:0] rDmaAdrs;
reg [pDmaAdrsWidth-1:0] rDmaAdrsEnd;
reg [pDmaAdrsWidth-1:0] rDmaAdrsCycleOver;
reg	qDmaAdrsRst, qDmaAdrsCke;
// DMA RUN
reg 		rDmaRun, 		qDmaRunCke;
reg [1:0] 	rDmaLatency;
reg 		qDmaLatencyRst;
reg 		rDmaDone;						assign oDmaDone = rDmaDone;
reg 		qDmaDoneCke;
reg 		qDmaAdrsOverCke;

always @(posedge iCLK)
begin
	if (iRST)				rDmaRun <=  1'b0;
	else if (qDmaRunCke)	rDmaRun <= ~rDmaRun;	// 1サイクルの DMA 動作通知
	else 					rDmaRun <=  rDmaRun;

	if (qDmaAdrsRst)		rDmaAdrs <= iDmaAdrsStart + rDmaAdrsCycleOver;
	else if (qDmaAdrsCke)	rDmaAdrs <= rDmaAdrs + iDmaAdrsAdd;
	else 					rDmaAdrs <= rDmaAdrs;

	if (qDmaAdrsRst)		rDmaAdrsEnd <= iDmaAdrsEnd;
	else 					rDmaAdrsEnd <= rDmaAdrsEnd;

	if (qDmaLatencyRst)		rDmaLatency <= 2'b00;
	else if (iDmaEnable)	rDmaLatency <= rDmaLatency + 1'b1;
	else 					rDmaLatency <= rDmaLatency;

	if (iRST)				rDmaDone <= 1'b0;
	else if (qDmaDoneCke)	rDmaDone <= 1'b1;	// 1サイクルの DMA 終了通知
	else 					rDmaDone <= 1'b0;

	if (iRST) 					rDmaAdrsCycleOver <= {pDmaAdrsWidth{1'b0}};		// サイクル動作 かつ アドレス増加がオーバーラップするとき
	else if (qDmaAdrsOverCke)	rDmaAdrsCycleOver <= rDmaAdrs - rDmaAdrsEnd;	// End の数値をオーバーした分だけ、次サイクルの Start アドレスとする。
	else 						rDmaAdrsCycleOver <= rDmaAdrsCycleOver;			// 例：アドレスEnd 255, Add = 6 のときなど 258 - 255 = 3 から開始する
end

always @*
begin
	qDmaAdrsRst 	<= ~rDmaRun;
	qDmaLatencyRst 	<= |{iRST,rDmaRun};
	qDmaDoneCke 	<=  (rDmaAdrsEnd <= rDmaAdrs);
	qDmaAdrsCke		<= &{~wDdtFull,rDmaRun,~qDmaDoneCke};
	qDmaAdrsOverCke	<= &{qDmaDoneCke,iDmaCycleEnable};

	casex ({rDmaLatency[1:0],rDmaRun,wDdtFull,qDmaDoneCke})
		'b110xx:	qDmaRunCke <= 1'b1;
		'bxx101:	qDmaRunCke <= 1'b1;
		default: 	qDmaRunCke <= 1'b0;
	endcase

	qDdtWd[24:0]	<= {{pAdrsNullWidth{1'b0}},rDmaAdrs};
	qDdtWd[28:25] 	<= pUfiAdrsMap;	// Block Id
	qDdtWd[29] 		<= 1'b0;		// Null
	qDdtWd[30] 		<= 1'b1;		// RW Cmd
	qDdtWe			<= &{~wDdtFull,rDmaRun,~qDmaDoneCke};
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

//-----------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction
endmodule