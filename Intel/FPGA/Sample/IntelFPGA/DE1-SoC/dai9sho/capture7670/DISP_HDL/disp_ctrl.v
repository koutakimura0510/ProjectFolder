/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第8章                         */
/* project: display                       */
/* outline: Avalon MMマスター読み出し制御 */

module disp_ctrl (
    input           CLK,
    input           RST,
    input           waitrequest,
    output  [25:0]  address,
    output          read,
    input           readdatavalid,
    input           DISPSTART,
    input           DISPON,
    input   [25:0]  DISPADDR,
    input           FIFOREADY
    );

/* 内部信号の宣言 */
reg [25:0]  addrcnt;
wire        dispend;

/* ステートマシン（宣言部） */
localparam HALT = 2'b00, SETADDR = 2'b01,
           READING = 2'b10, WAITING = 2'b11;
reg [1:0]   cur, nxt;

/* バースト長 */
localparam BURSTSIZE = 5'd16;

/* アドレスおよび読み出し信号 */
assign address = addrcnt + DISPADDR;
assign read    = (cur == SETADDR);

/* VRAM読み出し開始（DISPSTARTをCLKで同期化し立ち上がりを検出） */
reg [2:0]   dispstart_ff;

always @( posedge CLK ) begin
    if ( RST )
        dispstart_ff <= 3'b000;
    else begin
        dispstart_ff[0] <= DISPSTART;
        dispstart_ff[1] <= dispstart_ff[0];
        dispstart_ff[2] <= dispstart_ff[1];
    end
end

wire dispst = DISPON & (dispstart_ff[2:1] == 2'b01);

/* アドレスカウンタ */
always @( posedge CLK ) begin
    if ( RST )
        addrcnt <= 26'b0;
    else if ( cur==HALT && dispst )
        addrcnt <= 26'b0;
    else if ( cur == SETADDR && waitrequest==1'b0 )
        addrcnt <= addrcnt + 26'h0020;
end

/* 表示終了 */
localparam VGA_MAX = 26'd640 * 26'd480 * 26'd2;
assign dispend = (addrcnt == VGA_MAX);

/* バーストカウンタ */
reg [3:0] rdcnt;

always @( posedge CLK ) begin
    if ( RST )
        rdcnt <= 4'h0;
    else if ( cur==SETADDR )
        rdcnt <= 4'h0;
    else if ( readdatavalid )
        rdcnt <= rdcnt+ 4'h1;
end

/* ステートマシン */
always @( posedge CLK ) begin
    if ( RST )
        cur <= HALT;
    else
        cur <= nxt;
end

always @* begin
    case ( cur )
        HALT:       if ( dispst )
                        nxt = SETADDR;
                    else
                        nxt = HALT;
        SETADDR:    if ( waitrequest==1'b0 )
                        nxt = READING;
                    else
                        nxt = SETADDR;
        READING:    if ( rdcnt==BURSTSIZE-5'd1 && readdatavalid ) begin
                        if ( dispend )
                            nxt = HALT;
                        else if ( !FIFOREADY )
                            nxt = WAITING;
                        else
                            nxt = SETADDR;
                    end
                    else
                        nxt = READING;
        WAITING:    if ( FIFOREADY )
                        nxt = SETADDR;
                    else
                        nxt = WAITING;
        default:    nxt = HALT;
    endcase
end

endmodule
