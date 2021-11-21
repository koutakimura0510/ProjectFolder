/**---------------------------------------------------
 * Serial to Parallel
 * LRCLK　LがLow RがHigh
 * LがLowの場合、DataWordは1bit位相をずらして出力しなければならないので
 * 65bit分のシフトレジスタにデータを保存する
 *----------------------------------------------------*/
module I2S_SCP (
    BCLK, LRCLK, DIN, LATCH, DATA_32
);

inout BCLK, LRCLK, DIN;
output reg LATCH;
output reg [63:0] DATA_32;

reg previous_clk_lr;
reg [8:0] cnt;
reg [64:0] tmp_data64;

always @(posedge BCLK) begin
    tmp_data64 <= tmp_data64 << 1;
    tmp_data64[0] <= DIN;
    if (previous_clk_lr == 1 && LRCLK == 0) begin
        DATA_32[63:32] <= tmp_data64[63:32];
        DATA_32[31:0]  <= tmp_data64[31:0];
        LATCH <= 1'b1;
        cnt <= 9'b0;
    end

    if (cnt == 9'b1) begin
        LATCH <= 1'b0;
    end

    cnt <= cnt + 9'b1;
    previous_clk_lr <= LRCLK;
end

endmodule