//----------------------------------------------------------
// Create 2022/8/30
// Author koutakimura
// -
// 1pixel毎の描画データ生成
// 
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
// -
// 上記の並び順で各 module を前後のレイヤーと接続する。
// module を平行に並べるため、一番レイテンシが大きいブロックで処理速度が決定する。
// 
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
	// Ufi
	//
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	//
	output	[pOutColorDepth-1:0]	oPixel,
    output                       	oVd,
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
// 描画座標の生成
//-----------------------------------------------------------------------------
wire [pHdisplayWidth-1:0] 	wPixelDrawHpos;
wire [pVdisplayWidth-1:0] 	wPixelDrawVpos;
wire 						wAFE;
reg 						qPixelDrawPositionCke;

PixelDrawPosition #(
	.pHdisplayWidth	(pHdisplayWidth),
	.pVdisplayWidth	(pVdisplayWidth)
) PIXEL_DRAW_POSITION (
	.iHdisplay		(qHdisplay),
	.iVdisplay		(qVdisplay),
	.oHpos			(wPixelDrawHpos),
	.oVpos			(wPixelDrawVpos),
	.oAFE			(wAFE),
	.iRst			(iRst),
	.iCke			(qPixelDrawPositionCke),
	.iClk			(iClk)
);


//---------------------------------------------------------------------------
// 本来はメモリからバス経由で描画データを受信して四角形を生成するが、
// まだそこまでいっていないため、レジスタ経由にしている
//---------------------------------------------------------------------------

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
localparam lpDotSquareGenFifoDepth = 32;
localparam lpDxs = 0;
localparam lpDxe = lpDxs + 16;
localparam lpDys = 0;
localparam lpDye = lpDys + 16;
//
reg  					qDotSquareEdd;
reg 					qDotSquareEds;
wire [pColorDepth-1:0] 	wDotSquareDd;
wire 					wDotSquareVdd;
wire 					wDotSquareEmp;
wire 					wDotSquareFull;

DotSquareGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth),
	.pFifoDepth			(lpDotSquareGenFifoDepth),
	.pFifoBitWidth		(pColorDepth)
) DOT_SQUARE_GEN (
	.iPixel				(16'h0f33),
	.iHpos				(wPixelDrawHpos),
	.iVpos				(wPixelDrawVpos),
	.iDxs				(lpDxs),
	.iDxe				(lpDxe),
	.iDys				(lpDys),
	.iDye				(lpDye),
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
wire [pOutColorDepth-1:0] wPixelMargeDd;		assign oPixel = wPixelMargeDd;
wire  wPixelMargeVdd;							assign oVd 	  = wPixelMargeVdd;
wire  wPixelMargeFull;
wire  wPixelMargeEmp;
reg   qPixelMargeEds;
reg   qPixelMargeEdd;

DotMargeToPixelConverter #(
	.pColorDepth	(pColorDepth),
	.pFifoDepth		(16),
	.pFifoBitWidth	(pOutColorDepth)
) DMT_PIXEL_CONVERTER (
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