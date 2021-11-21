/*
 * SPI通信テストベンチ
 */

`timescale 1ns / 1ps
module TEST;

reg [7:0] mosi;
reg reset, clk;
reg sclk, senable;
wire [15:0] arduino_io;
wire [9:0] ledr;

D_FILTER i0(.CLK(clk), .RESET(reset), .ARDUINO_IO(arduino_io), .LEDR(ledr));

parameter CYCLE    = 32;    //clkの周期
parameter SCLK_NUM = 16;    //8クロック分SCKを出力
integer i, j;

always #(CYCLE) clk = ~clk;

assign arduino_io[0] = (sclk == 1'b1) ? 1'b1 : 1'b0;
assign arduino_io[1] = senable;
assign arduino_io[2] = (mosi & 1'b1 && sclk == 1'b1) ? 1'b1 : 1'b0;

initial begin
    #0;
    reset   = 1;
    clk     = 0;
    sclk    = 0;
    senable = 1;
    reset   = 0;
    mosi = 8'b10011001;
    senable = 0;
    #(CYCLE * 10);

    for (j = 0; j < 3; j = j + 1) begin
        for (i = 0; i < SCLK_NUM; i = i + 1) begin
            #(CYCLE * 10)
            sclk = ~sclk;
            if (i & 1'b1) begin
                mosi <= mosi >> 1;
            end
        end
        mosi = 8'b10011001;
    end
    senable = 1;

    #(CYCLE * 2000);
    $finish;
end

endmodule