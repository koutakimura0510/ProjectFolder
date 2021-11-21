`timescale 1 ns / 100 ps

module TEST_CLK_GEN;

parameter CYCLE = 20;
reg CLK = 1'b0;
reg RESET;
wire [35:0] GPIO;

CLK_GEN i0(.CLK(CLK), .RESET(RESET), .GPIO(GPIO));

always begin
	#(CYCLE/2)
	CLK = ~CLK;
end

initial begin
	#(CYCLE) RESET = 1'b1;
	#(CYCLE) RESET = 1'b0;
	#(CYCLE * 200) $stop;
end

endmodule