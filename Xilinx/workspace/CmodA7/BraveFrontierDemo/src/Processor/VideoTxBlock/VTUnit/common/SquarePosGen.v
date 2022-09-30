//----------------------------------------------------------
// Create 2022/09/27
// Author koutakimura
// -
// 設定値に合わせて座標を生成する
// -
// 2022-09-29 画面外の座標生成に対応 (負の値に対応)
// 
//----------------------------------------------------------
module SquarePosGen #(
    parameter								pHdisplayWidth  	= 11,
    parameter								pVdisplayWidth  	= 11,
	parameter								pJumpJyroBitWidth	= 4
)(
	// Internal Port
	// Display,Sync 
	input	signed	[pHdisplayWidth:0]		iHdisplay,		// 画面横サイズ
	input	signed	[pVdisplayWidth:0]		iVdisplay,		// 画面縦サイズ
    input			[pHdisplayWidth-1:0]    iFe,			// Frame End
	// 描画開始座標
	input	signed	[pHdisplayWidth:0]		iDStartX,		// x軸 開始点
	input	signed	[pVdisplayWidth:0]		iDStartY,		// y軸 開始点
	// 描画サイズ
	input			[pHdisplayWidth-1:0]	iDSizeX,		// x Size ※描画サイズが負の整数になることはない
	input			[pVdisplayWidth-1:0]	iDSizeY,		// y Size ※そのため、1bit 拡張のキャストで計算に使用する
	// 現在の座標
	output	signed 	[pHdisplayWidth:0] 		oDLeftX,		// x軸 左点
	output	signed 	[pHdisplayWidth:0] 		oDRightX,		// x軸 右点
	output	signed 	[pVdisplayWidth:0] 		oDTopY,			// y軸 上点
	output	signed 	[pVdisplayWidth:0] 		oDUnderY,		// y軸 下点
	// ジャンプ機能
	input 	signed	[pVdisplayWidth:0]		iJumpPeakY,		// ジャンプ Y軸 頂点
	input 	signed	[pVdisplayWidth:0]		iJumpGainY,		// ジャンプ 初速
	input 	signed  [pJumpJyroBitWidth:0]	iJumpJyroMaxY,	// ジャンプ 最大加速度
	input 	signed  [pJumpJyroBitWidth:0]	iJumpJyroMinY,	// ジャンプ 最小加速度
	input 									iJumpCkeY,		// ジャンプ ON 1, OFF 0
	// ダッシュ機能
	input 	signed	[pVdisplayWidth:0]		iDashPeakX,		// 水平移動の最高速
	input 	signed	[pVdisplayWidth:0]		iDashGainX,		// 水平移動の初速
	input 									iDashCkeX,		// Move ON 1, OFF 0
	// 通常動作
	input 	signed	[pHdisplayWidth:0]		iBasicGainX,	// X軸 通常動作時の 移動量
	input 	signed	[pVdisplayWidth:0]		iBasicGainY,	// Y軸 通常動作時の 移動量
	input 									iLeftCkeX,		// 左方向移動 Enable
	input 									iRightCkeX,		// 右方向移動 Enable
	input 									iTopCkeY,		// 上方向移動 Enable
	input 									iUnderCkeY,		// 下方向移動 Enable
	// Clk rst
	input									iRst,
	input									iClk
);


//-----------------------------------------------------------------------------
// localparam 
//-----------------------------------------------------------------------------
localparam lpHdisplayWidth = pHdisplayWidth + 1'b1;
localparam lpVdisplayWidth = pVdisplayWidth + 1'b1;


//-----------------------------------------------------------------------------
// Frame End 信号を使用して Cke 生成
// タイミングによっては Fe は Assert され続けるので、1clk だけ toggle するように変更
//-----------------------------------------------------------------------------
reg rFe;
reg qFe;

always @(posedge iClk)
begin
	if (iRst)	rFe <= 1'b0;
	else 		rFe <= (~iFe) & rFe;
end

always @*
begin
	qFe <= iFe & rFe;
end


//-----------------------------------------------------------------------------
// Y軸 ジャンプ移動量計算
//-----------------------------------------------------------------------------
reg  	signed [pVdisplayWidth:0] 	rJumpPeakY;
reg		signed [pVdisplayWidth:0] 	rJumpGainY;
reg 								rJumpCkeY;
//
wire 	signed [pVdisplayWidth:0] 	wJumpPeakY  = rJumpPeakY - rJumpGainY;
wire 	signed [pVdisplayWidth:0]	wJumpRiseY	= rJumpGainY - 1'b1;
wire 	signed [pVdisplayWidth:0]	wJumpFallY	= rJumpGainY + 1'b1;
//
reg 	qVDownPoint;
reg 	qJumpPeakY;
reg 	qJumpJyroMaxComp;
reg 	qJumpJyroMinComp;

always @(posedge iClk)
begin
	//-----------------------------------------------------------------------------
	// ジャンプ後は 次回ジャンプ可能地点に着地するまで、ジャンプの一連の動作を継続する
	// なるべく Cke 生成ロジックで制御信号を確認するようにして、ロジックを複雑にしないように
	// 後段の 計算などには 無駄な Sel を使用しないようにする。
	//-----------------------------------------------------------------------------
	if (iRst)
	begin
		rJumpCke <= 1'b0;
	end
	else
	begin
		casex ({rJumpCke, qVDownPoint, iJumpCkeY})
			'b0x1: 		rJumpCke <= 1'b1;
			'b10x: 		rJumpCke <= 1'b1;
			'b11x: 		rJumpCke <= 1'b0;
			default:	rJumpCke <= rJumpCke;
		endcase
	end

	//-----------------------------------------------------------------------------
	// ジャンプ高さの計算
	//-----------------------------------------------------------------------------
	casex ({qJumpPeakY, qFe, rJumpCkeY})
		'bxx0:		rJumpPeakY <= iJumpPeakY;		// 初期値
		'b011:		rJumpPeakY <= wJumpPeakY;		// 頂点に達するまで計算
		default: 	rJumpPeakY <= rJumpPeakY;		// 頂点に達した後は着地するまで固定
	endcase

	//-----------------------------------------------------------------------------
	// 加速度の計算
	//-----------------------------------------------------------------------------
	casex ({qJumpJyroMaxComp, qJumpJyroMinComp, qJumpPeakY, qFe, rJumpCkeY})
		'bxxxx0:	rJumpGainY <= iJumpGainY;
		'bx0011:	rJumpGainY <= wJumpRiseY;		// 上昇量 は緩やかに減速していく
		'b0x111:	rJumpGainY <= wJumpFallY;		// 下降量 は緩やかに加速していく
		default: 	rJumpGainY <= rJumpGainY;
	endcase
end

always @*
begin
	qJumpPeakY			<= rJumpPeakY[pVdisplayWidth];		// 負の値を検出時、頂点に達したとみなす
	qJumpJyroMaxComp	<= (iJumpJyroMaxY == rJumpGainY);
	qJumpJyroMinComp	<= (iJumpJyroMinY == rJumpGainY);
end


//-----------------------------------------------------------------------------
// 水平移動速度 計算
//-----------------------------------------------------------------------------
reg  signed [pVdisplayWidth:0] rSlideSpeed;
//
wire signed [pVdisplayWidth:0] wSlideSpeed  = rSlideSpeed - iSlideSpeed;
//
reg qVDownPoint;
reg qSlideSpeedPeak;

always @(posedge iClk)
begin
	casex ({qSlideSpeedPeak, qFe, iSlideEn})
		'bxx0:		rSlideSpeed <= iSlideSpeedPeak;
		'b111:		rSlideSpeed <= rSlideSpeed;
		'b011:		rSlideSpeed <= wSlideSpeed;
		default: 	rSlideSpeed <= rSlideSpeed;
	endcase
end

always @*
begin
	qSlideSpeedPeak <= rSlideSpeed[pVdisplayWidth];		// 負の値を検出時、最高速度に達したとみなす
end


//-----------------------------------------------------------------------------
// 座標計算
//-----------------------------------------------------------------------------
reg		signed [pHdisplayWidth:0] rDLeftX;			assign oDLeftX 	= rDLeftX;
reg		signed [pHdisplayWidth:0] rDRightX;			assign oDRightX = rDRightX;
reg		signed [pVdisplayWidth:0] rDTopY;			assign oDTopY 	= rDTopY;
reg		signed [pVdisplayWidth:0] rDUnderY;			assign oDUnderY	= rDUnderY;
// 符号拡張
wire 	signed [pHdisplayWidth:0] wDSizeX = iDSizeX;
wire 	signed [pVdisplayWidth:0] wDSizeY = iDSizeY;
// X軸
wire 	signed [pHdisplayWidth:0] wDRightXinit = iDStartX + wDSizeX;		// X軸 初期値
// Y軸
wire 	signed [pVdisplayWidth:0] wDTopYinit		= iDStartY;					// Y軸 Top 初期値
wire 	signed [pVdisplayWidth:0] wDUnderYinit 		= iDStartY + wDSizeY;		// Y軸 Under 初期値
wire 	signed [pVdisplayWidth:0] wDTopBasicYRise	= rDTopY   - iBasicGainY;	// 上昇時 Top 座標
wire 	signed [pVdisplayWidth:0] wDTopBasicYFall	= rDTopY   + iBasicGainY;	// 下降時 Top 座標
wire 	signed [pVdisplayWidth:0] wDUnderBasicYRise	= rDUnderY - iBasicGainY;	// 上昇時 Under 座標
wire 	signed [pVdisplayWidth:0] wDUnderBasicYFall	= rDUnderY + iBasicGainY;	// 下降時 Under 座標
// Y軸 ジャンプ
wire 	signed [pVdisplayWidth:0] wDTopJumpYRise	= rDTopY   - rJumpGainY;	// 上昇時 Top 座標
wire 	signed [pVdisplayWidth:0] wDTopJumpYFall	= rDTopY   + rJumpGainY;	// 下降時 Top 座標
wire 	signed [pVdisplayWidth:0] wDUnderJumpYRise	= rDUnderY - rJumpGainY;	// 上昇時 Under 座標
wire 	signed [pVdisplayWidth:0] wDUnderJumpYFall	= rDUnderY + rJumpGainY;	// 下降時 Under 座標
//
reg qDUnderOverflow;

always @(posedge iClk)
begin
	// // x軸 Left
    // if (iRst)   	rDLeftX <= iDStartX;
	// else if (qFe)	rDLeftX <= rDLeftX + iDGainX;
    // else        	rDLeftX <= rDLeftX;

	// // x軸 Right
	// casex ({qDUnderOverflow, qJumpPeakY, qFe, iSlideEn})
	// 	'bxxx0:		rDRightX <= wDRightXinit;
	// 	'b1111:		rDRightX <= wDRightXinit;
	// 	'bx011:		rDRightX <= wDTopBasicYRise;
	// 	'bx111:		rDRightX <= wDTopBasicYFall;
	// 	default: 	rDRightX <= rDRightX;
	// endcase

	// y軸 Top
	if (iRst)
	begin
		rDTopY <= wDTopYinit;
	end
	else
	begin
		casex ({qDUnderOverflow, qFe, qJumpPeakY, rJumpCkeY, iUnderCkeY, iTopCkeY})
			'bxxx000:	rDTopY <= rDTopY;
			'bx1x001:	rDTopY <= wDTopBasicYRise;
			'bx1x010:	rDTopY <= wDTopBasicYFall;
			'b0101xx:	rDTopY <= wDTopJumpYRise;
			'b0111xx:	rDTopY <= wDTopJumpYFall;
			default: 	rDTopY <= rDTopY;
		endcase
	end

	// y軸 Under
	if (iRst)
	begin
		rDUnderY <= wDUnderYinit;
	end
	else
	begin
		casex ({qDUnderOverflow, qFe, qJumpPeakY, rJumpCkeY, iUnderCkeY, iTopCkeY})
			'bxxx0:		rDUnderY <= wDUnderYinit;
			'b1111:		rDUnderY <= wDUnderYinit;
			'bx011:		rDUnderY <= wDUnderBasicYRise;
			'bx111:		rDUnderY <= wDUnderBasicYFall;
			default: 	rDUnderY <= rDUnderY;
		endcase
	end
end

always @*
begin
	qVDownPoint 	<= (iVdisplay == rDUnderY);		// 物体の最下点とディスプレイの最下点を参照
	qDUnderOverflow	<= (iVdisplay < wDUnderBasicYFall);	// 落下中 次フレームの Y座標が画面外の時 地面に着地する
end


endmodule