//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
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
    output          oHdmiClkNeg,    // hdmi clk negedge
    output          oHdmiClkPos,    // hdmi clk posedge
    output [2:0]    oHdmiDataPos,   // TMDS Channel Serial Data posedge
    output [2:0]    oHdmiDataNeg    // TMDS Channel Serial Data negedge
);


//----------------------------------------------------------
// System Reset Gen
//----------------------------------------------------------
wire wSysRST;

rstGen SYSTEM_RST (
    .iCLK   (iCLK),     .oRST   (wSysRST),
);


//----------------------------------------------------------
// PCLK 25  MHz Pixel
// TCLK 250 MHz TMDS
// BCLK 100 MHz Base
//----------------------------------------------------------
wire wTCLK, wPCLK, wBCLK;
wire wRST;

cgbWrapper CGB (
    .iCLK   (iCLK),     .iRST   (wSysRST),
    .oRST   (wRST),
    .oTCLK  (wTCLK),    .oPCLK  (wPCLK),
    .oBCLK  (wBCLK)
);


//----------------------------------------------------------
// APDS5689 I2C Connect
//----------------------------------------------------------


//----------------------------------------------------------
// Display Timing 
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
// RGB Gen
//----------------------------------------------------------
wire [23:0] wVRGB;

CaptiveShizuhaBase # (
    .pHdisplay      (pHdisplay),    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),  .pBuffDepth     (pBuffDepth)
) BASE (
    .iPCLK          (wPCLK),        .iRST           (wRST),
    .iBCLK          (wBCLK),        .iPFvde         (wPFvde),

    // output Pixel Data
    .oVRGB          (wVRGB)
);


//----------------------------------------------------------
// HDMI Output
//----------------------------------------------------------
tgbWrapper TGB (
    .iTmdsCLK        (wPCLK),       .iTmdsOverCLK    (wTCLK),
    .iRST            (wRST),
    .oHDMI_CLK_n     (oHdmiClkNeg), .oHDMI_CLK_p     (oHdmiClkPos),
    .oHDMI_n         (oHdmiDataNeg),.oHDMI_p         (oHdmiDataPos),
    .iVRGB           (wVRGB),       .iVDE            (wPVde),
    .iHSYNC          (wPHsync),     .iVSYNC          (wPVsync)
);


endmodule