/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第9章                        */
/* project: capture                      */
/* outline: Nioss IIシステムの最上位階層 */
/* board  : DE10-Lite                    */

module capture (
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
assign HEX0=8'hff, HEX1=8'hff, HEX2=8'hff, HEX3=8'hff, HEX4=8'hff, HEX5=8'hff;

/* Qsys外部で接続する信号 */
wire [25:0] DISPADDR;
wire        DISPON, VBLANK, CLRVBLNK;
wire [25:0] CAPADDR;
wire        CAPON, CBLANK, CLRCBLNK;

/* GPIO接続信号 */
wire PCLK  = GPIO[0];
wire VSYNC = GPIO[7];
wire HREF  = GPIO[9];
wire [7:0] CAMDATA = { GPIO[10], GPIO[12], GPIO[14], GPIO[16],
                       GPIO[18], GPIO[20], GPIO[22], GPIO[24] };
wire    XCLK, SCL, SDA;
assign GPIO[3] = XCLK;
assign GPIO[6] = SCL;
assign GPIO[8] = SDA;

/* Qsys階層の接続 */
capture_qsys u0 (
    .clk_clk                            (CLK),
    .reset_reset_n                      (~RST),
    .sdclk_clk                          (DRAM_CLK),
    .new_sdram_controller_0_wire_addr   (DRAM_ADDR),
    .new_sdram_controller_0_wire_ba     (DRAM_BA),
    .new_sdram_controller_0_wire_cas_n  (DRAM_CAS_N),
    .new_sdram_controller_0_wire_cke    (DRAM_CKE),
    .new_sdram_controller_0_wire_cs_n   (DRAM_CS_N),
    .new_sdram_controller_0_wire_dq     (DRAM_DQ),
    .new_sdram_controller_0_wire_dqm    ({DRAM_UDQM, DRAM_LDQM}),
    .new_sdram_controller_0_wire_ras_n  (DRAM_RAS_N),
    .new_sdram_controller_0_wire_we_n   (DRAM_WE_N),
    .disp_ip_0_conduit_end_0_clrvblnk   (CLRVBLNK),
    .disp_ip_0_conduit_end_0_dispaddr   (DISPADDR),
    .disp_ip_0_conduit_end_0_dispon     (DISPON),
    .disp_ip_0_conduit_end_0_vblank     (VBLANK),
    .disp_ip_0_conduit_end_0_vga_b      (VGA_B),
    .disp_ip_0_conduit_end_0_vga_g      (VGA_G),
    .disp_ip_0_conduit_end_0_vga_hs     (VGA_HS),
    .disp_ip_0_conduit_end_0_vga_r      (VGA_R),
    .disp_ip_0_conduit_end_0_vga_vs     (VGA_VS),
    .pio_0_external_connection_export   (DISPADDR),
    .pio_1_external_connection_export   ({CLRVBLNK, DISPON}),
    .pio_2_external_connection_export   (VBLANK),
    .cap_ip_0_conduit_end_0_camdata     (CAMDATA),
    .cap_ip_0_conduit_end_0_capaddr     (CAPADDR),
    .cap_ip_0_conduit_end_0_capon       (CAPON),
    .cap_ip_0_conduit_end_0_cblank      (CBLANK),
    .cap_ip_0_conduit_end_0_href        (HREF),
    .cap_ip_0_conduit_end_0_pclk        (PCLK),
    .cap_ip_0_conduit_end_0_vsync       (VSYNC),
    .cap_ip_0_conduit_end_0_xclk        (XCLK),
    .cap_ip_0_conduit_end_0_clrcblnk    (CLRCBLNK),
    .pio_3_external_connection_export   (CAPADDR),
    .pio_4_external_connection_export   ({CLRCBLNK, CAPON}),
    .pio_5_external_connection_export   (CBLANK),
    .sccb_0_conduit_end_scl             (SCL),
    .sccb_0_conduit_end_sda             (SDA)
);

endmodule
