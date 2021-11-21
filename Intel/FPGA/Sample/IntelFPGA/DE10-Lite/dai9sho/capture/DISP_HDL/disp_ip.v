/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章                              */
/* project: display                            */
/* outline: グラフィック表示回路IPの最上位階層 */

module disp_ip (
    // Avalon MM Master
    input           clk, reset,
    input           avm_waitrequest,
    input   [15:0]  avm_readdata,
    input           avm_readdatavalid,
    output  [25:0]  avm_address,
    output          avm_read,
    output  [4:0]   avm_burstcount,

    /* 画像出力 */
    output  [3:0]   coe_VGA_R,
    output  [3:0]   coe_VGA_G,
    output  [3:0]   coe_VGA_B,
    output          coe_VGA_HS, coe_VGA_VS,

    /* GPIOに接続 */
    input   [25:0]  coe_DISPADDR,
    input           coe_DISPON,
    input           coe_CLRVBLNK,
    output          coe_VBLANK
    );

/* 固定信号 */
assign avm_burstcount = 5'd16;  /* バースト長：16 */

/* ブロック間接続信号 */
wire            PCK;
wire            DISPSTART;
wire            FIFORD;
wire    [15:0]  FIFOOUT;
wire    [9:0]   HCNT;
wire    [9:0]   VCNT;
wire    [9:0]   wrcnt;

wire FIFOREADY = (wrcnt<10'd768);

/* 各ブロックの接続 */
disp_ctrl disp_ctrl (
    .CLK            (clk),
    .RST            (reset),
    .waitrequest    (avm_waitrequest),
    .address        (avm_address),
    .read           (avm_read),
    .readdatavalid  (avm_readdatavalid),
    .DISPSTART      (DISPSTART),
    .DISPON         (coe_DISPON),
    .DISPADDR       (coe_DISPADDR),
    .FIFOREADY      (FIFOREADY)
);

disp_fifo disp_fifo (
    .aclr       (~coe_VGA_VS),
    .data       (avm_readdata),
    .rdclk      (PCK),
    .rdreq      (FIFORD),
    .wrclk      (clk),
    .wrreq      (avm_readdatavalid),
    .q          (FIFOOUT),
    .wrusedw    (wrcnt)
);

disp_out disp_out (
    .PCK        (PCK),
    .RST        (reset),
    .DISPON     (coe_DISPON),
    .FIFORD     (FIFORD),
    .FIFOOUT    (FIFOOUT),
    .HCNT       (HCNT),
    .VCNT       (VCNT),
    .DISPSTART  (DISPSTART),
    .VGA_R      (coe_VGA_R),
    .VGA_G      (coe_VGA_G),
    .VGA_B      (coe_VGA_B)
);

disp_flag disp_flag (
    .CLK        (clk),
    .RST        (reset),
    .VGA_VS     (coe_VGA_VS),
    .CLRVBLNK   (coe_CLRVBLNK),
    .VBLANK     (coe_VBLANK)
);

syncgen syncgen (
    .CLK        (clk),
    .RST        (reset),
    .PCK        (PCK),
    .VGA_HS     (coe_VGA_HS),
    .VGA_VS     (coe_VGA_VS),
    .HCNT       (HCNT),
    .VCNT       (VCNT)
);

endmodule
