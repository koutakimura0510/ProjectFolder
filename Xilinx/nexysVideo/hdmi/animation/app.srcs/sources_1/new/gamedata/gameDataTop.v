//----------------------------------------------------------
// Create 2021/2/5
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// ゲームプレイ用のデータ生成トップモジュール
// 
// RGBデータと、あとで拡張予定のsoundデータの生成を行う
// 基本的な処理の流れとしては、フレームバッファはトリプルとして
// 1.順次HVSyncのタイミングに応じて、指定フレームバッファ内のpixelデータを出力
// 2.出力中に空いているフレームバッファに、次回の1フレームデータを保存
// 3.1フレームの描画が終了したら、次に出力するフレームバッファのチャンネルを切り替える
// 4.1~3を繰り返す。
//----------------------------------------------------------
module gameDataTop # (
    parameter pHDisplay      = 640,
    parameter pVDisplay      = 480,
    parameter pDramAddrWidth = 29,
    parameter pDramDataWidth = 128,
    parameter pDramMaskWidth = 16,
    parameter pBuffDepth     = 16,          // bram length
    parameter pBitWidth      = 32,          // data bit
    parameter pDramDebug     = "off",
    parameter pPixelDebug    = "off"
)(
    input           iDispCLK,   // ディスプレイ描画clk vgaの場合25MHz
    input           iRST,       // system rst
    input  [ 5:0]   iBtn,
    input  [ 7:0]   iSW,
    input           iVDE,       // video enable High->Lowの変化を確認しフレームバッファのchを切り替える
    input           iFVDE,      // fast video enable, 通常のvdeよりも1クロック早くHigh
    input           iFE,        // frame end
    output [23:0]   oVRGB,      // video rgb
    // output [31:0] oVSound,    // video sound data
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

    // デバッグ用OLED信号
    // output          oOledScl,
    // output          oOledSda,
    // output          oOledDC,
    // output          oOledRes,
    // output          oOledVbat,
    // output          oOledVdd,
    output [7:0]    oLED
);

////////////////////////////////////////////////////////////
`include "../include/commonAddr.vh"
// localparam lpHDisplay = 5;
// localparam lpVDisplay = 4;
localparam lpHDisplay = pHDisplay;
localparam lpVDisplay = pVDisplay;


//----------------------------------------------------------
// アプリケーション回路のCLK生成
//----------------------------------------------------------
wire wUiCLK, wUiRST;
wire wAppCLK = wUiCLK;
wire wAppRST = wUiRST;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// フレームバッファの書き込みと読み込みエリアの切り替え制御モジュール
//----------------------------------------------------------
// state side
wire [1:0] wRS, wWS;
wire wFbufReadStart;

// read fbuf side
wire wRFE;  // read frae enable
wire wWFE;  // write frae enable

frameStateRW #(
    .pBitLengthState    (2)
) FRAME_STATE_RW (
    .iCLK   (wAppCLK),          .iRST   (wAppRST),
    .iRE    (wRFE),             .iWE    (wWFE),     // fbuf change enable
    .oRS    (wRS),              .oWS    (wWS),      // state machine
    .oRE    (wFbufReadStart)
);

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 読み込みフレームバッファのアドレス生成
//----------------------------------------------------------
// ddr side
wire [pBitWidth-1:0] wDdrRA;
wire wDdrRready;
reg  qDdrRvalid;

frameBufferRead #(
    .pHDisplay          (lpHDisplay),
    .pVDisplay          (lpVDisplay),
    .pAddrWidth         (pBitWidth),
    .pBitLengthState    (2)
) FRAME_BUFFER_READ (
    .iCLK       (wAppCLK),      .iRST       (wAppRST),
    .iDdrRaE    (qDdrRvalid),   .iRS        (wRS),
    .oAddr      (wDdrRA),       .oRE        (wRFE)
);

always @*
begin
    qDdrRvalid <= wDdrRready & wFbufReadStart;
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// ピクセルデータ生成
// TODO 書き込むエリアのデータを読みこんでおき、アルファ値を結合する
// TODO 1フレーム領域書き込んだらenabe信号を出す
//----------------------------------------------------------
wire wWready;
wire [pBitWidth-1:0] wPixelWD; // pixel data
wire [pBitWidth-1:0] wPixelWA; // write addr
reg  qPixelValid, qDdrWrEn;    // write enable

pixelTop #(
    .pHDisplay              (lpHDisplay),
    .pVDisplay              (lpVDisplay),
    .pAddrWidth             (pBitWidth),
    .pBitWidth              (pBitWidth),
    .pBitLengthState        (2),
    .pDramDebug             (pPixelDebug)
) PIXEL_TOP (
    .iSW    (iSW),
    .iCLK   (wAppCLK),      .iRST   (wAppRST),
    .iWS    (wWS),          .iDdrWE (qPixelValid),
    .oPixel (wPixelWD),     .oAddr  (wPixelWA),
    .oWE    (wWFE)
);

always @*
begin
    qDdrWrEn    <= wWS != IDOL;
    qPixelValid <= qDdrWrEn & wWready;
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 非同期FIFO
// ディスプレイクロック(dclk)とアプリケーション側のクロック(aclk)で動作する
// FPSの向上の為、dclkの周期で必ず画素データがFIFOに存在していなければならない
// 画素データ出力とタイミングを合わせるため、iFVDEを使用し、iVDEがONになるより早くデータを出力する
//----------------------------------------------------------
wire [pBitWidth-1:0] wVRGB;            assign oVRGB = wVRGB[23:0];     // alpha値は必要でないので送信しない
wire [pDramDataWidth-1:0] wAppRD;
wire wAppRVD, wAppFull;
reg  rFS, qFS, qAppFull;

always @(posedge wAppCLK)
begin
    if (wAppRST)            rFS <= 0;
    else if (iFE)           rFS <= 1'b1;
    else                    rFS <= rFS;
end

bitConverter # (
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (pBitWidth),
    .pInDataWidth   (pDramDataWidth)
) BIT_CONVERTER (
    // write side               read side
    .iCLKA  (wAppCLK),          .iCLKB  (iDispCLK),
    .iRST   (wAppRST),
    .iWD    (wAppRD),           .oRD    (wVRGB),
    .iWE    (wAppRVD),          .iRE    (qFS),
    .oFLL   (wAppFull)
);

always @*
begin
    qAppFull <= (~wAppFull) & wFbufReadStart;
    qFS      <= rFS & iFVDE;
end

//----------------------------------------------------------
// DDRメモリ操作
//----------------------------------------------------------
ddr3Bridge #(
    // ddr parameter                    Bram fifo parameter
    .pDramAddrWidth (pDramAddrWidth),   .pBuffDepth     (pBuffDepth),
    .pDramDataWidth (pDramDataWidth),   .pBitWidth      (pBitWidth),
    .pDramMaskWidth (pDramMaskWidth),   .pDramDebug     (pDramDebug)
) DDR3_BRIDGE (
    // DDR port                             
    .ioDDR3_DQ          (ioDDR3_DQ),    .ioDDR3_DQS_N       (ioDDR3_DQS_N),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P), .oDDR3_ADDR         (oDDR3_ADDR),
    .oDDR3_BA           (oDDR3_BA),     .oDDR3_RAS          (oDDR3_RAS),
    .oDDR3_CAS          (oDDR3_CAS),    .oDDR3_WE           (oDDR3_WE),
    .oDDR3_RESET        (oDDR3_RESET),  .oDDR3_CLK_P        (oDDR3_CLK_P),
    .oDDR3_CLK_N        (oDDR3_CLK_N),  .oDDR3_CKE          (oDDR3_CKE),
    .oDDR3_DM           (oDDR3_DM),     .oDDR3_ODT          (oDDR3_ODT),

    // App Write Data Addr com
    .iWD                (wPixelWD),     .iWA                (wPixelWA),
    .iMask              (16'd0),        .iWvalid            (qDdrWrEn),  
    .oWready            (wWready),      

    // App Read Addr com
    .iRA                (wDdrRA),       .iRvalid            (qDdrRvalid),
    .oRready            (wDdrRready),

    // app output data com
    .oAppRD             (wAppRD),       .oAppRVD            (wAppRVD),
    .iAppFull           (qAppFull),

    // user interface clk rst
    .iCLK               (iDispCLK),     .iRST               (iRST),
    .oUiCLK             (wUiCLK),       .oUiRST             (wUiRST)
);


//----------------------------------------------------------
// データのモニタリング用にOLEDを使用
// 
//----------------------------------------------------------
// reg [31:0] rPixelSh [0:1];

// always @(posedge wAppCLK)
// begin
//     if (wAppRST) {rPixelSh[1], rPixelSh[0]} <= 64'd0;
//     else         {rPixelSh[1], rPixelSh[0]} <= {rPixelSh[0], wVRGB};
// end

// oledTop #(
//     .PDIVCLK        (100000),
//     .PDIVSCK        (128),
//     .DISPLAY_WIDTH  (128),
//     .DISPLAY_HEIGHT (4),
//     .BIT_LENGTH     (64)
// ) OLED_TOP (
//     .iCLK           (wAppCLK),
//     .iRST           (wAppRST),
//     .oOledScl       (oOledScl),
//     .oOledSda       (oOledSda),
//     .oOledDC        (oOledDC),
//     .oOledRes       (oOledRes),
//     .oOledVbat      (oOledVbat),
//     .oOledVdd       (oOledVdd),
//     .iDispLine1     (rPixelSh[1]),
//     .iDispLine2     ({2'd0, wRS, 2'd0, wWS}),
//     .iDispLine3     (wPixelWA),
//     .iDispLine4     (wDdrRA)
//     // 95
//     // .iDispLine1     ({"XPOS =  ", 4'd0, 2'd0, oUXS, oFXS}),
//     // .iDispLine2     ({"YPOS =  ", 4'd0, 2'd0, oUYS, oFYS}),
//     // .iDispLine3     ({"        ", 3'd0, oMapDirect[3], 3'd0, oMapDirect[2], 3'd0, oMapDirect[1], 3'd0, oMapDirect[0]}),
//     // .iDispLine4     ({"        ", 0})
// );

assign oLED = {7'd0, ~wUiRST};

endmodule