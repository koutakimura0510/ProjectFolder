/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第9章                         */
/* project: capture                       */
/* outline: Avalon MMマスター書き込み制御 */

module cap_ctrl
  (
    input           CLK,
    input           RST,
    input           waitrequest,
    output  [25:0]  address,
    output          write,
    output          FIFORD,
    input   [25:0]  CAPADDR,
    input           FIFOREADY,
    input           SETCBLNK
);

reg [25:0]  addrcnt;
wire        capend;

/* ステートマシン（宣言部） */
localparam HALT = 2'b00, PREREAD = 2'b01,
           WRITING = 2'b10, STBY = 2'b11;
reg [1:0]   cur, nxt;

/* バースト長 */
localparam BURSTSIZE  =  5'd16;
localparam BURSTBYTES = BURSTSIZE*2;

// Write Address
assign address = addrcnt + CAPADDR;
assign write   = (cur == WRITING);

/* アドレスカウンタ */
always @( posedge CLK ) begin
    if ( RST )
        addrcnt <= 26'b0;
    else if ( cur==HALT )
        addrcnt <= 26'b0;
    else if ( (cur==STBY) && FIFOREADY )
        addrcnt <= addrcnt + BURSTBYTES;
end

/* キャプチャ終了 */
localparam VGA_MAX = 26'd640 * 26'd480 * 26'd2;
assign capend = (addrcnt == VGA_MAX-BURSTBYTES);

/* バーストカウンタ */
reg [3:0] burstcnt;
wire burstend = (burstcnt==BURSTSIZE-4'd1);

always @( posedge CLK ) begin
    if ( RST )
        burstcnt <= 4'h0;
    else if ( cur==PREREAD )
        burstcnt <= 4'h0;
    else if ( (cur==WRITING) && ~waitrequest )
        burstcnt <= burstcnt+ 4'h1;
end

/* FIFO読み出し信号 */
assign FIFORD = (cur==PREREAD) ||
               ((cur==WRITING) && ~waitrequest && ~burstend);

/* 読み出しステートマシン */
always @( posedge CLK ) begin
    if ( RST | SETCBLNK )
        cur <= HALT;
    else
        cur <= nxt;
end

always @* begin
    case ( cur )
        HALT:       if ( FIFOREADY )
                        nxt = PREREAD;
                    else
                        nxt = HALT;
        PREREAD:    nxt = WRITING;
        WRITING:    if ( burstend && ~waitrequest ) begin
                        if ( capend )
                            nxt = HALT;
                        else
                            nxt = STBY;
                    end
                    else
                        nxt = WRITING;
        STBY:       if ( FIFOREADY )
                        nxt = PREREAD;
                    else
                        nxt = STBY;
        default:    nxt = HALT;
    endcase
end

endmodule
