/*
 * Create 2021/12/22
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * HDMIサンプル動作
 */
module main
#(
    // シミュレーションようにパラメータ設定を可能にする
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
    input           iBTNC,          // user push sw
    output          oHDMI_CLK_n,    // hdmi clk negedge
    output          oHDMI_CLK_p,    // hdmi clk posedge
    output [2:0]    oHDMI_n,        // TMDS Channel Serial Data posedge
    output [2:0]    oHDMI_p,        // TMDS Channel Serial Data negedge
    output [7:0]    oLED            // user led
);

// 負論理なので反転、clk wiz用リセット
assign rst = ~iRST;

// tmds制御信号
wire [7:0] oVB, oVG, oVR;                       // video RGB
wire [9:0] oTmdsParaB, oTmdsParaG, oTmdsParaR;  // tmdsパラレル信号
wire oTmdsSeriCH0, oTmdsSeriCH1, oTmdsSeriCH2;  // tmdsシリアル信号

// pll 制御信号
wire o_clk_250;     // pll clk 250MHz
wire o_clk_25;      // pll clk 25MHz
wire locked;

// video timing制御信号
wire oHSYNC;
wire oVSYNC;
wire oVDE;
wire [9:0] oHPOS;
wire [9:0] oVPOS;

assign oLED = {8'h00, locked, ~rst};


//----------------------------------------------------------
// モジュール接続
//----------------------------------------------------------
clk_wiz_0 CLK_GEN (
    .clk_out1(o_clk_25),
    .clk_out2(o_clk_250),
    .reset(rst),
    .locked(locked),
    .clk_in1(iCLK)
);

hvsyncGen #(
    .H_DISPLAY(H_DISPLAY),
    .H_BACK(H_BACK),
    .H_FRONT(H_FRONT),
    .H_SYNC(H_SYNC),
    .V_DISPLAY(V_DISPLAY),
    .V_TOP(V_TOP),
    .V_BOTTOM(V_BOTTOM),
    .V_SYNC(V_SYNC)
) HVSYNC_GEN (
    .iCLK(o_clk_25),
    .iRST(rst),
    .oHSYNC(oHSYNC),
    .oVSYNC(oVSYNC),
    .oVDE(oVDE),
    .oHPOS(oHPOS),
    .oVPOS(oVPOS)
);

rgbGen RGB_GEN(
    .iCLK(o_clk_25),
    .iRST(rst),
    .iHPOS(oHPOS),
    .iVPOS(oVPOS),
    .oBLUE(oVB),
    .oGREEN(oVG),
    .oRED(oVR)
);

tmdsEncoderDvi   TMDS_ENCODER_B(.iCLK(o_clk_25), .iRST(rst), .iVD(oVB), .iCD({oVSYNC, oHSYNC}), .iVDE(oVDE), .oTmdsPara(oTmdsParaB));
tmdsEncoderDvi   TMDS_ENCODER_G(.iCLK(o_clk_25), .iRST(rst), .iVD(oVG), .iCD(2'b00),            .iVDE(oVDE), .oTmdsPara(oTmdsParaG));
tmdsEncoderDvi   TMDS_ENCODER_R(.iCLK(o_clk_25), .iRST(rst), .iVD(oVR), .iCD(2'b00),            .iVDE(oVDE), .oTmdsPara(oTmdsParaR));

tmdsSerialize TMDS_B(.iCLK(o_clk_250), .iRST(rst), .iTmdsPara(oTmdsParaB), .oTmdsSeri(oTmdsSeriCH0));
tmdsSerialize TMDS_G(.iCLK(o_clk_250), .iRST(rst), .iTmdsPara(oTmdsParaG), .oTmdsSeri(oTmdsSeriCH1));
tmdsSerialize TMDS_R(.iCLK(o_clk_250), .iRST(rst), .iTmdsPara(oTmdsParaR), .oTmdsSeri(oTmdsSeriCH2));

tmdsDecoder TMDS_DECODER_CH0(.iTmdsSeri(oTmdsSeriCH0), .oHDMI_n(oHDMI_n[0]),  .oHDMI_p(oHDMI_p[0]));
tmdsDecoder TMDS_DECODER_CH1(.iTmdsSeri(oTmdsSeriCH1), .oHDMI_n(oHDMI_n[1]),  .oHDMI_p(oHDMI_p[1]));
tmdsDecoder TMDS_DECODER_CH2(.iTmdsSeri(oTmdsSeriCH2), .oHDMI_n(oHDMI_n[2]),  .oHDMI_p(oHDMI_p[2]));
tmdsDecoder TMDS_DECODER_CH3(.iTmdsSeri(o_clk_25),     .oHDMI_n(oHDMI_CLK_n), .oHDMI_p(oHDMI_CLK_p));

endmodule
