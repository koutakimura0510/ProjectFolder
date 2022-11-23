/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリ用、タイミング生成モジュール
 */
module ddr3Enable
#(
    parameter SYSTEM_CLK = 2000000000
)(
    input       iCLK,   // system clk
    input       iRST,   // syste rst
    output      oEnable1us
);

// 各Enable信号パラメータ
localparam ENABLE_1US = (SYSTEM_CLK / 1000000);

// System Clk Counter
reg [30:0] tmp_count;

// 指定周波数でenable信号生成
assign enable     = (tmp_count[30:0] == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;
assign oEnable1us = (tmp_count[6:0]  == (ENABLE_1US - 1)) ? 1'b1 : 1'b0;

//System CLKの周期でカウント
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmp_count <= 0;
    end else if (enable == 1'b1) begin
        tmp_count <= 0;
    end else begin
        tmp_count <= tmp_count + 1'b1;
    end
end


endmodule