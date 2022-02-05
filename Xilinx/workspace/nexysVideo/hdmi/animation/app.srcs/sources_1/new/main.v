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
    input  [5:0]    iBtn,           // user push sw
    output          oHDMI_CLK_n,    // hdmi clk negedge
    output          oHDMI_CLK_p,    // hdmi clk posedge
    output [2:0]    oHDMI_n,        // TMDS Channel Serial Data posedge
    output [2:0]    oHDMI_p,        // TMDS Channel Serial Data negedge
    output [7:0]    oLED,           // user led

    // ddr3 port
    // Vivado MIG生成機能使用
    inout  [15:0]   ddr3_dq,
    inout  [ 1:0]   ddr3_dqs_n,
    inout  [ 1:0]   ddr3_dqs_p,
    output [14:0]   ddr3_addr,
    output [ 2:0]   ddr3_ba,
    output          ddr3_ras_n,
    output          ddr3_cas_n,
    output          ddr3_we_n,
    output          ddr3_reset_n,
    output [0:0]    ddr3_ck_p,
    output [0:0]    ddr3_ck_n,
    output [0:0]    ddr3_cke,
    output [1:0]    ddr3_dm,
    output [0:0]    ddr3_odt,

    // 評価ボード上oled
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);

// 負論理なので反転、clk wiz用リセット
assign rst = ~iRST;

// sw
wire [ 5:0] oBtn;

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
assign oLED = {~iBtn, locked, ~rst};


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
// キー入力生成
//----------------------------------------------------------
swTop SW_TOP (
    .iCLK       (o_clk_25),
    .iRST       (user_rst),
    .iBtn       (~iBtn),
    .oBtn       (oBtn)
);


//----------------------------------------------------------
// RGBデータ
//----------------------------------------------------------
rgbTop #(
    .ADDR_WIDTH(29),
    .DATA_WIDTH(128),
    .MASK_WIDTH(16)
) RGB_TOP (
    .iCLK           (o_clk_25),
    .iRST           (user_rst),
    .iBtn           (oBtn),
    .iHPOS          (oHPOS),
    .iVPOS          (oVPOS),
    .iVDE           (oVDE),
    .oVRGB          (oVRGB),
    .ioDDR3_DQ      (ddr3_dq),
    .ioDDR3_DQS_N   (ddr3_dqs_n),
    .ioDDR3_DQS_P   (ddr3_dqs_p),
    .oDDR3_ADDR     (ddr3_addr),
    .oDDR3_BA       (ddr3_ba),
    .oDDR3_RAS      (ddr3_ras_n),
    .oDDR3_CAS      (ddr3_cas_n),
    .oDDR3_WE       (ddr3_we_n),
    .oDDR3_RESET    (ddr3_reset_n),
    .oDDR3_CLK_P    (ddr3_ck_p),
    .oDDR3_CLK_N    (ddr3_ck_n),
    .oDDR3_CKE      (ddr3_cke),
    .oDDR3_DM       (ddr3_dm),
    .oDDR3_ODT      (ddr3_odt),
    .oOledScl       (oOledScl),
    .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),
    .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),
    .oOledVdd       (oOledVdd)
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
