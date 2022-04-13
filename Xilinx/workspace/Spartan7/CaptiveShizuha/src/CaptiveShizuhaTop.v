//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7
// -
// 横スクロール Game 「囚われの静葉」Top Module
// 
// デバッグを除いて外部から信号を受信、又は外部に信号を送信するモジュールは Top に記述
// FPGA 内部で完結するモジュールは Base に記述
// 
//----------------------------------------------------------
module CaptiveShizuhaTop #(
    // シミュレーション用にパラメータ設定を可能にする
    parameter       pHdisplay       = 640,
    parameter       pHback          =  48,
    parameter       pHfront         =  16,
    parameter       pHsync          =  96,
    parameter       pVdisplay       = 480,
    parameter       pVtop           =  31,
    parameter       pVbottom        =  11,
    parameter       pVsync          =   2,
    parameter       pPixelDebug     = "off",
    parameter       pBuffDepth      = 1024
)(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    input  [5:0]    iBtn,           // user push sw
    input  [7:0]    iSW,
    output          oHDMI_CLK_n,    // hdmi clk negedge
    output          oHDMI_CLK_p,    // hdmi clk posedge
    output [2:0]    oHDMI_n,        // TMDS Channel Serial Data posedge
    output [2:0]    oHDMI_p,        // TMDS Channel Serial Data negedge
    output [7:0]    oLED,           // user led

    // 評価ボード上oled
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);


//----------------------------------------------------------
// PCLK 25  MHz Pixel
// TCLK 250 MHz TMDS
// BCLK 100 MHz Base
//----------------------------------------------------------
wire wTCLK, wPCLK, wBCLK;
wire wRST;
reg  qRST;

cgbWrapper CGB (
    .iCLK   (iCLK),     .iRST   (qRST),
    .oRST   (wRST),
    .oTCLK  (wTCLK),    .oPCLK  (wPCLK),
    .oBCLK  (wBCLK)
);

always @*
begin
    qRST = (~iRST);
end


//----------------------------------------------------------
// Switch Serialize Block
//----------------------------------------------------------
wire [ 5:0] wBtn;

ssbWrapper #(
    .pMonitorTiming (500000)
) SSB (
    .iCLK       (iBCLK),    .iRST       (iRST),
    .iBtn       (~iBtn),    .oBtn       (wBtn)
);


//----------------------------------------------------------
// Display Timing 
// P = Pixel
// B = Base
//----------------------------------------------------------
wire wPVde, wPFe, wPFvde, wPHsync, wPVsync;

dtbWrapper #(
    .pHdisplay  (pHdisplay),    .pHback     (pHback),
    .pHfront    (pHfront),      .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),    .pVtop      (pVtop),
    .pVbottom   (pVbottom),     .pVsync     (pVsync)
) DTP (
    .iCLK       (wPCLK),        .iRST       (wRST),
    .oVde       (wPVde),        .oFe        (wPFe),
    .oFvde      (wPFvde),
    .oHsync     (wPHsync),      .oVsync     (wPVsync)
);


//----------------------------------------------------------
// RGBデータ
//----------------------------------------------------------
wire [23:0] wVRGB;

CaptiveShizuhaBase # (
    .pHdisplay      (pHdisplay),    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),  .pBuffDepth     (pBuffDepth)
) BASE (
    .iPCLK          (wPCLK),        .iRST           (wRST),
    .iBCLK          (wBCLK),        .iPFvde         (wPFvde),

    // output Pixel Data
    .oVRGB          (wVRGB),

    // user interface
    .iBtn           (wBtn)
);


//----------------------------------------------------------
// HDMI信号
//----------------------------------------------------------
tgbWrapper TGB (
    .iTmdsCLK        (wPCLK),       .iTmdsOverCLK    (wTCLK),
    .iRST            (wRST),
    .oHDMI_CLK_n     (oHDMI_CLK_n), .oHDMI_CLK_p     (oHDMI_CLK_p),
    .oHDMI_n         (oHDMI_n),     .oHDMI_p         (oHDMI_p),
    .iVRGB           (wVRGB),       .iVDE            (wPVde),
    .iHSYNC          (wPHsync),     .iVSYNC          (wPVsync)
);


//----------------------------------------------------------
// デバッグ用に値表示
//----------------------------------------------------------
// odbWrapper #(
//     .PDIVCLK        (100000),
//     .PDIVSCK        (128),
//     .DISPLAY_WIDTH  (128),
//     .DISPLAY_HEIGHT (4),
//     // .BIT_LENGTH     (64)
//     .BIT_LENGTH     (95)
// ) ODB (
//     .iCLK           (wBCLK),
//     .iRST           (wRST),
//     .oOledScl       (oOledScl),
//     .oOledSda       (oOledSda),
//     .oOledDC        (oOledDC),
//     .oOledRes       (oOledRes),
//     .oOledVbat      (oOledVbat),
//     .oOledVdd       (oOledVdd),
//     .iDispLine1     ({0,0, wVRGB}),
//     .iDispLine2     ({0,0, 0}),
//     .iDispLine3     ({0,0, 0}),
//     .iDispLine4     ({0,0, 0})
// );

// reg [7:0] rLed;

// always @(posedge iBCLK)
// begin
//     if (iRST)   rLed <= 0;
//     else        rLed <= {2'b000, iBtn};
// end

// assign oLED = rLed;


endmodule