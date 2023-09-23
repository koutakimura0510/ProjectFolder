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
wire [7:0] wAudioAmpCh1Csr;
wire [7:0] wAudioAmpCh2Csr;
wire [7:0] wAudioAmpCh3Csr;
wire [7:0] wAudioAmpCh4Csr;
//
reg [pMidiChannel-1:0]		qAudioPlayCsr;
reg [(pMidiChannel*7)-1:0] 	qOnNoteNumberCsr;

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
	.oAudioAmpCh1(wAudioAmpCh1Csr),
	.oAudioAmpCh2(wAudioAmpCh2Csr),
	.oAudioAmpCh3(wAudioAmpCh3Csr),
	.oAudioAmpCh4(wAudioAmpCh4Csr),
	//
	.iAudioPlay(qAudioPlayCsr),
	.iOnNoteNumber(qOnNoteNumberCsr),
    // CLK RST
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Uart RX
// MIDI は UART 31.25kbps で受信する。電流が流れるとき論理"0"なので、
// 反転出力のフォトカプラを使用するか、FPGA側で論理を反転して使用する。
//-----------------------------------------------------------------------------
reg  		qUartRx;
wire [7:0] 	wMidiRd;
wire 		wMidiVd;

UartRX #(
	.pBaudRateGenDiv(1600)
) MidiRx (
	// External Port
	.iUartRX(qUartRx),
	// Decord Data
	.oUartRxThru(),
	.oRd(wMidiRd),	.oVd(wMidiVd),
	// CLK RST
	.iRST(iSRST),	.iCLK(iSCLK)
);

always @*
begin
	qUartRx <= ~iMIDI;
end


//-----------------------------------------------------------------------------
// MIDI Decorder
//-----------------------------------------------------------------------------
wire [(pMidiChannel * lpAudioBitDepth)-1:0] wMauAudioFreq;
wire [pMidiChannel-1:0] wMauAudioPlay;

MidiAudioUnit #(
	.pChannel(pChannel),
	.pAudioBitDepth(pAudioBitDepth),
	.pSim(pSim)
) MidiAudioUnit (
	// Midi Signals
	.iMidiRd(wMidiRd),			.iMidiRe(wMidiVd),
	// Audio Signals
	.oAudioFreq(wMauAudioFreq),	.oAudioPlay(wMauAudioPlay),
	// Midi Status
	.oNoteNumber(),
	.oNoteOn(),
	// Audio Control Status

	// Common
	.iRST(iSRST),	.inRST(inSRST),		.iCLK(iSCLK)
);



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
			// else if (wDmaRvd[x])	rDmaRdCh[x] <= {16'd0,wDmaRdCh[x]};
			else if (wDmaRvd[x])	rDmaRdCh[x] <= ((wDmaRdCh[x] - 16'd32767) * wAudioAmp[((x+1)*lpAudioBitDepth)-1:x*lpAudioBitDepth]) >> 8;
			else 					rDmaRdCh[x]	<= rDmaRdCh[x];
		end
		always @*
		begin
			rDmaRdCh[x] <= wDmaRvd[x] ? {16'd0,wDmaRdCh[x]} : 32'd32767;
			// else if (wDmaRvd[x])	rDmaRdCh[x] <= (wDmaRdCh[x] * wAudioAmp[((x+1)*lpAudioBitDepth)-1:x*lpAudioBitDepth]) >> 8;
		end
	end
endgenerate

wire [31:0] wDmaRdAddCh1   = (rDmaRdCh[0] * wAudioAmpCh1Csr);
wire [31:0] wDmaRdAddCh2   = (rDmaRdCh[1] * wAudioAmpCh2Csr);
wire [31:0] wDmaRdAddCh3   = (rDmaRdCh[2] * wAudioAmpCh3Csr);
wire [31:0] wDmaRdAddCh4   = (rDmaRdCh[3] * wAudioAmpCh4Csr);
wire [31:0] wDmaRdAddTotal = (wDmaRdAddCh1 + wDmaRdAddCh2 + wDmaRdAddCh3 + wDmaRdAddCh4) >> 8;
// wire [31:0] wDmaRdAdd = (rDmaRdCh[0] + rDmaRdCh[1] + rDmaRdCh[2] + rDmaRdCh[3]);

//-----------------------------------------------------------------------------
// Dual Clk Fifo
//-----------------------------------------------------------------------------
localparam lpDdrDepth 			= 256;
localparam lpDdrBitWidth 		= 32;
localparam lpDdrRemaingCntBorder= (lpDdrDepth / 2) - 1;

reg  [lpDdrBitWidth-1:0]	qDdrWd;
reg 	qDdrWe;
wire [lpDdrBitWidth-1:0]	wDdrRd;
reg		qDdrRe;
wire	wDdrFull, wDdrEmp;
wire	wDdrRvd;
wire	wDdrRemaingCntAlert;

ASyncFifoController #(
	.pFifoDepth(lpDdrDepth),
	.pFifoBitWidth(lpDdrBitWidth),
	.pFifoRemaingCntBorder(lpDdrRemaingCntBorder)
) DmaDataReceiver (
	// write
	.iWd(qDdrWd),		.iWe(qDdrWe),
	.oFull(wDdrFull),
	.oRemaingCntAlert(wDdrRemaingCntAlert),
	// read
	.oRd(wDdrRd),		.iRe(qDdrRe),
	.oRvd(wDdrRvd),		.oEmp(wDdrEmp),
	// common
	.inARST(inSRST),
	.iRCLK(iMCLK),
	.iWCLK(iSCLK)
);

always @*
begin
	qDdrWd <= wDmaRdAddTotal;
	// qDdrWd <= wDmaRdAdd;
	qDdrWe <= |{wDmaRvd};
	qDmaRe <= ~wDdrFull;
end

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
	// qAudioData[31:0] 	<= {wDmaRdAdd[23:0],8'h00};
  	// qDmaRe				<= wI2SRdy;
	// qDmaRdChRst			<= |{iMRST,wI2SRdy};
	qAudioData[31:0] 	<= {wDdrRd[23:0],8'h00};
  	qDdrRe				<= wI2SRdy;
	qDmaRdChRst			<= |{iMRST,wI2SRdy};
end


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------



endmodule