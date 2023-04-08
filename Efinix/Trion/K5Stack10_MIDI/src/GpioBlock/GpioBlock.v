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
	// GPIO Output Port
	output [pGpioWidth-1:0] oGpio,
	// GPIO Alt Mode
	input  iLocked,
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
wire [pGpioWidth-1:0] wGpioEnCsr;
wire [pGpioWidth-1:0] wGpioAltModeCsr;

GpioCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pGpioWidth(pGpioWidth)
) GPIO_CSR (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// CSR
	.oGpioEn(wGpioEnCsr),	.oGpioFlashMode(wGpioAltModeCsr),
    // CLK RST
	.iSRST(iSRST),			.iSCLK(iSCLK),
);


//----------------------------------------------------------
// GPIO 制御
//----------------------------------------------------------
genvar x;
reg [pGpioWidth-1:0] rGpio; 		assign oGpio = rGpio;

always @(posedge iSCLK)
begin
	rGpio[0]  <= wGpioAltModeCsr[0]  ? iLocked : wGpioEnCsr[0];
	rGpio[1]  <= wGpioAltModeCsr[1]  ? 1'b0 : wGpioEnCsr[1];
	rGpio[2]  <= wGpioAltModeCsr[2]  ? 1'b0 : wGpioEnCsr[2];
	rGpio[3]  <= wGpioAltModeCsr[3]  ? 1'b0 : wGpioEnCsr[3];
	rGpio[4]  <= wGpioAltModeCsr[4]  ? 1'b0 : wGpioEnCsr[4];
	rGpio[5]  <= wGpioAltModeCsr[5]  ? 1'b0 : wGpioEnCsr[5];
	rGpio[6]  <= wGpioAltModeCsr[6]  ? 1'b0 : wGpioEnCsr[6];
	rGpio[7]  <= wGpioAltModeCsr[7]  ? 1'b0 : wGpioEnCsr[7];
	rGpio[8]  <= wGpioAltModeCsr[8]  ? 1'b0 : wGpioEnCsr[8];
	rGpio[9]  <= wGpioAltModeCsr[9]  ? 1'b0 : wGpioEnCsr[9];
	rGpio[10] <= wGpioAltModeCsr[10] ? 1'b0 : wGpioEnCsr[10];
	rGpio[11] <= wGpioAltModeCsr[11] ? 1'b0 : wGpioEnCsr[11];
	rGpio[12] <= wGpioAltModeCsr[12] ? 1'b0 : wGpioEnCsr[12];
	rGpio[13] <= wGpioAltModeCsr[13] ? 1'b0 : wGpioEnCsr[13];
	rGpio[14] <= wGpioAltModeCsr[14] ? 1'b0 : wGpioEnCsr[14];
	rGpio[15] <= wGpioAltModeCsr[15] ? 1'b0 : wGpioEnCsr[15];
end

endmodule