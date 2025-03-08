 /*-----------------------------------------------------------------------------
  * MIDI 信号を解析して音源データを出力する
  * 23-08-26 v1.00 : New Release
  *-----------------------------------------------------------------------------*/
module MidiAudioUnit #(
	parameter pChannel = 4,
	parameter pAudioBitDepth = 16,
	parameter pSim = "no"
)(
	// Midi Signals
	input	[7:0] iMidiRd,
	input 	iMidiRe,
	// Audio Signals
	output	[(pAudioBitDepth*pChannel)-1:0] oAudioFreq,
	output	[pChannel-1:0]	oAudioPlay,
	// Midi Status
	output	[(pChannel * 7)-1:0] oNoteNumber,	// 0 ~ 127
	output	[pChannel-1:0] oNoteOn,				// "1" Play, "0" Stop
	// Audio Control Status

	// common
	input 	iRST,
	input	inRST,
	input 	iCLK
);


//-----------------------------------------------------------------------------
// MIDI Decoder
//-----------------------------------------------------------------------------
wire [6:0] wDecNoteNumber;
wire wDecNoteOn;
wire wDecNoteOff;

MidiDecoder MidiDecoder (
	// MIDI Status
	.iMidiRd(iMidiRd),	.iMidiRe(iMidiRe),
	// Decord Data
	.oNoteNumber(wDecNoteNumber),	.oNoteOn(wDecNoteOn),	.oNoteOff(wDecNoteOff),
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
// 各Ch 内部で現在発音中の NoteNumber を保持しており、入力の NoteNumber と一致した場合に oNoteOn が Dissert するようになっている。
//-----------------------------------------------------------------------------
genvar x;

wire [6:0] 			wChaNoteNumber[pChannel-1:0];
wire [pChannel-1:0] wChaNoteOnPipe;
wire [pChannel-1:0] wChaNoteOn;

generate
for (x = 0; x < pChannel; x = x + 1)
begin : MidiChannel
	if (x == 0)
	begin
		MidiChannel MidiChannel (
			// Midi Note Input
			.iNoteNumber(wDecNoteNumber),		.iNoteOn(wDecNoteOn),	.iNoteOff(wDecNoteOff),
			// Midi Note Output
			.oNoteNumber(wChaNoteNumber[x]),	.oNoteOn(wChaNoteOn[x]),.oNoteOnPipe(wChaNoteOnPipe[x]),
			// common
			.iRST(iRST),	.iCLK(iCLK)
		);
	end
	else
	begin
		MidiChannel MidiChannel (
			// Midi Note Input
			.iNoteNumber(wDecNoteNumber),		.iNoteOn(wChaNoteOnPipe[x-1]),	.iNoteOff(wDecNoteOff),
			// Midi Note Output
			.oNoteNumber(wChaNoteNumber[x]),	.oNoteOn(wChaNoteOn[x]),		.oNoteOnPipe(wChaNoteOnPipe[x]),
			// common
			.iRST(iRST),	.iCLK(iCLK)
		);
	end

	assign oNoteNumber[(7*(x+1))-1:7*x] = wChaNoteNumber[x];
	assign oNoteOn[x] = wChaNoteOn[x];
end
endgenerate

//-----------------------------------------------------------------------------
// MIDI Pitch, MIDI 信号から 音源データ生成
//-----------------------------------------------------------------------------
wire [pAudioBitDepth-1:0] 	wPicAudioFreq [pChannel-1:0];

generate
for (x = 0; x < pChannel; x = x + 1)
begin : MidiPicth
	MidiPicth #(
		.pAudioBitDepth(pAudioBitDepth),
		.pSim(pSim)
	) MidiPicth (
		// Midi Note Input
		.iNoteNumber(wChaNoteNumber[x]),	.iNoteOn(wChaNoteOn[x]),
		// Audio Freq Output
		.oAudioFreq(wPicAudioFreq[x]),
		// common
		.iRST(iRST),		.iCLK(iCLK)
	);

assign oAudioFreq[(pAudioBitDepth*(x+1))-1:pAudioBitDepth*x] = wPicAudioFreq[x];
assign oAudioPlay[x] = wChaNoteOn[x];
end
endgenerate


//-----------------------------------------------------------------------------
// MIDI Amp 音源データの振幅調整
//-----------------------------------------------------------------------------
// wire [pAudioBitDepth-1:0] 	wPicAudioFreq [pChannel-1:0];

// generate
// for (x = 0; x < pChannel; x = x + 1)
// begin : MidiAmp
// 	MidiAmp #(
// 		.pAudioBitDepth(pAudioBitDepth),
// 		.pSim(pSim)
// 	) MidiAmp (
// 		// Midi Note Input
// 		.iNoteNumber(wChaNoteNumber[x]),	.iNoteOn(wChaNoteOn[x]),
// 		// Audio Freq Output
// 		.oAudioFreq(wPicAudioFreq[x]),
// 		// common
// 		.iRST(iRST),		.iCLK(iCLK)
// 	);
// end
// endgenerate



endmodule