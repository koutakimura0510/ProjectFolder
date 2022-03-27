//----------------------------------------------------------
// Create 2022/3/27
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// 横スクロール Game 「囚われの静葉」Top Module
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
// ピクセルクロック、タイミング生成
//----------------------------------------------------------
wire wVde, wFe, wFvde, wHsync, wVsync;
wire wSCLK, wTCLK, wRST;

dtpWrapper #(
    .pHdisplay  (pHdisplay),    .pHback     (pHback),
    .pHfront    (pHfront),      .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),    .pVtop      (pVtop),
    .pVbottom   (pVbottom),     .pVsync     (pVsync)
) DTP (
    .iCLK       (iCLK),         .iRST       (iRST),
    .oVde       (wVde),         .oFe        (wFe),
    .oFvde      (wFvde),
    .oHsync     (wHsync),       .oVsync     (wVsync),
    .oSCLK      (wSCLK),        .oTCLK      (wTCLK),
    .oRST       (wRST)
);


//----------------------------------------------------------
// RGBデータ
//----------------------------------------------------------
wire [23:0] wVRGB;

CaptiveShizuhaBase # (
    .pHdisplay      (pHdisplay),    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug)
) BASE (
    .iSCLK          (wSCLK),        .iRST           (wRST),
    .iFvde          (wFvde),
    .iVde           (wVde),         .iFe            (wFe),
    .oVRGB          (wVRGB),

    // oled side
    .oOledScl       (oOledScl),     .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),      .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),    .oOledVdd       (oOledVdd),

    // debug led
    .oLED           (oLED)
);


//----------------------------------------------------------
// HDMI信号
//----------------------------------------------------------
tgbWrapper TGB (
    .iTmdsCLK        (wSCLK),       .iTmdsOverCLK    (wTCLK),
    .iRST            (wRST),
    .oHDMI_CLK_n     (oHDMI_CLK_n), .oHDMI_CLK_p     (oHDMI_CLK_p),
    .oHDMI_n         (oHDMI_n),     .oHDMI_p         (oHDMI_p),
    .iVRGB           (wVRGB),       .iVDE            (wVDE),
    .iHSYNC          (wHSYNC),      .iVSYNC          (wVSYNC)
);

endmodule
