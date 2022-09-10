 //----------------------------------------------------------
 // Create 2022/09/05
 // Author koutakimura
 // -
 // 現在座標に対応したバックグラウンドのデータを出力する
 //----------------------------------------------------------
module DotSquareGen #(
    parameter                   	pHdisplayWidth  = 11,
    parameter                   	pVdisplayWidth  = 11,
	parameter						pColorDepth		= 16,
	parameter 						pFifoDepth		= 16,
	parameter 						pFifoBitWidth	= 16
)(
	// Internal Port
    input  [pHdisplayWidth-1:0]     iHpos,		// 現在の横幅の座標
    input  [pVdisplayWidth-1:0]     iVpos,		// 現在の立幅の座標
    output [pColorDepth-1:0]    	oPixel,
    output                      	oVd,
	// Clk rst
    input                       	iRst,
	input 							iCke,
    input                       	iClk
);


//----------------------------------------------------------
// 色データ入力
//----------------------------------------------------------
reg [pColorDepth-1:0] rPixel;			assign oPixel 	= rPixel;
reg rVd;								assign oVd		= rVd;
reg qCke;
reg [3:0] qPosMatch;

always @(posedge iClk)
begin
    rPixel <= iPixel;

    if (iRst)   	rVd <= 1'd0;
	else if (iCke)	rVd <= qCke;
    else        	rVd <= 1'd0;
end

always @*
begin
	qCke <= &(qPosMatch);
end


//----------------------------------------------------------
// 
//----------------------------------------------------------

endmodule