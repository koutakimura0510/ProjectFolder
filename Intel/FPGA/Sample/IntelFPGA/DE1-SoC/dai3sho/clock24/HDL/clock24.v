/* Copyright(C) 2017 Cobac.Net All Rights Reserved. */
/* chapter: 第3章                        */
/* project: CLOCK24                      */
/* outline: 時刻あわせ機能つき24時間時計 */

module CLOCK24(
    input   CLK, RST,
    input   [2:0]   KEY,
    output  [6:0]   HEX0, HEX1, HEX2, HEX3, HEX4, HEX5
);

wire    CASEC, CAMIN;
wire    MODE,   SELECT, ADJUST;
wire    SECCLR, MININC, HOURINC;
wire    SECON,  MINON,  HOURON;
wire    EN1HZ,  SIG2HZ;
wire    [3:0]   SECL, MINL, HOURL;
wire    [2:0]   SECH, MINH;
wire    [1:0]   HOURH;

/* 各ブロックの接続 */
CNT1SEC CNT1SEC( .CLK(CLK), .RST(RST), .EN1HZ(EN1HZ), .SIG2HZ(SIG2HZ) );

BTN_IN  BTN_IN ( .CLK(CLK), .RST(RST), .nBIN(KEY),
                 .BOUT({MODE, SELECT, ADJUST}) );

SECCNT   SEC ( .CLK(CLK), .RST(RST), .EN(EN1HZ), .CLR(SECCLR),
               .QH(SECH), .QL(SECL), .CA(CASEC) );

MINCNT   MIN ( .CLK(CLK), .RST(RST), .EN(CASEC), .INC(MININC),
               .QH(MINH), .QL(MINL), .CA(CAMIN) );

HOURCNT HOUR ( .CLK(CLK), .RST(RST), .EN(CAMIN), .INC(HOURINC),
               .QH(HOURH),.QL(HOURL) );

STATE  STATE ( .CLK(CLK), .RST(RST), .SIG2HZ(SIG2HZ),
               .MODE(MODE),     .SELECT(SELECT), .ADJUST(ADJUST),
               .SECCLR(SECCLR), .MININC(MININC), .HOURINC(HOURINC),
               .SECON(SECON),   .MINON(MINON),   .HOURON(HOURON) );

SEG7DEC SL(.DIN(SECL),           .EN(SECON),  .nHEX(HEX0));
SEG7DEC SH(.DIN({1'b0, SECH}),   .EN(SECON),  .nHEX(HEX1));
SEG7DEC ML(.DIN(MINL),           .EN(MINON),  .nHEX(HEX2));
SEG7DEC MH(.DIN({1'b0, MINH}),   .EN(MINON),  .nHEX(HEX3));
SEG7DEC HL(.DIN(HOURL),          .EN(HOURON), .nHEX(HEX4));
SEG7DEC HH(.DIN({2'b00, HOURH}), .EN(HOURON), .nHEX(HEX5));

endmodule
