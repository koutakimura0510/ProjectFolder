/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章                  */
/* project: CLOCK24                */
/* outline: 1Hzおよび2Hz信号の作成 */

module CNT1SEC(
    input  CLK, RST,
    output EN1HZ,
    output reg SIG2HZ
);

/* 50MHzカウンタ */
reg [25:0] cnt;

always @( posedge CLK ) begin
    if ( RST )
        cnt <= 26'b0;
    else if ( EN1HZ )
        cnt <= 26'b0;
    else
        cnt <= cnt + 1'b1;
end

/* 1Hzのイネーブル信号 */
assign EN1HZ = (cnt==26'd49999999);

/* 2Hz、デューティ50%の信号作成 */
wire cnt37499999 = (cnt==26'd37499999);
wire cnt24999999 = (cnt==26'd24999999);
wire cnt12499999 = (cnt==26'd12499999);

always @( posedge CLK ) begin
    if( RST )
        SIG2HZ <= 1'b0;
    else if( cnt12499999 | cnt24999999 | cnt37499999 | EN1HZ )
        SIG2HZ <= ~SIG2HZ;
end

endmodule
