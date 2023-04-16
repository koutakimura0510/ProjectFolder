//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// 汎用 GPIO の制御を司るブロック
// 2023/04/08 V1.1 USIBの更新版に対応
//----------------------------------------------------------
module GpioBlock #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8,
	parameter pGpioWidth = 16
)(
	// GPIO Output Ctrl
	output [pGpioWidth-1:0] oGpioR,
	output [pGpioWidth-1:0] oGpioDir,
	// GPIO Alt Mode Signal
	input  iLocked,
	// GPIO Input
	input  [pGpioWidth-1:0] iGpioIn,
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
    // CLK Reset
    input  iSCLK,
    input  iSRST
);

//----------------------------------------------------------
// Csr Space
//----------------------------------------------------------
wire [pGpioWidth-1:0] wGpioOutCtrl;
wire [pGpioWidth-1:0] wGpioDir;				assign oGpioDir = wGpioDir;
wire [pGpioWidth-1:0] wGpioAltModeCsr;

GpioCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pGpioWidth(pGpioWidth)
) GpioCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// CSR
	.oGpioOutCtrl(wGpioOutCtrl),
	.oGpioDir(wGpioDir),	.oGpioAltMode(wGpioAltModeCsr),
	.iGpioIn(iGpioIn),
    // CLK RST
	.iSRST(iSRST),			.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// LED Toggle
//-----------------------------------------------------------------------------
localparam lpCntMax = 100000000-1;

reg [27:0] rCnt;
reg rLed;

always @(posedge iSCLK)
begin
	if (iSRST) 					rCnt <= 0;
	else if (lpCntMax==rCnt) 	rCnt <= 0;
	else 						rCnt <= rCnt + 1'b1;

	if (iSRST) 					rLed <= 0;
	else if (lpCntMax==rCnt) 	rLed <= ~rLed;
	else 						rLed <= rLed;
end


//-----------------------------------------------------------------------------
// IO Part
//-----------------------------------------------------------------------------
genvar x;
reg [pGpioWidth-1:0] rGpioR; 		assign oGpioR = rGpioR;

always @(posedge iSCLK)
begin
	rGpioR[0] <= wGpioAltModeCsr[0] ? iLocked : wGpioOutCtrl[0];
	rGpioR[1] <= wGpioAltModeCsr[1] ? rLed : wGpioOutCtrl[1];
	rGpioR[2] <= wGpioAltModeCsr[2] ? rLed : wGpioOutCtrl[2];
end

endmodule