//----------------------------------------------------------
// Create 2022/8/24
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado22.1
// Board  CmodA7
// -
// [Top Module]
// Pre  Processer メインシステム・ターゲット処理に使用する Clk の生成
//      Processer メインシステム処理
//----------------------------------------------------------
module SampleTop (
	// Osc Clk
    input           iOscSystemClk,     // OSC  clk
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
wire wMemClk, wPixelClk, wSysClk, wAudioClk;
wire wSysRst, wAudioRst;
wire wPreVde, wPreFe, wPreFvde, wPreHsync, wPreVsync;

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
    .oMemClk        (wMemClk),          .oPixelClk      (wPixelClk),
    .oSysClk        (wSysClk),          .oAudioClk      (wAudioClk),
    .oSysRst        (wSysRst),          .oAudioRst      (wAudioRst)
);


//----------------------------------------------------------
// CPU
//----------------------------------------------------------
Processer PROCESSER (
    //----------------------------------------------------------
    // External Port
    //----------------------------------------------------------
	// Cmod A7 LED
	.oLed			(oLed),				.oLedB			(oLedB),
	.oLedG			(oLedG),			.oLedR			(oLedR),
	// TestPort
	.oTestPort		(oTestPort),
	
    //----------------------------------------------------------
    // Internal Port
    //----------------------------------------------------------
    // Clk Reset Port
    .iPixelClk      (wPixelClk),     .iMemClk        (wMemClk),
    .iSysClk        (wSysClk),       .iAudioClk      (wAudioClk),
    .iSysRst        (wSysRst),       .iAudioRst      (wAudioRst)
);


endmodule
