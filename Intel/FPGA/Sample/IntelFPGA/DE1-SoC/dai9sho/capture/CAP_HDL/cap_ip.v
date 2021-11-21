/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第9章                      */
/* project: capture                    */
/* outline: キャプチャ回路IP最上位階層 */

module cap_ip (
    // Avalon MM Master
    input           clk, reset,
    input           avm_waitrequest,
    output  [25:0]  avm_address,
    output          avm_write,
    output  [15:0]  avm_writedata,
    output  [4:0]   avm_burstcount,

    /* カメラ入力 */
    input           coe_PCLK,
    input           coe_VSYNC,
    input           coe_HREF,
    input   [7:0]   coe_CAMDATA,
    output          coe_XCLK,

    /* GPIOに接続 */
    input   [25:0]  coe_CAPADDR,
    input           coe_CAPON,
    input           coe_CLRCBLNK,
    output          coe_CBLANK
    );

/* 固定信号 */
assign avm_burstcount = 5'd16;  /* バースト長：16 */

/* ブロック間接続信号 */
wire            FIFORD;
wire            FIFOWR;
wire    [11:0]  FIFOIN;
wire            FIFORST;
wire            SETCBLNK;
wire    [9:0]   rdcnt;

/* バースト長以上FIFOに格納 */
wire    FIFOREADY = (rdcnt>=10'd16) & coe_CAPON;

cap_ctrl cap_ctrl (
    .CLK        (clk),
    .RST        (reset),
    .waitrequest(avm_waitrequest),
    .address    (avm_address),
    .write      (avm_write),
    .FIFORD     (FIFORD),
    .CAPADDR    (coe_CAPADDR),
    .FIFOREADY  (FIFOREADY),
    .SETCBLNK   (SETCBLNK)
);

cap_fifo cap_fifo(
    .aclr       (FIFORST),
    .data       ({4'h0, FIFOIN}),
    .rdclk      (clk),
    .rdreq      (FIFORD),
    .wrclk      (coe_PCLK),
    .wrreq      (FIFOWR),
    .q          (avm_writedata),
    .rdusedw    (rdcnt)
);

cap_in cap_in (
    .CLK        (clk),
    .RST        (reset),
    .CAPON      (coe_CAPON),
    .FIFOWR     (FIFOWR),
    .FIFOIN     (FIFOIN),
    .PCLK       (coe_PCLK),
    .HREF       (coe_HREF),
    .XCLK       (coe_XCLK),
    .CAMDATA    (coe_CAMDATA)
);

cap_flag cap_flag (
    .CLK        (clk),
    .PCLK       (coe_PCLK),
    .RST        (reset),
    .VSYNC      (coe_VSYNC),
    .CLRCBLNK   (coe_CLRCBLNK),
    .SETCBLNK   (SETCBLNK),
    .FIFORST    (FIFORST),
    .CBLANK     (coe_CBLANK)
);

endmodule
