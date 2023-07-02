/*-----------------------------------------------------------------------------
 * Create  2023/07/2
 * Author  kouta kimura
 * -
 * 32bit Interval Timer 
 * 
 *-----------------------------------------------------------------------------*/
module ClkCounter #(
    parameter 	pDivNum  			= 25000000,	// 分周クロックの値を指定
    parameter 	pTimerCntBitWidth  	= 32  //
)(
	// Internal Clk
	output [pTimerCntBitWidth-1:0] oTimerCnt,
	// Clk Reset
	input	iRST,
	input	iCLK
);

localparam  lpTimerBitWidth = fBitWidth(pDivNum);
localparam [lpTimerBitWidth-1:0] lpTimerMaxCnt = pDivNum-1;

reg [lpTimerBitWidth-1:0] 	rSystickCnt;
reg 						qSystickCntCke;
reg [pTimerCntBitWidth-1:0]	rTimerCnt;			assign oTimerCnt = rTimerCnt;

always @(posedge iCLK)
begin
	if (iRST) 					rSystickCnt <= {lpTimerBitWidth{1'b0}};
	else if (qSystickCntCke)	rSystickCnt <= rSystickCnt + 1'b1;
	else 						rSystickCnt <= rSystickCnt;

	if (iRST) 					rTimerCnt <= {pTimerCntBitWidth{1'b0}};
	else if (qSystickCntCke)	rTimerCnt <= rSystickCnt + 1'b1;
	else 						rTimerCnt <= rSystickCnt;
end

always @*
begin
	qSystickCntCke <= (rSystickCnt == lpTimerMaxCnt);
end

//----------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//----------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule