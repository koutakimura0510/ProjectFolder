/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章                        */
/* project: display                      */
/* outline: Nioss IIシステムの最上位階層 */

module display (
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
assign HEX0=7'h7f, HEX1=7'h7f, HEX2=7'h7f, HEX3=7'h7f, HEX4=7'h7f, HEX5=7'h7f;

/* Qsys外部で接続する信号 */
wire [25:0] DISPADDR;
wire        DISPON, VBLANK, CLRVBLNK;

/* Qsys階層の接続 */
display_qsys u0 (
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
    .new_sdram_controller_0_wire_we_n  (DRAM_WE_N),
    .disp_ip_0_conduit_end_0_clrvblnk  (CLRVBLNK),
    .disp_ip_0_conduit_end_0_dispaddr  (DISPADDR),
    .disp_ip_0_conduit_end_0_dispon    (DISPON),
    .disp_ip_0_conduit_end_0_vblank    (VBLANK),
    .disp_ip_0_conduit_end_0_vga_b     (VGA_B),
    .disp_ip_0_conduit_end_0_vga_g     (VGA_G),
    .disp_ip_0_conduit_end_0_vga_hs    (VGA_HS),
    .disp_ip_0_conduit_end_0_vga_r     (VGA_R),
    .disp_ip_0_conduit_end_0_vga_vs    (VGA_VS),
    .pio_0_external_connection_export  (DISPADDR),
    .pio_1_external_connection_export  ({CLRVBLNK, DISPON}),
    .pio_2_external_connection_export  (VBLANK)
);

endmodule
