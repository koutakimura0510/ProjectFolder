/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第5章以降                                */
/* project:                                          */
/* outline: Nioss IIシステムの最上位階層テンプレート */
/* board  : DE0-CV                                   */

module nios2sys_top (
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


endmodule
