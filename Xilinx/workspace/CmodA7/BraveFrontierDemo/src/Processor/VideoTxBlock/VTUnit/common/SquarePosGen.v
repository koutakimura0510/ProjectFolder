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
	output 	[pVdisplayWidth-1:0]	oDTopY,		// y軸 上点
	output 	[pVdisplayWidth-1:0]	oDUnderY,	// y軸 下点
	//
	input 	[pVdisplayWidth-1:0]	iJumpPeak,	// ジャンプの高さ
	input 	[pVdisplayWidth-1:0]	iJumpSpeed,	// ジャンプの初速
	input 							iJumpEn,	// Jump ON 1, OFF 0
	//
	input 	[pVdisplayWidth-1:0]	iSlidePeak,	// 水平移動の最高速
	input 	[pVdisplayWidth-1:0]	iSlideSpeed,// 水平移動の初速
	input 							iSlideEn,	// Move ON 1, OFF 0
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
reg  signed [pVdisplayWidth:0] rJumpPeak;
//
wire signed [pVdisplayWidth:0] wJumpSpeed = iJumpSpeed;
wire signed [pVdisplayWidth:0] wJumpPeak  = rJumpPeak - wJumpSpeed;
//
reg qVDownPoint;
reg qJumpPeak;

always @(posedge iClk)
begin
	casex ({qVDownPoint, qJumpPeak, qCke, iJumpEn})
		'bxxx0:		rJumpPeak <= iJumpPeak;
		'b1111:		rJumpPeak <= iJumpPeak;
		'b0011:		rJumpPeak <= wJumpPeak;
		default: 	rJumpPeak <= rJumpPeak;
	endcase
end

always @*
begin
	qJumpPeak <= rJumpPeak[pVdisplayWidth];		// 負の値を検出時、頂点に達したとみなす
end


//-----------------------------------------------------------------------------
// 速度 計算
// Gain = 移動量に応じて座標移動を行う
//-----------------------------------------------------------------------------
reg [pHdisplayWidth-1:0] rDLeftX;			assign oDLeftX 	= rDLeftX;
reg [pHdisplayWidth-1:0] rDRightX;			assign oDRightX = rDRightX;
reg [pVdisplayWidth-1:0] rDTopY;			assign oDTopY 	= rDTopY;
reg [pVdisplayWidth-1:0] rDUnderY;			assign oDUnderY	= rDUnderY;
// X軸
wire [pHdisplayWidth-1:0] wDRightXinit = iDStartX + iDSizeX;	// X軸 初期値
// Y軸
wire [pVdisplayWidth-1:0] wDUnderYinit = iDStartY + iDSizeY;	// Y軸 初期値
wire [pVdisplayWidth-1:0] wDTopYRise   = rDTopY   - iDGainY;	// 上昇時 Top 座標
wire [pVdisplayWidth-1:0] wDTopYFall   = rDTopY   + iDGainY;	// 下降時 Top 座標
wire [pVdisplayWidth-1:0] wDUnderYRise = rDUnderY - iDGainY;	// 上昇時 Under 座標
wire [pVdisplayWidth-1:0] wDUnderYFall = rDUnderY + iDGainY;	// 下降時 Under 座標
//
reg qDUnderOverflow;

always @(posedge iClk)
begin
	// x軸 Left
    if (iRst)   	rDLeftX 	<= iDStartX;
	else if (qCke)	rDLeftX 	<= rDLeftX + iDGainX;
    else        	rDLeftX 	<= rDLeftX;

    if (iRst)   	rDRightX 	<= iDStartX + iDSizeX;
	else if (qCke)	rDRightX 	<= rDRightX + iDGainX;
    else        	rDRightX 	<= rDRightX;

	// x軸 Right
	casex ({qDUnderOverflow, qJumpPeak, qCke, iSlideEn})
		'bxxx0:		rDRightX <= wDRightXinit;
		'b1111:		rDRightX <= wDRightXinit;
		'bx011:		rDRightX <= wDTopYRise;
		'bx111:		rDRightX <= wDTopYFall;
		default: 	rDRightX <= rDTopY;
	endcase


	// y軸 Top
	casex ({qDUnderOverflow, qJumpPeak, qCke, iJumpEn})
		'bxxx0:		rDTopY <= iDStartY;
		'b1111:		rDTopY <= iDStartY;
		'bx011:		rDTopY <= wDTopYRise;
		'bx111:		rDTopY <= wDTopYFall;
		default: 	rDTopY <= rDTopY;
	endcase

	// y軸 Under
	casex ({qDUnderOverflow, qJumpPeak, qCke, iJumpEn})
		'bxxx0:		rDUnderY <= wDUnderYinit;
		'b1111:		rDUnderY <= wDUnderYinit;
		'bx011:		rDUnderY <= wDUnderYRise;
		'bx111:		rDUnderY <= wDUnderYFall;
		default: 	rDUnderY <= rDUnderY;
	endcase
end

always @*
begin
	qVDownPoint 	<= (iVdisplay == rDUnderY);		// 物体の最下点とディスプレイの最下点を参照
	qDUnderOverflow	<= (iVdisplay < wDUnderYFall);	// 落下中 次フレームの Y座標が画面外の時 地面に着地する
end


endmodule