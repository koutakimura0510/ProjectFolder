/*-----------------------------------------------------------------------------
 * MIDI Channel
 * 
 * 23-08-26 v1.00 : new release
 * 23-08-28 v1.01 : module 内で NoteNumber から周波数を求めていたが、Channel ごとに Note Data を振り分ける処理のみに変更
 *					MIDI Note Data によるデータの生成は、後段以降で行うこととした。
 *-----------------------------------------------------------------------------*/
module MidiChannel (
	// Midi Note Input
	input	[6:0] 	iNoteNumber,
	input 			iNoteOn,		// One Shot Pulse
	input 			iNoteOff,
	// Midi Note Output
	output  [6:0] 	oNoteNumber,
	output 			oNoteOn,		// "H" Run, "L" Not Run
	output 			oNoteOnPipe,	// One Shot Pulse
	// common
	input 	iRST,
	input 	iCLK
);

//-----------------------------------------------------------------------------
// Channel
//-----------------------------------------------------------------------------
reg [6:0]	rNoteNumber;
reg 		rRun;
reg 		qRunCke;
reg 		qNoteNumberCke;

always @(posedge iCLK)
begin
	if (iRST) 					rRun <=  1'b0;
	else if (qRunCke)			rRun <= ~rRun;
	else 						rRun <=  rRun;

	if (iRST) 					rNoteNumber <= 7'd0;
	else if (qNoteNumberCke)	rNoteNumber <= iNoteNumber;
	else 						rNoteNumber <= rNoteNumber;
end

always @*
begin
	casex ({rRun,iNoteOn,iNoteOff,(rNoteNumber==iNoteNumber)})
		'b010x:		qRunCke <= 1'b1;	// Assert
		'b1011:		qRunCke <= 1'b1;	// Dissert
		default: 	qRunCke <= 1'b0;
	endcase

	casex ({rRun,iNoteOn})
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
	qNoteOnPipeCke <= &{rRun,iNoteOn};
end

//-----------------------------------------------------------------------------
assign oNoteNumber  = rNoteNumber;
assign oNoteOn		= rRun;
assign oNoteOnPipe  = rNoteOnPipe;

endmodule