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
    parameter       pHpulse         =  30,
    parameter       pVdisplay		= 272,
    parameter       pVfront			=  12,
    parameter       pVback        	=   4,
    parameter       pVpulse         =  10,
    parameter       pPixelDebug     = "off",
    parameter       pBuffDepth      = 1024,      // Displayの横幅よりも大きいサイズを指定
    parameter       pDebug          = "off"
)(
	// Osc Clk
    input           iOscSystemClk,     // OSC  clk
	// SPI
    inout           ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    inout           ioSpiCs,
    input           iMSSel,
	// RAM
	output 	[18:0]	oMemAdrs,
	inout	[7:0]	ioMemDq,
	output 			oMemOE,
	output 			oMemWE,
	output 			oMemCE,
	// Display
    output	[7:4]   oTftColorR,
    output	[7:4]   oTftColorG,
    output	[7:4]   oTftColorB,
    output          oTftDclk,
    output          oTftHSync,
    output          oTftVSync,
    output          oTftDe,
    output          oTftBackLight,
    output          oTftRst,
	// I2C Controller
    output          oI2CScl,
    inout           ioI2CSda,
	// PWM Audio
    output          oAudioMclk,
	// LED
	output	[1:0]	oLed,
	output 			oLedB,
	output 			oLedG,
	output 			oLedR,
	// TestPort
	output	[3:0]	oTestPort
);


//----------------------------------------------------------
// System Clk / Display Timing Clk Generate
//----------------------------------------------------------
wire wMemClk, wVideoClk, wSysClk, wAudioClk;
wire wSysRst, wAudioRst;
wire wPreVde, wPreFe, wPreFvde, wPreHSync, wPreVSync;

PreProcesser #(
    .pSystemPll     ("on"),
    .pAudioPll      ("off")
) PRE_PROCESSER (
    //----------------------------------------------------------
    // External Port
    //----------------------------------------------------------
    .iClk           (iOscSystemClk),    .iAudioClk      (),

    //----------------------------------------------------------
    // Internal port
    //----------------------------------------------------------
    // CLK, Reset Port
    .oMemClk        (wMemClk),          .oVideoClk      (wVideoClk),
    .oSysClk        (wSysClk),          .oAudioClk      (wAudioClk),
    .oSysRst        (wSysRst),          .oAudioRst      (wAudioRst)
);


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
    .pHback         (pHback),
    .pHfront        (pHfront),
    .pHpulse        (pHpulse),
    .pVdisplay      (pVdisplay),
    .pVfront        (pVfront),
    .pVback         (pVback),
    .pVpulse        (pVpulse),
    .pPixelDebug    (pPixelDebug),
    .pBuffDepth     (pBuffDepth),
    .pDebug         (pDebug)
) PROCESSER (
    //----------------------------------------------------------
    // External Port
    //----------------------------------------------------------
    // SPI
    .ioSpiSck       (ioSpiSck),
    .ioSpiMiso      (ioSpiMiso),        .ioSpiMosi    	(ioSpiMosi),
    .ioSpiHold      (ioSpiHold),        .ioSpiWp      	(ioSpiWp),
    .ioSpiCs		(ioSpiCs),			.iMSSel			(iMSSel),
    .oSpiConfigCs   (oSpiConfigCs),
    // I2C Controller
    .oI2CScl        (oI2CScl),         .ioI2CSda        (ioI2CSda),
    // Memory
	.oMemAdrs		(oMemAdrs),			.ioMemDq		(ioMemDq),
	.oMemOE			(oMemOE),			.oMemWE			(oMemWE),
	.oMemCE			(oMemCE),
	// TFT Display
	.oTftColorR		(oTftColorR),		.oTftColorG		(oTftColorG),
	.oTftColorB		(oTftColorB),
	.oTftDclk		(oTftDclk),			.oTftHSync		(oTftHSync),
	.oTftVSync		(oTftVSync),
	.oTftDe			(oTftDe),
	.oTftBackLight	(oTftBackLight),	.oTftRst		(oTftRst),
	// Audio PWM
	.oAudioMclk		(oAudioMclk),
	// Cmod A7 LED
	.oLed			(oLed),				.oLedB			(oLedB),
	.oLedG			(oLedG),			.oLedR			(oLedR),
	// TestPort
	.oTestPort		(oTestPort),

    //----------------------------------------------------------
    // Internal Port
    //----------------------------------------------------------
    // Clk Reset Port
    .iVideoClk      (wVideoClk),     .iMemClk        (wMemClk),
    .iSysClk        (wSysClk),       .iAudioClk      (wAudioClk),
    .iSysRst        (wSysRst),       .iAudioRst      (wAudioRst)
);


endmodule
