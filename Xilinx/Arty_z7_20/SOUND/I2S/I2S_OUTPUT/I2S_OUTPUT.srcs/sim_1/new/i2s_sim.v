`timescale 1ns / 1ps

module i2s_sim;

parameter SYSCLK = 2;
parameter CYCLE = 10;

integer count = 0;

reg reset, sysclk, mclk;
reg [31:0] gp_in, gp_status;
wire gp_out;
wire bclk_out, audio_data_out, lrclk_out;

MAIN i0(
    .CLK(sysclk),
    .RESET(reset),
    .BCLK_OUT(bclk_out),
    .AUDIO_DATA_OUT(audio_data_out),
    .LRCLK_OUT(lrclk_out),
    .MCLK_IN_IBUF(mclk),
    .GP_IN(gp_in),
    .GP_STATUS(gp_status),
    .GP_OUT(gp_out)
);

always #(SYSCLK)
	sysclk = ~sysclk;


always #(CYCLE)
	mclk = ~mclk;


initial begin
    #0;
    #(CYCLE);
    sysclk = 0;
    mclk = 0;
    reset = 0;
    gp_status = 1;
    gp_in = 32'haa558899;
    #(CYCLE);
    reset = 1;
    sysclk = 0;
	mclk   = 0;
forever begin
    count = count + 1;
    gp_in = count;
    #(CYCLE * 15);
    gp_status = 1;
    #(CYCLE * 8);
    gp_status = 0;
end
end


endmodule
