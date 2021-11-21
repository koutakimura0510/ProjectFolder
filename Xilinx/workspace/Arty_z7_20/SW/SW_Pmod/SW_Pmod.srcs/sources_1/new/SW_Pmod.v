`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2021/05/29 13:42:18
// Design Name: 
// Module Name: SW_Pmod
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SW_Pmod(
    input CLK, RESET,
    input [5:0] BTN,
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
parameter SYSTEM_CLK = 125000000;
parameter TYATA_CLK  = 625000;

reg [26:0] tmp_count;
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
assign ENABLE_khz  = (tmp_count[19:0] == (TYATA_CLK - 1)) ? 1'b1 : 1'b0;

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
