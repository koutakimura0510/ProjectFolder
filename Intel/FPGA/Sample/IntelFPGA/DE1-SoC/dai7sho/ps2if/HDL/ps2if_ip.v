/* Copyright(C) 2017 Cobac.Net All Rights Reserved.  */
/* chapter: 第7章                  */
/* project: ps2if                  */
/* outline: PS/2インターフェースIP */

module ps2if_ip (
    /* Avalonバス */
    input           clk, reset,
    input   [1:0]   address,
    input           write, read,
    input   [7:0]   writedata,
    output  [7:0]   readdata,
    /* 外部入出力 */
    inout           PS2CLK, PS2DATA,     // 双方向
    output reg      LOGCLK
);

/* シフトレジスタ、受信レジスタ、フラグ類（reg宣言） */
reg     [9:0]   sft;
reg     [7:0]   ps2rdata;
reg     empty, valid;

/* ステートマシン（パラメータおよびreg宣言） */
localparam HALT=3'h0, CLKLOW=3'h1, STBIT=3'h2, SENDBIT=3'h3,
          WAITCLK=3'h4, GETBIT=3'h5, SETFLG=3'h6;
reg     [2:0]   cur, nxt;

/* 送信時のシフトレジスタ書き込み信号 */
wire txregwr = (address==2'h2) & write;

/* レジスタ読み出し */
assign readdata =  (address==2'h0) ? {6'b0, empty, valid}: ps2rdata;

/* PS2CLK出力のハザード防止 */
reg     ps2clken;

always @( posedge clk ) begin
    if ( reset )
        ps2clken <= 1'b0;
    else
        ps2clken <= (cur==CLKLOW  || cur==STBIT);
end

/* PS2出力 */
assign  PS2CLK  = (ps2clken) ? 1'b0  : 1'bz;
assign  PS2DATA = (cur==SENDBIT || cur==STBIT) ? sft[0]: 1'bz;

/* スタートビット送出用100μs計時用カウンタ */
reg [12:0]   txcnt;

localparam TXMAX=13'd5000;
wire over100us = (txcnt==TXMAX-1);

always @( posedge clk ) begin
    if ( reset )
        txcnt <= 13'h0000;
    else if ( cur==HALT )
        txcnt <= 13'h0000;
    else if ( over100us )
        txcnt <= 13'h0000;
    else
        txcnt <= txcnt + 13'h1;
end

/* 受信したPS2CLKの立ち下がり検出および同期化 */
reg     [2:0]   sreg;
wire            clkfall;

always @( posedge clk ) begin
    if ( reset )
        sreg <= 3'b000;
    else
        sreg <= {sreg[1:0], PS2CLK};
end

assign clkfall = sreg[2] & ~sreg[1];

/* 送受信ビット数カウンタ */
reg     [3:0]   bitcnt;

always @( posedge clk ) begin
    if ( reset )
        bitcnt <= 4'h0;
    else if ( cur==HALT )
        bitcnt <= 4'h0;
    else if ( (cur==SENDBIT || cur==GETBIT) & clkfall )
        bitcnt <= bitcnt + 4'h1;
end

/* ステートマシン */
always @( posedge clk ) begin
    if ( reset )
        cur <= HALT;
    else
        cur <= nxt;
end

always @* begin
    case ( cur )
        HALT:   if ( txregwr )
                    nxt <= CLKLOW;
                else if ( (PS2DATA==1'b0) & clkfall )
                    nxt <= GETBIT;
                else
                    nxt <= HALT;
        CLKLOW: if ( over100us )
                    nxt <= STBIT;
                else
                    nxt <= CLKLOW;
        STBIT:  if ( over100us )
                    nxt <= SENDBIT;
                else
                    nxt <= STBIT;
        SENDBIT:if ( (bitcnt==4'h9) & clkfall )
                    nxt <= WAITCLK;
                else
                    nxt <= SENDBIT;
        WAITCLK:if ( clkfall )
                    nxt <= HALT;
                else
                    nxt <= WAITCLK;
        GETBIT: if ( (bitcnt==4'h7) & clkfall )
                    nxt <= SETFLG;
                else
                    nxt <= GETBIT;
        SETFLG:  if ( clkfall )
                    nxt <= WAITCLK;
                else
                    nxt <= SETFLG;
        default:nxt <= HALT;
    endcase
end

/* emptyフラグ（受信中も非empty） */
always @( posedge clk ) begin
    if ( reset )
        empty <= 1'b1;
    else
        empty <= (cur==HALT) ? 1'b1: 1'b0;
end

/* 受信データ有効フラグ */
always @( posedge clk ) begin
    if ( reset )
        valid <= 1'b0;
    else if ( (address==2'h0) & write )
        valid <= writedata[0];
    else if ( cur==SETFLG & clkfall )
        valid <= 1'b1;
end

/* シフトレジスタ */
always @( posedge clk ) begin
    if ( reset )
        sft <= 10'h000;
    else if ( txregwr )
        sft <= { ~(^writedata), writedata, 1'b0 };
    else if ( cur==SENDBIT & clkfall )
        sft <= {1'b1, sft[9:1]};
    else if ( cur==GETBIT & clkfall )
        sft <= {PS2DATA, sft[9:1]};
end

/* 受信データ */
always @( posedge clk ) begin
    if ( reset )
        ps2rdata <= 8'h00;
    else if ( cur==SETFLG & clkfall )
        ps2rdata <= sft[9:2];
end

/* SignalTap II用クロック（1MHz） */
reg [4:0]   logcnt;

localparam MAX=5'd25;
wire cntend = (logcnt==MAX-1);

always @( posedge clk ) begin
    if ( reset )
        logcnt <= 5'h00;
    else if ( cntend )
        logcnt <= 5'h00;
    else
        logcnt <= logcnt + 5'h1;
end

always @( posedge clk ) begin
    if ( reset )
        LOGCLK <= 1'b0;
    else if ( cntend )
        LOGCLK <= ~LOGCLK;
end

endmodule
