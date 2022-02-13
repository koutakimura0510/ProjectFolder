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


//----------------------------------------------------------
// gameDataTop内を動作させるクロックとリセット信号
//----------------------------------------------------------
wire oUiCLK, oUiRST;


//----------------------------------------------------------
// DDRメモリの読み込みデータを保存しピクセルクロックのタイミングで出力
//----------------------------------------------------------
wire [pBitDepth-1:0] oRD;
wire oRDEMP;
wire oRVD;
wire iRDE;
wire [pBitDepth-1:0] iRA;
wire iRAE;
wire oRAFLL;
wire oCal;  // ddr calibration
assign oVRGB = 24'h222222;

// TODO dual port ram 作成

assign iRDE  = (~oRDEMP) & oCal;
assign iRAE  = (~oRAFLL) & oCal;
assign iRA   = raddr;


//----------------------------------------------------------
// ピクセルデータ生成
//----------------------------------------------------------
localparam pRgbWidth = 32;

wire oWFLL;
wire [pRgbWidth-1:0] wPixelWD;      // pixel data
wire [pDramAddrWidth-1:0] wPixelWA; // write addr
reg qPixelWE;                       // write enable

rgbTop #(
    .pDramAddrWidth (pDramAddrWidth),
    .pRgbWidth      (pRgbWidth)
) RGB_TOP (

);

always @*
begin
    qPixelWE <= (~oWFLL);
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

    // data hand shake                  read pixel data
    .iWD                (wPixelWD),     .oRD                (oRD),
    .iWA                (wPixelWA),     .oRDEMP             (oRDEMP),
    .iMask              (16'd0),        .oRVD               (oRVD),
    .iWE                (qPixelWE),     .iRDE               (iRDE),
    .oWFLL              (oWFLL),        
                                        // read ddr side
                                        .iRA                (iRA),
                                        .iRAE               (iRAE),
                                        .oRAFLL             (oRAFLL),

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