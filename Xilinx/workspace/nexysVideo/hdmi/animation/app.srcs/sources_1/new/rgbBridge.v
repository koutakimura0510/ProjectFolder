/*
 * Create 2021/12/22
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * 複数RGB結合モジュール
 */
module rgbBridge (
    input  [31:0]   iBackARGB,      // 背景画素
    input  [31:0]   iForeARGB,      // 前景画素
    input  [31:0]   iUserARGB,      // キャラクター画素
    output [ 7:0]   oVR,            // video red
    output [ 7:0]   oVG,            // video green
    output [ 7:0]   oVB             // video blue
);

assign oVR = (iUserARGB[23:16] == 0) ? (iForeARGB[23:16] == 0) ? iBackARGB[23:16] : iForeARGB[23:16] : iUserARGB[23:16];
assign oVG = (iUserARGB[15: 8] == 0) ? (iForeARGB[15: 8] == 0) ? iBackARGB[15: 8] : iForeARGB[15: 8] : iUserARGB[15: 8];
assign oVB = (iUserARGB[ 7: 0] == 0) ? (iForeARGB[ 7: 0] == 0) ? iBackARGB[ 7: 0] : iForeARGB[ 7: 0] : iUserARGB[ 7: 0];

endmodule