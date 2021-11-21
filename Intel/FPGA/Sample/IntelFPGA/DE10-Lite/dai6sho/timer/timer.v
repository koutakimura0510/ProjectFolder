/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第6章                        */
/* project: timer                        */
/* outline: Nioss IIシステムの最上位階層 */
/* board  : DE10_Lite                    */

module timer (
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

    /* GPIOコネクタ #0、ARDUINOコネクタ */
    inout   [35:0]  GPIO,
    inout   [15:0]  ARDUINO_IO
);

/* 未使用端子の固定 */
assign HEX0[7]=1'b1;
assign HEX1=8'hff, HEX2=8'hff, HEX3=8'hff, HEX4=8'hff, HEX5=8'hff;

/* Qsys階層の接続 */
timer_qsys u0 (
    .clk_clk                          (CLK),
    .reset_reset_n                    (~RST),
    .pio_0_external_connection_export (HEX0[6:0]),
    .pio_1_external_connection_export (SW[3:0])
);

endmodule
