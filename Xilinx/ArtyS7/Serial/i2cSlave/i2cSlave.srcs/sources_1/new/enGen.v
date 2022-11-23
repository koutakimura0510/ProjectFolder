/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * enable信号生成
 */
module enGen
#(
// simlationが行いやすくするため、parameter設定を行えるようにする
parameter pSysClk = 100000000,  // System CLK
parameter pSetClk = 100000,     // デバイスの設定1ms
parameter pDynClk = 500000,     // ダイナミック点灯5ms
parameter pSclClk = 125         // 400kHz
)(
input 			iRST,		    // System Reset
input 			iCLK,		    // System Clock
output          enSet,          // 1ms
output          enKhz,          // 5ms
output          en400Khz        // 立上り立下り合わせて400Khz
);

reg [26:0] tmp_count;           // System Clk Counter

// 指定周波数でenable信号生成
assign enable   = (tmp_count[26:0] == (pSysClk - 1)) ? 1'b1 : 1'b0;
assign enSet    = (tmp_count[16:0] == (pSetClk - 1)) ? 1'b1 : 1'b0;
assign enKhz    = (tmp_count[18:0] == (pDynClk - 1)) ? 1'b1 : 1'b0;
assign en400Khz = (tmp_count[ 6:0] == (pSclClk - 1)) ? 1'b1 : 1'b0;

//System CLKの周期でカウント
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmp_count <= 27'd0;
    end else if (enable == 1'b1) begin
        tmp_count <= 27'd0;
    end else begin
        tmp_count <= tmp_count + 27'd1;
    end
end

endmodule