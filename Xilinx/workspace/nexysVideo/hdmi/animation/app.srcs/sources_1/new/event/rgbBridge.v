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
    output [23:0]   oVRGB           // video rgb
);

wire [7:0] oVR = (iUserARGB[31:24] == 0 && iUserARGB[23:16] == 0) ? (iForeARGB[23:16] == 0) ? iBackARGB[23:16] : iForeARGB[23:16] : iUserARGB[23:16];
wire [7:0] oVG = (iUserARGB[31:24] == 0 && iUserARGB[15: 8] == 0) ? (iForeARGB[15: 8] == 0) ? iBackARGB[15: 8] : iForeARGB[15: 8] : iUserARGB[15: 8];
wire [7:0] oVB = (iUserARGB[31:24] == 0 && iUserARGB[ 7: 0] == 0) ? (iForeARGB[ 7: 0] == 0) ? iBackARGB[ 7: 0] : iForeARGB[ 7: 0] : iUserARGB[ 7: 0];

//----------------------------------------------------------
// 色データ出力
// 描画すると何故か色が反転してしまうためNOT端子で辻褄が合うようにしている
//----------------------------------------------------------
assign oVRGB = ~{oVR, oVG, oVB};

endmodule