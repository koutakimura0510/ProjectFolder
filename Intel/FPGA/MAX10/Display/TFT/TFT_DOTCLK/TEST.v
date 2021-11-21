/*
 * TFT-LCDテストベンチ
 */
`timescale 1ns / 1ps
module TEST;

parameter CYCLE = 100;
parameter SIM_SEX_MAX = 5;

reg reset, clk;
wire [35:0] gpio;
wire [15:0] arduino;

TFT_DOTCLK #(.SYSTEM_CLK(SIM_SEX_MAX), .SYSTEM_CLK_10MS(SIM_SEX_MAX))
          i0(.CLK(clk), .RESET(reset), .GPIO(gpio), .ARDUINO_IO(arduino));

always #(CYCLE)
	clk = ~clk;


initial begin
    #0;
    #(CYCLE);
    reset = 0;
    #(CYCLE);
    reset = 1;
	clk   = 0;
    #(CYCLE * 5000);
    $finish;
end

endmodule