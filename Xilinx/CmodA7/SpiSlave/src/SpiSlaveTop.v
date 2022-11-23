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
// -
// 外部 デバイスと接続して、FPGA SPI Master / Slave動作を確認するプロジェクト
// iMSSel = VCC FPGA Slave 、GND FPGA Master となる。
// 
// SPI コマンド・データの内容については SPISignal.v のコメントを参照すること。
// Slave 時は MISO には、32bit 0xaaaaaaaa を返すようにしているので使用するときは確認。
// MOSI は、32bit 下位4bit をボード付属の LED に接続しているので確認する。
// 
// LED[0] iMSSel
// LED[1] MOSI[4]
// LEDB MOSI[0]
// LEDG MOSI[1]
// LEDR MOSI[2]
// 
//----------------------------------------------------------
module SpiSlaveTop (
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
	// LED
	output	[1:0]	oLed,
	output 			oLedB,
	output 			oLedG,
	output 			oLedR,
	// TestPort
	output	[3:0]	oTestPort
);


//----------------------------------------------------------
// System Clk
// OSC 12MHz Input -> SystemClk 96MHz Output
// 
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
    // SPI
    .ioSpiSck       (ioSpiSck),
    .ioSpiMiso      (ioSpiMiso),        .ioSpiMosi    	(ioSpiMosi),
    .ioSpiHold      (ioSpiHold),        .ioSpiWp      	(ioSpiWp),
    .ioSpiCs		(ioSpiCs),			.iMSSel			(iMSSel),
    .oSpiConfigCs   (oSpiConfigCs),
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
