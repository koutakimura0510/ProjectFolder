/*-----------------------------------------------------------------------------
 * MIDI Status を解析しデータの振り分けを行う
 * 
 * 23-08-26 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module MidiDecoder (
	input	[7:0] iMidiRd,
	input 	iMidiRe,
	// control status
	output	[6:0]	oNoteNumber,
	output	oNoteOn,	// One Shot Pulse
	output	oNoteOff,	// One Shot Pulse
	// common
	input 	iRST,
	input 	iCLK
);

//-----------------------------------------------------------------------------
// Note On State
// 0x90 = Note On
// 0xXX = Note Number
// 0xXX = Note Number Strength
// 
// Note Off State
// 0x80 = Note Off
// 0xXX = Note Number
// 0xXX = Note Number Strength (無効値)
//-----------------------------------------------------------------------------
reg [6:0] 	rNoteNumber;					assign oNoteNumber	= rNoteNumber;
reg [1:0] 	rNoteOn;						assign oNoteOn		= rNoteOn[1];
reg [1:0] 	rNoteOff;						assign oNoteOff		= rNoteOff[1];
reg 		qNoteNumberCke;
reg 		qNoteOnRst,		qNoteOnCke;
reg 		qNoteOffRst,	qNoteOffCke;

always @(posedge iCLK)
begin
	if (iRST)				rNoteNumber <= 7'd0;
	else if (qNoteNumberCke)rNoteNumber <= iMidiRd[6:0];
	else 					rNoteNumber <= rNoteNumber;

	if (qNoteOnRst)			rNoteOn[0] <= 1'b0;
	else if (qNoteOnCke)	rNoteOn[0] <= 1'b1;
	else 					rNoteOn[0] <= rNoteOn[0];

	if (qNoteOnRst)			rNoteOn[1] <= 1'b0;
	else if (iMidiRe)		rNoteOn[1] <= rNoteOn[0];
	else 					rNoteOn[1] <= rNoteOn[1];

	if (qNoteOffRst)		rNoteOff[0] <= 1'b0;
	else if (qNoteOffCke)	rNoteOff[0] <= 1'b1;
	else 					rNoteOff[0] <= rNoteOff[0];

	if (qNoteOffRst)		rNoteOff[1] <= 1'b0;
	else if (iMidiRe)		rNoteOff[1] <= rNoteOff[0];
	else 					rNoteOff[1] <= rNoteOff[1];
end

always @*
begin
	casex ({iRST,rNoteOn[1:0]})
		'b1xx:		qNoteOnRst <= 1'b1;
		'b011:		qNoteOnRst <= 1'b1;
		default:	qNoteOnRst <= 1'b0;
	endcase

	case ({iMidiRe,iMidiRd[7:0]})
		'h1_90:		qNoteOnCke <= 1'b1;
		default:	qNoteOnCke <= 1'b0;
	endcase
	
	casex ({iRST,rNoteOff[1:0]})
		'b1xx:		qNoteOffRst <= 1'b1;
		'b011:		qNoteOffRst <= 1'b1;
		default:	qNoteOffRst <= 1'b0;
	endcase

	case ({iMidiRe,iMidiRd[7:0]})
		'h1_80:		qNoteOffCke <= 1'b1;
		default:	qNoteOffCke <= 1'b0;
	endcase

	casex ({iMidiRe,rNoteOn[1:0],rNoteOff[1:0]})
		'b101xx:	qNoteNumberCke <= 1'b1;
		'b1xx01:	qNoteNumberCke <= 1'b1;
		default: 	qNoteNumberCke <= 1'b0;
	endcase
end

endmodule