`timescale 1ns / 1ns

module TEST_LED_BLINK;

reg CLK = 1'b0, RESET;
wire [9:0] LEDR;

parameter SIM_SEC1_MAX = 4;
parameter CYCLE = 20;

LED_BLINK #(.SEC1_MAX(SIM_SEC1_MAX)) i0(.CLK(CLK), . RESET(RESET), .LEDR(LEDR));

always #(CYCLE/2)
	CLK = ~CLK;
	
initial
begin
	RESET = 1'b1;
	#CYCLE RESET = 1'b0;
	#(CYCLE * SIM_SEC1_MAX * 20) $stop;
end

endmodule