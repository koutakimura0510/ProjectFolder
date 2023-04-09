//----------------------------------------------------------
// Create 2023/4/9
// Author koutakimura
// -
// V1.0 : new Relaese I2S の制御を司る
// 
//----------------------------------------------------------
module I2SBlock #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8
)(
	// I2S Output Ctrl
	output oI2S_MCLK,
	output oI2S_BCLK,
	output oI2S_LRCLK,
	output oI2S_SDATA,
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
    // CLK Reset
	input  iMRST,
    input  iSRST,
	input  iMCLK,
    input  iSCLK
);

//----------------------------------------------------------
// Csr Space
//----------------------------------------------------------
// wire [pGpioWidth-1:0] wGpioOutCtrl;
// wire [pGpioWidth-1:0] wGpioDir;				assign oGpioDir = wGpioDir;
// wire [pGpioWidth-1:0] wGpioAltModeCsr;

// I2SCsr #(
// 	.pBlockAdrsWidth(pBlockAdrsWidth),
// 	.pAdrsMap(pAdrsMap),
// 	.pUsiBusWidth(pUsiBusWidth),
// 	.pCsrAdrsWidth(pCsrAdrsWidth),
// 	.pCsrActiveWidth(pCsrActiveWidth),
// 	.pGpioWidth(pGpioWidth)
// ) I2SCsr (
// 	// CSR
// 	.oGpioOutCtrl(wGpioOutCtrl),
// 	.oGpioDir(wGpioDir),	.oGpioAltMode(wGpioAltModeCsr),
// 	.iGpioIn(iGpioIn),
// 	// Bus Master Read
// 	.oSUsiRd(oSUsiRd),
// 	// Bus Master Write
// 	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
//     // CLK RST
// 	.iSRST(iSRST),			.iSCLK(iSCLK)
// );

I2SSignalGen I2SSignalGen(
	// I2S Output Ctrl
	.oI2S_MCLK(oI2S_MCLK),		.oI2S_BCLK(oI2S_BCLK),
	.oI2S_LRCLK(oI2S_LRCLK),	.oI2S_SDATA(oI2S_SDATA),
	// Control and Data
	.iAudioData(),	.oAudioDataRdy(),
	// CLK RST
	.iMRST(iMRST),	.iSRST(iSRST),
	.iMCLK(iMCLK),	.iSCLK(iSCLK)
);

endmodule