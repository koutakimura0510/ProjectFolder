//----------------------------------------------------------
// Create 2022/8/30
// Author koutakimura
// -
// 座標データに応じて、1pixel毎の描画データ生成
// 
//----------------------------------------------------------
module PixelDotGen #(
	// variable
    parameter                   	pHdisplayWidth  = 11,
    parameter                   	pVdisplayWidth  = 11,
	parameter						pColorRGBDepth	= 16		// ARGB bit深度 
)(
	// Internal Port
	// Ufi
	//
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	//
	output	[pColorDepth-1:0]		oPixel,
    output                       	oVd,
    // CLK Reset
    input           				iRst,
    input           				iClk
);


//-----------------------------------------------------------------------------
// システムクロックで内部で使用する座標データ生成
//-----------------------------------------------------------------------------
wire [pHdisplayWidth-1:0] wHpos;
wire [pVdisplayWidth-1:0] wVpos;

PixelPosGen #(
	.pHdisplayWidth	(pHdisplayWidth),
	.pVdisplayWidth	(pVdisplayWidth)
) PIXEL_POS_GEN (
	.iHdisplay		(iHdisplay),
	.iVdisplay		(iVdisplay),
	.oHpos			(wHpos),
	.oVpos			(wVpos),
	.oFrameEnd		(oFrameEnd),
	.iCke			(iCke),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);



//-----------------------------------------------------------------------------
// 本来はメモリからバス経由で描画データを受信して四角形を生成するが、
// まだそこまでいっていないため、レジスタ経由にしている
//-----------------------------------------------------------------------------
DotSquareGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorRGBDepth)
) DOT_SQUARE_GEN (
	.iHpos				(iHpos),
	.iVpos				(iVpos),
	.iDxs				(iDxs),
	.iDxe				(iDxe),
	.iDys				(iDys),
	.iDye				(iDye),
	.iPixel				(iPixel),
	.oPixel				(oPixel),
	.oVd				(oVd)
);


endmodule