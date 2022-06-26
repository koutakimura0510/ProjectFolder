//----------------------------------------------------------
// Create 2022/6/26
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
module BraveFrontier #(
    parameter       pHdisplay       = 640,
    parameter       pHback          =  48,
    parameter       pHfront         =  16,
    parameter       pHsync          =  96,
    parameter       pVdisplay       = 480,
    parameter       pVtop           =  31,
    parameter       pVbottom        =  11,
    parameter       pVsync          =   2,
    parameter       pPixelDebug     = "off",
    parameter       pBuffDepth      = 1024,      // Displayの横幅よりも大きいサイズを指定
    parameter       pDebug          = "off"
)(
    input           iOscSystemClk,     // OSC  clk
    input           iOscAudioClk,      // OSC  clk
    // output          oSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    output          oSpiCs,
    inout  [15:0]   ioSrampDq,
    inout  [1:0]    ioSrampDqs,
    output          oSrampClk,
    output          oSrampCs,
    inout  [15:0]   ioSramsDq,
    inout  [1:0]    ioSramsDqs,
    output          oSramsClk,
    output          oSramsCs,
    output [7:4]    oTftColorR,
    output [7:4]    oTftColorG,
    output [7:4]    oTftColorB,
    output          oTftDclk,
    output          oTftHsync,
    output          oTftVsync,
    output          oTftDe,
    output          oTftBackLight,
    output          oTftRst,
    output          oSwScl,
    inout           ioSwSda,
    output          oAudioMclk,
    output          oAudioBclk,
    output          oAudioCclk,
    output          oAudioData,
    output          oUartTx,
    input           iUartRx,
    output [1:0]    oLedEdge,
    output          oLedClk
);


//----------------------------------------------------------
// ピンアサイン確認用
//----------------------------------------------------------
// assign oSpiSck      = 1'd0;
assign ioSpiMiso    = 1'dz;
assign ioSpiMosi    = 1'dz;
assign ioSpiWp      = 1'dz;
assign ioSpiHold    = 1'dz;
assign oSpiConfigCs = 1'd0;
assign oSpiCs       = 1'd0;
assign ioSrampDq    = 16'dz;
assign ioSrampDqs   = 2'dz;
assign oSrampClk    = 1'd0;
assign oSrampCs     = 1'd0;
assign ioSramsDq    = 16'dz;
assign ioSramsDqs   = 2'dz;
assign oSramsClk    = 1'd0;
assign oSramsCs     = 1'd0;
assign oTftColorR   = 4'd0;
assign oTftColorG   = 4'd0;
assign oTftColorB   = 4'd0;
assign oTftDclk     = 1'd0;
assign oTftHsync    = 1'd0;
assign oTftVsync    = 1'd0;
assign oTftDe       = 1'd0;
assign oTftBackLight= 1'd0;
assign oTftRst      = 1'd0;
assign oSwScl       = 1'd0;
assign ioSwSda      = 1'dz;
assign oAudioMclk   = 1'd0;
assign oAudioBclk   = 1'd0;
assign oAudioCclk   = 1'd0;
assign oAudioData   = 1'd0;
assign oUartTx      = 1'd0;
assign iUartRx      = 1'dz;
assign oLedEdge     = 2'd0;
assign oLedClk      = 1'd0;


//----------------------------------------------------------
// System Clk / Display Timing Clk Generate
//----------------------------------------------------------
wire wMemClk, wPixelClk, wSysClk, wAudioClk;
wire wSysRst;
wire wPreVde, wPreFe, wPreFvde, wPreHsync, wPreVsync;

PreProcesser #(
    .pHdisplay      (pHdisplay),
    .pHback         (pHback),
    .pHfront        (pHfront),
    .pHsync         (pHsync),
    .pVdisplay      (pVdisplay),
    .pVtop          (pVtop),
    .pVbottom       (pVbottom),
    .pVsync         (pVsync),
    .pSystemPll     ("on"),
    .pAudioPll      ("off")
) PREPROCESSER (
    .iClk           (iOscSystemClk),
    .iAudioClk      (iOscAudioClk),
    .oMemClk        (wMemClk),
    .oPixelClk      (wPixelClk),
    .oSysClk        (wSysClk),
    .oAudioClk      (wAudioClk),
    .oSysRst        (wSysRst),
    .oAudioRst      (wAudioRst),
    .oVde           (wPreVde),
    .oFe            (wPreFe),
    .oFvde          (wPreFvde),
    .oHsync         (wPreHsync),
    .oVsync         (wPreVsync)
);


// //----------------------------------------------------------
// // CPU
// //----------------------------------------------------------
// wire [23:0] wProPixel;
// wire [15:0] wProSound;
// reg  qProSoundCke;
// reg  qProFvde;

// Processer # (
//     .pHdisplay      (pHdisplay),
//     .pVdisplay      (pVdisplay),
//     .pPixelDebug    (pPixelDebug),
//     .pBuffDepth     (pBuffDepth),
//     .pDebug         (pDebug)
// ) PROCESSER (
//     .iPixelClk      (wPixelClk),
//     .iSysClk        (wSysClk),
//     .iRst           (wSysRst),
//     .oUnusedPin     (oUnusedPin),
//     .oApdsScl       (oApdsScl),
//     .ioApdsSda      (ioApdsSda),
//     .iApdsIntr      (iApdsIntr),
//     .oQspiCs        (oQspiCs),
//     .oQspiSck       (oQspiSck),
//     .ioQspiDq0      (ioQspiDq0),
//     .ioQspiDq1      (ioQspiDq1),
//     .ioQspiDq2      (ioQspiDq2),
//     .ioQspiDq3      (ioQspiDq3),
//     .iUartRx        (iUartRx),
//     .oUartTx        (oUartTx),
//     .iPFvde         (qProFvde),
//     .oPixel         (wProPixel),
//     .iSoundCke      (qProSoundCke),
//     .oSound         (wProSound)
// );

// always @*
// begin
//     qProFvde <= wPreFvde;
// end


//----------------------------------------------------------
// TMDS output
//----------------------------------------------------------
// wire wPostSoundCke;
// reg  [15:0] qPostSound;
// reg  [23:0] qPostPixel;
// reg  qPostVde;
// reg  qPostHsync;
// reg  qPostVsync;

// PostProcesser POSTPROCESSER (
//     .iPixelClk      (wPixelClk),
//     .iMemClk        (wMemClk),
//     .iRst           (wSysRst),
//     .oHdmiClkPos    (oHdmiClkPos),
//     .oHdmiClkNeg    (oHdmiClkNeg),
//     .oHdmiDataPos   (oHdmiDataPos),
//     .oHdmiDataNeg   (oHdmiDataNeg),
//     .oHdmiScl       (oHdmiScl),
//     .ioHdmiSda      (ioHdmiSda),
//     .ioHdmiCec      (ioHdmiCec),
//     .iHdmiHpd       (iHdmiHpd),
//     .iPixel         (qPostPixel),
//     .iVde           (qPostVde),
//     .iHsync         (qPostHsync),
//     .iVsync         (qPostVsync),
//     .oLed           (oLed)
// );

// always @*
// begin
//     // qProSoundCke <= wPostSoundCke;
//     qProSoundCke    <= 1'b0;
//     qPostSound      <= wProSound;
//     qPostPixel      <= wProPixel;
//     qPostVde        <= wPreVde;
//     qPostHsync      <= wPreHsync;
//     qPostVsync      <= wPreVsync;
// end

endmodule