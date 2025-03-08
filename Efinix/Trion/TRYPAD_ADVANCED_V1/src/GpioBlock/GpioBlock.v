/*-----------------------------------------------------------------------------
 * GPIO の制御を司るブロック
 * 
 * 23-04-08 v1.00 : New Release
 * 23-09-29 v1.01 : I2C Slave 機能追加
 *-----------------------------------------------------------------------------*/
module GpioBlock #(
	parameter pBlockAdrsWidth 					= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap	= 'h01,
	parameter pUsiBusWidth						= 32,
	parameter pCsrAdrsWidth						= 8,
	parameter pCsrActiveWidth					= 8,
	parameter pGpioWidth						= 16,
	parameter pExtSwNum							= 7
)(
	// GPIO Output Ctrl
	output	[pGpioWidth-1:0] 	oGpio,
	output	[pGpioWidth-1:0] 	oGpioDir,
	// GPIO Alt Mode Signal
	input	[pGpioWidth-1:0] 	iGpioAltMode,
	// GPIO Input
	input	[pGpioWidth-1:0] 	iGpioIn,
	// User I/F
	input	[pExtSwNum-1:0]		iPushSw,
	output	[pExtSwNum-1:0]		oEdgeSw,
	output	[pExtSwNum-1:0]		oLongSw,
	//
	input						iPllLock,
	// Bus Master Read
	output	[pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	input	[pUsiBusWidth-1:0] 	iSUsiWd,
	input	[pUsiBusWidth-1:0] 	iSUsiAdrs,
    // CLK Reset
    input	iSCLK,
    input	iSRST
);

//----------------------------------------------------------
// Csr Space
//----------------------------------------------------------
wire [pGpioWidth-1:0] 	wGpioOutCtrl;
wire [pGpioWidth-1:0] 	wGpioDir;				assign oGpioDir = wGpioDir;
wire [pGpioWidth-1:0] 	wGpioAltModeCsr;
reg  [pExtSwNum-1:0]	qEdgeSwCsr,		qLongSwCsr;

GpioCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pGpioWidth(pGpioWidth),
	.pExtSwNum(pExtSwNum)
) GpioCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),				.iSUsiAdrs(iSUsiAdrs),
	// control / Status
	.oGpioOutCtrl(wGpioOutCtrl),
	.oGpioDir(wGpioDir),			.oGpioAltMode(wGpioAltModeCsr),		.iGpioIn(iGpioIn),
	.iPushSw(iPushSw),				.iEdgeSw(qEdgeSwCsr),				.iLongSw(qLongSwCsr),
	.iPllLock(iPllLock),
    // CLK RST
	.iSRST(iSRST),					.iSCLK(iSCLK)
);


/**----------------------------------------------------------------------------
 * Get Sw チャタリング除去
 *---------------------------------------------------------------------------*/
localparam [15:0] 	lpSampCntMax	= 99999;		// 1ms

wire [pExtSwNum-1:0] wEdgeSw;				assign oEdgeSw = wEdgeSw;
wire [pExtSwNum-1:0] wLongSw;				assign oLongSw = wLongSw;

GetSw #(
	.pSampCntMax(lpSampCntMax),
	.pExtSwNum(pExtSwNum)
) GetSw (
	// Control / Status
	.iPushSw(iPushSw),
	.oEdgeSw(wEdgeSw),
	.oLongSw(wLongSw),
	// common
	.iRST(iSRST),	.iCLK(iSCLK)
);

always @*
begin
	qEdgeSwCsr <= wEdgeSw;
	qLongSwCsr <= wLongSw;
end

//-----------------------------------------------------------------------------
// I/O Part
//-----------------------------------------------------------------------------
genvar gpioX;
wire [pGpioWidth-1:0] wGpio; 		assign oGpio = wGpio;

generate
	for (gpioX = 0; gpioX < pGpioWidth; gpioX = gpioX + 1)
	begin
		// I/O のレジスタ出力機能を使用するため、ロジック削減のためにFFは使用しない。
		assign wGpio[gpioX] = wGpioAltModeCsr[gpioX] ? iGpioAltMode[gpioX] : wGpioOutCtrl[gpioX];
	end
endgenerate

endmodule