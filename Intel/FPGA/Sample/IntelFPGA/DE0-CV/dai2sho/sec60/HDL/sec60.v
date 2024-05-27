/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第2章課題 */
/* project: SEC60     */
/* outline: 60秒計    */

module SEC60(
    input           CLK, RST,
    output  [6:0]   HEX0,
    output  [6:0]   HEX1
);

/* 1Hzのイネーブル信号生成（クロック周波数: 50MHz） */
reg  [25:0] cnt;
wire en1hz = (cnt==26'd49_999_999);

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 26'b0;
    else if ( en1hz )
        cnt <= 26'b0;
    else
        cnt <= cnt + 26'b1;
end

/* 1秒桁 */
reg  [3:0] sec;

always @( posedge CLK ) begin
    if ( RST )
        sec <= 4'h0;
    else if ( en1hz )
        if ( sec==4'h9 )
            sec <= 4'h0;
        else
            sec <= sec + 4'h1;
end

/* 10秒桁 */
reg  [2:0] min;

always @( posedge CLK ) begin
    if( RST )
        min <= 3'd0;
    else if( en1hz && sec==4'd9 ) begin
        if( min==3'd5 )
            min <= 3'd0;
        else
            min <= min + 3'd1;
    end
end

/* 7セグメント表示デコーダの接続 */
seg7dec dec_min( min, HEX1 );
seg7dec dec_sec( sec, HEX0 );

endmodule
