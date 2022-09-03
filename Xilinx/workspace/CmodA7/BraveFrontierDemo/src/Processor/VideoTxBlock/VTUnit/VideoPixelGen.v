//----------------------------------------------------------
// Create 2022/8/30
// Author koutakimura
// -
// 1pixel毎の描画データ生成
// 
//----------------------------------------------------------
module VideoPixelGen #(
	// Display Size
    parameter       				pHdisplayWidth	= 11,
    parameter       				pVdisplayWidth	= 11,
	// Color Depth
	parameter						pColorDepth		= 16
)(
	// Internal Port
	// Ufi
	//
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
	//
	output	[pColorDepth-1:0]		oPixel,
    output                       	oVd,
	// output 							o
    // CLK Reset
    input           				iRst,
	input 							iCke,
    input           				iClk
);

assign oPixel = 16'h00f0;

//-----------------------------------------------------------------------------
// Csr レジスタ入力値を配線遅延など考慮して一度レジスタで受信する
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
	.iCke			(iCke),
	.iClk			(iClk)
);


//-----------------------------------------------------------------------------
// 本来はメモリからバス経由で描画データを受信して四角形を生成するが、
// まだそこまでいっていないため、レジスタ経由にしている
//-----------------------------------------------------------------------------
wire [pColorDepth-1:0] 	wDotSquare;				assign oPixel = wDotSquare;
wire 					wPixelVd;				assign oVd 	  = wPixelVd;


// generate
DotSquareGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth)
) DOT_SQUARE_GEN (
	.iHpos				(wPixelDrawHpos),
	.iVpos				(wPixelDrawVpos),
	.iDxs				(0),
	.iDxe				(32),
	.iDys				(0),
	.iDye				(32),
	.iPixel				(16'h0f00),
	.oPixel				(wDotSquare),
	.oVd				(wPixelVd)
);


endmodule