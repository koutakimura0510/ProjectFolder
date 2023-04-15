//-----------------------------------------------------------------------------
// Create 2023/4/9
// Author koutakimura
// -
// V1.0 : new Relaese I2S の制御を司る
// 
//-----------------------------------------------------------------------------
module SynthesizerBlock #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8
)(
	// MIPI Input Ctrl
	input  iMIDI,
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

//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
wire wI2SModuleRst;

SynthesizerCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth)
) SynthesizerCsr (
	// CSR
	.oI2SModuleRst(wI2SModuleRst),
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
    // CLK RST
	.iSRST(iSRST),			.iSCLK(iSCLK)
);

// synthesizer

I2SSignalGen I2SSignalGen(
	// I2S Output Ctrl
	.oI2S_MCLK(oI2S_MCLK),		.oI2S_BCLK(oI2S_BCLK),
	.oI2S_LRCLK(oI2S_LRCLK),	.oI2S_SDATA(oI2S_SDATA),
	// Control and Data
	.iAudioData(32),	.oAudioDataRdy(),
	// CLK RST
	.iMRST(iMRST),	.iSRST(iSRST),
	.iMCLK(iMCLK),	.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// RST Gen
// 異なるクロックドメインのクロック切り替え用途
//-----------------------------------------------------------------------------
always @(posedge iCLK)
begin
	if (iRST) Q <= D;
	else Q <= D;
end
always @*
begin
	
end

endmodule