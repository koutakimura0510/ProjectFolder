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
    parameter pDramAddrWidth = 29,
    parameter pDramDataWidth = 128,
    parameter pDramMaskWidth = 16,
    parameter pBuffDepth     = 16,          // bram length
    parameter pBitDepth      = 32           // data bit
)(
    input           iDispCLK,   // ディスプレイ描画clk vgaの場合25MHz
    input           iCLK,       // system clk
    input           iRST,       // system rst
    input  [ 5:0]   iBtn,
    input           iVDE,       // video enable High->Lowの変化を確認しフレームバッファのchを切り替える
    input           iFVDE,      // fast video enable, 通常のvdeよりも1クロック早くHigh
    input           iFLE,       // frame end enable
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
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd,
    output [7:0]    oLED
);


////////////////////////////////////////////////////////////
`include "./frame/framePara.vh"


//----------------------------------------------------------
// gameDataTop内を動作させるクロック・リセット信号、初期化完了のキャリブレーション信号
//----------------------------------------------------------
wire oUiCLK, oUiRST;
wire oCal;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// フレームバッファの書き込みと読み込みエリアの切り替え制御モジュール
//----------------------------------------------------------
// state side
wire [pBitState-1:0] wRS, wWS;
wire wFbufReadStart;

// read fbuf side
wire wRFE;  // read frae enable

frameStateRW #(
    .pBitLengthState    (pBitState)
) FRAME_STATE_RW (
    .iCLK   (oUiCLK),   .iRST   (oUiRST),
    .iRE    (wRFE),     .iWE    (),         // fbuf change enable
    .oRS    (wRS),      .oWS    (wWS),      // state machine
    .oRE    (wFbufReadStart)
);

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 読み込みフレームバッファのアドレス生成
//----------------------------------------------------------
// ddr side
wire [pBitDepth-1:0] wDdrRA;
wire qDdrRaE;
wire wDdrRaFLL;

frameBufferRead #(
    .pAddrWidth         (pBitDepth),
    .pBitLengthState    (pBitState)
) FRAME_BUFFER_READ (
    .iCLK       (oUiCLK),   .iRST       (oUiRST),
    .iDdrRaE    (qDdrRaE),  .iRS        (wWS),
    .oAddr      (wDdrRA),   .oRE        (wRFE)
);

always @*
begin
    qDdrRaE <= (~oRAFLL) & oCal & wFbufReadStart;
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// ピクセルデータ生成
// TODO 書き込むエリアのデータを読みこんでおき、アルファ値を結合する
// TODO 1フレーム領域書き込んだらenabe信号を出す
//----------------------------------------------------------
localparam pRgbWidth = 32;

wire wWFLL;
wire [pRgbWidth-1:0] wPixelWD;      // pixel data
wire [pDramAddrWidth-1:0] wPixelWA; // write addr
reg qPixelWE;                       // write enable

// rgbTop #(
//     .pDramAddrWidth (pDramAddrWidth),
//     .pRgbWidth      (pRgbWidth)
// ) RGB_TOP (

// );

always @*
begin
    qPixelWE <= (~wWFLL);
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 非同期FIFO
// ディスプレイクロック(dclk)とアプリケーション側のクロック(aclk)で動作する
// FPSの向上の為、dclkの周期で必ず画素データがFIFOに存在していなければならない
// 画素データ出力とタイミングを合わせるため、iFVDEを使用し、iVDEがONになるより1CLK早くデータを出力する
//----------------------------------------------------------
// top module side
wire [31:0] qVRGB;      assign oVRGB = qVRGB[23:0];     // alpha値は必要でないので送信しない

//ddr side
wire [pBitDepth-1:0] wDdrRD;
wire wDdrRdEMP;
wire wDdrRVD;
reg  qDdrRDE;

// fifo side
wire wDualFll;

fifoDualController #(
    .pBuffDepth (512),
    .pBitWidth  (32)
) PIXEL_FIFO_DUAL_CONTROLLER (
    // write side       read side
    .iCLKA  (oUiCLK),   .iCLKB  (iDispCLK),
    .iRST   (oUiRST),
    .iWD    (wDdrRD),   .oRD    (qVRGB),
    .iWE    (wDdrRVD),  .iRE    (iFVDE),
    .oFLL   (wDualFll), .oRVD   (oRVD),
                        .oEMP   ()
);

always @*
begin
    qDdrRDE <= (~wDdrRdEMP) & (~wDualFll) & oCal;
end


//----------------------------------------------------------
// DDRメモリ操作
//----------------------------------------------------------
ddr3Bridge #(
    // ddr parameter                    Bram fifo parameter
    .pDramAddrWidth (pDramAddrWidth),   .pBuffDepth     (pBuffDepth),
    .pDramDataWidth (pDramDataWidth),   .pBitDepth      (pBitDepth),
    .pDramMaskWidth (pDramMaskWidth)
) DDR3_BRIDGE (
    // DDR port                             
    .ioDDR3_DQ          (ioDDR3_DQ),    .ioDDR3_DQS_N       (ioDDR3_DQS_N),
    .ioDDR3_DQS_P       (ioDDR3_DQS_P), .oDDR3_ADDR         (oDDR3_ADDR),
    .oDDR3_BA           (oDDR3_BA),     .oDDR3_RAS          (oDDR3_RAS),
    .oDDR3_CAS          (oDDR3_CAS),    .oDDR3_WE           (oDDR3_WE),
    .oDDR3_RESET        (oDDR3_RESET),  .oDDR3_CLK_P        (oDDR3_CLK_P),
    .oDDR3_CLK_N        (oDDR3_CLK_N),  .oDDR3_CKE          (oDDR3_CKE),
    .oDDR3_DM           (oDDR3_DM),     .oDDR3_ODT          (oDDR3_ODT),

    // write data side                  read pixel data
    .iWD                (wPixelWD),     .oRD                (wDdrRD),
    .iWA                (wPixelWA),     .oRDEMP             (wDdrRdEMP),
    .iMask              (16'd0),        .oRVD               (wDdrRVD),
    .iWE                (qPixelWE),     .iRDE               (qDdrRDE),
    .oWFLL              (wWFLL),        
                                        // read ddr address side
                                        .iRA                (wDdrRA),
                                        .iRAE               (qDdrRaE),
                                        .oRAFLL             (wDdrRaFLL),

    // user interface clk rst
    .iCLK               (iDispCLK),     .iRST           (iRST),
    .oUiCLK             (oUiCLK),       .oUiRST         (oUiRST),
    .oInitCalibComplete (oCal)
);

//----------------------------------------------------------
// デバッグ用に値表示
//----------------------------------------------------------
oledTop #(
    .PDIVCLK        (100000),
    .PDIVSCK        (128),
    .DISPLAY_WIDTH  (128),
    .DISPLAY_HEIGHT (4),
    .BIT_LENGTH     (64)
) OLED_TOP (
    .iCLK           (oUiCLK),
    .iRST           (oUiRST),
    .oOledScl       (oOledScl),
    .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),
    .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),
    .oOledVdd       (oOledVdd),
    .iDispLine1     ({64'd0}),
    .iDispLine2     ({64'd0}),
    .iDispLine3     ({64'd0}),
    .iDispLine4     ({64'd0})
    // 95
    // .iDispLine1     ({"XPOS =  ", 4'd0, 2'd0, oUXS, oFXS}),
    // .iDispLine2     ({"YPOS =  ", 4'd0, 2'd0, oUYS, oFYS}),
    // .iDispLine3     ({"        ", 3'd0, oMapDirect[3], 3'd0, oMapDirect[2], 3'd0, oMapDirect[1], 3'd0, oMapDirect[0]}),
    // .iDispLine4     ({"        ", 0})
);

assign oLED = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, oCal, ~oUiRST};

endmodule