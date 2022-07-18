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
// LED の点灯パターン作成
//----------------------------------------------------------
logic [7:0] rUserLed;			assign oUserLed = rUserLed;

always_ff @(posedge iSysClk)
begin
	if (iSysRst) 	rUserLed <= 8'd0;
	else 			rUserLed <= {iUserDipSw, iUserPushSw};
end


endmodule