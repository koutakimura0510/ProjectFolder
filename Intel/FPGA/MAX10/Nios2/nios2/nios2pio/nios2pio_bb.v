
module nios2pio (
	clk_clk,
	reset_reset_n,
	pio_0_external_connection_export,
	pio_1_external_connection_export);	

	input		clk_clk;
	input		reset_reset_n;
	output	[7:0]	pio_0_external_connection_export;
	input	[3:0]	pio_1_external_connection_export;
endmodule
