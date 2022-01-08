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
wire oOledScl;
wire oOledSda;
wire oOledDC;
wire oOledRes;
wire oOledVbat;
wire oOledVdd;

main #(
    .H_DISPLAY  (40),
    .H_BACK     (2),
    .H_FRONT    (2),
    .H_SYNC     (2),
    .V_DISPLAY  (10),
    .V_TOP      (2),
    .V_BOTTOM   (2),
    .V_SYNC     (2),
    .SYS_CLK    (6),
    .KEY_CLK    (4),
    .CLK_1MS    (2)
    // .H_DISPLAY  (640),
    // .H_BACK     (48),
    // .H_FRONT    (16),
    // .H_SYNC     (96),
    // .V_DISPLAY  (480),
    // .V_TOP      (31),
    // .V_BOTTOM   (11),
    // .V_SYNC     (2)
) MAIN (
    .iCLK           (iCLK),
    .iRST           (iRST),
    .iBtn           (iBTN),
    .oHDMI_CLK_n    (oHDMI_CLK_N),
    .oHDMI_CLK_p    (oHDMI_CLK_P),
    .oHDMI_n        (oHDMI_N),
    .oHDMI_p        (oHDMI_P),
    .oLED           (oLED),
    .oOledScl       (oOledScl),
    .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),
    .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),
    .oOledVdd       (oOledVdd)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

initial begin
    iRST = 0;
    #(CYCLE * 2);
    iRST = 1;
    #(CYCLE * 20 * 4);
    iBTN = 5'b10100;
    #(CYCLE * 100 * 4);
    iBTN = 5'b10110;
    $stop;
end

endmodule
