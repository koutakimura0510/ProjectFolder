 /*-----------------------------------------------------------------------------
  * MIDI module Unit
  * 23-08-26 v1.00 : New Release
  *-----------------------------------------------------------------------------*/
module MidiDecodeUnit #(
	parameter pChannel = 4,
	parameter pAudioBitDepth = 16
)(
	// Midi Signal
	input	[7:0] iMidiRd,
	input 	iMidiRe,
	output	[(pChannel * 7)-1:0] oOnNoteNumber,
	// Audio
	output	[(pAudioBitDepth*pChannel)-1:0] oAudioFreq,
	output	[pChannel-1:0]	oAudioPlay,
	output	[(pChannel*pAudioBitDepth)-1:0]	oAudioAmp,
	// common
	input 	iRST,
	input	inRST,
	input 	iCLK
);


//-----------------------------------------------------------------------------
// MIDI Decoder
//-----------------------------------------------------------------------------
wire [6:0] wNoteNumber;
wire wNoteOn;
wire wNoteOff;

MidiDecoder MidiDecoder (
	// MIDI Status
	.iMidiRd(iMidiRd),	.iMidiRe(iMidiRe),
	// Decord Data
	.oNoteNumber(wNoteNumber),	.oNoteOn(wNoteOn),	.oNoteOff(wNoteOff),
	// Common
	.iRST(iRST),	.iCLK(iCLK)
);


//-----------------------------------------------------------------------------
// MIDI Channel
// 同時発音数は pChannel の数存在する。
// CH1 が発音中の場合は CH2 に NoteOn 情報を渡す。
// CH2 も発音中の場合は CH3に...というようにパイプ処理になっている。
// 
// NoteOff 情報と NoteNumber は全てのChannel に入力されているが、
// 各Ch 内部で現在発音中の NoteNumber を保持しており、入力の NoteNumber と一致した場合に停止するようになっている。
//-----------------------------------------------------------------------------
genvar x;

wire [6:0] wOnNoteNumber[pChannel-1:0];
wire [pChannel-1:0] wNoteOnPipe;
wire [pAudioBitDepth-1:0] wAudioFreq[pChannel-1:0];
wire [pChannel-1:0] wAudioPlay;
wire [pAudioBitDepth-1:0] wAudioAmp[pChannel-1:0];

generate
for (x = 0; x < pChannel; x = x + 1)
begin : MidiChannel
	if (x == 0)
	begin
		MidiChannel MidiChannel (
			// Midi Note
			.iNoteNumber(wNoteNumber),		.iNoteOn(wNoteOn),			.iNoteOff(wNoteOff),
			.oNoteNumber(wOnNoteNumber[x]),	.oNoteOnPipe(wNoteOnPipe[x]),
			// Audio
			.oAudioFreq(wAudioFreq[x]),		.oAudioPlay(wAudioPlay[x]),	.oAudioAmp(wAudioAmp[x]),
			.iRST(iRST),	.iCLK(iCLK)
		);
	end
	else
	begin
		MidiChannel MidiChannel (
			// Midi Note
			.iNoteNumber(wNoteNumber),		.iNoteOn(wNoteOnPipe[x-1]),	.iNoteOff(wNoteOff),
			.oNoteNumber(wOnNoteNumber[x]),	.oNoteOnPipe(wNoteOnPipe[x]),
			// Audio
			.oAudioFreq(wAudioFreq[x]),		.oAudioPlay(wAudioPlay[x]),	.oAudioAmp(wAudioAmp[x]),
			.iRST(iRST),	.iCLK(iCLK)
		);
	end

	assign oOnNoteNumber[(7*(x+1))-1:7*x] = wOnNoteNumber[x];
	assign oAudioFreq[(pAudioBitDepth*(x+1))-1:pAudioBitDepth*x] = wAudioFreq[x];
	assign oAudioPlay[x] = wAudioPlay[x];
	assign oAudioAmp[(pAudioBitDepth*(x+1))-1:pAudioBitDepth*x] = wAudioAmp[x];
end
endgenerate


endmodule