//----------------------------------------------------------
// Create 2022/8/30
// Author koutakimura
// -
// 1pixel毎の描画データ生成
// 
// ※ Zynq プロジェクト時の考え方の違いがある。
// ソフトで座標やアニメーション表現したときは、インターバルタイマー関数や
// PL 部でカウントしているカウント値を読んで「時間」で処理の決定を行っていたが、
// 今回からは 1Frame 単位で処理を行う。
// こうしないと指定の FPS が出ているか確認できないし、時間だとタイミングが正しいのか分からなくなる。
// 「秒数を計測して処理をさせる」は制限時間などに用いて、描画には極力用いないこと。
// -
// レイヤーの並び順は下記の通りである。
// 遠景
// 背景
// フィールド
// NPC
// プレイヤー
// 前オブジェクト
// エフェクト
// 前景
// メニュー
// シーン
// module を平行に並べるため、一番レイテンシが大きいブロックで処理速度が決定する。
// -
// module 共通プレフィックス
// D = Draw
// -
//----------------------------------------------------------
module VideoPixelGen #(
	// Display Size
    parameter       				pHdisplayWidth	= 11,
    parameter       				pVdisplayWidth	= 11,
	// Color Depth
	parameter						pColorDepth		= 16,
	// non valiable
	parameter						pOutColorDepth	= pColorDepth - (pColorDepth / 4) // alpha値を除いたbit幅
)(
	// Internal Port
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	//
	output	[pOutColorDepth-1:0]	oPixel,
    output                       	oWEd,
    // CLK Reset
    input           				iRst,
	input 							iCke,
    input           				iClk
);


//-----------------------------------------------------------------------------
// Csr レジスタ入力値を配線遅延など考慮して一度レジスタで受信する
// 横幅 480 の場合、0 ~ 479 の範囲を使用するため、設定値から -1 した値を各 module で利用する
//-----------------------------------------------------------------------------
reg	[pHdisplayWidth-1:0] rHdisplay;
reg	[pVdisplayWidth-1:0] rVdisplay;
reg	[pHdisplayWidth-1:0] qHdisplay;
reg	[pVdisplayWidth-1:0] qVdisplay;

initial
begin
	rHdisplay = {pHdisplayWidth{1'b0}};
	rVdisplay = {pVdisplayWidth{1'b0}};
end

always @(posedge iClk)
begin
	rHdisplay <= iHdisplay - 1'b1;
	rVdisplay <= iVdisplay - 1'b1;
end

always @*
begin
	qHdisplay <= rHdisplay;
	qVdisplay <= rVdisplay;
end


//-----------------------------------------------------------------------------
// Draw Module で共通利用する内部で高速な描画座標の生成
//-----------------------------------------------------------------------------
wire [pHdisplayWidth-1:0] 	wPixelDrawHpos;
wire [pVdisplayWidth-1:0] 	wPixelDrawVpos;
wire 						wAFE;
reg 						qPixelDrawPositionCke;

PixelDrawPosition #(
	.pHdisplayWidth	(pHdisplayWidth),
	.pVdisplayWidth	(pVdisplayWidth)
) PixelDrawPosition (
	.iHdisplay		(qHdisplay),
	.iVdisplay		(qVdisplay),
	.oHpos			(wPixelDrawHpos),
	.oVpos			(wPixelDrawVpos),
	.oAFE			(wAFE),
	.iRst			(iRst),
	.iCke			(qPixelDrawPositionCke),
	.iClk			(iClk)
);

//-----------------------------------------------------------------------------
// Draw Module で共通利用するマップ情報
// ※ 現在座標からの算出されるマップ情報は、キャラクターの移動・フィールド生成などにも使用されるため共通で必要
//-----------------------------------------------------------------------------
localparam lpMapIdBitWidth 	= 8;
localparam lpMapXSize		= 150;
localparam lpMapYSize		= 150;
MapInfo #(
	.pMapIdBitWidth		(lpMapIdBitWidth),
	.pMapXSize			(lpMapXSize),
	.pMapYSize			(lpMapYSize)
) MapInfo (

);


//-----------------------------------------------------------------------------
// DistantView Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Background Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Field Draw
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// NPC Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Player Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Object Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Effect Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Foreground Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Menu Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Scene Draw
//-----------------------------------------------------------------------------
localparam lpDotSquareGenFifoDepth = 16;
//
reg 					qDotSquareEds;
wire 					wDotSquareFull;
wire [pColorDepth-1:0] 	wDotSquareDd;
wire 					wDotSquareVdd;
reg  					qDotSquareEdd;
wire 					wDotSquareEmp;

SceneChange #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth),
	.pFifoDepth			(lpDotSquareGenFifoDepth),
	.pFifoBitWidth		(pColorDepth)
) SceneChange (
	.iColor				(16'h00f0),
	.iHdisplay			(qHdisplay),
	.iVdisplay			(qVdisplay),
	.iHpos				(wPixelDrawHpos),
	.iVpos				(wPixelDrawVpos),
	.iFe				(wAFE),
	.iEds 				(qDotSquareEds),
	.oFull				(wDotSquareFull),
	.oDd				(wDotSquareDd),
	.oVdd				(wDotSquareVdd),
	.iEdd				(qDotSquareEdd),
	.oEmp				(wDotSquareEmp),
	.iRst				(iRst),
	.iClk				(iClk)
);

always @*
begin
	qDotSquareEds			<= (~wDotSquareFull);
	qPixelDrawPositionCke 	<= (~wDotSquareFull);
end


//-----------------------------------------------------------------------------
// Final Stage ドットデータを結合し一つのピクセルデータに変換する
//-----------------------------------------------------------------------------
localparam lpDotMargeToPixelConverterFifoDepth = 16;

wire [pOutColorDepth-1:0] wPixelMargeDd;		assign oPixel = wPixelMargeDd;
wire  wPixelMargeVdd;							assign oWEd 	  = wPixelMargeVdd;
wire  wPixelMargeFull;
wire  wPixelMargeEmp;
reg   qPixelMargeEds;
reg   qPixelMargeEdd;

DotMargeToPixelConverter #(
	.pColorDepth	(pColorDepth),
	.pFifoDepth		(lpDotMargeToPixelConverterFifoDepth),
	.pFifoBitWidth	(pOutColorDepth)
) DotMargeToPixelConverter (
	.iDistantground	({pColorDepth{1'b0}}),
	.iBackground	(wDotSquareDd),
	.iField			({pColorDepth{1'b0}}),
	.iNpc			({pColorDepth{1'b0}}),
	.iPlayer		({pColorDepth{1'b0}}),
	.iObject		({pColorDepth{1'b0}}),
	.iEffect1		({pColorDepth{1'b0}}),
	.iEffect2		({pColorDepth{1'b0}}),
	.iForeground	({pColorDepth{1'b0}}),
	.iMenuWindow	({pColorDepth{1'b0}}),
	.iEds			(qPixelMargeEds),
	.oFull			(wPixelMargeFull),
	.oDd			(wPixelMargeDd),
	.oVdd			(wPixelMargeVdd),
	.iEdd			(qPixelMargeEdd),
	.oEmp			(wPixelMargeEmp),
	.iRst			(iRst),
	.iClk			(iClk)
);

always @*
begin
	qPixelMargeEds	<= wDotSquareVdd;
	qPixelMargeEdd 	<= (~wPixelMargeEmp) & iCke;
	qDotSquareEdd	<= (~wPixelMargeFull);
end


endmodule