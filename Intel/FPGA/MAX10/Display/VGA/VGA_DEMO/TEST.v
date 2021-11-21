/*
 * VGAテストベンチ
 */
`timescale 1ns / 1ps
module TEST;

parameter CYCLE = 100;    //clkの周期

reg reset, clk;
wire [3:0] r, g, b;
wire hsync, vsync;
wire [9:0] ledr;
wire [15:0] arduino;

VGA_DEMO i0(
    .CLK(clk),
    .RESET(reset),
	.LEDR(ledr),
    .VGA_R(r),
    .VGA_G(g),
    .VGA_B(b),
    .VGA_HS(hsync),
    .VGA_VS(vsync),
	.ARDUINO_IO(arduino)
);

always begin
	#(CYCLE);
	clk = ~clk;
end

initial begin
    #0;
    reset = 1;
	clk = 0;
    #(CYCLE * 5);
    reset = 0;
    #(CYCLE * 2000);
    $finish;
end

endmodule