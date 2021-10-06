/*
 * SWのビット値取得
 *
 * Vivado 20.2
 * Ubuntu LTS 20.04
 *
 * SW_LEFT  0x20
 * SW_RIGHT 0x10
 * SW_UP    0x01
 * SW_DOWN  0x02
 * SW_A     0x08
 * SW_B     0x04
 */
module GET_SW(
    input CLK, RESET,
    input [5:0] BTN,
    output [5:0] GP_SW,
    output reg [2:0] LED1,
    output reg [2:0] LED2
);


/*
 * FPGAの入力CLK使用時
 * 125MHz
 *
 * Zynqの入力CLK使用時
 * 100MHz
 */
parameter SYSTEM_CLK = 100000000;
parameter TYATA_CLK  = 500000;


/*
 * tmp_countは100 ~ 125MHz使用時は27bit固定
 */
reg [26:0] tmp_count;


/*
 * 使用するスイッチは4つ
 */
reg [5:0] key_up;
wire [5:0] KEY;


/*
 * ENABLE信号の生成
 */
always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'b0) begin
        tmp_count <= 0;
    end else if (ENABLE == 1'b1) begin
        tmp_count <= 0;
    end else begin
        tmp_count <= tmp_count + 27'b1;
    end
end


/*
 * チャタリング除去済みのスイッチの入力値の取得
 */
always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'b0) begin
        key_up <= 0;
    end else if (KEY != 0) begin
        key_up <= ~BTN;
    end else if (key_up != 0) begin
        key_up <= key_up & ~BTN;
    end
end

assign ENABLE      = (tmp_count == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;
assign ENABLE_khz  = (tmp_count[18:0] == (TYATA_CLK - 1)) ? 1'b1 : 1'b0;
assign GP_SW       = key_up;

SW_GEN KEY5(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[5]), .EDGE(KEY[5]));
SW_GEN KEY4(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[4]), .EDGE(KEY[4]));
SW_GEN KEY3(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[3]), .EDGE(KEY[3]));
SW_GEN KEY2(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[2]), .EDGE(KEY[2]));
SW_GEN KEY1(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[1]), .EDGE(KEY[1]));
SW_GEN KEY0(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[0]), .EDGE(KEY[0]));


/*
 * デモ用にLED点灯
 */
always @(posedge CLK, negedge RESET) begin
    if (RESET == 1'b0) begin
        LED1 <= 3'b111;
        LED2 <= 3'b111;
    end else begin
        LED1 <= key_up[2:0];
        LED2 <= key_up[5:3];
    end
end

endmodule
