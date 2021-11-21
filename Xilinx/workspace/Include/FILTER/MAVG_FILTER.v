/*
 * 移動平均フィルタの実装
 * y[n] = (x[n] + x[n-1] + x[n-2] + ... x[n-[N-1]]) / N
 * ----------------------------------------------------
 * ENABLE : フィルタの動作タイミングを決めるパルス信号
 * IDATA  : 32bitオーディオデータを指定
 * ODATA  : フィルタをかけたオーディオデータを出力
 */
module MAVG_FILTER (
    input CLK, RESET, ENABLE,
    input [31:0] IDATA,
    output reg [31:0] ODATA
);

reg [33:0] data[0:3];

always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        data[0] <= 0;
        data[1] <= 0;
        data[2] <= 0;
        data[3] <= 0;
    end else if (ENABLE == 1'b1) begin
        data[0] <= {{2{IDATA[31]}}, IDATA};
        data[1] <= data[0];
        data[2] <= data[1];
        data[3] <= data[2];
        ODATA <= (data[0] + data[1] + data[2] + data[3]) >> 2;
        // ODATA <= IDATA; // そのまま通過、テスト
    end
end

endmodule