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
(
    parameter pCLK = 100000000
)(
input 			iRST,		// System Reset
input 			iCLK,		// System Clock
output          enKhz
);

parameter SEG_CNT = (500000 - 1);       // ダイナミック点灯5ms Enable信号生成

// enable信号の生成
reg [26:0] tmp_count;

assign enable = (tmp_count[26:0] == (pCLK - 1)) ? 1'b1 : 1'b0;
assign enKhz  = (tmp_count[18:0] == SEG_CNT) ? 1'b1 : 1'b0;

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