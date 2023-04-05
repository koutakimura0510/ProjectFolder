//----------------------------------------------------------
// Create 2022/9/03
// Author koutakimura
// -
// クロック変換用途、及びピクセルデータの保持・読み出しを行う
// common の Dual CLK Contoroller を Instance することで、
// モジュールの入出力を自由に組み替える目的がある。
// 
//----------------------------------------------------------
module VideoDualClkFIFO #(
    parameter 				pBuffDepth  = 1024,   	// FIFO BRAMのサイズ指定、画面サイズの横幅より大きくする
    parameter 				pBitWidth   = 16      	// bitサイズ
)(
    input  [pBitWidth-1:0]  iWd,		// Write Data
    input                   iWe,		// Write Enable
    output                  ofull,
	//
    output [pBitWidth-1:0]  oRd,		// Read Data
    input                   iRe,		// Read Enable
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
// 
// レイテンシ：3
// ※ 入力データが存在する前提で出力を行うため EMP 信号で制御を行っていない
//-----------------------------------------------------------------------------
reg  [pBitWidth-1:0] rRd;		assign oRd  = rRd;
wire [pBitWidth-1:0] wRd;
wire wRVd;

fifoDualControllerGray # (
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (pBitWidth),
	.pFullAlMost	(5)
) InstPixelDualClkFifo (
    .iWD            (iWd),
    .iWE            (iWe),
    .oRD            (wRd),
    .iRE            (iRe),
    .oRVD           (wRVd),
    .oFLL           (ofull),
    .oEMP           (),
    .iSrcRst        (iSrcRst),
    .iDstRst        (iDstRst),
    .iSrcClk        (iSrcClk),
    .iDstClk        (iDstClk)
);

initial
begin
	rRd = {pBitWidth{1'b0}};
end

always @(posedge iDstClk)
begin
    if (wRVd) 	rRd <= wRd;
    else		rRd <= {pBitWidth{1'b0}};	// 読み込みタイミングエラー用に 黒色指定
end

endmodule