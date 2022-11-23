/*
 * 移動平均フィルタの実装
 * y[n] = a * y[i-1] + (1-a) * x[i]
 * ----------------------------------------------------
 * ENABLE : フィルタの動作タイミングを決めるパルス信号
 * IDATA  : 32bitオーディオデータを指定
 * ODATA  : フィルタをかけたオーディオデータを出力
 */
module RC_FILTER (
    input CLK, RESET, ENABLE,
    input [31:0] IDATA,
    output reg [31:0] ODATA
);

reg [31:0] old;

always @(posedge CLK) begin
    if (RESET == 1'b1) begin
        old <= 0;
		  ODATA <= 0;
    end else if (ENABLE == 1'b1) begin
		  //old <= (old >> 1) + (old >> 2) + (old >> 5) + (old >> 6) + (IDATA >> 3) + (IDATA >> 4) + (IDATA >> 7);
        //ODATA <= old;
         ODATA <= IDATA; // そのまま通過、テスト
    end
end
     
 endmodule