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
	input  [pGpioWidth-1:0] iGpioAltMode,
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
// IO Part
//-----------------------------------------------------------------------------
reg [pGpioWidth-1:0] rGpioR; 		assign oGpioR = rGpioR;

always @(posedge iSCLK)
begin
	rGpioR[0] <= wGpioAltModeCsr[0] ? iGpioAltMode[0] : wGpioOutCtrl[0];
	rGpioR[1] <= wGpioAltModeCsr[1] ? iGpioAltMode[1] : wGpioOutCtrl[1];
	rGpioR[2] <= wGpioAltModeCsr[2] ? iGpioAltMode[2] : wGpioOutCtrl[2];
end

endmodule