module LedBlinkSwTop (
	input 			iOscClk,
	input	[3:0]	iUserDipSw,
	input 	[3:0]	iUserPushSw,
	output 	[7:0]	oUserLed
);


//----------------------------------------------------------
// 外部信号をシステムクロック同期信号に変換
//----------------------------------------------------------
logic [3:0] wUserSlideSw;
logic [3:0] wUserPushSw;

PreProcesser PRE_PROCESSER (
	.iOscClk		(iOscClk),
	.iUserDipSw	(iUserDipSw),
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
	.iSysClk		(iOscClk),
	.iSysRst		(1'b0),
	.iUserDipSw	(wUserSlideSw),
	.iUserPushSw	(wUserPushSw),
	.oUserLed		(wUserLed)
);


endmodule