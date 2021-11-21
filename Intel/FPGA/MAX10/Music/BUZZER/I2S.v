module I2S (
    CLK, RESET,
    LRCLK_IN, BCLK_IN, DOUT_IN,
    LRCLK, BCLK, DOUT
);

input CLK, RESET;
inout LRCLK_IN, BCLK_IN, DOUT_IN;
inout LRCLK, DOUT, BCLK;


assign LRCLK = (LRCLK_IN == 1'b1) ? 1'b1 : 1'b0;
assign BCLK  = (BCLK_IN  == 1'b1) ? 1'b1 : 1'b0;
assign DOUT  = (DOUT_IN  == 1'b1) ? 1'b1 : 1'b0;

endmodule