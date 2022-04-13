/*
 * Create 2021/12/22
 * Author koutakimura
 * -
 * HDMI Decoder
 */
module tmdsDecoder (
    input   iTmdsSeri,  // tmds serial data
    output  oHDMI_n,
    output  oHDMI_p
);

wire wPos = iTmdsSeri;
wire wNeg = (~iTmdsSeri);

OBUF HDMI_OBUF_POS (.O (oHDMI_n), .I (wPos));
OBUF HDMI_OBUF_NEG (.O (oHDMI_p), .I (wNeg));

endmodule