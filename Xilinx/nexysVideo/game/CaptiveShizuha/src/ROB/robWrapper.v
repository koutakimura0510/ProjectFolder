/*
 * Create 2022/3/26
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * RGB Operation Block 
 * RGB色データ生成モジュール
 */
module rgbGen(
    input           iBCLK,          // Base clk
    input           iRST,           // system rst
    input  [ 9:0]   iHPOS,          // 描画座標horizon
    input  [ 9:0]   iVPOS,          // 描画座標vertical
    input  [ 9:0]   iXS,            // 描画開始x_start座標
    input  [ 9:0]   iXE,            // 描画開始x_end座標
    input  [ 9:0]   iYS,            // 描画開始y_start座標
    input  [ 9:0]   iYE,            // 描画開始y_end座標
    input  [31:0]   iARGB,          // 入力画素
    output [31:0]   oARGB           // 出力画素
);

rgbGen BACK_GROUND(.iBCLK(iBCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(32'hffffffff), .oARGB(oBackARGB));
rgbGen FORE_GROUND(.iBCLK(iBCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(oFieldDot),  .oARGB(oForeARGB));
rgbGen USER_GROUND(.iBCLK(iBCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(oUXS), .iXE(oUXE), .iYS(oUYS), .iYE(oUYE), .iARGB(oPlayerDot), .oARGB(oUserARGB));

rgbBridge RGB_BRIDGE (
    .iBackARGB(oBackARGB), .iForeARGB(oForeARGB), .iUserARGB(oUserARGB), .oVRGB(oVRGB)
);

endmodule