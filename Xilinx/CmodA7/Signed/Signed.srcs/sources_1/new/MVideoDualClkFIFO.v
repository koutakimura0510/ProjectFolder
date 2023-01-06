//----------------------------------------------------------
// Create 2022/9/03
// Author koutakimura
// -
// クロック変換用途、及びピクセルデータの保持・読み出しを行う
// common の Dual CLK Contoroller を Instance することで、
// モジュールの入出力を自由に組み替える目的がある。
// 
//----------------------------------------------------------
module MVideoDualClkFIFO #(
    parameter 				pBuffDepth  = 1024,   	// FIFO BRAMのサイズ指定、画面サイズの横幅より大きくする
    parameter 				pBitWidth   = 16,      	// bitサイズ
	parameter 				pFullAlMost = 8			// 指定数値分早く Full 出力
)(
    input  [pBitWidth-1:0]  iWd,		// Write Data
    input                   iWe,		// Write Enable
    output                  ofull,
	//
    output [pBitWidth-1:0]  oRd,		// Read Data
    input                   iRe,		// Read Enable
	output 					oRvd,
	output 					oEmp,
	// clk rst
    input                   iSrcRst,	// Active High
    input                   iDstRst,	// Active High
    input                   iSrcClk,	// Source side clk
    input                   iDstClk		// Dest side clk
);


//-----------------------------------------------------------------------------
// FIFO 出力レイテンシ
//-----------------------------------------------------------------------------
localparam lpFullAlMost = pBuffDepth >> 2;


//-----------------------------------------------------------------------------
// Dual Clk FIFO Instance
//-----------------------------------------------------------------------------

fifoDualController # (
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (pBitWidth),
	.pFullAlMost	(pFullAlMost)
) InstPixelDualClkFifo (
    .iWD            (iWd),
    .iWE            (iWe),
    .oRD            (oRd),
    .iRE            (iRe),
    .oRVD           (oRvd),
    .oFLL           (ofull),
    .oEMP           (oEmp),
    .iSrcRst        (iSrcRst),
    .iDstRst        (iDstRst),
    .iSrcClk        (iSrcClk),
    .iDstClk        (iDstClk)
);

endmodule