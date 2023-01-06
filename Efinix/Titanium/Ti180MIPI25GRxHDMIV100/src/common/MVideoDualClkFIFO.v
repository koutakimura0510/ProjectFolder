/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MVideoDualClkFIFO.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Copyright(c) 2011-2022, by Net-Vision Corp. All rights reserved.
 * (Note) For this source code, it is forbidden using and issuing
 *        without permission.
 * （注） このソース・コードの無断使用および無断持ち出しを禁止します．
 *
 * Revision    :
 * 29/Dec-2022 V1.00 New Release, Inh.fr. "MVideoDualClkFIFO.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
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