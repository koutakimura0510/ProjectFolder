/*
 * Create 2021/12/17
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * 評価基板付属のOLED SSD1306動作確認プロジェクト
 *
 * 定数値は全て大文字で固定
 * input output端子は小文字・大文字を組み合わせたものを
 */
module top
#(
    parameter PDIVCLK       = 100000,
    parameter PDIVSCK       = 125,
    parameter DISPLAY_WIDTH = 128,
    parameter DISPLAY_PAGE  = 8
)(
    // system clk, rst sw
    input           iCLK,
    input           iRST,

    // system ctrl sw
    input           iBtnC,
    input           iBtnD,
    input           iBtnU,

    // system oled
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd,

    // system led
    output [7:0]    oLED
);

assign rst = ~iRST;
wire [1:0] oled_state;
reg  [7:0] led;         assign oLED = led;

always @(posedge iCLK) begin
    if (rst == 1'b1) begin
        led <= 8'hff;
    end else begin
        led <= {6'd0, oled_state};
    end
end

oledTop #(
    .PDIVCLK(PDIVCLK),
    .PDIVSCK(PDIVSCK),
    .DISPLAY_WIDTH(DISPLAY_WIDTH),
    .DISPLAY_PAGE(DISPLAY_PAGE)
) OLED_TOP (
    .iCLK(iCLK),
    .iRST(rst),
    .oOledScl(oOledScl),
    .oOledSda(oOledSda),
    .oOledDC(oOledDC),
    .oOledRes(oOledRes),
    .oOledVbat(oOledVbat),
    .oOledVdd(oOledVdd),
    .oSetEnable(oled_state)
);


endmodule
