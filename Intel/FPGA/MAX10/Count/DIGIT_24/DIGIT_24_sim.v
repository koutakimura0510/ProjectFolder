/**-------------------------------------------------
 * 2021-1-23
 * -------------------------------------------------*/
`timescale 1 ns / 1 ns
module DIGIT_24_sim;


/**-------------------------------------------------
 * DUT => DIGIT_24.v
 * input  => reg
 * output => wire
 * -------------------------------------------------*/
reg clk = 1'b0, reset;
reg [2:0] key;
wire ENABLE, EN_BLINK, ENABLE_khz, ENABLE_BUZZ;
wire [35:0] gpio;

parameter CYCLE = 20;
parameter SIM_MAX = 4;	//sim 4clk enable


/**-------------------------------------------------
 * Instance Pin Connect
 * -------------------------------------------------*/
ENABLE_GENERATE #(.SYSTEM_CLK(SIM_MAX), .TYATA_CLK(SIM_MAX), .BUZZ_CLK(SIM_MAX))
		i0(.CLK(clk), .ENABLE(ENABLE), .RESET(reset), .EN_BLINK(EN_BLINK),
		   .ENABLE_khz(ENABLE_khz), .ENABLE_BUZZ(ENABLE_BUZZ));
							
BUZZER i1(.CLK(CLK), .ENABLE(ENABLE), .KEY({key[1:0]}), .GPIO(gpio[34]));

/**-------------------------------------------------
 * CLK Generate
 * -------------------------------------------------*/
always 
begin
	#(CYCLE/2)
	clk = ~clk;
end


initial
begin
	reset = 1'b1;	// RESET
	#CYCLE reset = 1'b0;
	#CYCLE key[0] = 3'b1;
	#CYCLE key[1] = 3'b0;
	#(CYCLE * SIM_MAX * 20) $stop;
end

endmodule
