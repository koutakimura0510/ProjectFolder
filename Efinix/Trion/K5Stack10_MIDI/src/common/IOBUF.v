/*-----------------------------------------------------------------------------
 * Create  2023/4/8
 * Author  koutakimura
 * -
 * Efinix FPGA 専用 IOBUF 汎用module
 * 
 *-----------------------------------------------------------------------------*/
module IOBUF (
	input	O,	// GPIO Output Data
	output	I,	// GPIO Input Data
	input	T	// 1.Output, 0.Input
);


assign ioGPIOB_O[16]  = wMasterCs;
assign wSlaveCs		  = ioGPIOB_I[16];
assign ioGPIOB_OE[16] = wnSpiDir;

endmodule
