/*
 * Create 2022/3/27
 * Author koutakimura
 * -
 * TMDS Generate Block
 */
module tgbWrapper (
    input           iTmdsCLK,       // 画面サイズに対応したclkを入力
    input           iTmdsOverCLK,   // tmdsの10倍のクロック入力
    input           iRST,           // Active High
    output          oHDMI_CLK_n,    // hdmi clk negedge
    output          oHDMI_CLK_p,    // hdmi clk posedge
    output [ 2:0]   oHDMI_n,        // TMDS Channel Serial Data posedge
    output [ 2:0]   oHDMI_p,        // TMDS Channel Serial Data negedge
    input  [23:0]   iVRGB,          // rgb
    input           iVDE,           // video enable signal
    input           iHSYNC,
    input           iVSYNC
);

// tmds
wire [ 9:0] oTmdsParaB, oTmdsParaG, oTmdsParaR;  // tmdsパラレル信号
wire oTmdsSeriCH0, oTmdsSeriCH1, oTmdsSeriCH2;  // tmdsシリアル信号

//----------------------------------------------------------
// HDMI信号
//----------------------------------------------------------
tmdsEncoderDvi TMDS_ENCODER_B(.iCLK(iTmdsCLK), .iRST(iRST), .iVD(iVRGB[ 7: 0]), .iCD({iVSYNC, iHSYNC}), .iVDE(iVDE), .oTmdsPara(oTmdsParaB));
tmdsEncoderDvi TMDS_ENCODER_G(.iCLK(iTmdsCLK), .iRST(iRST), .iVD(iVRGB[15: 8]), .iCD(2'b00),            .iVDE(iVDE), .oTmdsPara(oTmdsParaG));
tmdsEncoderDvi TMDS_ENCODER_R(.iCLK(iTmdsCLK), .iRST(iRST), .iVD(iVRGB[23:16]), .iCD(2'b00),            .iVDE(iVDE), .oTmdsPara(oTmdsParaR));

tmdsSerialize TMDS_B(.iCLK(iTmdsOverCLK), .iRST(iRST), .iTmdsPara(oTmdsParaB), .oTmdsSeri(oTmdsSeriCH0));
tmdsSerialize TMDS_G(.iCLK(iTmdsOverCLK), .iRST(iRST), .iTmdsPara(oTmdsParaG), .oTmdsSeri(oTmdsSeriCH1));
tmdsSerialize TMDS_R(.iCLK(iTmdsOverCLK), .iRST(iRST), .iTmdsPara(oTmdsParaR), .oTmdsSeri(oTmdsSeriCH2));

tmdsDecoder TMDS_DECODER_CH0(.iTmdsSeri(oTmdsSeriCH0), .oHDMI_n(oHDMI_n[0]),  .oHDMI_p(oHDMI_p[0]));
tmdsDecoder TMDS_DECODER_CH1(.iTmdsSeri(oTmdsSeriCH1), .oHDMI_n(oHDMI_n[1]),  .oHDMI_p(oHDMI_p[1]));
tmdsDecoder TMDS_DECODER_CH2(.iTmdsSeri(oTmdsSeriCH2), .oHDMI_n(oHDMI_n[2]),  .oHDMI_p(oHDMI_p[2]));
tmdsDecoder TMDS_DECODER_CH3(.iTmdsSeri(iTmdsCLK),     .oHDMI_n(oHDMI_CLK_n), .oHDMI_p(oHDMI_CLK_p));


endmodule