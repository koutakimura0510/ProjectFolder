/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章         */
/* project: CLOCK1        */
/* outline: 1Hz信号の作成 */

module CNT1SEC(
    input  CLK, RST,
    output EN1HZ
);

/* 50MHzカウンタ */
reg [25:0] cnt;

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 26'b0;
    else if ( EN1HZ )
        cnt <= 26'b0;
    else
        cnt <= cnt + 26'b1;
end

/* 1Hzのイネーブル信号 */
assign EN1HZ = (cnt==26'd49_999_999);

endmodule
