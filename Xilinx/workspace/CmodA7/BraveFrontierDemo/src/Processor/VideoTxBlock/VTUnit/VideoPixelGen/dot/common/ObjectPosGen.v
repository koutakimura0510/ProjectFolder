//----------------------------------------------------------
// Create 2022/09/27
// Author koutakimura
// -
// 設定値に合わせて座標を生成する
// -
// 2022-09-29 画面外の座標生成に対応 (負の値に対応)
// 
//----------------------------------------------------------
module ObjectPosGen #(
    parameter								pHdisplayWidth  	= 11,
    parameter								pVdisplayWidth  	= 11,
	parameter								pBasicGainBitWdith	= 3,	// 通常移動量のレジスタ幅
	parameter								pDashGainBitWdith	= 4,	// ダッシュ移動量のレジスタ幅
	parameter								pJumpJyroBitWidth	= 4		// ジャンプ加速度のレジスタ幅
)(
	// Internal Port
	// 現在の座標
	output	signed 	[pHdisplayWidth:0] 		oDLeftX,			// x軸 左点
	output	signed 	[pHdisplayWidth:0] 		oDRightX,			// x軸 右点
	output	signed 	[pVdisplayWidth:0] 		oDTopY,				// y軸 上点
	output	signed 	[pVdisplayWidth:0] 		oDUnderY,			// y軸 下点
	// Display,Sync 
	input			[pHdisplayWidth-1:0]	iHdisplay,			// 画面横サイズ
	input			[pVdisplayWidth-1:0]	iVdisplay,			// 画面縦サイズ
    input									iFe,				// Frame End
	// 描画開始座標
	input	signed	[pHdisplayWidth:0]		iDInitX,			// x軸 開始点
	input	signed	[pVdisplayWidth:0]		iDInitY,			// y軸 開始点
	// 描画サイズ
	input			[pHdisplayWidth-1:0]	iDSizeX,			// XSize ※描画サイズが負の整数になることはない
	input			[pVdisplayWidth-1:0]	iDSizeY,			// YSize ※そのため、内部で 1bit 拡張のキャストで計算に使用する
	// ダッシュ機能
	// input 	signed	[pDashGainBitWdith:0]	iDashPeakX,		// Dash 最高速
	input 	signed	[pDashGainBitWdith:0]	iDashGainX,			// Dash 加速度
	input 									iDashCkeX,			// Dash ON 1, OFF 0
	// ジャンプ機能
	input 	signed	[pVdisplayWidth:0]		iJumpPeakY,			// Jump Y軸 頂点
	input 	signed	[pVdisplayWidth:0]		iJumpGainY,			// Jump 初速
	input 	signed  [pJumpJyroBitWidth:0]	iJumpJyroMaxY,		// Jump 最大加速度
	input 	signed  [pJumpJyroBitWidth:0]	iJumpJyroMinY,		// Jump 最小加速度
	input 			[5:0]					iJumpUpdateTiming,	// Jump 更新頻度 60fps のbit幅確保 0~64
	input 									iJumpCkeY,			// Jump ON 1, OFF 0
	// 通常動作
	input 	signed	[pBasicGainBitWdith:0]	iBasicGainX,		// X軸 通常動作時の 移動量
	input 	signed	[pBasicGainBitWdith:0]	iBasicGainY,		// Y軸 通常動作時の 移動量
	input 									iLeftCkeX,			// 左方向移動 Enable
	input 									iRightCkeX,			// 右方向移動 Enable
	input 									iTopCkeY,			// 上方向移動 Enable
	input 									iUnderCkeY,			// 下方向移動 Enable
	// 当たり判定
	output 									oRightWallPointX,
	output 									oLeftWallPointX,
	// Clk rst
	input									iRst,
	input									iClk
);


//-----------------------------------------------------------------------------
// localparam 
//-----------------------------------------------------------------------------
localparam lpHdisplayWidth = pHdisplayWidth + 1'b1;
localparam lpVdisplayWidth = pVdisplayWidth + 1'b1;
// DisplaySize 符号拡張
wire signed	[pHdisplayWidth:0]	wHdisplay = {1'b0, iHdisplay};
wire signed	[pVdisplayWidth:0]	wVdisplay = {1'b0, iVdisplay};


//-----------------------------------------------------------------------------
// Y軸 ジャンプ移動量計算
//-----------------------------------------------------------------------------
reg  	signed [pVdisplayWidth:0] 	rJumpPeakY;
reg		signed [pVdisplayWidth:0] 	rJumpGainY;			
reg 								rJumpCkeY;			// jump 中とみなすための Cke
reg            				[5:0]	rJumpUpdateTiming;
reg									qJumpUpdateTiming;
reg 								qGroundPointY;
reg 								qJumpPeakY;
reg 								qJumpJyroMaxComp;
reg 								qJumpJyroMinComp;
//
wire 	signed [pVdisplayWidth:0] 	wJumpPeakY  = rJumpPeakY - rJumpGainY;
wire 	signed [pVdisplayWidth:0]	wJumpRiseY	= qJumpUpdateTiming ? rJumpGainY - 1'b1 : rJumpGainY;
wire 	signed [pVdisplayWidth:0]	wJumpFallY	= qJumpUpdateTiming ? rJumpGainY + 1'b1 : rJumpGainY;

always @(posedge iClk)
begin
	//-----------------------------------------------------------------------------
	// ジャンプ後は 次回ジャンプ可能地点に着地するまで、ジャンプの一連の動作を継続する
	// なるべく Cke 生成ロジックで制御信号を確認するようにして、ロジックを複雑にしないように
	// 後段の 計算などには 無駄な Sel を使用しないようにする。
	// 基本的には 座標の更新は Frame単位で行われるため、Cke の生成がレジスタ経由で 1Clk 遅れたとしても全く問題ない
	//-----------------------------------------------------------------------------
	if (iRst)
	begin
		rJumpCkeY <= 1'b0;
	end
	else
	begin
		// TODO 追加予定
		// アクション要素を入れる場合、例えば敵を踏んで更に飛ぶときなど専用の Cke を用意して追加
		casex ({qGroundPointY, rJumpCkeY, iJumpCkeY})
			'bx01: 		rJumpCkeY <= 1'b1;
			'b01x: 		rJumpCkeY <= 1'b1;
			'b11x: 		rJumpCkeY <= 1'b0;
			default:	rJumpCkeY <= rJumpCkeY;
		endcase
	end

	//-----------------------------------------------------------------------------
	// 何Frame に一度 Jump更新計算を行うのか指定する
	// 滑らかなジャンプを再現するために必要だった
	//-----------------------------------------------------------------------------
	casex ({qJumpUpdateTiming, iFe, rJumpCkeY})
		'bxx0:		rJumpUpdateTiming <= 6'd0;
		'b011:		rJumpUpdateTiming <= rJumpUpdateTiming + 1'b1;
		'b111:		rJumpUpdateTiming <= 6'd0;
		default:	rJumpUpdateTiming <= rJumpUpdateTiming;
	endcase

	//-----------------------------------------------------------------------------
	// ジャンプ高さの計算
	//-----------------------------------------------------------------------------
	casex ({qJumpPeakY, iFe, rJumpCkeY, iJumpCkeY})
		'bxx0x:		rJumpPeakY <= iJumpPeakY;						// 初期値
		'b0110:		rJumpPeakY <= {1'b1, {pVdisplayWidth{1'b0}}};	// ジャンプ中 iJumpCkeY が Disert されたとき、Disert の地点から落下する
		'b0111:		rJumpPeakY <= wJumpPeakY;						// 頂点に達するまで計算
		default: 	rJumpPeakY <= rJumpPeakY;						// 頂点に達した後は着地するまで固定
	endcase

	//-----------------------------------------------------------------------------
	// 加速度の計算
	//-----------------------------------------------------------------------------
	casex ({qJumpJyroMaxComp, qJumpJyroMinComp, qJumpPeakY, iFe, rJumpCkeY})
		'bxxxx0:	rJumpGainY <= iJumpGainY;
		'bx0011:	rJumpGainY <= wJumpRiseY;		// 上昇量取得、緩やかに減速していく
		'b0x111:	rJumpGainY <= wJumpFallY;		// 下降量取得、緩やかに加速していく
		default: 	rJumpGainY <= rJumpGainY;
	endcase
end

always @*
begin
	qJumpPeakY			<= rJumpPeakY[pVdisplayWidth];		// 負の値を検出時、頂点に達したとみなす
	qJumpJyroMaxComp	<= (iJumpJyroMaxY == rJumpGainY);
	qJumpJyroMinComp	<= (iJumpJyroMinY == rJumpGainY);
	qJumpUpdateTiming	<= (rJumpUpdateTiming == iJumpUpdateTiming);
end


//-----------------------------------------------------------------------------
// 水平移動速度 計算
// Dash 中は 固定値で加算する方式に変更した、そのため input iDashPeakX コメントアウト
//-----------------------------------------------------------------------------
// localparam lpDashFrameCntBitWidth = 4;

// reg [lpDashFrameCntBitWidth-1:0] 		rDashFrameCnt;
// reg		signed	[pDashGainBitWdith:0]	rDashGainX;
// wire 	signed	[pDashGainBitWdith:0]	wDashGainX = rDashGainX + 1'b1;;
// //
// reg 									qDashFrameCntCke;
// reg 									qDashPeak;

// always @(posedge iClk)
// begin
// 	// Dash は指定回数のフレームの更新があった場合に、移動量を増幅させる
// 	casex ({iFe, iDashCkeX})
// 		'bx0:		rDashFrameCnt <= {lpDashFrameCntBitWidth{1'b0}};
// 		'b11:		rDashFrameCnt <= rDashFrameCnt + 1'b1;
// 		default: 	rDashFrameCnt <= rDashFrameCnt;
// 	endcase

// 	casex ({qDashPeak, qDashFrameCntCke, iFe, iDashCkeX})
// 		'bxxx0:		rDashGainX <= iDashGainX;
// 		'b0111:		rDashGainX <= wDashGainX;	// 緩やかに加速
// 		'b0011:		rDashGainX <= wDashSpeed;
// 		default: 	rDashGainX <= rDashSpeed;
// 	endcase
// end

// always @*
// begin
// 	qDashPeak			<= iDashPeakX == rDashGainX;
// 	qDashFrameCntCke 	<= &{rDashFrameCnt};
// end


//-----------------------------------------------------------------------------
// 座標計算
//-----------------------------------------------------------------------------
localparam 	[pHdisplayWidth:0] lpDRightWallXAdd	= 119;
localparam 	[pHdisplayWidth:0] lpDRightWallXSub	= 31;
localparam 	[pHdisplayWidth:0] lpDLeftWallXAdd	= 119 - 32;
localparam 	[pHdisplayWidth:0] lpDLeftWallXSub	= 0;

reg		signed [pHdisplayWidth:0] rDLeftX;			assign oDLeftX 	= rDLeftX;
reg		signed [pHdisplayWidth:0] rDRightX;			assign oDRightX = rDRightX;
reg		signed [pVdisplayWidth:0] rDTopY;			assign oDTopY 	= rDTopY;
reg		signed [pVdisplayWidth:0] rDUnderY;			assign oDUnderY	= rDUnderY;
// 符号拡張
wire 	signed [pHdisplayWidth:0] wDSizeX			= iDSizeX;
wire 	signed [pVdisplayWidth:0] wDSizeY			= iDSizeY;
// X軸 Basic
wire 	signed [pHdisplayWidth:0] wDLeftXinit		= iDInitX;					// X軸 Left 初期値
wire 	signed [pHdisplayWidth:0] wDRightXinit		= iDInitX  + wDSizeX;		// X軸 Right 初期値
wire 	signed [pHdisplayWidth:0] wDLeftBasicXAdd	= rDLeftX  + iBasicGainX;	// X軸 Work Left 次フレーム座標
wire 	signed [pHdisplayWidth:0] wDLeftBasicXSub	= rDLeftX  - iBasicGainX;	// X軸 Work Left 次フレーム座標
wire 	signed [pHdisplayWidth:0] wDRightBasicXAdd	= rDRightX + iBasicGainX;	// X軸 Work Right 次フレーム座標
wire 	signed [pHdisplayWidth:0] wDRightBasicXSub	= rDRightX - iBasicGainX;	// X軸 Work Right 次フレーム座標
// X軸 Dash
wire 	signed [pHdisplayWidth:0] wDLeftDashXAdd	= rDLeftX  + iDashGainX;	// X軸 Dash Left 次フレーム座標
wire 	signed [pHdisplayWidth:0] wDLeftDashXSub	= rDLeftX  - iDashGainX;	// X軸 Dash Left 次フレーム座標
wire 	signed [pHdisplayWidth:0] wDRightDashXAdd	= rDRightX + iDashGainX;	// X軸 Dash Right 次フレーム座標
wire 	signed [pHdisplayWidth:0] wDRightDashXSub	= rDRightX - iDashGainX;	// X軸 Dash Right 次フレーム座標
// Y軸 Basic
wire 	signed [pVdisplayWidth:0] wDTopYinit		= iDInitY;					// Y軸 Top 初期値
wire 	signed [pVdisplayWidth:0] wDUnderYinit		= iDInitY  + wDSizeY;		// Y軸 Under 初期値
wire 	signed [pVdisplayWidth:0] wDTopBasicYRise	= rDTopY   - iBasicGainY;	// 上昇時 Top 次フレーム座標
wire 	signed [pVdisplayWidth:0] wDTopBasicYFall	= rDTopY   + iBasicGainY;	// 下降時 Top 次フレーム座標
wire 	signed [pVdisplayWidth:0] wDUnderBasicYRise	= rDUnderY - iBasicGainY;	// 上昇時 Under 次フレーム座標
wire 	signed [pVdisplayWidth:0] wDUnderBasicYFall	= rDUnderY + iBasicGainY;	// 下降時 Under 次フレーム座標
// Y軸 Jump
wire 	signed [pVdisplayWidth:0] wDTopJumpYRise	= rDTopY   - rJumpGainY;	// 上昇時 Jump Top 次フレーム座標
wire 	signed [pVdisplayWidth:0] wDTopJumpYFall	= rDTopY   + rJumpGainY;	// 下降時 Jump Top 次フレーム座標
wire 	signed [pVdisplayWidth:0] wDUnderJumpYRise	= rDUnderY - rJumpGainY;	// 上昇時 Jump Under 次フレーム座標
wire 	signed [pVdisplayWidth:0] wDUnderJumpYFall	= rDUnderY + rJumpGainY;	// 下降時 Jump Under 次フレーム座標
//
reg 	qRightWallPointX;
reg 	qLeftWallPointX;
reg 	qDLeftOverflow;
reg 	qDRightOverflow;
reg 	qDUnderOverflow;


//-----------------------------------------------------------------------------
// x軸の座標更新
//-----------------------------------------------------------------------------
// 上位モジュールも使用するためレジスタ出力にもする
reg rRightWallPointX;						assign oRightWallPointX = rRightWallPointX;
reg rLeftWallPointX;						assign oLeftWallPointX  = rLeftWallPointX;

always @(posedge iClk)
begin
	if (iRst)	{rRightWallPointX, rLeftWallPointX}	<= 2'b00;
	else		{rRightWallPointX, rLeftWallPointX}	<= {qRightWallPointX, qLeftWallPointX};

	if (iRst)
	begin
		rDLeftX  <= wDLeftXinit;
		rDRightX <= wDRightXinit;
	end
	else
	begin
		//-----------------------------------------------------------------------------
		// 共通事項として
		// 1フレームの更新タイミングで、左右・ダッシュの cke 信号に応じて座標を更新する
		// 左右の座標を確認し、どちらかがオーバーフローしていれば画面端に座標をとどめる
		//-----------------------------------------------------------------------------
		casex ({qDLeftOverflow, qDRightOverflow, iFe, iDashCkeX, iLeftCkeX, iRightCkeX})
			'bxxx000:	rDLeftX <= rDLeftX;
			'bx01001:	rDLeftX <= wDLeftBasicXAdd;
			'b0x1010:	rDLeftX <= wDLeftBasicXSub;
			'bx01101:	rDLeftX <= wDLeftDashXAdd;
			'b0x1110:	rDLeftX <= wDLeftDashXSub;
			'bx11xxx:	rDLeftX <= lpDLeftWallXAdd;
			'b1x1xxx:	rDLeftX <= lpDLeftWallXSub;
			default: 	rDLeftX <= rDLeftX;
		endcase

		casex ({qDLeftOverflow, qDRightOverflow, iFe, iDashCkeX, iLeftCkeX, iRightCkeX})
			'bxxx000:	rDRightX <= rDRightX;
			'bx01001:	rDRightX <= wDRightBasicXAdd;
			'b0x1010:	rDRightX <= wDRightBasicXSub;
			'bx01101:	rDRightX <= wDRightDashXAdd;
			'b0x1110:	rDRightX <= wDRightDashXSub;
			'bx11xxx:	rDRightX <= lpDRightWallXAdd;
			'b1x1xxx:	rDRightX <= lpDRightWallXSub;
			default: 	rDRightX <= rDRightX;
		endcase
	end
end

always @*
begin
	// 左右の壁との衝突ポイント
	qRightWallPointX 	<= (wHdisplay == rDRightX);
	qLeftWallPointX		<= ({pHdisplayWidth{1'b0}} == rDLeftX);
	// 左右移動中、次フレームの X座標が画面外であれば Assert
	qDLeftOverflow		<= (wDLeftBasicXSub < 0) || (wDLeftDashXSub < 0);
	qDRightOverflow		<= (wHdisplay < wDRightBasicXAdd) || (wHdisplay < wDRightDashXAdd);
end

//-----------------------------------------------------------------------------
// y軸座標更新
//-----------------------------------------------------------------------------
always @(posedge iClk)
begin
	if (iRst)
	begin
		rDTopY   <= wDTopYinit;
		rDUnderY <= wDUnderYinit;
	end
	else
	begin
		//-----------------------------------------------------------------------------
		// jump 動作が必要な処理の場合、jump 中は上下キーの移動は受け付けない
		//-----------------------------------------------------------------------------
		casex ({qDUnderOverflow, iFe, qJumpPeakY, rJumpCkeY, iUnderCkeY, iTopCkeY})
			'bxxx000:	rDTopY <= rDTopY;
			'bx1x001:	rDTopY <= wDTopBasicYRise;
			'bx1x010:	rDTopY <= wDTopBasicYFall;
			'bx101xx:	rDTopY <= wDTopJumpYRise;
			'b0111xx:	rDTopY <= wDTopJumpYFall;
			'b1111xx:	rDTopY <= wDTopYinit;
			default: 	rDTopY <= rDTopY;
		endcase

		casex ({qDUnderOverflow, iFe, qJumpPeakY, rJumpCkeY, iUnderCkeY, iTopCkeY})
			'bxxx000:	rDUnderY <= rDUnderY;
			'bx1x001:	rDUnderY <= wDUnderBasicYRise;
			'bx1x010:	rDUnderY <= wDUnderBasicYFall;
			'bx101xx:	rDUnderY <= wDUnderJumpYRise;
			'b0111xx:	rDUnderY <= wDUnderJumpYFall;
			'b1111xx:	rDUnderY <= wDUnderYinit;
			default: 	rDUnderY <= rDUnderY;
		endcase
	end
end

always @*
begin
	// 物体の最下点とディスプレイの最下点を参照
	qGroundPointY 	<= (wVdisplay == rDUnderY);

	// 落下中、次フレームの Y座標が画面外であれば Assert
	// この信号線は、Jump 動作時のみに使用するため Jump 中の座標移動しか確認していない
	qDUnderOverflow	<= (wVdisplay < wDUnderJumpYFall);
end


endmodule