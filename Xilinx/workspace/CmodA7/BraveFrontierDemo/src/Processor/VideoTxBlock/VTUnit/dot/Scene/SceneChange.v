//----------------------------------------------------------
// Create 2022/09/27
// Author koutakimura
// -
// 
//----------------------------------------------------------
module SceneChange #(
    parameter                   	pHdisplayWidth  = 11,
    parameter                   	pVdisplayWidth  = 11,
	parameter						pColorDepth		= 16,
	//
	parameter						pFifoDepth 		= 16,
	parameter						pFifoBitWidth	= 16
)(
	// Internal Port
	// Status
    input			[pColorDepth-1:0]		iColor,		// 描画色
	input	signed	[pHdisplayWidth:0]		iHdisplay,	// 画面横サイズ
	input	signed	[pVdisplayWidth:0]		iVdisplay,	// 画面縦サイズ
    input  			[pHdisplayWidth-1:0]    iHpos,		// 現在の横座標
    input  			[pVdisplayWidth-1:0]    iVpos,		// 現在の縦座標
	input 									iFe,
	// control
	input 									iEds,		// Enable Data Src
	output 									oFull,		// FIFO Full
	output 									oVdd,		// Valid Dest Data 
    output 	[pColorDepth-1:0]    			oDd,		// Dest Data
	input 									iEdd,		// Enable Data Dest
	output 									oEmp,		// FIFO Empty
	// Clk rst
    input                       			iRst,
    input                       			iClk
);


//-----------------------------------------------------------------------------
// Enable 生成
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// 描画座標の更新
//-----------------------------------------------------------------------------
wire signed [pHdisplayWidth:0] wDLeftX;
wire signed [pHdisplayWidth:0] wDRightX;
wire signed [pVdisplayWidth:0] wDTopY;
wire signed [pVdisplayWidth:0] wDUnderY;

SquarePosGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pGainWidth			(7)
) SquarePosGen (
	.iHdisplay			(iHdisplay),
	.iVdisplay			(iVdisplay),
	.iFe				(iFe),
	.iDStartX			(),
	.iDStartY			(),
	.iDSizeX			(),
	.iDSizeY			(),
	.iDGainX			(),
	.iDGainY			(),
	.oDLeftX			(wDLeftX),
	.oDRightX			(wDRightX),
	.oDTopY				(wDTopY),
	.oDUnderY			(wDUnderY),
	.iRst				(iRst),
	.iClk				(iClk)
);



//-----------------------------------------------------------------------------
// 四角形の生成
//-----------------------------------------------------------------------------
wire [pColorDepth-1:0] wPixel;

DotSquareGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth)
) DotSquareGen (
	.oPixel 			(wPixel),
	.iColor				(iPixel),
	.iHpos				(iHpos),
	.iVpos				(iVpos),
	.iDLeftX			(wDLeftX),
	.iDRightX			(wDRightX),
	.iDTopY				(wDTopY),
	.iDUnderY			(wDUnderY),
	//
	.iRst				(iRst),
	.iClk				(iClk)
);


//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
reg rWe;	// 前段の pixelデータが 1clk 遅れのためタイミングを合わせる

fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) InstDotSquareFifo (
	// src side
	.iWd			(wPixel),
	.iWe			(rWe),
	.oFull			(oFull),
	// dst side
	.oRd			(oDd),
	.oRvd			(oVdd),
	.iRe			(iEdd),
	.oEmp			(oEmp),
	//
	.iRst			(iRst),
	.iClk			(iClk)
);

always @(posedge iClk)
begin
	if (iRst) 		rWe <= 1'b0;
	else if (iEds)	rWe <= 1'b1;
	else 			rWe <= 1'b0;
end


endmodule