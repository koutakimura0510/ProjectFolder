//----------------------------------------------------------
// Create 2022/3/27
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// Base module
// ゲーム進行のモジュールを管理するブロック
//----------------------------------------------------------
module CaptiveShizuhaBase #(
    parameter       pHdisplay     = 640,
    parameter       pVdisplay     = 480,
    parameter       pPixelDebug   = "yes"
)(
    input           iSCLK,      // Sync CLK
    input           iRST,       // system rst
    input [5:0]     iBtn,
    input           iVde,       // video enable
    input           iFvde,      // fast video enable
    input           iFe,        // frame end
    output [23:0]   oVRGB,
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);


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
// Base内動作クロックの生成
// ディスプレイ制御のSync Clkよりも高速なCLKを生成し、描画用データの生成を行う
//----------------------------------------------------------
wire wBCLK;
wire wLock;
wire wRST = (~wLock);

baseClkGen BASE_CLK_GEN (
    .clk_out1   (wBCLK),    .reset      (iRST),
    .locked     (wLock),    .clk_in1    (iSCLK)
);


//----------------------------------------------------------
// Switch Serialize Block
//----------------------------------------------------------
wire [ 5:0] wBtn;

ssbWrapper #(
    .pMonitorTiming (500000)
) SSB (
    .iCLK       (wBCLK),    .iRST       (wRST),
    .iBtn       (~iBtn),    .oBtn       (wBtn)
);

//----------------------------------------------------------
// Position Generate Block
//----------------------------------------------------------
pgbWrapper #(

) PGB (

);


//----------------------------------------------------------
// Dot Generate Block
//----------------------------------------------------------
dgbWrapper #(
    .pHdisplay  (pHdisplay),
    .pVdisplay  (pVdisplay)
) DGB (

);

//----------------------------------------------------------
// RGB Operation Block 
//----------------------------------------------------------
robWrapper #(

) ROB (

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
    .iCLK           (iSCLK),
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