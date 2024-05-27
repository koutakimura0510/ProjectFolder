/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第7章                        */
/* project: ps2if                        */
/* outline: Nioss IIシステムの最上位階層 */
/* board  : DE10-Lite                    */

module ps2if (
    /* クロック、リセット（SW[9]） */
    input           CLK, RST,

    /* スライドスイッチ、プッシュスイッチ、7セグメントLED */
    input   [8:0]   SW,
    input   [1:0]   KEY,
    output  [7:0]   HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,

    /* 単体LED */
    output  [9:0]   LEDR,

    /* VGA */
    output  [3:0]   VGA_R,  VGA_G, VGA_B,
    output          VGA_HS, VGA_VS,

    /* SDRAM */
    output          DRAM_CLK, DRAM_CKE,
    output  [12:0]  DRAM_ADDR,
    output  [1:0]   DRAM_BA,
    output          DRAM_CAS_N, DRAM_RAS_N,
    output          DRAM_CS_N,  DRAM_WE_N,
    output          DRAM_UDQM,  DRAM_LDQM,
    inout   [15:0]  DRAM_DQ,

    /* GPIO、ARDUINO */
    inout   [35:0]  GPIO,
    inout   [15:0]  ARDUINO_IO
);

/* 未使用端子の固定 */
assign HEX0[7]=1'b1, HEX1[7]=1'b1, HEX2[7]=1'b1;
assign HEX3[7]=1'b1, HEX4[7]=1'b1, HEX5[7]=1'b1;

/* Qsys階層の接続 */
ps2if_qsys u0 (
    .clk_clk                  (CLK),
    .reset_reset_n            (~RST),
    .ps2if_ip_0_conduit_end_ps2clk  (ARDUINO_IO[0]),
    .ps2if_ip_0_conduit_end_ps2data (ARDUINO_IO[1]),
    .ps2if_ip_0_conduit_end_logclk  (),
    .pio_0_external_connection_export (
        {LEDR[3], HEX3[6:0],
         LEDR[2], HEX2[6:0],
         LEDR[1], HEX1[6:0],
         LEDR[0], HEX0[6:0]} ),
    .pio_1_external_connection_export (
        {LEDR[5], HEX5[6:0],
         LEDR[4], HEX4[6:0]} )
);

endmodule
