/*
 * Create 2022/3/26
 * Author koutakimura
 * -
 * ユーザーの描画座標データ生成
 */

module upbWrapper
(
    input           iSCLK,      // Sys clk
    input           iRST,       // Active High
    input  [ 5:0]   iBtn,
    input  [ 9:0]   iStartX,    // 描画開始開始x座標
    input  [ 9:0]   iStartY,    // 描画開始開始y座標
    output [ 9:0]   oUXS,       // ユーザーの左上端のx座標
    output [ 9:0]   oUYS,       // ユーザーの左上端のy座標
    output [ 9:0]   oUXE,       // ユーザーの右上端のx座標
    output [ 9:0]   oUYE,       // ユーザーの右下端のy座標
    output [15:0]   oFXS,       // field user xpos
    output [15:0]   oFYS,       // field user ypos
    output [ 1:0]   oDirX,      // 現在のキャラクターの横方向の向き
    output [ 1:0]   oDirY,      // 現在のキャラクターの縦方向の向き
    input  [15:0]   iMapWidth,
    input  [ 3:0]   iMapDirect  // bit列 上[3] 下[2] 左[1] 右[0]
);

userPos USER_POS (
    .iCLK       (iSCLK),      .iRST         (iRST),
    .iBtn       (iBtn),
    .iStartX    (0),          .iStartY      (416),
    .oUXS       (oUXS),       .oUYS         (oUYS), 
    .oUXE       (oUXE),       .oUYE         (oUYE),
    .oFXS       (oFXS),       .oFYS         (oFYS),
    .oDirX      (oDirX),      .oDirY        (oDirY),
    .iMapWidth  (oMapWidth),  .iMapDirect   (oMapDirect)
);

endmodule