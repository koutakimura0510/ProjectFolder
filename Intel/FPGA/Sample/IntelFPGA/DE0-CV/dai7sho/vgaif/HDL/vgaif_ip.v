/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第7章             */
/* project: vgaif             */
/* outline: VGA文字表示回路IP */

module vgaif_ip (
    /* Avalonバス */
    input           clk, reset,
    input   [11:0]  address,
    input   [3:0]   byteenable,
    input           write, read,
    input   [31:0]  writedata,
    output  [31:0]  readdata,
    /* VGA出力 */
    output  [3:0]   VGA_R,
    output  [3:0]   VGA_G,
    output  [3:0]   VGA_B,
    output          VGA_HS, VGA_VS
);

/* VGA(640×480)用パラメータ読み込み */
`include "vga_param.vh"

wire    [9:0]   HCNT;
wire    [9:0]   VCNT;
wire            PCK;

/* syncgen接続 */
syncgen syncgen (
    .CLK    (clk),
    .RST    (reset),
    .PCK    (PCK),
    .VGA_HS (VGA_HS),
    .VGA_VS (VGA_VS),
    .HCNT   (HCNT),
    .VCNT   (VCNT)
);

/* 内部での参照用にカウント値を変換 */
wire [9:0] iHCNT = HCNT - HFRONT - HWIDTH - HBACK + 10'd8;
wire [9:0] iVCNT = VCNT - VFRONT - VWIDTH - VBACK - 10'd40;

/* VRAM接続信号 */
wire [31:0] vramout;
wire [11:0] vramaddr;

/* VRAM接続 */
VRAM VRAM (
    .data_a     ( writedata ),
    .address_a  ( address ),
    .wren_a     ( write ),
    .byteena_a  ( byteenable ),
    .clock_a    ( clk ),
    .q_a        ( readdata ),
    .data_b     ( 32'h0 ),
    .address_b  ( vramaddr ),
    .wren_b     ( 1'b0 ),
    .clock_b    ( PCK ),
    .q_b        ( vramout )
);

wire [2:0] vdotcnt;
wire [7:0] cgout;

/* CGROM接続 */
CGROM CGROM (
    .address({vramout[6:0], vdotcnt}),
    .q      (cgout),
    .clock  (PCK)
);

/* HCNTとVCNTを文字とドットのカウンタとして分けて考える */
wire [6:0] hchacnt = iHCNT[9:3];  /* 水平文字カウンタ   */
wire [2:0] hdotcnt = iHCNT[2:0];  /* 水平ドットカウンタ */
wire [5:0] vchacnt = iVCNT[8:3];  /* 垂直文字カウンタ   */
assign     vdotcnt = iVCNT[2:0];  /* 垂直ドットカウンタ */

/* VRAMのアドレス生成  vramaddr ← vchacnt ＊ 80 ＋ hchacnt */
assign vramaddr = (vchacnt<<6) + (vchacnt<<4) + hchacnt;

/* シフトレジスタ */
reg [7:0] sreg;
wire sregld = (hdotcnt==3'h6 && iHCNT<10'd640);

always @( posedge PCK ) begin
    if ( reset )
        sreg <= 8'h00;
    else if ( sregld )
        sreg <= cgout;
    else
        sreg <= {sreg[6:0], 1'b0};
end

/* 色情報をsregのLDと同時に取り込む */
reg [11:0] color;

always @( posedge PCK ) begin
    if ( reset )
        color <= 12'h000;
    else if ( sregld )
        color <= vramout[27:16];
end

/* 水平、垂直表示イネーブル信号 */
wire hdispen = (10'd7<=iHCNT && iHCNT<10'd647);
wire vdispen = (iVCNT<9'd400);

/* RGB出力信号作成 */
reg [11:0] vga_rgb;

always @( posedge PCK ) begin
    if ( reset )
        vga_rgb <= 12'h000;
    else
        vga_rgb <= color & {12{hdispen & vdispen & sreg[7]}};
end

assign VGA_R = vga_rgb[11:8];
assign VGA_G = vga_rgb[ 7:4];
assign VGA_B = vga_rgb[ 3:0];

endmodule
