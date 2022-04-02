//----------------------------------------------------------
// Create 2022/3/27
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
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
wire wLock;
wire wRST = (~wLock);

dtpClkGen DTP_CLK_GEN (
    .clk_out1   (wPCLK),        .clk_out2   (wTCLK),
    .clk_out3   (wBCLK),
    .reset      (~iRST),        .locked     (wLock),
    .clk_in1    (iCLK)
);


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
    .pPixelDebug    (pPixelDebug)
) BASE (
    .iPCLK          (wPCLK),        .iRST           (wRST),
    .iBCLK          (wBCLK),
    .iPFvde         (wPFvde),
    .iPVde          (wPVde),        .iPFe           (wPFe),

    // output Pixel Data
    .oVRGB          (wVRGB),

    // oled side
    .oOledScl       (oOledScl),     .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),      .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),    .oOledVdd       (oOledVdd),

    // user interface
    .iBtn           (wBtn),

    // debug led
    .oLED           (oLED)
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

endmodule
