/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章   */
/* project: CLOCK1  */
/* outline: 1時間計 */

module CLOCK1(
    input   CLK, RST,
    input   [2:0]   KEY,
    output  [6:0]   HEX0, HEX1, HEX2, HEX3
);

/* スイッチ入力回路の接続 */
wire    clr, minup, secup;
BTN_IN b0 ( .CLK(CLK), .RST(RST),
            .nBIN(KEY), .BOUT({clr, minup, secup}) );

/* 1Hzイネーブル回路の接続 */
wire    en1hz;
CNT1SEC CNT1SEC( .CLK(CLK), .RST(RST), .EN1HZ(en1hz));

/* 60進カウンタの接続 */
wire    [3:0]   min1,  sec1;
wire    [2:0]   min10, sec10;
wire    cout, dummy;

CNT60 SECCNT( .CLK(CLK), .RST(RST), .CLR(clr), .EN(en1hz),
              .INC(secup), .QH(sec10), .QL(sec1), .CA(cout) );
CNT60 MINCNT( .CLK(CLK), .RST(RST), .CLR(clr), .EN(cout),
              .INC(minup), .QH(min10), .QL(min1), .CA(dummy) );

/* 7セグメントデコーダの接続 */
SEG7DEC d0( .DIN(sec1),  .nHEX(HEX0) );
SEG7DEC d1( .DIN(sec10), .nHEX(HEX1) );
SEG7DEC d2( .DIN(min1),  .nHEX(HEX2) );
SEG7DEC d3( .DIN(min10), .nHEX(HEX3) );

endmodule
