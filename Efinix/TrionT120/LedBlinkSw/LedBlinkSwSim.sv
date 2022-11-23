// `timescale 1ns / 1ps
module LedBlinkSwSim;

parameter CYCLE = 10;
reg [3:0] 	rUserDipSw  = 0;
reg [3:0] 	rUserPushSw = 0;
wire [7:0] 	wUserLed;
reg 		rSysClk = 0;

LedBlinkSwTop LEDBlinkSwTop
(
	.iUserDipSw		(rUserDipSw),
	.iUserPushSw	(rUserPushSw),
	.oUserLed		(wUserLed),
	.iOscClk		(rSysClk)
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
	$dumpfile("outflow/sim.vcd");
	$dumpvars(0, LedBlinkSwSim);
end

endmodule
