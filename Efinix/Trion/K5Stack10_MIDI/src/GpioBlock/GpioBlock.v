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


//----------------------------------------------------------
// GPIO 制御
//----------------------------------------------------------
genvar x;
reg [pGpioWidth-1:0] rGpioR; 		assign oGpioR = rGpioR;

always @(posedge iSCLK)
begin
	rGpioR[0]  <= wGpioAltModeCsr[0]  ? 1'b0 : wGpioOutCtrl[0];
	rGpioR[1]  <= wGpioAltModeCsr[1]  ? 1'b0 : wGpioOutCtrl[1];
	rGpioR[2]  <= wGpioAltModeCsr[2]  ? 1'b0 : wGpioOutCtrl[2];
	rGpioR[3]  <= wGpioAltModeCsr[3]  ? 1'b0 : wGpioOutCtrl[3];
	rGpioR[4]  <= wGpioAltModeCsr[4]  ? 1'b0 : wGpioOutCtrl[4];
	rGpioR[5]  <= wGpioAltModeCsr[5]  ? 1'b0 : wGpioOutCtrl[5];
	rGpioR[6]  <= wGpioAltModeCsr[6]  ? 1'b0 : wGpioOutCtrl[6];
	rGpioR[7]  <= wGpioAltModeCsr[7]  ? 1'b0 : wGpioOutCtrl[7];
	rGpioR[8]  <= wGpioAltModeCsr[8]  ? 1'b0 : wGpioOutCtrl[8];
	rGpioR[9]  <= wGpioAltModeCsr[9]  ? 1'b0 : wGpioOutCtrl[9];
	rGpioR[10] <= wGpioAltModeCsr[10] ? 1'b0 : wGpioOutCtrl[10];
	rGpioR[11] <= wGpioAltModeCsr[11] ? 1'b0 : wGpioOutCtrl[11];
	rGpioR[12] <= wGpioAltModeCsr[12] ? 1'b0 : wGpioOutCtrl[12];
	rGpioR[13] <= wGpioAltModeCsr[13] ? 1'b0 : wGpioOutCtrl[13];
	rGpioR[14] <= wGpioAltModeCsr[14] ? iLocked : wGpioOutCtrl[14];
	rGpioR[15] <= wGpioAltModeCsr[15] ? 1'b0 : wGpioOutCtrl[15];
	rGpioR[16] <= wGpioAltModeCsr[16] ? 1'b0 : wGpioOutCtrl[16];
	rGpioR[17] <= wGpioAltModeCsr[17] ? 1'b0 : wGpioOutCtrl[17];
end

endmodule