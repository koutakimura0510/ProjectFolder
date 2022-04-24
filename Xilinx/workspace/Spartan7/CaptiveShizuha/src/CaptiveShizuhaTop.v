//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
// -
// [Top Module]
// Pre  Processer メインシステム・ターゲット処理に使用する Clk の生成
//      Processer メインシステム処理
// Post Processer メインシステムの処理結果を、ターゲット接続の Clk に変換
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
    parameter       pBuffDepth      = 1024      // Displayの横幅よりも大きいサイズを指定
)(
    input           iClk,           // OSC  clk
    output [2:0]    oUnusedPin,     // not  pin
    output          oApdsScl,       // APDS I2C SCL
    inout           ioApdsSda,      // APDS I2C SDA
    input           iApdsIntr,      // APDS Interrupt / Open Drain Active Low
    output [1:0]    oQspiCs,        // Qspi Mode Cs   / Spi Mode Cs   Low Active
    output [1:0]    oQspiSck,       // Qspi Mode Clk  / Spi Mode Clk
    output [1:0]    ioQspiDq0,      // Qspi Mode DQ 0 / Spi Mode MOSI
    input  [1:0]    ioQspiDq1,      // Qspi Mode DQ 1 / Spi Mode MISO
    output [1:0]    ioQspiDq2,      // Qspi Mode DQ 2 / Spi Mode Wp   Low Active
    output [1:0]    ioQspiDq3,      // Qspi Mode DQ 3 / Spi Mode Hold Low Active
    output          oHdmiClkPos,    // hdmi clk posedge
    output          oHdmiClkNeg,    // hdmi clk negedge
    output [2:0]    oHdmiDataPos,   // hdmi Data 8b10b posedge
    output [2:0]    oHdmiDataNeg,   // hdmi Data 8b10b negedge
    output          oHdmiScl,       // hdmi I2c scl 
    inout           ioHdmiSda,      // hdmi I2c sda
    inout           ioHdmiCec,      // hdmi cec
    input           iHdmiHpd,       // hdmi hpd Low Active
    input           iUartRx,        // Uart
    output          oUartTx,        // Uart
    output [1:0]    oLed            // Led Flash
);


//----------------------------------------------------------
// System Clk / Display Timing Clk Generate
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wSysClk;
wire wSysRst;
wire wVde, wFe, wFvde, wHsync, wVsync;

PreProcesser #(
    .pHdisplay      (pHdisplay),
    .pHback         (pHback),
    .pHfront        (pHfront),
    .pHsync         (pHsync),
    .pVdisplay      (pVdisplay),
    .pVtop          (pVtop),
    .pVbottom       (pVbottom),
    .pVsync         (pVsync)
) PREPROCESSER (
    .iClk           (iClk),
    .oTmdsClk       (wTmdsClk),
    .oPixelClk      (wPixelClk),
    .oSysClk        (wSysClk),
    .oRst           (wSysRst),
    .oVde           (wVde),
    .oFe            (wFe),
    .oFvde          (wFvde),
    .oHsync         (wHsync),
    .oVsync         (wVsync)
);


//----------------------------------------------------------
// CPU
//----------------------------------------------------------
wire [23:0] wPixel;

Processer # (
    .pHdisplay      (pHdisplay),
    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),
    .pBuffDepth     (pBuffDepth)
) PROCESSER (
    .iPixelClk      (wPixelClk),
    .iSysClk        (wSysClk),
    .iRst           (wSysRst),
    .oUnusedPin     (oUnusedPin),
    .oApdsScl       (oApdsScl),
    .ioApdsSda      (ioApdsSda),
    .iApdsIntr      (iApdsIntr),
    .oQspiCs        (oQspiCs),
    .oQspiSck       (oQspiSck),
    .ioQspiDq0      (ioQspiDq0),
    .ioQspiDq1      (ioQspiDq1),
    .ioQspiDq2      (ioQspiDq2),
    .ioQspiDq3      (ioQspiDq3),
    .iUartRx        (iUartRx),
    .oUartTx        (oUartTx),
    .iPFvde         (wFvde),
    .oPixel         (wPixel)
);


//----------------------------------------------------------
// TODO Sound 
// TMDS output
//----------------------------------------------------------
PostProcesser POSTPROCESSER (
    .iPixelClk      (wPixelClk),
    .iTmdsClk       (wTmdsClk),
    .iRst           (wSysRst),
    .oHdmiClkPos    (oHdmiClkPos),
    .oHdmiClkNeg    (oHdmiClkNeg),
    .oHdmiDataPos   (oHdmiDataPos),
    .oHdmiDataNeg   (oHdmiDataNeg),
    .oHdmiScl       (oHdmiScl),
    .ioHdmiSda      (ioHdmiSda),
    .ioHdmiCec      (ioHdmiCec),
    .iHdmiHpd       (iHdmiHpd),
    .iPixel         (wPixel),
    .iVde           (wVde),
    .iHsync         (wHsync),
    .iVsync         (wVsync),
    .oLed           (oLed)
);

endmodule