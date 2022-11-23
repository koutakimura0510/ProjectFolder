/*
 * Create 2021/12/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * TMDSパラレル->シリアル変換モジュール
 */
module tmdsSerialize (
    input           iCLK,        // PLL clk
    input           iRST,        // system rst
    input  [9:0]    iTmdsPara,   // tmdsパラレル信号
    output          oTmdsSeri    // tmdsシリアル信号
);

reg [9:0] otmds;        assign oTmdsSeri = otmds[0];
reg [3:0] tmds_cnt;


//----------------------------------------------------------
// tmdsシリアル信号出力
// LSB farstで送信を行う
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmds_cnt <= 0;
    end else if (tmds_cnt == 4'd9) begin
        tmds_cnt <= 0;
    end else begin
        tmds_cnt <= tmds_cnt + 1'b1;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        otmds <= 0;
    end else if (tmds_cnt == 4'd9) begin
        otmds <= iTmdsPara;
    end else begin
        otmds <= otmds[9:1];
    end
end

endmodule