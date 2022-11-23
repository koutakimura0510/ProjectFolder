//----------------------------------------------------------
// Create 2022/7/20
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processor (
    // Internal port
	input 			iSysClk,
	input			iSysRst,
	input	[3:0] 	iUserDipSw,
	input	[3:0] 	iUserPushSw,
	output 	[7:0]	oUserLed
);


//----------------------------------------------------------
// PLL CLK の速度確認用
//----------------------------------------------------------
wire wPulse;

PulseGenerator #(
	.pSysClk	(50000000),
	.pTimeCke	(8'd1),
	.pStartPulse(1'b1)
) LED_PULSE (
    .iSysClk	(iSysClk),
    .iSysRst	(iSysRst),
    .oPulse		(wPulse)
);

//----------------------------------------------------------
// LED の点灯パターン作成
//----------------------------------------------------------
reg [7:0] rUserLed;			assign oUserLed = rUserLed;

always_ff @(posedge iSysClk)
begin
	if (iSysRst) 	rUserLed <= 8'd0;
	else 			rUserLed <= {wPulse, iSysRst, iUserDipSw[1:0], iUserPushSw};
end


endmodule