 //----------------------------------------------------------
 // Create 2022/09/07
 // Author koutakimura
 // -
 // ドットデータを結合し一つのピクセルデータに変換する
 //----------------------------------------------------------
module DotMargeToPixelConverter #(
	parameter						pColorDepth		= 16,
	parameter 						pFifoDepth		= 16,
	parameter 						pFifoBitWidth	= 16
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
wire [pColorDepth-1:0]	wSrcPixel;
wire 					wWe;

// OverlayMarge #(
// 	.pDspUsed		("yes"),
// 	.pColorDepth	(pColorDepth)
// ) OverlayMarge (
// 	.iSrcPixel		(iVpgDemo),
// 	.iOverlayPixel	(iSceneChange),
// 	.iWe			(iEds),
// 	.oDstPixel		(wSrcPixel),
// 	.oWe			(wWe),
// 	.iRst			(iRst),
// 	.iClk			(iClk)
// );


//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) InstDotMargeToPixelConverterFifo (
	// src side
	.iWd			(iVpgDemo),
	.iWe			(iEds),
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
// fifoController #(
// 	.pFifoDepth		(pFifoDepth),
// 	.pFifoBitWidth	(pFifoBitWidth)
// ) InstDotMargeToPixelConverterFifo (
// 	// src side
// 	.iWd			(wSrcPixel),
// 	.iWe			(wWe),
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


endmodule