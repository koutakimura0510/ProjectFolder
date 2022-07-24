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
    parameter       pHdisplay       = 480,
    parameter       pHback          =  43,
    parameter       pHfront         =   8,
    parameter       pHsync          =  30,
    parameter       pVdisplay       = 272,
    parameter       pVtop           =  12,
    parameter       pVbottom        =   4,
    parameter       pVsync          =  10,
    parameter       pPixelDebug     = "off",
    parameter       pBuffDepth      = 1024,      // Displayの横幅よりも大きいサイズを指定
    parameter       pDebug          = "off"
)(
    input           iOscSystemClk,     // OSC  clk
    input           iOscAudioClk,      // OSC  clk
    inout           ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    output          oSpiCs1,
    output          oSpiCs2,
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
// System Clk / Display Timing Clk Generate
//----------------------------------------------------------
wire wMemClk, wPixelClk, wSysClk, wAudioClk;
wire wSysRst, wAudioRst;
wire wPreVde, wPreFe, wPreFvde, wPreHsync, wPreVsync;

// 後段のモジュールに接続
reg  qProSysClk;
reg  qProMemClk;
reg  qPostPixelClk, qProPixelClk;
reg  qPostPixelRst, qProSysRst;
reg  qPostAudioClk, qProAudioClk;
reg  qPostAudioRst, qProAudioRst;

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
) PRE_PROCESSER (
    //----------------------------------------------------------
    // External Port
    //----------------------------------------------------------
    .iClk           (iOscSystemClk),    .iAudioClk      (iOscAudioClk),

    //----------------------------------------------------------
    // Internal port
    //----------------------------------------------------------
    // CLK, Reset Port
    .oMemClk        (wMemClk),          .oPixelClk      (wPixelClk),
    .oSysClk        (wSysClk),          .oAudioClk      (wAudioClk),
    .oSysRst        (wSysRst),          .oAudioRst      (wAudioRst),

    // Video Port
    .oVde           (wPreVde),          .oFe            (wPreFe),
    .oFvde          (wPreFvde),         .oHsync         (wPreHsync),
    .oVsync         (wPreVsync)
);

always @*
begin
    qProSysClk	<= wSysClk;
    qProMemClk	<= wMemClk;
    {qPostPixelClk, qProPixelClk} <= {2{wPixelClk}};
    {qPostAudioClk, qProAudioClk} <= {2{wAudioClk}};
    {qPostPixelRst, qProSysRst}   <= {2{wSysRst}};
    {qPostAudioRst, qProAudioRst} <= {2{wAudioRst}};
end


//----------------------------------------------------------
// CPU
//----------------------------------------------------------
// Video
wire [15:0] wProPixel;
wire wProBackLightControl;
reg  qProFvde;

// Audio
wire [31:0] wProAudioData;
reg  qProAudioLRch;

Processer # (
    .pHdisplay      (pHdisplay),
    .pVdisplay      (pVdisplay),
    .pPixelDebug    (pPixelDebug),
    .pBuffDepth     (pBuffDepth),
    .pDebug         (pDebug)
) PROCESSER (
    //----------------------------------------------------------
    // External Port
    //----------------------------------------------------------
    // SPI
    .ioSpiSck       (ioSpiSck),
    .ioSpiMiso      (ioSpiMiso),        .ioSpiMosi      (ioSpiMosi),
    .ioSpiHold      (ioSpiHold),        .ioSpiWp        (ioSpiWp),
    .oSpiCs1        (oSpiCs1),          .oSpiCs2        (oSpiCs2),
    .oSpiConfigCs   (oSpiConfigCs),
    // I2C Controller
    .oSwScl         (oSwScl),           .ioSwSda        (ioSwSda),
    // Memory Primary
    .ioSrampDq      (ioSrampDq),        .ioSrampDqs     (ioSrampDqs),
    .oSrampClk      (oSrampClk),        .oSrampCs       (oSrampCs),
    // Memory Secondary
    .ioSramsDq      (ioSramsDq),        .ioSramsDqs     (ioSramsDqs),
    .oSramsClk      (oSramsClk),        .oSramsCs       (oSramsCs),
    // uart
    .iUartRx        (iUartRx),          .oUartTx        (oUartTx),
    // Led
    .oLedClk        (oLedClk),          .oLedEdge       (oLedEdge),

    //----------------------------------------------------------
    // Internal Port
    //----------------------------------------------------------
    // Video Port
    .iPFvde         (qProFvde),         .oPixelData     (wProPixel),
    .oBackLightControl  (wProBackLightControl),
    // Audio Port
    .iAudioLRch     (qProAudioLRch),    .oAudioData     (wProAudioData),
    // Clk Reset Port
    .iPixelClk      (qProPixelClk),     .iMemClk        (qProMemClk),
    .iSysClk        (qProSysClk),       .iAudioClk      (qProAudioClk),
    .iSysRst        (qProSysRst),       .iAudioRst      (qProAudioRst)
);

always @*
begin
    qProFvde <= wPreFvde;
end


//----------------------------------------------------------
// Video / Audio output
//----------------------------------------------------------
// Video 
reg  [11:0] qPostPixel;
reg  qPostVde;
reg  qPostHsync;
reg  qPostVsync;
reg  qPostBackLightControl;

// Audio
reg  [31:0] qPostAudioData;
wire wPostAudioLRch;

PostProcesser POST_PROCESSER (
    //----------------------------------------------------------
    // External Port
    //----------------------------------------------------------
    // Video Port
	.oTftColorR		    (oTftColorR),       .oTftColorG		    (oTftColorG),
	.oTftColorB		    (oTftColorB),
	.oTftDclk		    (oTftDclk),         .oTftRst		    (oTftRst),
	.oTftHsync		    (oTftHsync),        .oTftVsync		    (oTftVsync),
	.oTftDe			    (oTftDe),           .oTftBackLight	    (oTftBackLight),
    // Audio Port
	.oAudioMclk		    (oAudioMclk),       .oAudioBclk		    (oAudioBclk),
	.oAudioCclk		    (oAudioCclk),       .oAudioData		    (oAudioData),

    //----------------------------------------------------------
    // Internal Port
    //----------------------------------------------------------
    // Video Port
    .iPixelClk          (qPostPixelClk),    .iSysRst            (qPostPixelRst),
    .iPixelData         (qPostPixel),       .iVde               (qPostVde),
    .iHsync             (qPostHsync),       .iVsync             (qPostVsync),
    .iBackLightControl  (qPostBackLightControl),
    // Audio Port
    .iAudioClk          (qPostAudioClk),    .iAudioRst		    (qPostAudioRst),
	.iAudioData		    (qPostAudioData),   .oAudioLRch         (wPostAudioLRch)
);

always @*
begin
    qPostPixel              <= wProPixel[11:0];
    qPostVde                <= wPreVde;
    qPostHsync              <= wPreHsync;
    qPostVsync              <= wPreVsync;
    qPostAudioData          <= wProAudioData;
    qPostBackLightControl   <= wProBackLightControl;
    qProAudioLRch           <= wPostAudioLRch;
end


endmodule