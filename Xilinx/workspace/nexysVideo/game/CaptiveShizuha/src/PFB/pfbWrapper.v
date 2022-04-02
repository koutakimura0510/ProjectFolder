/*
 * Create 2022/3/26
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * Pixel Async Fifo Block
 */

module pfbWrapper #(
    parameter pBuffDepth  = 1024,   // FIFO BRAMのサイズ指定、画面サイズの横幅より大きくする
    parameter pBitWidth   = 24      // bitサイズ
)(
    input           iBCLK,          // Base clk
    input           iPCLK,          // Pixel Clk
    input           iRST,           // Active High
    input  [23:0]   iWD,            // Write Data
    input           iWE,            // PD Write Enable
    output [23:0]   oRD,            // Read Data
    input           iRE,            // PD Read Enable
    output          oFull
);

fifoDualController # (
    .pBuffDepth  (pBuffDepth),
    .pBitWidth   (pBitWidth)
) LINE_DUAL_BUFFER_1 (
    .iCLKA  (iBCLK),    .iCLKB  (iPCLK),
    .iRST   (iRST),

    // write side
    .iWD    (iWD),      .iWE    (iWE),
    .oFLL   (oFull),

    // read side
    .oRD    (oRD),      .iRE    (iRE),
    .oRVD   (),         .oEMP   ()
);

endmodule