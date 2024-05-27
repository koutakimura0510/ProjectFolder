/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第7章課題（スクロールホイール対応）*/
/* project: ps2if                              */
/* outline: Nioss IIシステムの最上位階層       */

module ps2if (
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

/* Qsys階層の接続 */
ps2if_qsys u0 (
    .clk_clk                  (CLK),
    .reset_reset_n            (~RST),
    .ps2if_ip_0_conduit_end_ps2clk  (PS2_CLK),
    .ps2if_ip_0_conduit_end_ps2data (PS2_DAT),
    .ps2if_ip_0_conduit_end_logclk  (),
    .pio_0_external_connection_export (
        {LEDR[3], HEX3,
         LEDR[2], HEX2,
         LEDR[1], HEX1,
         LEDR[0], HEX0} ),
    .pio_1_external_connection_export (
        {LEDR[5], HEX5,
         LEDR[4], HEX4} )
);

endmodule
