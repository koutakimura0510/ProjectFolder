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
    parameter       pPixelDebug   = "yes"
)(

    input           iPCLK,      // Pixel Clk
    input           iBCLK,      // Base Clk
    input           iRST,       // Active High Sync Reset

    // Interface 
    input  [5:0]    iBtn,       // Async Push SW

    // Pixel Clk Sync Signal
    input           iPVde,      // Pixel Clk Timing video enable
    input           iPFvde,     // Pixel Clk Timing fast video enable
    input           iPFe,       // Pixel Clk Timing frame end

    // TGB side output
    output [23:0]   oVRGB,

    // debug monitor
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd,
    output [7:0]    oLED
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
reg qCkeDgb;
wire [23:0] wPixel;

dgbWrapper #(
    .pHdisplay          (pHdisplay),
    .pVdisplay          (pVdisplay),
    .pPixelWidth        (24)
) DGB (
    .iBCLK  (iBCLK),    .iRST   (iRST),
    .iCKE   (qCkeDgb),  .oPixel (wPixel),
    .oVd    (),         .oFe    ()
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
wire [23:0] wRD;        assign oVRGB = wRD;
wire wFull;


pfbWrapper #(
    .pBuffDepth             (1024),
    .pBitWidth              (24)
) PFB (
    .iBCLK  (iBCLK),        .iPCLK  (iPCLK),
    .iRST   (iRST),     
    .iWD    (wPixel),       .iWE    (qCkeDgb),
    .oFull  (wFull),
    .oRD    (wRD),          .iRE    (iPFvde)
);

always @*
begin
    qCkeDgb <= (~wFull);
end


//----------------------------------------------------------
// デバッグ用に値表示
//----------------------------------------------------------
odbWrapper #(
    .PDIVCLK        (100000),
    .PDIVSCK        (128),
    .DISPLAY_WIDTH  (128),
    .DISPLAY_HEIGHT (4),
    // .BIT_LENGTH     (64)
    .BIT_LENGTH     (95)
) ODB (
    .iCLK           (iBCLK),
    .iRST           (iRST),
    .oOledScl       (oOledScl),
    .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),
    .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),
    .oOledVdd       (oOledVdd),
    .iDispLine1     ({"XPOS =  ", 0}),
    .iDispLine2     ({"YPOS =  ", 0}),
    .iDispLine3     ({"        ", 0}),
    .iDispLine4     ({"        ", 0})
);

reg [7:0] rLed;

always @(posedge iBCLK)
begin
    if (iRST)   rLed <= 0;
    else        rLed <= {2'b000, iBtn};
end

assign oLED = rLed;

endmodule