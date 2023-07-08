/*-----------------------------------------------------------------------------
 * Create  2023/07/2
 * Author  kouta kimura
 * -
 * 32bit Interval Timer 
 * 
 *-----------------------------------------------------------------------------*/
module ClkCounter #(
    parameter 	pTimerCntBitWidth  	= 32
)(
	// Internal Clk
	output [pTimerCntBitWidth-1:0] oTimerCnt,
	input  [pTimerCntBitWidth-1:0] iTimerDiv,
	// common
	input	iRST,
	input	iCLK
);

reg [pTimerCntBitWidth-1:0]	rSystickCnt;
reg 						qSystickCntCke;
reg [pTimerCntBitWidth-1:0]	rTimerCnt;			assign oTimerCnt = rTimerCnt;

always @(posedge iCLK)
begin
	if (!iRST) 					rSystickCnt <= {pTimerCntBitWidth{1'b0}};
	else if (qSystickCntCke)	rSystickCnt <= {pTimerCntBitWidth{1'b0}};
	else 						rSystickCnt <=  rSystickCnt + 1'b1;

	if (!iRST) 					rTimerCnt <= {pTimerCntBitWidth{1'b0}};
	else if (qSystickCntCke)	rTimerCnt <=  rTimerCnt + 1'b1;
	else 						rTimerCnt <=  rTimerCnt;
end

always @*
begin
	qSystickCntCke <= (rSystickCnt == iTimerDiv);
end

endmodule