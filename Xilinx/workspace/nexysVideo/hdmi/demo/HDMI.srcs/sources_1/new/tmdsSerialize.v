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


//----------------------------------------------------------
// tmdsシリアル信号出力
//----------------------------------------------------------
reg otmds;      assign oTmdsSeri = otmds;


//----------------------------------------------------------
// tmdsシフトレジスタカウント動作
//----------------------------------------------------------
reg [3:0] tmds_cnt;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmds_cnt <= 0;
    end else if (tmds_cnt == 4'h9) begin
        tmds_cnt <= 0;
    end else begin
        tmds_cnt <= tmds_cnt + 1'b1;
    end
end


 //----------------------------------------------------------
 // LSB farstで送信を行う
 //----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        otmds <= 0;
    end else begin
        otmds <= (iTmdsPara >> tmds_cnt) & 1'b1;
    end
end

endmodule