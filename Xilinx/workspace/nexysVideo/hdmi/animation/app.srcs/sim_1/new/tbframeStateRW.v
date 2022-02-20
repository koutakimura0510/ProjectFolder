`timescale 1ns / 1ps
/*
 * Create 2021/1/29
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * プレイヤーのドットデータ作成モジュールのテストベンチ
 */


module tbframeStateRW;

parameter CYCLE = 2;
`include "../../sources_1/new/gamedata/include/commonAddr.vh"

////////////////////////////////////////////////////////////
reg         iCLK = 0;
reg         iRST = 0;
reg         iRE  = 0;
reg         iWE  = 0;
wire        oRE;
wire [1:0]  oRS;
wire [1:0]  oWS;

frameStateRW #(
    .pBitLengthState (2)
) FRAME_STATE_RW (
    .iCLK       (iCLK),
    .iRST       (iRST),
    .iRE        (iRE),
    .iWE        (iWE),
    .oRE        (oRE),
    .oRS        (oRS),
    .oWS        (oWS)
);

always begin
    #(CYCLE/2);
    iCLK = ~iCLK;
end

////////////////////////////////////////////////////////////
reg [3:0] rWCnt;

always @(posedge iCLK)
begin
    if (iRST)               rWCnt <= 0;
    else if (rWCnt == 5)    rWCnt <= 0;
    else if (oWS == IDOL)   rWCnt <= rWCnt;
    else                    rWCnt <= rWCnt + 1'b1;
end

always @(posedge iCLK)
begin
    if (iRST)               iWE <= 0;
    else if (rWCnt == 5)    iWE <= 1'b1;
    else                    iWE <= 1'b0;
end

////////////////////////////////////////////////////////////

reg [3:0] rRCnt;

always @(posedge iCLK)
begin
    if (iRST)            rRCnt <= 0;
    else if (rRCnt == 9) rRCnt <= 0;
    else                 rRCnt <= rRCnt + 1'b1;
end

always @(posedge iCLK)
begin
    if (iRST)               iRE <= 0;
    else if (rRCnt == 9)    iRE <= 1'b1;
    else                    iRE <= 1'b0;
end

////////////////////////////////////////////////////////////
initial begin
    iRST = 0;
    #(CYCLE * 2);
    iRST = 1;
    #(CYCLE * 4);
    iRST = 0;
    #(CYCLE * 100 * 4);
    $stop;
end

endmodule
