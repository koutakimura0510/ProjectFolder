/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第6章課題                    */
/* project: nios2clock1                  */
/* outline: Nioss IIシステムの最上位階層 */

module nios2clock1 (
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

    /* GPIOコネクタ #0 */
    inout   [35:0]  GPIO_0
);

/* 未使用端子の固定 */
assign HEX4=7'h7f, HEX5=7'h7f;

/* 接続用ダミー信号 */
wire d0, d1, d2, d3;

/* Qsys階層の接続 */
nios2clock1_qsys u0 (
    .clk_clk                    (CLK),
    .reset_reset_n              (~RST),
    .mypio_0_conduit_end_inport (KEY[1:0]),
    .mypio_0_conduit_end_outport({d3, HEX3, d2, HEX2, d1, HEX1, d0, HEX0})
);

endmodule
