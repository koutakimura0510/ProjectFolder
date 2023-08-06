/*-----------------------------------------------------------------------------
 * Create  2023/4/9
 * Author  kouta kimura
 * -
 * V1.0 : new Relaese
 * 
 *-----------------------------------------------------------------------------*/
module SynthesizerBlock #(
	// USI
  	parameter pBlockAdrsWidth = 8,
  	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
  	parameter pUsiBusWidth = 32,
  	parameter pCsrAdrsWidth = 8,
  	parameter pCsrActiveWidth = 8,
  	// UFI
	parameter pUfiDqBusWidth 	= 16,
	parameter pUfiAdrsBusWidth	= 32,
	parameter [3:0] pUfiAdrsMap	= 'h1,
	parameter pDmaAdrsWidth		= 18,
	parameter pDmaBurstLength	= 256
	// parameter pUfiEnableBit 	= 32,
)(
	// MIPI Input Ctrl
	input  iMIDI,
	// I2S Output Ctrl
	output oI2S_MCLK,
	output oI2S_BCLK,
	output oI2S_LRCLK,
	output oI2S_SDATA,
	// Control Status data
	output [7:0] oMidiRd,	// デバッグ用途に外部出力しておく
	output oMidiVd,			//
	// Usi Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0] iSUsiWd,
	input	[pUsiBusWidth-1:0] iSUsiAdrs,
	// Ufi Bus Master Read
	input	[pUfiDqBusWidth-1:0] 	iMUfiRd,
	input	[pUfiAdrsBusWidth-1:0] 	iMUfiAdrs,
	// Ufi Bus Master Write
	output	[pUfiDqBusWidth-1:0] 	oMUfiWd,
	output	[pUfiAdrsBusWidth-1:0] 	oMUfiAdrs,
	input	iMUfiRdy,
	// CLK Reset
	input  iMRST,
	input  iSRST,
	input  inSRST,
	input  iMCLK,
	input  iSCLK
);

//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
wire wI2SModuleRstCsr;
wire [pDmaAdrsWidth-1:0] wDmaAdrsStartCsr;
wire [pDmaAdrsWidth-1:0] wDmaAdrsEndCsr;
wire wDmaEnableCsr;
wire wDmaDoneCsr;

SynthesizerCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pDmaAdrsWidth(pDmaAdrsWidth)
) SynthesizerCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// CSR
	.oI2SModuleRst(wI2SModuleRstCsr),
	.oDmaAdrsStart(wDmaAdrsStartCsr),
	.oDmaAdrsEnd(wDmaAdrsEndCsr),
	.oDmaEnable(wDmaEnableCsr),
	.iDmaDone(wDmaDoneCsr),
    // CLK RST
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// UFI Audio Data Read
//-----------------------------------------------------------------------------
wire [pUfiDqBusWidth-1:0] wDmaRd;
wire wDmaRvd;
reg  qDmaRe;

UfibReadDmaUnit #(
	// variable parameter
	.pDmaAdrsWidth(pDmaAdrsWidth),
	.pUfiDqBusWidth(pUfiDqBusWidth),
	.pUfiAdrsBusWidth(pUfiAdrsBusWidth),
	.pUfiAdrsMap(pUfiAdrsMap),
	.pDmaBurstLength(pDmaBurstLength),
	.pDmaReadDataSyncMode("async")
) UfibReadDmaUnit (
	// Ufi Bus Master Read
	.iMUfiRd(iMUfiRd),
	.iMUfiAdrs(iMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(oMUfiWd),
	.oMUfiAdrs(oMUfiAdrs),
	.iMUfiRdy(iMUfiRdy),
	// Control / Status
	.iDmaAdrsStart(wDmaAdrsStartCsr),
	.iDmaAdrsEnd(wDmaAdrsEndCsr),
	.iDmaEnable(wDmaEnableCsr),
	.oDmaDone(wDmaDoneCsr),
	// read data
	.oDmaRd(wDmaRd),
	.oDmaRvd(wDmaRvd),
	.iDmaRe(qDmaRe),
	// CLK Reset
	.iRST(iSRST),
	.inRST(inSRST),
	.iCLK(iSCLK),
	.iACLK(iMCLK)
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
	.oRd(wMidiRd),	.oVd(wMidiVd),
	// CLK RST
	.iRST(iSRST),	.iCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// I2S Encorder
//-----------------------------------------------------------------------------
reg  [31:0] qAudioData;
wire wI2SRdy;

I2SSignalGen I2SSignalGen(
	// I2S Output Ctrl
	.oI2S_MCLK(oI2S_MCLK),
	.oI2S_BCLK(oI2S_BCLK),
	.oI2S_LRCLK(oI2S_LRCLK),
	.oI2S_SDATA(oI2S_SDATA),
	// Control and Data
	.iAudioData(qAudioData),
	.oAudioDataRdy(wI2SRdy),
	// CLK RST
	.iMRST(iMRST),	.iMCLK(iMCLK)
);

always @*
begin
	qAudioData[14:0]	<= 15'd0;
	qAudioData[30:15] 	<= wDmaRd;
	qAudioData[31]		<= 1'b0;
  	qDmaRe 				<= wI2SRdy;
end

//-----------------------------------------------------------------------------
// RST Gen
// 異なるクロックドメインのクロック切り替え用途
//-----------------------------------------------------------------------------
// reg [1:0] rI2SModuleRst;

// always @(posedge iMCLK)
// begin
//   if (iMRST)   rI2SModuleRst <= 2'b11;
//   else     rI2SModuleRst <= {rI2SModuleRst[0],wI2SModuleRstCsr};
// end
// always @*
// begin
  
// end

endmodule