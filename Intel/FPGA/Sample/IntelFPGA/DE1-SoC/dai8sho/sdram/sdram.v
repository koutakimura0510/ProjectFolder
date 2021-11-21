/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章                        */
/* project: sdram                        */
/* outline: Nioss IIシステムの最上位階層 */
/* board  : DE1-SoC                      */

module sdram (
    /* クロック、リセット（SW[9]） */
    input           CLK, RST,

    /* スライドスイッチ、プッシュスイッチ、7セグメントLED */
    input   [8:0]   SW,
    input   [3:0]   KEY,
    output  [6:0]   HEX0, HEX1, HEX2, HEX3, HEX4, HEX5,

    /* 単体LED、PS/2端子 */
    output  [9:0]   LEDR,
    inout           PS2_CLK, PS2_DAT,

    /* VGA */
    output          VGA_CLK,
    output  [7:0]   VGA_R,  VGA_G, VGA_B,
    output          VGA_HS, VGA_VS,
    output          VGA_BLANK_N, VGA_SYNC_N,

    /* SDRAM */
    output          DRAM_CLK, DRAM_CKE,
    output  [12:0]  DRAM_ADDR,
    output  [1:0]   DRAM_BA,
    output          DRAM_CAS_N, DRAM_RAS_N,
    output          DRAM_CS_N,  DRAM_WE_N,
    output          DRAM_UDQM,  DRAM_LDQM,
    inout   [15:0]  DRAM_DQ,

    /* GPIOコネクタ #0 */
    inout   [35:0]  GPIO_0
);

/* 未使用端子の固定 */
assign HEX0=7'h7f, HEX1=7'h7f, HEX2=7'h7f, HEX3=7'h7f, HEX4=7'h7f, HEX5=7'h7f;

/* Qsys階層の接続 */
sdram_qsys u0 (
    .clk_clk                  (CLK),
    .reset_reset_n            (~RST),
    .sdclk_clk                         (DRAM_CLK),
    .new_sdram_controller_0_wire_addr  (DRAM_ADDR),
    .new_sdram_controller_0_wire_ba    (DRAM_BA),
    .new_sdram_controller_0_wire_cas_n (DRAM_CAS_N),
    .new_sdram_controller_0_wire_cke   (DRAM_CKE),
    .new_sdram_controller_0_wire_cs_n  (DRAM_CS_N),
    .new_sdram_controller_0_wire_dq    (DRAM_DQ),
    .new_sdram_controller_0_wire_dqm   ({DRAM_UDQM, DRAM_LDQM}),
    .new_sdram_controller_0_wire_ras_n (DRAM_RAS_N),
    .new_sdram_controller_0_wire_we_n  (DRAM_WE_N)
);

endmodule
