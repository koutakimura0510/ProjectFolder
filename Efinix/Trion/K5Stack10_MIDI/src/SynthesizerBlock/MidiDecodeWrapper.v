/*-----------------------------------------------------------------------------
 * Create  2023/8/12
 * Author  kouta kimura
 * -
 * https://westgate-lab.hatenablog.com/entry/2020/07/11/160507
 * v1.00 : new Relaese
 *  
 *-----------------------------------------------------------------------------*/
module MidiDecodWrapper #(
	parameter pChannel = 4,
	parameter pAudioBitDepth = 16
)(
	// Midi Signal
	input	iMIDI,
	output 	oUartRxThru,
	output	[(pChannel * 7)-1:0] oOnNoteNumber,
	// Audio
	output	[(pAudioBitDepth*pChannel)-1:0] oAudioFreq,
	output	[pChannel-1:0]	oAudioPlay,
	output	[(pChannel*pAudioBitDepth)-1:0]	oAudioAmp,
	// common
	input 	iSRST,
	input	inSRST,
	input 	iSCLK
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
	.oUartRxThru(oUartRxThru),
	.oRd(wMidiRd),	.oVd(wMidiVd),
	// CLK RST
	.iRST(iSRST),	.iCLK(iSCLK)
);

always @*
begin
	qUartRx <= ~iMIDI;
end

//-----------------------------------------------------------------------------
// MIDI Decod Unit
//-----------------------------------------------------------------------------
MidiDecodeUnit #(
	.pChannel(pChannel),
	.pAudioBitDepth(pAudioBitDepth)
) MidiDecodeUnit (
	// MIDI Status
	.iMidiRd(wMidiRd),
	.iMidiRe(wMidiVd),
	.oOnNoteNumber(oOnNoteNumber),
	// Decord Data
	.oAudioFreq(oAudioFreq),
	.oAudioPlay(oAudioPlay),
	.oAudioAmp(oAudioAmp),
	// Common
	.iRST(iSRST),
	.inRST(inSRST),
	.iCLK(iSCLK)
);

endmodule