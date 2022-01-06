/*
 * Create 2021/12/22
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * HDMIアニメーションプロジェクト
 * スイッチ操作のオブジェクトと自動操作のオブジェクトの描画を行う
 */
module main
#(
    // シミュレーション用にパラメータ設定を可能にする
    parameter H_DISPLAY       = 640,
    parameter H_BACK          =  48,
    parameter H_FRONT         =  16,
    parameter H_SYNC          =  96,
    parameter V_DISPLAY       = 480,
    parameter V_TOP           =  31,
    parameter V_BOTTOM        =  11,
    parameter V_SYNC          =   2 
)
(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    input  [4:0]    iBtn,           // user push sw
    output          oHDMI_CLK_n,    // hdmi clk negedge
    output          oHDMI_CLK_p,    // hdmi clk posedge
    output [2:0]    oHDMI_n,        // TMDS Channel Serial Data posedge
    output [2:0]    oHDMI_p,        // TMDS Channel Serial Data negedge
    output [7:0]    oLED            // user led
);

// 負論理なので反転、clk wiz用リセット
assign rst = ~iRST;

// 一定周期enable信号
wire oEn5ms;

// sw
wire [ 4:0] oBtn;

// ユーザー座標データ
wire [ 9:0] oUXS;
wire [ 9:0] oUYS;
wire [ 9:0] oUXE;
wire [ 9:0] oUYE;

// 色データ
wire [31:0] oBackARGB;                          // BackGround ARGB 背景
wire [31:0] oForeARGB;                          // ForeGround ARGB 前景
wire [31:0] oUserARGB;                          // UserGround ARGB ユーザー

// tmds制御信号
wire [23:0] oVRGB;                              // video RGB

// pll 制御信号
wire o_clk_250;     // pll clk 250MHz
wire o_clk_25;      // pll clk 25MHz
wire locked;

// video timing制御信号
wire oHSYNC;
wire oVSYNC;
wire oVDE;
wire [ 9:0] oHPOS;
wire [ 9:0] oVPOS;


// 操作状況をLEDで確認
assign oLED = {1'b0, iBtn, locked, ~rst};


//----------------------------------------------------------
// モジュール接続
//----------------------------------------------------------
clk_wiz_0 CLK_GEN (
    .clk_out1   (o_clk_25),
    .clk_out2   (o_clk_250),
    .reset      (rst),
    .locked     (locked),
    .clk_in1    (iCLK)
);

hvsyncGen #(
    .H_DISPLAY  (H_DISPLAY),
    .H_BACK     (H_BACK),
    .H_FRONT    (H_FRONT),
    .H_SYNC     (H_SYNC),
    .V_DISPLAY  (V_DISPLAY),
    .V_TOP      (V_TOP),
    .V_BOTTOM   (V_BOTTOM),
    .V_SYNC     (V_SYNC)
) HVSYNC_GEN (
    .iCLK       (o_clk_25),
    .iRST       (rst),
    .oHSYNC     (oHSYNC),
    .oVSYNC     (oVSYNC),
    .oVDE       (oVDE),
    .oHPOS      (oHPOS),
    .oVPOS      (oVPOS)
);


//----------------------------------------------------------
// システムEnable信号生成
//----------------------------------------------------------
enGen EN_GEN(.iCLK(o_clk_25), .iRST(rst), .oEn5ms(oEn5ms));


//----------------------------------------------------------
// キー入力生成
//----------------------------------------------------------
swTop SW_TOP(.iCLK(o_clk_25), .iRST(rst), .iBtn(iBtn), .iEnMs(oEn5ms), .oBtn(oBtn));


//----------------------------------------------------------
// ユーザー座標データ生成
//----------------------------------------------------------
userPos USER_POS(.iCLK(o_clk_25), .iRST(rst), .iBtn(oBtn), .oUXS(oUXS), .oUYS(oUYS), .oUXE(oUXE), .oUYE(oUYE));


//----------------------------------------------------------
// 描画データ生成
//----------------------------------------------------------
rgbGen BACK_GROUND(.iCLK(o_clk_25), .iRST(rst), .iHPOS(oHPOS), .iVPOS(oVPOS), .iXS(0),    .iXE(640),  .iYS(0),    .iYE(480),  .iARGB(32'hff000000), .oARGB(oBackARGB));
rgbGen FORE_GROUND(.iCLK(o_clk_25), .iRST(rst), .iHPOS(oHPOS), .iVPOS(oVPOS), .iXS(0),    .iXE(640),  .iYS(448),  .iYE(480),  .iARGB(32'hff006400), .oARGB(oForeARGB));
rgbGen USER_GROUND(.iCLK(o_clk_25), .iRST(rst), .iHPOS(oHPOS), .iVPOS(oVPOS), .iXS(oUXS), .iXE(oUXE), .iYS(oUYS), .iYE(oUYE), .iARGB(32'hff00bfff), .oARGB(oUserARGB));
rgbBridge RGB_BRIDGE(.iBackARGB(oBackARGB), .iForeARGB(oForeARGB), .iUserARGB(oUserARGB), .oVRGB(oVRGB));


//----------------------------------------------------------
// HDMI信号
//----------------------------------------------------------
tmdsTop TMDS_TOP (
    .iTmdsCLK        (o_clk_25),
    .iTmdsOverCLK    (o_clk_250),
    .iRST            (rst),
    .oHDMI_CLK_n     (oHDMI_CLK_n),
    .oHDMI_CLK_p     (oHDMI_CLK_p),
    .oHDMI_n         (oHDMI_n),
    .oHDMI_p         (oHDMI_p),
    .iVRGB           (oVRGB),
    .iVDE            (oVDE),
    .iHSYNC          (oHSYNC),
    .iVSYNC          (oVSYNC)
);

endmodule
