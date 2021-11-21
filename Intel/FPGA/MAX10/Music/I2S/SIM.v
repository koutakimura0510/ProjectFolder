/*
 * テストベンチ
 */

`timescale 1ns / 1ps
module SIM;
// Inputs
reg reset;
reg clk;
reg bclk, lrclk, data;
// Outputs
wire [15:0] arduino_io;

I2S i0(.CLK(clk), .RESET(reset), .ARDUINO_IO(arduino_io));

parameter CYCLE = 32; // 1サイクルを64と定義する

always #(CYCLE) clk = ~clk;
always #(CYCLE*907) lrclk = ~lrclk;
always #(CYCLE*907/32) bclk = ~bclk;
always #(CYCLE*907/32*6) data = ~data;

assign arduino_io[7] = (lrclk == 1'b1) ? 1'b1 : 1'b0;
assign arduino_io[6] = (bclk == 1'b1) ? 1'b1 : 1'b0;
assign arduino_io[5] = (data == 1'b1) ? 1'b1 : 1'b0;

initial begin
    #0;             // 初期化
    reset = 1;
    clk   = 0;
    data  = 0;
    bclk  = 0;
    lrclk = 1;

    #(CYCLE);
    reset = 0;      // リセット解除

    #(CYCLE*5000);
    $finish;        // シミュレーション終了
end
endmodule