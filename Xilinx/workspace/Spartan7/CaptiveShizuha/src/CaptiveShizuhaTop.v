//----------------------------------------------------------
// Create 2022/4/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Board  My Board Spartan7 FTGB196
// -
// [Top Module の構造]
// Pre  Processer module
//      Processer module
// Post Processer module
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
    input           iClk,           // OSC  clk
    output [1:0]    oApdsScl,       // APDS I2C SCL
    inout  [1:0]    ioApdsSda,      // APDS I2C SDA
    input  [1:0]    iApdsIntr,      // APDS Interrupt / Open Drain Active Low
    output [1:0]    oQspiCs,        // Qspi Flash Memory chip select Low Active
    output [1:0]    oQspiSck,       // Qspi Flash Memory Clk
    inout  [1:0]    ioQspiDq0,      // SPI時 MOSI
    inout  [1:0]    ioQspiDq1,      // SPI時 MISO
    inout  [1:0]    ioQspiDq2,      // SPI時 High 固定, 書き込み保護 Low Active
    inout  [1:0]    ioQspiDq3,      // SPI時 High 固定, 書き込み停止 Low Active
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
// ホスト前処理モジュール
// 
// main 処理に使用する Clk, Display Sync の生成を行う
// (役割的には OSC と同じ 一定タイミングでクロックを出力だけである)
//----------------------------------------------------------
wire wTmdsClk, wPixelClk, wSysClk;
wire wSysRst;
wire wVde, wFe, wFvde, wHsync, wVsync;

PreProcesser #(
    .pHdisplay  (pHdisplay),
    .pHback     (pHback),
    .pHfront    (pHfront),
    .pHsync     (pHsync),
    .pVdisplay  (pVdisplay),
    .pVtop      (pVtop),
    .pVbottom   (pVbottom),
    .pVsync     (pVsync)
) PREPROCESSER (
    .iClk       (iClk),
    .oTmdsClk   (wTmdsClk),
    .oPixelClk  (wPixelClk),
    .oSysClk    (wSysClk),
    .oRst       (wSysRst),
    .oVde       (wVde),
    .oFe        (wFe),
    .oFvde      (wFvde),
    .oHsync     (wHsync),
    .oVsync     (wVsync)
);


//----------------------------------------------------------
// ホストメイン処理モジュール
// 
// システムの管理を司る
//----------------------------------------------------------
wire [23:0] wVRGB;

Processer # (
    .pHdisplay      (pHdisplay),
    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),
    .pBuffDepth     (pBuffDepth)
) PROCESSER (
    .iPixelClk      (wPixelClk),
    .iRst           (wSysRst),
    .iSysClk        (wSysClk),
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
    .oVRGB          (wVRGB)
);


//----------------------------------------------------------
// TODO オーディオ出力追加予定
// 
// ホスト後処理モジュール
// 
// 受信した Pixel Data, Sound Data を TMDS 信号に変換し出力を行う
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
    .iVRGB          (wVRGB),
    .iVde           (wVde),
    .iHsync         (wHsync),
    .iVsync         (wVsync),
    .oLed           (oLed)
);

endmodule