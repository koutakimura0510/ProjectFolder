/*-----------------------------------------------------------------------------
 * FM音源参考記事 : https://synth-voice.sakura.ne.jp/synth-voice/html5/voice-lab00.html
 * 
 * 23-04-09 v1.00 : new release
 * 23-08-26 v1.10 : MIDI デコード回路追加
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
	parameter pDmaBurstLength	= 256,
	parameter pMidiChannel		= 2
	// parameter pUfiEnableBit 	= 32,
)(
	// MIPI Input Ctrl
	input  iMIDI,
	// I2S Output Ctrl
	output oI2S_MCLK,
	output oI2S_BCLK,
	output oI2S_LRCLK,
	output oI2S_SDATA,
	// Usi Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0] iSUsiWd,
	input	[pUsiBusWidth-1:0] iSUsiAdrs,
	// Ufi Bus Master Read
	input	[pUfiDqBusWidth-1:0] 	iMUfiRd,
	input	[pUfiAdrsBusWidth-1:0] 	iMUfiAdrs,
	// Ufi Bus Master Write
	output	[(pMidiChannel*pUfiDqBusWidth)-1:0] 	oMUfiWd,
	output	[(pMidiChannel*pUfiAdrsBusWidth)-1:0] 	oMUfiAdrs,
	input	[pMidiChannel-1:0]	iMUfiRdy,
	// CLK Reset
	input  iMRST,
	input  iSRST,
	input  inSRST,
	input  iMCLK,
	input  iSCLK
);


//---------------------------------------------------------------------------
// localparam
//---------------------------------------------------------------------------
localparam lpAudioBitDepth = 16;

genvar x;

//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
wire wI2SModuleRstCsr;
wire wDmaEnableCsr;
wire wDmaCycleEnableCsr;
wire [pDmaAdrsWidth-1:0] wDmaAdrsStartCsr;
wire [pDmaAdrsWidth-1:0] wDmaAdrsEndCsr;
wire [pDmaAdrsWidth-1:0] wDmaAdrsAddCsr;
wire [pMidiChannel-1:0] wDmaDoneCsr;
//
reg  qAudioFreqCsr;
reg  qAudioPlayCsr;
reg  qUartRxThruCsr;
reg [(pMidiChannel*7)-1:0] qOnNoteNumberCsr;

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
	.oDmaEnable(wDmaEnableCsr),
	.oDmaCycleEnable(wDmaCycleEnableCsr),
	.oDmaAdrsStart(wDmaAdrsStartCsr),
	.oDmaAdrsEnd(wDmaAdrsEndCsr),
	.oDmaAdrsAdd(wDmaAdrsAddCsr),
	.iDmaDone(wDmaDoneCsr),
	//
	.iAudioFreq(qAudioFreqCsr),
	.iAudioPlay(qAudioPlayCsr),
	.iUartRxThru(qUartRxThruCsr),
	.iOnNoteNumber(qOnNoteNumberCsr),
    // CLK RST
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// MIDI Decorder
//-----------------------------------------------------------------------------
wire [(pMidiChannel*7)-1:0] wOnNoteNumber;
wire wUartRxThru;
wire [(pMidiChannel * lpAudioBitDepth)-1:0] wAudioFreq;
wire [pMidiChannel-1:0] wAudioPlay;
wire [(pMidiChannel * lpAudioBitDepth)-1:0]	wAudioAmp;

MidiDecodWrapper #(
	.pChannel(pMidiChannel),
	.pAudioBitDepth(lpAudioBitDepth)
) MidiDecodWrapper (
	// Midi Signal
	.iMIDI(iMIDI),
	.oUartRxThru(wUartRxThru),
	.oOnNoteNumber(wOnNoteNumber),
	// Audio
	.oAudioFreq(wAudioFreq),
	.oAudioPlay(wAudioPlay),
	.oAudioAmp(wAudioAmp),
	// common
	.iSRST(iSRST),
	.inSRST(inSRST),
	.iSCLK(iSCLK)
);

always @*
begin
	qAudioFreqCsr <= wAudioFreq[15:0];
	qAudioPlayCsr <= wAudioPlay[0];
	qUartRxThruCsr <= wUartRxThru;
	qUartRxThruCsr <= wOnNoteNumber;
end


//-----------------------------------------------------------------------------
// UFI Audio Data Read
//-----------------------------------------------------------------------------
reg  [31:0] rDmaRdCh [pMidiChannel-1:0];
wire [pUfiDqBusWidth-1:0] wDmaRdCh [pMidiChannel-1:0];
wire [pMidiChannel-1:0] wDmaRvd;
reg  qDmaRe;
reg  qDmaRdChRst;
reg  [6:0] qNotejuge;

generate
	for (x = 0; x < pMidiChannel; x = x + 1)
	begin : SynthUfiDmaChannel
		UfibReadDmaUnit #(
			// variable parameter
			.pDmaAdrsWidth(pDmaAdrsWidth),
			.pUfiDqBusWidth(pUfiDqBusWidth),
			.pUfiAdrsBusWidth(pUfiAdrsBusWidth),
			.pUfiAdrsMap(pUfiAdrsMap + x),
			.pDmaBurstLength(pDmaBurstLength),
			.pDmaReadDataSyncMode("async")
		) UfibReadDmaUnit (
			// Ufi Bus Master Read
			.iMUfiRd(iMUfiRd),		.iMUfiAdrs(iMUfiAdrs),
			// Ufi Bus Master Write
			.oMUfiWd(oMUfiWd[((x+1) * pUfiDqBusWidth)-1 : (x * pUfiDqBusWidth)]),
			.oMUfiAdrs(oMUfiAdrs[((x+1) * pUfiAdrsBusWidth)-1 : (x * pUfiAdrsBusWidth)]),
			.iMUfiRdy(iMUfiRdy[x]),
			// Control / Status
			.iDmaEnable(wAudioPlay[x]),
			.iDmaCycleEnable(wDmaCycleEnableCsr),
			.iDmaAdrsStart(wDmaAdrsStartCsr),
			.iDmaAdrsEnd(wDmaAdrsEndCsr),
			.iDmaAdrsAdd(wAudioFreq[((x+1) * lpAudioBitDepth)-1 : (x * lpAudioBitDepth)]),
			.oDmaDone(wDmaDoneCsr[x]),
			// read data
			.oDmaRd(wDmaRdCh[x]),
			.oDmaRvd(wDmaRvd[x]),
			.iDmaRe(qDmaRe),
			// CLK Reset
			.iRST(iSRST),		.inRST(inSRST),
			.iCLK(iSCLK),		.iACLK(iMCLK)
		);

		always @(posedge iMCLK)
		begin
			if (qDmaRdChRst)		rDmaRdCh[x] <= 32'd32768;
			else if (wDmaRvd[x])	rDmaRdCh[x] <= {16'd0,wDmaRdCh[x]};
			// else if (wDmaRvd[x])	rDmaRdCh[x] <= (wDmaRdCh[x] * wAudioAmp[((x+1)*lpAudioBitDepth)-1:x*lpAudioBitDepth]) >> 8;
			else 					rDmaRdCh[x]	<= rDmaRdCh[x];
		end
	end
endgenerate

wire [31:0] wDmaRdAdd = (rDmaRdCh[0] + rDmaRdCh[1] + rDmaRdCh[2] + rDmaRdCh[3]);

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
	// qAudioData[14:0]	<= 15'd0;
	// qAudioData[30:15] 	<= wAafRd;
	qAudioData[31:0] 	<= {wDmaRdAdd[23:0],8'h00};
	// qAafRe				<= wI2SRdy;
  	qDmaRe				<= wI2SRdy;
	qDmaRdChRst			<= |{iMRST,wI2SRdy};
end


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------



endmodule