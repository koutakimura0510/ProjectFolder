//----------------------------------------------------------
// Create 2021/1/6
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// RGB生成Topモジュール
// 
// RGBデータと、あとで拡張予定のsoundデータの生成を行う
// 基本的な処理の流れとしては、フレームバッファはトリプルとして
// 1.順次HVSyncのタイミングに応じて、指定フレームバッファ内のpixelデータを出力
// 2.出力中に空いているフレームバッファに、次回の1フレームデータを保存
// 3.1フレームの描画が終了したら、次に出力するフレームバッファのチャンネルを切り替える
// 4.1~3を繰り返す。
//----------------------------------------------------------
module rgbTop #(
    parameter ADDR_WIDTH = 29,
    parameter DATA_WIDTH = 128,
    parameter MASK_WIDTH = 16
)(
    input           iCLK,   // ディスプレイ描画clk
    input           iRST,   // system rst
    input  [ 5:0]   iBtn,
    input  [ 9:0]   iHPOS,
    input  [ 9:0]   iVPOS,
    input           iVDE,   // video enable
    output [23:0]   oVRGB,
    inout  [15:0]   ioDDR3_DQ,
    inout  [ 1:0]   ioDDR3_DQS_N,
    inout  [ 1:0]   ioDDR3_DQS_P,
    output [14:0]   oDDR3_ADDR,
    output [ 2:0]   oDDR3_BA,
    output          oDDR3_RAS,
    output          oDDR3_CAS,
    output          oDDR3_WE,
    output          oDDR3_RESET,
    output          oDDR3_CLK_P,
    output          oDDR3_CLK_N,
    output          oDDR3_CKE,
    output [ 1:0]   oDDR3_DM,
    output          oDDR3_ODT,
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);

// 1ms enable
wire oEn1ms;

// ユーザー座標データ
wire [ 9:0] oUXS, oUXE;
wire [ 9:0] oUYS, oUYE;
wire [15:0] oFXS, oFYS;

// 色データ
wire [31:0] oBackARGB;      // BackGround ARGB 背景
wire [31:0] oForeARGB;      // ForeGround ARGB 前景
wire [31:0] oUserARGB;      // UserGround ARGB ユーザー
wire [31:0] oPlayerDot;
wire [31:0] oFieldDot;

// mapchip ID
wire [15:0] oMapWidth;
wire [ 3:0] oMapDirect;

// キャラクターの向き
wire [ 1:0] oDirX, oDirY;

//----------------------------------------------------------
// enable信号生成
//----------------------------------------------------------
enGen #(
    .SYS_CLK(25000)
) RGB_1MS_GEN (
    .iCLK(iCLK), .iRST(iRST), .oEnable(oEn1ms)
);

//----------------------------------------------------------
// フィールドのドットデータ生成
//----------------------------------------------------------
dotFieldTop DOT_FIELD_TOP (
    .iCLK(iCLK),   .iRST(iRST),
    .iVDE(iVDE),   .iUXS(oUXS), .iUYS(oUYS), .iFXS(oFXS), .iFYS(oFYS),
    .iHPOS(iHPOS), .iVPOS(iVPOS),
    .oFieldDot(oFieldDot), .oMapWidth(oMapWidth), .oMapDirect(oMapDirect)
);

//----------------------------------------------------------
// ユーザー座標データ生成
//----------------------------------------------------------
userPos USER_POS (
    .iCLK(iCLK), .iRST(iRST),
    .iBtn(iBtn), .iEn1Ms(oEn1ms),
    .iStartX(0), .iStartY(416),
    .oUXS(oUXS), .oUYS(oUYS), .oUXE(oUXE), .oUYE(oUYE), .oFXS(oFXS), .oFYS(oFYS),
    .oDirX(oDirX), .oDirY(oDirY),
    .iMapWidth(oMapWidth), .iMapDirect(oMapDirect)
);

//----------------------------------------------------------
// プレイヤーのドットデータ生成
//----------------------------------------------------------
dotPlayerTop #(
    .VMAX(480),
    .CHIP_WIDTH(32)
) DOT_PLAYER_TOP (
    .iCLK(iCLK), .iRST(iRST),
    .iUXS(oUXS), .iUXE(oUXE), .iUYS(oUYS), .iUYE(oUYE),
    .iHPOS(iHPOS), .iVPOS(iVPOS),
    .iDirX(oDirX), .iDirY(oDirY),
    .oPlayerDot(oPlayerDot)
);


//----------------------------------------------------------
// 描画データ生成
//----------------------------------------------------------
rgbGen BACK_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(32'hffffffff), .oARGB(oBackARGB));
rgbGen FORE_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(oFieldDot),  .oARGB(oForeARGB));
rgbGen USER_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(oUXS), .iXE(oUXE), .iYS(oUYS), .iYE(oUYE), .iARGB(oPlayerDot), .oARGB(oUserARGB));

rgbBridge RGB_BRIDGE (
    .iBackARGB(oBackARGB), .iForeARGB(oForeARGB), .iUserARGB(oUserARGB), .oVRGB(oVRGB)
);

//----------------------------------------------------------
// デバッグ用に値表示
//----------------------------------------------------------
oledTop #(
    .PDIVCLK        (25000),
    .PDIVSCK        (32),
    .DISPLAY_WIDTH  (128),
    .DISPLAY_HEIGHT (4),
    .BIT_LENGTH     (95)
) OLED_TOP (
    .iCLK           (iCLK),
    .iRST           (iRST),
    .oOledScl       (oOledScl),
    .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),
    .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),
    .oOledVdd       (oOledVdd),
    .iDispLine1     ({"XPOS =  ", 4'd0, 2'd0, oUXS, oFXS}),
    .iDispLine2     ({"YPOS =  ", 4'd0, 2'd0, oUYS, oFYS}),
    .iDispLine3     ({"        ", 3'd0, oMapDirect[3], 3'd0, oMapDirect[2], 3'd0, oMapDirect[1], 3'd0, oMapDirect[0]}),
    .iDispLine4     ({"        ", 0})
);

endmodule