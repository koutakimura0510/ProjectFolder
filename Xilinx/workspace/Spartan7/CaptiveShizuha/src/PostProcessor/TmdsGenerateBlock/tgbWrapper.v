/*
 * Create 2022/3/27
 * Author koutakimura
 * -
 * TMDS Generate Block
 */
module tgbWrapper (
    input           iPixelClk,      // 画面サイズに対応したclkを入力
    input           iTmdsClk,       // PixelClkの10倍のクロック入力
    input           iRst,           // Active High
    output          oHdmiClkNeg,    // hdmi clk posedge
    output          oHdmiClkPos,    // hdmi clk negedge
    output [ 2:0]   oHdmiDataPos,   // hdmi Data 8b10b posedge
    output [ 2:0]   oHdmiDataNeg,   // hdmi Data 8b10b negedge
    output          oHdmiScl,       // hdmi I2c scl
    inout           ioHdmiSda,      // hdmi I2c sda
    inout           ioHdmiCec,      // hdmi cec
    input           iHdmiHpd,       // hdmi hpd
    input  [23:0]   iPixel,         // Pixel Data
    input           iVde,           // video enable signal
    input           iHsync,
    input           iVsync
);


//---------------------------------------------------------------------------
// 使用していない
//---------------------------------------------------------------------------
assign oHdmiScl  = 1'b1;
assign ioHdmiSda = 1'bz;
assign ioHdmiCec = 1'bz;

// tmds
wire [ 9:0] oTmdsParaB, oTmdsParaG, oTmdsParaR;  // tmdsパラレル信号
wire oTmdsSeriCH0, oTmdsSeriCH1, oTmdsSeriCH2;   // tmdsシリアル信号

//----------------------------------------------------------
// 8b10b変換
//----------------------------------------------------------
tmdsEncoderDvi TMDS_ENCODER_B (
    .iClk       (iPixelClk),
    .iRst       (iRst),
    .iVD        (iPixel[ 7: 0]),
    .iCD        ({iVsync, iHsync}),
    .iVde       (iVde),
    .oTmdsPara  (oTmdsParaB)
);

tmdsEncoderDvi TMDS_ENCODER_G (
    .iClk       (iPixelClk),
    .iRst       (iRst),
    .iVD        (iPixel[15: 8]),
    .iCD        (2'b00),
    .iVde       (iVde),
    .oTmdsPara  (oTmdsParaG)
);

tmdsEncoderDvi TMDS_ENCODER_R (
    .iClk       (iPixelClk),
    .iRst       (iRst),
    .iVD        (iPixel[23:16]),
    .iCD        (2'b00),
    .iVde       (iVde),
    .oTmdsPara  (oTmdsParaR)
);


//---------------------------------------------------------------------------
// パラレル->シリアル変換
//---------------------------------------------------------------------------
tmdsSerialize TMDS_B (
    .iClk       (iTmdsClk),
    .iRst       (iRst),
    .iTmdsPara  (oTmdsParaB),
    .oTmdsSeri  (oTmdsSeriCH0)
);

tmdsSerialize TMDS_G (
    .iClk       (iTmdsClk),
    .iRst       (iRst),
    .iTmdsPara  (oTmdsParaG),
    .oTmdsSeri  (oTmdsSeriCH1)
);

tmdsSerialize TMDS_R (
    .iClk       (iTmdsClk),
    .iRst       (iRst),
    .iTmdsPara  (oTmdsParaR),
    .oTmdsSeri  (oTmdsSeriCH2)
);


//---------------------------------------------------------------------------
// HDMI 信号出力
//---------------------------------------------------------------------------
tmdsDecoder TMDS_DECODER_CH0 (
    .iTmdsSeri      (oTmdsSeriCH0),
    .oHdmiDataNeg   (oHdmiDataNeg[0]),
    .oHdmiDataPos   (oHdmiDataPos[0])
);

tmdsDecoder TMDS_DECODER_CH1 (
    .iTmdsSeri      (oTmdsSeriCH1),
    .oHdmiDataNeg   (oHdmiDataNeg[1]),
    .oHdmiDataPos   (oHdmiDataPos[1])
);

tmdsDecoder TMDS_DECODER_CH2 (
    .iTmdsSeri      (oTmdsSeriCH2),
    .oHdmiDataNeg   (oHdmiDataNeg[2]),
    .oHdmiDataPos   (oHdmiDataPos[2])
);

tmdsDecoder TMDS_DECODER_CH3 (
    .iTmdsSeri      (iPixelClk),
    .oHdmiDataNeg   (oHdmiClkNeg),
    .oHdmiDataPos   (oHdmiClkPos)
);


endmodule