/*
 * Create 2021/12/23
 * Author koutakimura
 * -
 * TMDSパラレル->シリアル変換モジュール
 */
module tmdsSerialize (
    input           iCLK,        // PLL clk
    input           iRST,        // system rst
    input  [9:0]    iTmdsPara,   // tmdsパラレル信号
    output          oTmdsSeri    // tmdsシリアル信号
);

//----------------------------------------------------------
// tmdsシリアル信号出力
// LSB farstで送信を行う
//----------------------------------------------------------
reg  [9:0] rTmds;        assign oTmdsSeri = rTmds[0];
reg  [3:0] rTmdsCnt;
reg  qEnable;

always @(posedge iCLK) begin
    if (iRST)           rTmdsCnt <= 0;
    else if (qEnable)   rTmdsCnt <= 0;
    else                rTmdsCnt <= rTmdsCnt + 1'b1;
end

always @(posedge iCLK) begin
    if (iRST)           rTmds <= 0;
    else if (qEnable)   rTmds <= iTmdsPara;
    else                rTmds <= rTmds[9:1];
end

always @*
begin
    qEnable <= rTmdsCnt == 4'd9;
end

endmodule