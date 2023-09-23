/*-----------------------------------------------------------------------------
 * MIDI Status を解析しデータの振り分けを行う
 * 
 * 23-08-26 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module MidiAmpAdjust #(
	parameter pAudioBitWidth = 16
)(
	input	[pAudioBitWidth-1:0] iAudioFreq,
	input 	iMidiRe,
	// control status
	output	[6:0]	oNoteNumber,
	output	oNoteOn,	// One Shot Pulse
	output	oNoteOff,	// One Shot Pulse
	// common
	input 	iRST,
	input 	iCLK
);




endmodule