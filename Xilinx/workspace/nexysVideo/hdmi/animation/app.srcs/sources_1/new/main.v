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
    parameter V_SYNC          =   2,
    parameter SYS_CLK         = 25000000,
    parameter KEY_CLK         = 125000,
    parameter CLK_1MS         = 25000
)
(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    input  [4:0]    iBtn,           // user push sw
    output          oHDMI_CLK_n,    // hdmi clk negedge
    output          oHDMI_CLK_p,    // hdmi clk posedge
    output [2:0]    oHDMI_n,        // TMDS Channel Serial Data posedge
    output [2:0]    oHDMI_p,        // TMDS Channel Serial Data negedge
    output [7:0]    oLED,           // user led

    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);

// 負論理なので反転、clk wiz用リセット
assign rst = ~iRST;

// 一定周期enable信号
wire oEn5ms;
wire oEn1ms;

// sw
wire [ 4:0] oBtn;

// tmds制御信号
wire [23:0] oVRGB;                              // video RGB

// pll 制御信号
wire o_clk_250;     // pll clk 250MHz
wire o_clk_25;      // pll clk 25MHz
wire locked;
wire user_rst = ~locked;

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


//----------------------------------------------------------
// ディスプレイ制御信号生成
//----------------------------------------------------------
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
    .iRST       (user_rst),
    .oHSYNC     (oHSYNC),
    .oVSYNC     (oVSYNC),
    .oVDE       (oVDE),
    .oHPOS      (oHPOS),
    .oVPOS      (oVPOS)
);


//----------------------------------------------------------
// システムEnable信号生成
//----------------------------------------------------------
enGen #(
    .SYS_CLK(SYS_CLK),
    .KEY_CLK(KEY_CLK),
    .CLK_1MS(CLK_1MS)
) EN_GEN (
    .iCLK       (o_clk_25),
    .iRST       (user_rst),
    .oEn5ms     (oEn5ms),
    .oEn1ms     (oEn1ms)
);


//----------------------------------------------------------
// キー入力生成
//----------------------------------------------------------
swTop SW_TOP (
    .iCLK       (o_clk_25),
    .iRST       (user_rst),
    .iBtn       (iBtn),
    .iEnMs      (oEn5ms),
    .iEn1Ms     (oEn1ms),
    .oBtn       (oBtn)
);


//----------------------------------------------------------
// RGBデータ
//----------------------------------------------------------
rgbTop RGB_TOP(
    .iCLK       (o_clk_25),
    .iRST       (user_rst),
    .iBtn       (oBtn),
    .iEn1Ms     (oEn1ms),
    .iHPOS      (oHPOS),
    .iVPOS      (oVPOS),
    .iVDE       (oVDE),
    .oVRGB      (oVRGB),
    .oOledScl   (oOledScl),
    .oOledSda   (oOledSda),
    .oOledDC    (oOledDC),
    .oOledRes   (oOledRes),
    .oOledVbat  (oOledVbat),
    .oOledVdd   (oOledVdd)
);


//----------------------------------------------------------
// HDMI信号
//----------------------------------------------------------
tmdsTop TMDS_TOP (
    .iTmdsCLK        (o_clk_25),
    .iTmdsOverCLK    (o_clk_250),
    .iRST            (user_rst),
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
