//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
// -
// デバッグを除いて外部から信号を受信、又は外部に信号を送信するモジュールは Top に記述
// FPGA 内部で完結するモジュールは Base に記述
// 
//----------------------------------------------------------
module CaptiveShizuhaTop #(
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
    input           iClk,           // OSC  clk
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    output [1:0]    oApdsScl,       // APDS I2C SCL
    output          oHdmiClkNeg,    // hdmi clk negedge
    output          oHdmiClkPos,    // hdmi clk posedge
    output [2:0]    oHdmiDataPos,   // TMDS Channel Serial Data posedge
    output [2:0]    oHdmiDataNeg,   // TMDS Channel Serial Data negedge
    inout           ioHdmiSda,      // hdmi I2c sda
    output          oHdmiScl,       // hdmi I2c scl
    input           iHdmiCec,       // hdmi cec
    input           iHdmiHpd,       // hdmi hpd

    //
    output          oQspiSck
);


//----------------------------------------------------------
// System Reset Gen
//----------------------------------------------------------
wire wSysRst;

rstGen #(
    .pRstFallTime (100)
) SYSTEM_RST (
    .iClk   (iClk),     .oRst   (wSysRst),
);


//----------------------------------------------------------
// PicelClk 25  MHz
// TmdsClk  250 MHz
// BaseClk  100 MHz
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wBaseClk;
wire wRst;

cgbWrapper CGB (
    .iClk       (iClk),         .iRst       (wSysRst),
    .oRst       (wRst),
    .oTmdsClk   (wTmdsClk),     .oPixelClk  (wPixelClk),
    .oBaseClk   (wBaseClk)
);


//----------------------------------------------------------
// APDS9960 I2C Connect
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
    .iClk       (wPixelClk),    .iRst       (wRst),
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
    .iPixelClk      (wPixelClk),    .iRst           (wRst),
    .iBaseClk       (wBaseClk),     .iPFvde         (wPFvde),

    // output Pixel Data
    .oVRGB          (wVRGB)
);


//----------------------------------------------------------
// HDMI Output
//----------------------------------------------------------
tgbWrapper TGB (
    .iPixelCLK       (wPixelClk),   .iTmdsCLK    (wTmdsClk),
    .iRst            (wRst),
    .oHdmiClkNeg     (oHdmiClkNeg), .oHdmiClkPos     (oHdmiClkPos),
    .oHdmiDataNeg    (oHdmiDataNeg),.oHdmiDataPos    (oHdmiDataPos),
    .iVRGB           (wVRGB),       .iVDE            (wPVde),
    .iHSYNC          (wPHsync),     .iVSYNC          (wPVsync)
);


endmodule