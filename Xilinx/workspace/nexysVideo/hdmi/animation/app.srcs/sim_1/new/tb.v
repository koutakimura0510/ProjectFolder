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

wire  [15:0]          ddr3_dq;
wire  [ 1:0]          ddr3_dqs_n;
wire  [ 1:0]          ddr3_dqs_p;
wire [14:0]           ddr3_addr;
wire [ 2:0]           ddr3_ba;
wire                  ddr3_ras_n;
wire                  ddr3_cas_n;
wire                  ddr3_we_n;
wire                  ddr3_reset_n;
wire                  ddr3_ck_p;
wire                  ddr3_ck_n;
wire                  ddr3_cke;
wire [ 1:0]           ddr3_dm;
wire                  ddr3_odt;

main #(
    .H_DISPLAY  (4),
    .H_BACK     (2),
    .H_FRONT    (2),
    .H_SYNC     (2),
    .V_DISPLAY  (3),
    .V_TOP      (2),
    .V_BOTTOM   (2),
    .V_SYNC     (2)
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
    .iSW            (8'd00),
    .oHDMI_CLK_n    (oHDMI_CLK_N),
    .oHDMI_CLK_p    (oHDMI_CLK_P),
    .oHDMI_n        (oHDMI_N),
    .oHDMI_p        (oHDMI_P),
    .oLED           (oLED),
    .ddr3_dq        (ddr3_dq),
    .ddr3_dqs_n     (ddr3_dqs_n),
    .ddr3_dqs_p     (ddr3_dqs_p),
    .ddr3_addr      (ddr3_addr),
    .ddr3_ba        (ddr3_ba),
    .ddr3_ras_n     (ddr3_ras_n),
    .ddr3_cas_n     (ddr3_cas_n),
    .ddr3_we_n      (ddr3_we_n),
    .ddr3_reset_n   (ddr3_reset_n),
    .ddr3_ck_p      (ddr3_ck_p),
    .ddr3_ck_n      (ddr3_ck_n),
    .ddr3_cke       (ddr3_cke),
    .ddr3_dm        (ddr3_dm),
    .ddr3_odt       (ddr3_odt),
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
    #(CYCLE * 2000 * 4);
    $stop;
end

endmodule
