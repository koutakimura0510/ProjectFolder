 /*-----------------------------------------------------------------------------
  * NoteNumber から Pitch(鳴らす音の周波数) を生成する
  * 23-08-26 v1.00 : New Release
  *-----------------------------------------------------------------------------*/
module MidiPitch #(
	parameter pAudioBitDepth = 16,
	parameter pIntegerFileName 	= "./src/SynthesizerBlock/dat/IndexInteger.dat",
	parameter pDecimalFileName 	= "./src/SynthesizerBlock/dat/IndexDecimal.dat",
	parameter pPitchFileName	= "./src/SynthesizerBlock/dat/PitchSin.dat"
)(
	// Midi Note Input
	input	[6:0] iNoteNumber,
	input 	iNoteOn,
	// Audio Freq Output
	output	[pAudioBitDepth-1:0] oAudioFreq,
	// common
	input 	iRST,
	input 	iCLK
);


//-----------------------------------------------------------------------------
// MIDI Tone Index Generator
//-----------------------------------------------------------------------------
wire [pAudioBitDepth-1:0] wMpiPitchIndex;
reg qMtiRst;

MidiPitchIndex #(
	.pBramDepth(128),
	.pAudioBitDepth(pAudioBitDepth),
	.pIntegerFileName(pIntegerFileName),
	.pDecimalFileName(pDecimalFileName)
) MidiPitchIndex (
	.iNoteNumber(iNoteNumber),
	.oPitchIndex(wMpiPitchIndex),
	// common
	.iRST(qMtiRst),
	.iCKE(1'b1),
	.iCLK(iCLK)
);

always @*
begin
	qMtiRst <= |{iRST, iNoteOn};
end


//-----------------------------------------------------------------------------
// MIDI Picth Gen
//-----------------------------------------------------------------------------
MidiPicthRom #(
	.pBramDepth(256),
	.pAudioBitDepth(pAudioBitDepth),
	.pFileName(pPitchFileName)
) MidiPicthRom (
	.iToneIndex(wMpiPitchIndex),
	.oAudioFreq(oAudioFreq),
	.iCLK(iCLK)
);

endmodule