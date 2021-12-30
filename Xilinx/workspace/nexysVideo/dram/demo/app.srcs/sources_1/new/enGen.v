/*
 * Create 2021/12/29
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * システム動作のenable信号モジュール
 */
module enGen #(
    parameter SYSTEM_CLK = 1000000000
)(
    input iCLK,
    input iRST,
    output oEnable5ms
);

// 各Enable信号
localparam TYATA_CLK  = (SYSTEM_CLK / 200);
// localparam TYATA_CLK  = 4;

reg [26:0] tmp_count;
assign ENABLE      = (tmp_count == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;		 // 1s  ENABLE
assign oEnable5ms  = (tmp_count[18:0] == (TYATA_CLK - 1)) ? 1'b1 : 1'b0; // 5ms ENABLE


//System CLKの周期でカウント
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmp_count <= 27'd0;
    end else if (ENABLE == 1'b1) begin
        tmp_count <= 27'd0;
    end else begin
        tmp_count <= tmp_count + 27'd1;
    end
end


endmodule
