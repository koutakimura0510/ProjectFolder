/*-----------------------------------------------------------------------------
 * MIDI Channel
 * 
 * 23-08-26 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module MidiChannel #(
	parameter pSim = "no"
)(
	// Midi Status
	input	[6:0] iNoteNumber,
	input 	iNoteOn,
	input 	iNoteOff,
	output 	oNoteOnPipe,
	output  [6:0] oNoteNumber,
	// Audio Output
	output	[15:0]	oAudioFreq,
	output	oAudioPlay,			// "1" On, "0" Off
	output	[15:0]	oAudioAmp,
	// common
	input 	iRST,
	input 	iCLK
);

//-----------------------------------------------------------------------------
// Channel
//-----------------------------------------------------------------------------
(* syn_romstyle = "block_rom" *) reg [15:0] rBramNoteFreq [0:127];
(* syn_romstyle = "block_rom" *) reg [15:0] rBramNoteAmp [0:127];

initial
begin
	if (pSim == "no")
	begin
		$readmemh("./src/SynthesizerBlock/dat/BramNoteAmp.dat", rBramNoteAmp);
		$readmemh("./src/SynthesizerBlock/dat/BramNoteFreq.dat", rBramNoteFreq);
	end
	else
	begin
		$readmemh("../dat/BramNoteAmp.dat", rBramNoteAmp);
		$readmemh("../dat/BramNoteFreq.dat", rBramNoteFreq);
	end
end

reg [15:0] 	rNoteFreq;
reg [15:0] 	rNoteAmp;
reg [1:0]	rRun;
reg 		qRunCke;
reg [6:0]	rNoteNumber;
reg 		qNoteNumberCke;

always @(posedge iCLK)
begin
	rNoteFreq	<= rBramNoteFreq[rNoteNumber];
	rRun[1] 	<= rRun[0];

	if (rRun[0])	rNoteAmp <= rBramNoteAmp[rNoteNumber];
	else 			rNoteAmp <= 16'd256;

	if (iRST) 					rRun[0] <=  1'b0;
	else if (qRunCke)			rRun[0] <= ~rRun[0];
	else 						rRun[0] <=  rRun[0];

	if (iRST) 					rNoteNumber <= 7'd0;
	else if (qNoteNumberCke)	rNoteNumber <= iNoteNumber;
	else 						rNoteNumber <= rNoteNumber;
end

always @*
begin
	casex ({rRun[0],iNoteOn,iNoteOff,(rNoteNumber==iNoteNumber)})
		'b010x:		qRunCke <= 1'b1;	// Assert
		'b1011:		qRunCke <= 1'b1;	// Dissert
		default: 	qRunCke <= 1'b0;
	endcase

	casex ({rRun[0],iNoteOn})
		'b01:		qNoteNumberCke <= 1'b1;	// Run でなければデータ取得可能
		default: 	qNoteNumberCke <= 1'b0;
	endcase
end


//-----------------------------------------------------------------------------
// Pipe Part
// 特定の Channel が使用中の場合、NoteOn情報を後段に渡す。
//-----------------------------------------------------------------------------
reg rNoteOnPipe;
reg qNoteOnPipeCke;

always @(posedge iCLK)
begin
	if (iRST) 					rNoteOnPipe <= 1'b0;
	else if (qNoteOnPipeCke)	rNoteOnPipe <= 1'b1;
	else 						rNoteOnPipe <= 1'b0;
end

always @*
begin
	qNoteOnPipeCke <= &{rRun[0],iNoteOn};
end

//-----------------------------------------------------------------------------
assign oNoteNumber  = rNoteNumber;
assign oAudioFreq	= rNoteFreq;
assign oAudioPlay	= rRun[1];
assign oAudioAmp	= rNoteAmp;
assign oNoteOnPipe  = rNoteOnPipe;

endmodule