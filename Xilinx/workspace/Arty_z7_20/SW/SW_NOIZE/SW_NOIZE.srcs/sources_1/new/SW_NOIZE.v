/*
 * SWのチャタリング除去回路
 *
 * Vivado 20.2
 * Ubuntu LTS 20.04
 */
module SW_NOIZE(
    input CLK, RESET,
    input [3:0] BTN,
    output reg [3:0] LED,
    output [3:0] GP_SW
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
reg [3:0] key_up;
wire [3:0] KEY;


/*
 * ENABLE信号の生成
 */
always @ (posedge CLK, negedge RESET) begin
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
always @ (posedge CLK, negedge RESET) begin
  if (RESET == 1'b0) begin
    key_up <= 0;
  end else if (KEY != 0) begin
    key_up <= BTN;
  end else if (key_up != 0) begin
    key_up <= key_up & BTN;
  end
end

assign ENABLE      = (tmp_count == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;
assign ENABLE_khz  = (tmp_count[18:0] == (TYATA_CLK - 1)) ? 1'b1 : 1'b0;
assign GP_SW       = key_up;

SW_GEN KEY3(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[3]), .EDGE(KEY[3]));
SW_GEN KEY2(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[2]), .EDGE(KEY[2]));
SW_GEN KEY1(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[1]), .EDGE(KEY[1]));
SW_GEN KEY0(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(BTN[0]), .EDGE(KEY[0]));


/*
 * デモ用にLED点灯
 */
always @(key_up) begin
    case (key_up)
        4'b0001: LED <= 4'b0001;
        4'b0010: LED <= 4'b0010;
        4'b0100: LED <= 4'b0100;
        4'b1000: LED <= 4'b1000;
        default: LED <= 4'b0000;
    endcase
end

endmodule
