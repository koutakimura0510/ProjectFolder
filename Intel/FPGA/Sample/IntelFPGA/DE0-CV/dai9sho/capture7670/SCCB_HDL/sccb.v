/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第9章            */
/* project: capture          */
/* outline: SCCBコントローラ */

module sccb (
    /* Avalon-MM Slave */
    input           clk, reset,
    input           address,
    input           write, read,
    input   [15:0]  writedata,
    output  [15:0]  readdata,

    /* SCCB */
    output  reg     SCL,
    output          SDA
);

/* レジスタ書き込み信号 */
wire sccbtrig = (write && address==1'b0);

/* BUSYフラグ読み出し */
reg    sccbbusy;
assign readdata = (address==1'b1 && read==1'b1) ? {15'b0, sccbbusy}: 16'b0;

/* ステートマシン（宣言部） */
localparam HALT=2'h0, STBIT=2'h1, SEND=2'h2, POSDLY=2'h3;
reg [1:0]   cur, nxt;

/* 各種イネーブル信号作成用カウンタ（100kHz） */
localparam CNTMAX=10'd1000;
reg [9:0]   cnt10;

always @( posedge clk ) begin
    if ( reset )
        cnt10 <= 10'h0;
    else if ( cnt10==CNTMAX-1 )
        cnt10 <= 10'h0;
    else
        cnt10 <= cnt10 + 10'h1;
end

/* 各種イネーブル信号 */
wire state_en = (cnt10==CNTMAX-1);
wire sclset0  = (cnt10==2);
wire sclset1  = (cnt10==CNTMAX/2+2);
wire sft_en   = (cnt10==CNTMAX/4-1) && (cur!=HALT);

/* データシフトレジスタ */
reg [29:0] dsft;

always @( posedge clk ) begin
    if ( reset )
        dsft <= 30'h3fff_ffff;
    else if ( sccbtrig )
        dsft <= { 2'b10, 8'h42, 1'b0, writedata[15:8], 1'b0,
                                      writedata[7:0],  1'b0, 1'b0};
    else if ( sft_en )
        dsft <= {dsft[28:0], 1'b1};
end

/* Hi-Zシフトレジスタ */
localparam [29:0] HIZPOS=30'b00_000000001_000000001_000000001_0;
reg [29:0] zsft;

always @( posedge clk ) begin
    if ( reset )
        zsft <= 30'b0;
    else if ( sccbtrig )
        zsft <= HIZPOS;
    else if ( sft_en )
        zsft <= {zsft[28:0], 1'b0};
end

/* SDA出力作成 */
assign SDA = (zsft[29]==1'b1) ? 1'bz: dsft[29];

/* SCL出力作成 */
always @( posedge clk ) begin
    if ( reset )
        SCL <= 1'b1;
    else if ( cur==SEND ) begin
        if ( sclset0 )
            SCL <= 1'b0;
        else if ( sclset1 )
            SCL <= 1'b1;
    end
    else
        SCL <= 1'b1;
end

/* データ送出カウンタ */
reg [4:0] sendcnt;

always @( posedge clk ) begin
    if ( reset )
        sendcnt <= 5'h00;
    else if ( cur==HALT )
        sendcnt <= 5'h00;
    else if ( cur==SEND && state_en )
        sendcnt <= sendcnt + 5'h01;
end

wire sendend = (sendcnt==5'd27);

/* sccbbusy遅延用カウンタ   */
/* 1カウントあたり10μs遅延 */
reg [7:0] busycnt;
localparam BUSYCNTMAX = 20;

always @( posedge clk ) begin
    if ( reset )
        busycnt <= 8'h00;
    else if ( cur==HALT )
            busycnt <= 8'h00;
    else if ( state_en && cur==POSDLY )
        if ( busycnt==BUSYCNTMAX )
            busycnt <= 8'h00;
        else
            busycnt <= busycnt + 8'h01;
end

/* sccbbusy信号 */
always @( posedge clk ) begin
    if ( reset )
        sccbbusy <= 1'b0;
    else if ( sccbtrig )
        sccbbusy <= 1'b1;
    else if ( state_en && cur==POSDLY && busycnt==BUSYCNTMAX )
        sccbbusy <= 1'b0;
end

/* 状態遷移の開始信号                     */
/* sccbtrigを次のstate_enまで伸ばして作成 */
/* sccbtrigとstate_enが同時でも伸びる     */
reg     regwrite;

always @(  posedge clk ) begin
    if ( reset )
        regwrite <= 1'b0;
    else if ( sccbtrig )
        regwrite <= 1'b1;
    else if ( state_en )
        regwrite <= 1'b0;
end

/* ステートマシン */
always @( posedge clk ) begin
    if ( reset )
        cur <= HALT;
    else if ( state_en )
        cur <= nxt;
end

always @* begin
    case ( cur )
        HALT:   if ( regwrite )
                    nxt = STBIT;
                else
                    nxt = HALT;
        STBIT: nxt = SEND;
        SEND:   if ( sendend )
                    nxt = POSDLY;
                else
                    nxt = SEND;
        POSDLY: if ( busycnt==BUSYCNTMAX )
                    nxt = HALT;
                else
                    nxt = POSDLY;
        default:nxt = HALT;
    endcase
end

endmodule
