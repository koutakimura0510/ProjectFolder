/*
 * Create 2021/1/6
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * 
 * RGB生成Topモジュール
 */
module rgbTop (
    input           iCLK,   // ディスプレイ描画clk
    input           iRST,   // system rst
    input  [ 5:0]   iBtn,
    input           iEn1Ms,
    input  [ 9:0]   iHPOS,
    input  [ 9:0]   iVPOS,
    input           iVDE,   // video enable
    output [23:0]   oVRGB,
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);


// ユーザー座標データ
wire [ 9:0] oUXS;
wire [ 9:0] oUYS;
wire [ 9:0] oUXE;
wire [ 9:0] oUYE;
wire [15:0] oFXS;
wire [15:0] oFYS;

// 色データ
wire [31:0] oBackARGB;      // BackGround ARGB 背景
wire [31:0] oForeARGB;      // ForeGround ARGB 前景
wire [31:0] oUserARGB;      // UserGround ARGB ユーザー
wire [31:0] oPlayerDot;
wire [31:0] oFieldDot;

// mapchip ID
wire [15:0] oMapWidth;
wire [ 3:0] oMapDirect;


//----------------------------------------------------------
// フィールドのドットデータ生成
//----------------------------------------------------------
dotFieldTop DOT_FIELD_TOP (
    .iCLK           (iCLK),
    .iRST           (iRST),
    .iVDE           (iVDE),
    .iUXS           (oUXS),
    .iUYS           (oUYS),
    .iFXS           (oFXS),
    .iFYS           (oFYS),
    .iHPOS          (iHPOS),
    .iVPOS          (iVPOS),
    .oFieldDot      (oFieldDot),
    .oMapWidth      (oMapWidth),
    .oMapDirect     (oMapDirect)
);

//----------------------------------------------------------
// ユーザー座標データ生成
//----------------------------------------------------------
userPos USER_POS (
    .iCLK           (iCLK),
    .iRST           (iRST),
    .iBtn           (iBtn),
    .iEn1Ms         (iEn1Ms),
    .iStartX        (0),
    .iStartY        (416),
    .oUXS           (oUXS),
    .oUYS           (oUYS),
    .oUXE           (oUXE),
    .oUYE           (oUYE),
    .oFXS           (oFXS),
    .oFYS           (oFYS),
    .iMapWidth      (oMapWidth),
    .iMapDirect     (oMapDirect)
);

//----------------------------------------------------------
// プレイヤーのドットデータ生成
//----------------------------------------------------------
dotPlayerTop DOT_PLAYER_TOP (
    .iCLK       (iCLK),
    .iRST       (iRST),
    .iUXS       (oUXS),
    .iUXE       (oUXE),
    .iUYS       (oUYS),
    .iUYE       (oUYE),
    .iHPOS      (iHPOS),
    .iVPOS      (iVPOS),
    .oPlayerDot (oPlayerDot)
);


//----------------------------------------------------------
// 描画データ生成
//----------------------------------------------------------
rgbGen BACK_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(32'hffffffff), .oARGB(oBackARGB));
rgbGen FORE_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(oFieldDot),  .oARGB(oForeARGB));
rgbGen USER_GROUND(.iCLK(iCLK), .iRST(iRST), .iHPOS(iHPOS), .iVPOS(iVPOS), .iXS(oUXS), .iXE(oUXE), .iYS(oUYS), .iYE(oUYE), .iARGB(oPlayerDot), .oARGB(oUserARGB));

rgbBridge RGB_BRIDGE (
    .iBackARGB      (oBackARGB),
    .iForeARGB      (oForeARGB),
    .iUserARGB      (oUserARGB),
    .oVRGB          (oVRGB)
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
    .iDispLine1     ({"XPOS =  ", 8'd0, 2'd0, oUXS, 2'd0, oFXS}),
    .iDispLine2     ({"YPOS =  ", 8'd0, 2'd0, oUYS, 2'd0, oFYS}),
    .iDispLine3     ({"        ", 3'd0, oMapDirect[3], 3'd0, oMapDirect[2], 3'd0, oMapDirect[1], 3'd0, oMapDirect[0]}),
    .iDispLine4     ({"        ", 0})
);

endmodule