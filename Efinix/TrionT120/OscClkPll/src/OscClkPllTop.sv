///----------------------------------------------------------
// Create  2022/07/20
// Author  kouta kimura
// Editor  VSCode ver1.62.7
// Build   Efinix2021.v2.32
// Borad   Trion T120
// -
// T120 評価ボードの PLL 動作サンプル
// User LED / Push SW / Dip Sw のプロジェクトをコピーしたため、
// LED 点灯回路も付属されている
// 
//----------------------------------------------------------
module OscClkPllTop (
    // External Port
	input	[3:0]	iUserDipSw,
	input 	[3:0]	iUserPushSw,
	output 	[7:0]	oUserLed,
    // Internal Port
	input 			iSysClk,
    input           iPllLoked,	// Low Active
    output          oPllRst		// High Active
);

assign oPllRst = 1'b1;

//----------------------------------------------------------
// 外部信号をシステムクロック同期信号に変換
//----------------------------------------------------------
logic [3:0] wUserSlideSw;
logic [3:0] wUserPushSw;

PreProcesser PRE_PROCESSER (
	.iOscClk		(iSysClk),
	.iUserDipSw		(iUserDipSw),
	.iUserPushSw	(iUserPushSw),
	.oUserSlideSw	(wUserSlideSw),
	.oUserPushSw	(wUserPushSw),
	.oSysRst		()
);


//----------------------------------------------------------
// システム内部処理
//----------------------------------------------------------
logic [7:0] wUserLed;			assign oUserLed = wUserLed;

Processor PROCESSER (
	.iSysClk		(iSysClk),
	.iSysRst		(iPllLoked),
	.iUserDipSw		(wUserSlideSw),
	.iUserPushSw	(wUserPushSw),
	.oUserLed		(wUserLed)
);


endmodule