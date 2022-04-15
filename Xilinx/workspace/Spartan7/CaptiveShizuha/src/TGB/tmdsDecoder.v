/*
 * Create 2021/12/22
 * Author koutakimura
 * -
 * HDMI Decoder
 */
module tmdsDecoder (
    input   iTmdsSeri,  // tmds serial data
    output  oHdmiDataNeg,
    output  oHdmiDataPos
);

wire wPos = iTmdsSeri;
wire wNeg = (~iTmdsSeri);

OBUF HDMI_OBUF_POS (.O (oHdmiDataNeg), .I (wPos));
OBUF HDMI_OBUF_NEG (.O (oHdmiDataPos), .I (wNeg));

endmodule