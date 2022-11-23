//----------------------------------------------------------
// Create 2022/3/27
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// Base module
// ゲームの進行状況に応じて、描画用のピクセルデータを生成するモジュール
//----------------------------------------------------------
module CaptiveShizuhaBase #(
    parameter       pHdisplay     = 640,
    parameter       pVdisplay     = 480,
    parameter       pPixelDebug   = "yes",
    parameter       pBuffDepth    = 1024
)(

    input           iPCLK,      // Pixel Clk
    input           iBCLK,      // Base Clk
    input           iRST,       // Active High Sync Reset

    // Interface 
    input  [5:0]    iBtn,       // Async Push SW

    // Pixel Clk Sync Signal
    input           iPFvde,     // Pixel Clk Timing fast video enable

    // TGB side output
    output [23:0]   oVRGB
);


//----------------------------------------------------------
// Position Generate Block
//----------------------------------------------------------
// pgbWrapper #(
// .iBCLK
// ) PGB (
// 
// );


//----------------------------------------------------------
// Dot Generate Block
//----------------------------------------------------------
reg  qCkeDgb;
wire [23:0] wPiDgb;
wire wVdDgb;

dgbWrapper #(
    .pHdisplay          (pHdisplay),
    .pVdisplay          (pVdisplay),
    .pPixelWidth        (24),
    .pPixelDebug        (pPixelDebug)
) DGB (
    .iBCLK  (iBCLK),    .iRST   (iRST),
    .iCKE   (qCkeDgb),  .oPixel (wPiDgb),
    .oVd    (wVdDgb),   .oFe    ()
);


//----------------------------------------------------------
// RGB Operation Block 
//----------------------------------------------------------
// robWrapper #(

// ) ROB (

// );

//----------------------------------------------------------
// Pixel Async Fifo Block
//----------------------------------------------------------
wire [23:0] wRD;            assign oVRGB = wRD;
wire wFull;


pfbWrapper #(
    .pBuffDepth             (pBuffDepth),
    .pBitWidth              (24)
) PFB (
    .iBCLK  (iBCLK),        .iPCLK  (iPCLK),
    .iRST   (iRST),
    .iWD    (wPiDgb),       .oRD    (wRD),
    .iWE    (wVdDgb),       .iRE    (iPFvde),
    .oFull  (wFull)
);

always @*
begin
    qCkeDgb <= (~wFull);
end

endmodule