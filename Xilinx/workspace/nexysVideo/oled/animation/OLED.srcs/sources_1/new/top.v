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
(
    // system clk, rst sw
    input           iCLK,
    input           iRST,

    // system ctrl sw
    input           iBtnC,
    input           iBtnD,
    input           iBtnU,

    // system led
    output [7:0]    oLED,

    // system oled
    output          oOledDC,
    output          oOledRes,
    output          oOledScl,
    output          oOledSda,
    output          oOledVbat,
    output          oOledVdd
);

assign oLED = 8'haa;

endmodule
