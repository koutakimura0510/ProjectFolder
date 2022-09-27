//----------------------------------------------------------
// Create 2022/09/27
// Author koutakimura
// -
// 設定値に合わせて座標を生成する
// 
//----------------------------------------------------------
module SquarePosGen #(
    parameter						pHdisplayWidth  = 11,
    parameter						pVdisplayWidth  = 11,
	parameter						pGainWidth		= 7
)(
	// Internal Port
	input	[pHdisplayWidth-1:0]	iHdisplay,	// 画面横サイズ
	input	[pVdisplayWidth-1:0]	iVdisplay,	// 画面縦サイズ
    input  	[pHdisplayWidth-1:0]    iFe,		// Frame End
	//
	input  	[pHdisplayWidth-1:0]	iDStartX,	// x軸 開始点
	input  	[pVdisplayWidth-1:0]	iDStartY,	// y軸 開始点
	//
	input  	[pHdisplayWidth-1:0]	iDSizeX,	// x Size
	input  	[pVdisplayWidth-1:0]	iDSizeY,	// y Size
	// 
	input  	[pGainWidth-1:0]		iDGainX,	// x軸 移動量
	input  	[pGainWidth-1:0]		iDGainY,	// y軸 移動量
	//
	output 	[pHdisplayWidth-1:0]	oDLeftX,	// x軸 左点
    output 	[pHdisplayWidth-1:0]   	oDRightX,	// x軸 右点
	output 	[pVdisplayWidth-1:0]	oDUpY,		// y軸 上点
	output 	[pVdisplayWidth-1:0]	oDDownY,	// y軸 下点
	//
	input 	[pVdisplayWidth-1:0]	iJumpPeak,	// ジャンプの高さ
	input 	[pVdisplayWidth-1:0]	iJumpSpeed,	// ジャンプの初速
	// Clk rst
    input                       	iRst,
    input                       	iClk
);


//-----------------------------------------------------------------------------
// Frame End 信号を使用して Cke 生成
// タイミングによっては Fe は Assert され続けるので、1clk だけ toggle するように変更
//-----------------------------------------------------------------------------
reg rFe;
reg qCke;

always @(posedge iClk)
begin
	if (iRst)	rFe <= 1'b0;
	else 		rFe <= (~iFe) & rFe;
end

always @*
begin
	qCke <= iFe & rFe;
end


//-----------------------------------------------------------------------------
// 速度 計算
//-----------------------------------------------------------------------------
wire signed [pVdisplayWidth:0] wJumpPeak = iJumpSpeed;
reg  signed [pVdisplayWidth:0] rJumpPeak;
reg qVDownMatch;
reg qJumpPeak;

always @(posedge iClk)
begin
	if (iRst)
	begin
		rJumpPeak <= iJumpPeak;
	end
	else
	begin
		casex ({qVDownMatch, qJumpPeak, qFe})
			'b001: 		rJumpPeak <= rJumpPeak - wJumpPeak;
			'b111:		rJumpPeak <= iJumpPeak;
			default: 	rJumpPeak <= rJumpPeak;
		endcase
	end
end

always @*
begin
	qJumpPeak <= rJumpPeak[pVdisplayWidth];	// 負の値を検出
end

//-----------------------------------------------------------------------------
// 速度 計算
// Gain = 移動量に応じて座標移動を行う
//----------------------------------------------------------
reg [pHdisplayWidth-1:0] rDLeftX;			assign oDLeftX 	= rDLeftX;
reg [pHdisplayWidth-1:0] rDRightX;			assign oDRightX = rDRightX;
reg [pVdisplayWidth-1:0] rDUpY;				assign oDUpY 	= rDUpY;
reg [pVdisplayWidth-1:0] rDDownY;			assign oDDownY	= rDDownY;
//

always @(posedge iClk)
begin
	// x軸
    if (iRst)   	rDLeftX 	<= iDStartX;
	else if (qCke)	rDLeftX 	<= rDLeftX + iDGainX;
    else        	rDLeftX 	<= rDLeftX;

    if (iRst)   	rDRightX 	<= iDStartX + iDSizeX;
	else if (qCke)	rDRightX 	<= rDRightX + iDGainX;
    else        	rDRightX 	<= rDRightX;

	// y軸
    if (iRst)
	begin
		rDUpY 		<= iDStartY;
	end
	else
	else if (qCke)	rDUpY 		<= rDUpY + iDGainY;
    else        	rDUpY 		<= rDUpY;

    if (iRst)   	rDDownY 	<= iDStartY + iDSizeY;
	else if (qCke)	rDDownY 	<= rDDownY  + iDGainX;
    else        	rDDownY 	<= rDDownY;
end

always @*
begin
	qVDownMatch <= iVdisplay == rDDownY;
end


endmodule