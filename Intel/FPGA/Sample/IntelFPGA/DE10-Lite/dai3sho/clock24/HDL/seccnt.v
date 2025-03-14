/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章             */
/* project: CLOCK24           */
/* outline: 秒のカウンタ      */

module SECCNT(
    input   CLK, RST,
    input   EN,  CLR,
    output  reg [2:0]   QH,
    output  reg [3:0]   QL,
    output  CA
);

/* 1秒桁 */
always @( posedge CLK ) begin
    if( RST | CLR )
        QL <= 4'd0;
    else if( EN==1'b1 ) begin
        if( QL==4'd9 )
            QL <= 4'd0;
        else
            QL <= QL + 1'b1;
    end
end

/* 10秒桁 */
always @( posedge CLK ) begin
    if( RST | CLR )
        QH <= 3'd0;
    else if( EN==1'b1 && QL==4'd9 ) begin
        if( QH==3'd5 )
            QH <= 3'd0;
        else
            QH <= QH + 1'b1;
    end
end

/* 桁上がり信号 */
assign CA = (QH==3'd5 && QL==4'd9 && EN==1'b1);

endmodule
