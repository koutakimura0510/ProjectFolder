 //----------------------------------------------------------
 // Create 2022/09/07
 // Author koutakimura
 // -
 // ドットデータを結合し一つのピクセルデータに変換する
 //----------------------------------------------------------
module DotMargeToPixelConverter #(
	parameter						pColorDepth		= 16,
	parameter 						pFifoDepth		= 16,
	parameter 						pFifoBitWidth	= 16,
	parameter						pFifoFastOutValue = 10
)(
	// Internal Port
    input  [pColorDepth-1:0]		iField,
    input  [pColorDepth-1:0]		iNpc,
    input  [pColorDepth-1:0]		iPlayer,
    input  [pColorDepth-1:0]		iObject,
    input  [pColorDepth-1:0]		iEffect1,
    input  [pColorDepth-1:0]		iEffect2,
    input  [pColorDepth-1:0]		iForeground,
    input  [pColorDepth-1:0]		iMenuWindow,
    input  [pColorDepth-1:0]		iVpgDemo,
	input  [pColorDepth-1:0]		iSceneChange,
	// control
	input 							iEds,
	output 							oFull,
    output [pFifoBitWidth-1:0]    	oDd,
	output 							oVdd,
	input 							iEdd,
	output 							oEmp,
	// Clk rst
    input                       	iRst,
    input                       	iClk
);


//-----------------------------------------------------------------------------
// オーバーレイ処理
//-----------------------------------------------------------------------------
wire [pColorDepth-1:0]	wDstPixel;
wire 					wWe;

OverlayMerge #(
	.pDspUsed		("yes"),
	.pColorDepth	(pColorDepth)
) OverlayMerge (
	.iSrcPixel		(iVpgDemo),
	.iOverlayPixel	(iSceneChange),
	.iWe			(iEds),
	.oDstPixel		(wDstPixel),
	.oWe			(wWe),
	.iRst			(iRst),
	.iClk			(iClk)
);


//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
// fifoController #(
// 	.pFifoDepth		(pFifoDepth),
// 	.pFifoBitWidth	(pFifoBitWidth)
// ) InstDotMargeToPixelConverterFifo (
// 	// src side
// 	.iWd			(iVpgDemo),
// 	.iWe			(iEds),
// 	.oFull			(oFull),
// 	// dst side
// 	.oRd			(oDd),
// 	.oRvd			(oVdd),
// 	.iRe			(iEdd),
// 	.oEmp			(oEmp),
// 	//
// 	.iRst			(iRst),
// 	.iClk			(iClk)
// );
fifoControllerLutRam #(
	.pFifoDepth			(pFifoDepth),
	.pFifoBitWidth		(pFifoBitWidth),
	.pFifoFastOutValue	(pFifoFastOutValue)
) fifoControllerLutRam (
	// src side
	.iWd			(wDstPixel),
	.iWe			(wWe),
	.oFull			(oFull),
	// dst side
	.oRd			(oDd),
	.oRVd			(oVdd),
	.iRe			(iEdd),
	.oEmp			(oEmp),
	//
	.iRst			(iRst),
	.iClk			(iClk)
);


endmodule