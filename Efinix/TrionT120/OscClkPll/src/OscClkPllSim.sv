`timescale 1ns / 1ps
module OscClkPllSim;

parameter CYCLE = 10;
reg [3:0] 	rUserDipSw  = 0;
reg [3:0] 	rUserPushSw = 0;
wire [7:0] 	wUserLed;
reg 		rSysClk = 0;
wire 		rPllLoked = 0;
wire 		wPllRst;

OscClkPllTop OSC_CLK_PllTop
(
	.iUserDipSw		(rUserDipSw),
	.iUserPushSw	(rUserPushSw),
	.oUserLed		(wUserLed),
	.iSysClk		(rSysClk),
	.iPllLoked		(rPllLoked),
	.oPllRst		(wPllRst)
);

always begin
    #(CYCLE/2);
    rSysClk = ~rSysClk;
end

initial begin
    #(CYCLE * 2000 * 4);
    $finish;
end

initial begin
	$dumpfile("outflow/OscClkPll.vcd");
	$dumpvars(0, OscClkPllSim);
end

endmodule
