//----------------------------------------------------------
// Create 2022/08/31
// Author koutakimura
// -
// 指定範囲で指定色の四角形データを出力する
// 
// 2022-09-29 座標が画面外の場合のドットデータ生成に対応
// 
//----------------------------------------------------------
module DotSquareGen #(
    parameter                   			pHdisplayWidth  = 11,
    parameter                   			pVdisplayWidth  = 11,
	parameter								pColorDepth		= 16
)(
	// Internal Port
	output 			[pColorDepth-1:0]		oPixel,
    input  			[pColorDepth-1:0]		iColor,		// 描画色
    input 			[pHdisplayWidth-1:0]	iHpos,		// 現在の横幅の座標
    input 			[pVdisplayWidth-1:0]	iVpos,		// 現在の立幅の座標
    input signed 	[pHdisplayWidth:0]		iDLeftX,	// 描画開始 X座標 Draw X Start
    input signed 	[pHdisplayWidth:0]		iDRightX,	// 描画終了 X座標 Draw X End
    input signed 	[pVdisplayWidth:0]		iDTopY,		// 描画開始 Y座標 Draw Y Start
    input signed 	[pVdisplayWidth:0]		iDUnderY,	// 描画終了 Y座標 Draw Y End
	// Clk rst
    input                       	iRst,
    input                       	iClk
);


//-----------------------------------------------------------------------------
// 比較用に符号拡張
//-----------------------------------------------------------------------------
wire signed [pHdisplayWidth:0] wHpos = {1'b0, iHpos};
wire signed [pVdisplayWidth:0] wVpos = {1'b0, iVpos};


//----------------------------------------------------------
// 指定色のデータ及び範囲外であれば透過値最大のデータを出力
//----------------------------------------------------------
reg [pColorDepth-1:0] rPixel;		assign oPixel = rPixel;
reg qCke;
reg [3:0] qPosMatch;

always @(posedge iClk)
begin
	if (qCke) 		rPixel <= iColor;
    else 			rPixel <= {pColorDepth{1'b0}};
end

//-----------------------------------------------------------------------------
// 画面外に座標データがはみ出ても、範囲内のドットデータは描画するようにする
//-----------------------------------------------------------------------------
always @*
begin
	qPosMatch[0] <= (iDLeftX <= wHpos);
	qPosMatch[1] <= (wHpos 	 <  iDRightX);
	qPosMatch[2] <= (iDTopY  <= wVpos);
	qPosMatch[3] <= (wVpos   <  iDUnderY);
	qCke 		 <= &(qPosMatch);
end

endmodule