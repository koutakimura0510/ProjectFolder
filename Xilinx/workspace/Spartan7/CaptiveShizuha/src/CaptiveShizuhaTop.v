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
    parameter       pBuffDepth      = 1024      // Display の横幅より大きくサイズを指定
)(
    // CLK
    input           iClk,           // OSC  clk

    // APDS9960
    output [1:0]    oApdsScl,       // APDS I2C SCL
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    input  [1:0]    iApdsIntr,      // APDS Interrupt

    // Flash Memory
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    output [1:0]    oQspiMosi,      // Qspi Flash Memory Master Data output
    input  [1:0]    iQspiMiso,      // Qspi Flash Memory Master Data input
    inout  [1:0]    ioQspiHold,
    inout  [1:0]    ioQspiRst,
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select

    // HDMI TX
    output          oHdmiClkPos,    // hdmi clk posedge
    output          oHdmiClkNeg,    // hdmi clk negedge
    output [2:0]    oHdmiDataPos,   // TMDS Channel Serial Data posedge
    output [2:0]    oHdmiDataNeg,   // TMDS Channel Serial Data negedge
    output          oHdmiScl,       // hdmi I2c scl
    inout           ioHdmiSda,      // hdmi I2c sda
    inout           ioHdmiCec,      // hdmi cec
    input           iHdmiHpd,       // hdmi hpd

    // UART
    input           iUartRx,        // Uart
    output          oUartTx,        // Uart

    // LED
    output [1:0]    oLed            // Led Flash
);

//---------------------------------------------------------------------------
// 未使用 Pin 割り当て
//---------------------------------------------------------------------------
// wire unUsed[2] = iHdmiHpd;

assign oUartTx      = iUartRx;
assign oApdsScl     = iQspiMiso;
assign ioApdsSda    = 2'bzz;
assign oQspiSck     = 2'b00;
assign oQspiMosi    = 2'b00;
assign ioQspiHold   = 2'bzz;
assign ioQspiRst    = 2'bzz;
assign oQspiCs      = iApdsIntr;
assign oHdmiScl     = iClk;
assign ioHdmiSda    = 1'bz;
assign ioHdmiCec    = 1'bz;
assign oLed         = 2'd0;


// //----------------------------------------------------------
// // System Reset Gen
// //----------------------------------------------------------
// wire wSysRst;

// rstGen #(
//     .pRstFallTime (100)
// ) SYSTEM_RST (
//     .iClk   (iClk),     .oRst   (wSysRst),
// );


// //----------------------------------------------------------
// // PicelClk 25  MHz
// // TmdsClk  250 MHz
// // BaseClk  100 MHz
// //----------------------------------------------------------
// wire wTmdsClk, wPixelClk, wBaseClk;
// wire wRst;

// cgbWrapper CGB (
//     .iClk       (iClk),         .iRst       (wSysRst),
//     .oRst       (wRst),
//     .oTmdsClk   (wTmdsClk),     .oPixelClk  (wPixelClk),
//     .oBaseClk   (wBaseClk)
// );


// //----------------------------------------------------------
// // APDS9960 I2C Connect
// //----------------------------------------------------------


// //----------------------------------------------------------
// // Display Timing 
// //----------------------------------------------------------
// wire wPVde, wPFe, wPFvde, wPHsync, wPVsync;

// dtbWrapper #(
//     .pHdisplay  (pHdisplay),    .pHback     (pHback),
//     .pHfront    (pHfront),      .pHsync     (pHsync),
//     .pVdisplay  (pVdisplay),    .pVtop      (pVtop),
//     .pVbottom   (pVbottom),     .pVsync     (pVsync)
// ) DTP (
//     .iClk       (wPixelClk),    .iRst       (wRst),
//     .oVde       (wPVde),        .oFe        (wPFe),
//     .oFvde      (wPFvde),
//     .oHsync     (wPHsync),      .oVsync     (wPVsync)
// );


// //----------------------------------------------------------
// // RGB Gen
// //----------------------------------------------------------
// wire [23:0] wVRGB;

// CaptiveShizuhaBase # (
//     .pHdisplay      (pHdisplay),    .pVdisplay      (pVdisplay),
//     .pPixelDebug    (pPixelDebug),  .pBuffDepth     (pBuffDepth)
// ) BASE (
//     .iPixelClk      (wPixelClk),    .iRst           (wRst),
//     .iBaseClk       (wBaseClk),     .iPFvde         (wPFvde),

//     // output Pixel Data
//     .oVRGB          (wVRGB)
// );


// //----------------------------------------------------------
// // HDMI Output
// //----------------------------------------------------------
// tgbWrapper TGB (
//     .iPixelCLK       (wPixelClk),   .iTmdsCLK    (wTmdsClk),
//     .iRst            (wRst),
//     .oHdmiClkNeg     (oHdmiClkNeg), .oHdmiClkPos     (oHdmiClkPos),
//     .oHdmiDataNeg    (oHdmiDataNeg),.oHdmiDataPos    (oHdmiDataPos),
//     .iVRGB           (wVRGB),       .iVDE            (wPVde),
//     .iHSYNC          (wPHsync),     .iVSYNC          (wPVsync)
// );


endmodule