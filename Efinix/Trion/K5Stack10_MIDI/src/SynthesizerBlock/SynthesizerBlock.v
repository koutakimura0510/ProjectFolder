/*-----------------------------------------------------------------------------
 * Create  2023/4/9
 * Author  kouta kimura
 * -
 * V1.0 : new Relaese
 * 
 *-----------------------------------------------------------------------------*/
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
	// Control Status data
	output [7:0] oMidiRd,  // デバッグ用途に外部出力しておく
	output oMidiVd,      // ;;
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
  .iSUsiWd(iSUsiWd),    .iSUsiAdrs(iSUsiAdrs),
    // CLK RST
  .iSRST(iSRST),      .iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// MIDI Decorder
//-----------------------------------------------------------------------------
wire [7:0] wMidiRd;   assign oMidiRd = wMidiRd;
wire wMidiVd;         assign oMidiVd = wMidiVd;

UartRX #(
  .pBaudRateGenDiv(3200)
) UartRX (
  // External Port
  .iUartRX(iMIDI),
  // Decord Data
  .oRd(wMidiRd),  .oVd(wMidiVd),
  // CLK RST
  .iRST(iSRST),  .iCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Synthesizer
//-----------------------------------------------------------------------------
// SynthesizerUnit


//-----------------------------------------------------------------------------
// Sound Generator
//-----------------------------------------------------------------------------
// wire 
// reg qSawCke;

// SawGen #(
//   .pAudioBitWidth(),
//   .pDivBitWidth()
// ) SawGen (
//   .oSaw(),
//   .iCke(qSawCke),
//   .iDiv(),
//   // CLK, RST
//   .iRST(iMRST),
//   .iCLK(iMCLK)
// );


//-----------------------------------------------------------------------------
// I2S Encorder
//-----------------------------------------------------------------------------
wire wI2SRdy;

I2SSignalGen I2SSignalGen(
  // I2S Output Ctrl
  .oI2S_MCLK(oI2S_MCLK),    .oI2S_BCLK(oI2S_BCLK),
  .oI2S_LRCLK(oI2S_LRCLK),  .oI2S_SDATA(oI2S_SDATA),
  // Control and Data
  .iAudioData('h8000_0002),  .oAudioDataRdy(wI2SRdy),
  // CLK RST
  .iMRST(iMRST),  .iMCLK(iMCLK)
);

// always @*
// begin
//   qSawCke <= wI2SRdy;
// end

//-----------------------------------------------------------------------------
// RST Gen
// 異なるクロックドメインのクロック切り替え用途
//-----------------------------------------------------------------------------
// reg [1:0] rI2SModuleRst;

// always @(posedge iMCLK)
// begin
//   if (iMRST)   rI2SModuleRst <= 2'b11;
//   else     rI2SModuleRst <= {rI2SModuleRst[0],wI2SModuleRst};
// end
// always @*
// begin
  
// end

endmodule