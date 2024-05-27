/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章           */
/* project: display         */
/* outline: 表示出力作成    */

module disp_out (
    input               PCK,
    input               RST,
    input               DISPON,
    output  reg         FIFORD,
    input   [15:0]      FIFOOUT,

    input   [9:0]       HCNT,
    input   [9:0]       VCNT,
    output  reg         DISPSTART,

    output  reg [3:0]   VGA_R,
    output  reg [3:0]   VGA_G,
    output  reg [3:0]   VGA_B
    );

/* VGA(640×480)用パラメータ読み込み */
`include "vga_param.vh"

/* FIFO読み出し信号 */
wire [9:0] rdstart = HFRONT + HWIDTH + HBACK - 10'd3;
wire [9:0] rdend   = HPERIOD - 10'd3;

always @( posedge PCK ) begin
    if ( RST )
        FIFORD <= 1'b0;
    else if ( VCNT < VFRONT + VWIDTH + VBACK )
        FIFORD <= 1'b0;
    else if ( (HCNT==rdstart) & DISPON )
        FIFORD <= 1'b1;
    else if ( HCNT==rdend )
        FIFORD <= 1'b0;
end

/* FIFORDを1クロック遅らせて表示の最終イネーブルを作る */
reg disp_enable;

always @( posedge PCK ) begin
    if ( RST )
        disp_enable  <= 1'b0;
    else
        disp_enable  <= FIFORD;
end

/* VGA_R～VGA_B出力 */
always @( posedge PCK ) begin
    if ( RST )
        {VGA_R, VGA_G, VGA_B} <= 12'h0;
    else if ( disp_enable )
        {VGA_R, VGA_G, VGA_B} <= FIFOOUT[11:0];
    else
        {VGA_R, VGA_G, VGA_B} <= 12'h0;
end

/* VRAM読み出し開始 */
always @( posedge PCK ) begin
    if ( RST )
        DISPSTART <= 1'b0;
    else
        DISPSTART <= (VCNT == VFRONT + VWIDTH + VBACK -10'd1);
end

endmodule
