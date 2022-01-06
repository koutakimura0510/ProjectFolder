`timescale 1ns / 1ps
/*
 * Create 2021/12/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * hdmi video timing テストベンチ
 */

module tb;

parameter CYCLE = 10;

reg iCLK    = 0;
reg iRST    = 1;
reg [4:0] iBTN = 0;
wire oHDMI_CLK_N;
wire oHDMI_CLK_P;
wire [2:0] oHDMI_N;
wire [2:0] oHDMI_P;
wire [7:0] oLED;

main #(
    .H_DISPLAY(30),
    .H_BACK(6),
    .H_FRONT(6),
    .H_SYNC(6),
    .V_DISPLAY(15),
    .V_TOP(5),
    .V_BOTTOM(5),
    .V_SYNC(2)
) MAIN (
    .iCLK(iCLK),
    .iRST(iRST),
    .iBtn(iBTN),
    .oHDMI_CLK_n(oHDMI_CLK_N),
    .oHDMI_CLK_p(oHDMI_CLK_P),
    .oHDMI_n(oHDMI_N),
    .oHDMI_p(oHDMI_P),
    .oLED(oLED)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    iRST = 0;
    #(CYCLE * 2);
    iRST = 1;
    #(CYCLE * 100 * 4);
    $stop;
end

endmodule
