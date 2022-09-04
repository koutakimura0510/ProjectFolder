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
wire [pColorDepth-1:0] 	wDotSquare;
wire 					wPixelVd;

DotSquareGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth)
) DOT_SQUARE_GEN (
	.iHpos				(wPixelDrawHpos),
	.iVpos				(wPixelDrawVpos),
	.iDxs				(1),
	.iDxe				(32),
	.iDys				(1),
	.iDye				(32),
	.iPixel				(16'h0f00),
	.oPixel				(wDotSquare),
	.oVd				(wPixelVd),
	.iRst				(iRst),
	.iCke				(iCke),
	.iClk				(iClk)
);


//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
reg [pOutColorDepth-1:0] rPixel;		assign oPixel = rPixel;
wire wVd;								assign oVd 	  = wVd;

always @(posedge iClk)
begin
	if (wPixelVd)	rPixel <= wDotSquare[pOutColorDepth-1:0];
	else 			rPixel <= {pOutColorDepth{1'b1}};
end

SftReg #(
	.pBitWidth		(1),
	.pSftRegDepth	(1),
	.pLutRam		("no")
) COLOR_SFT_REG (
	.iD				(iCke),
	.oQ				(wVd),
	.iRst			(iRst),
	.iClk			(iClk)
);

endmodule