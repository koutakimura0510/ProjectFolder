`timescale 1ns / 1ps

module I2S_SIM;

parameter CYCLE = 10;
parameter CKL = 2;

reg reset, clk, sys;
reg [31:0] gp_in, gp_status;
wire mclk_out, bclk_out, audio_data_out, lrclk_out;

I2S_DEMO i0(
    .CLK(sys),
    .RESET(reset),
    .MCLK_OUT(mclk_out),
    .BCLK(bclk_out),
    .SDATA(audio_data_out),
    .LRCLK(lrclk_out),
    .MCLK_IN(clk)
);

always #(CYCLE)
	clk = ~clk;

always #(CKL)
    sys = ~sys;


initial begin
    #0;
    #(CYCLE);
    clk = 0;
    sys = 0;
    reset = 0;
    gp_status = 1;
    #(CYCLE);
    reset = 1;
	clk   = 0;
    sys = 0;
    #(CYCLE * 5000);
    $finish;
end
endmodule
