/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの制御用待機時間生成モジュール
 */
module oledTime
#(
    parameter PDIVCLK = 100000      // 分周回路の値 通常1ms
)(
    input 			iCLK,		    // System Clock
    input 			iRST,		    // System Reset
    output          oEnable         // 指定時間enable
);


//----------------------------------------------------------
// 分周回路パラメータ 最大1Secまで分周可能
//----------------------------------------------------------
localparam COUNT_ORDER = (PDIVCLK - 1);

reg [26:0] tmp_count;       assign oEnable = (tmp_count == COUNT_ORDER) ? 1'b1 : 1'b0;

// 分周回路
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        tmp_count <= 27'd0;
    end else if (oEnable == 1'b1) begin
        tmp_count <= 27'd0;
    end else begin
        tmp_count <= tmp_count + 27'd1;
    end
end

endmodule