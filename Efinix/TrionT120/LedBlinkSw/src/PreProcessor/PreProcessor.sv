//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// ホスト前処理ブロック
// Processor. PostProcesser のシステムを動作させるための CLK を生成する
// 
// 22/07/20
// System Verilogに対応
//----------------------------------------------------------
module PreProcesser 
(
	// External Port
    input           iOscClk,
	input	[3:0]	iUserDipSw,
	input	[3:0]	iUserPushSw,
	// INternal Port
	output 	[3:0]	oUserSlideSw,
	output	[3:0]	oUserPushSw,
	output			oSysRst
);


//----------------------------------------------------------
// リセット信号は今回は生成しないため、0固定
//----------------------------------------------------------
assign oSysRst = 1'b0;


//----------------------------------------------------------
// 非同期信号を同期化
//----------------------------------------------------------
UserSwWrapper USER_SW_WRAPPER (
	.iSysClk 		(iOscClk),
	.iSysRst		(1'b0),
	.iUserDipSw	(iUserDipSw),
	.iUserPushSw	(iUserPushSw),
	.oUserSlideSw	(oUserSlideSw),
	.oUserPushSw	(oUserPushSw)
);


endmodule