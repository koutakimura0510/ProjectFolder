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
    input                   iBCLK,          // Base clk
    input                   iPCLK,          // Pixel Clk
    input                   iRST,           // Active High
    input  [pBitWidth-1:0]  iWD,            // Write Data
    input                   iWE,            // PD Write Enable
    output [pBitWidth-1:0]  oRD,            // Read Data
    input                   iRE,            // PD Read Enable
    output                  oFull
);


reg  [pBitWidth-1:0] rPixel;     assign oRD = rPixel;
wire [pBitWidth-1:0] wPixel;
wire wRvd;

always @(posedge iPCLK)
begin
    if (iRST)       rPixel <= 0;
    else if (wRvd)  rPixel <= wPixel;
    else            rPixel <= rPixel;
end

fifoDualControllerGray # (
    .pBuffDepth  (pBuffDepth),
    .pBitWidth   (pBitWidth)
) ASYNC_PIXEL_BUFFER (
    .iCLKA  (iBCLK),    .iCLKB  (iPCLK),
    .iRST   (iRST),

    // write side
    .iWD    (iWD),      .iWE    (iWE),
    .oFLL   (oFull),

    // read side
    .oRD    (wPixel),   .iRE    (iRE),
    .oRVD   (wRvd),     .oEMP   ()
);

//----------------------------------------------------------
// FIFO
//----------------------------------------------------------
// reg  qLineRe;
// wire [pBitWidth-1:0] wLineRd;
// wire wLineRvd, wLineEmp;

// fifoController #(
//     .pBuffDepth (16),
//     .pBitWidth  (pBitWidth)
// ) LINE_BUFFER_1 (
//     .iCLK   (iBCLK),    .iRST   (iRST),
//     .iWD    (iWD),      .oRD    (wLineRd),
//     .iWE    (iWE),      .iRE    (qLineRe),
//     .oFLL   (oFull),    .oRVD   (wLineRvd),
//                         .oEMP   (wLineEmp)
// );


//----------------------------------------------------------
// Aync Dual Buffer
//----------------------------------------------------------
// reg  [pBitWidth-1:0] rPixel;     assign oRD = rPixel;
// wire [pBitWidth-1:0] wPixel;
// wire wRvd, wDualFull;

// always @(posedge iPCLK)
// begin
//     if (iRST)       rPixel <= 0;
//     else if (wRvd)  rPixel <= wPixel;
//     else            rPixel <= rPixel;
// end

// fifoDualController # (
//     .pBuffDepth             (pBuffDepth),
//     .pBitWidth              (pBitWidth)
// ) LINE_DUAL_BUFFER_1 (
//     .iCLKA  (iBCLK),        .iCLKB  (iPCLK),
//     .iRST   (iRST),

//     // write side
//     .iWD    (wLineRd),      .iWE    (wLineRvd),
//     .oFLL   (wDualFull),

//     // read side
//     .oRD    (wPixel),       .iRE    (iRE),
//     .oRVD   (wRvd),         .oEMP   ()
// );

// always @*
// begin
//     qLineRe <= (~wDualFull)& (~wLineEmp);
// end

endmodule