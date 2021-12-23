/*
 * Create 2021/12/22
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * HDMI Decoder
 */
module tmdsDecoder (
    input   iCLK,       // pll clk
    input   iRST,       // system rst
    input   iTmdsSeri,  // tmds serial data
    output  oHDMI_N,
    output  oHDMI_P
);

reg hdmi_n;        assign oHDMI_N = hdmi_n;
reg hdmi_p;        assign oHDMI_P = hdmi_p;

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        hdmi_n <= 0;
        hdmi_p <= 1'b1;
    end else if (iTmdsSeri == 1'b1) begin
        hdmi_n <= 1'b1;
        hdmi_p <= 0;
    end else begin
        hdmi_n <= 0;
        hdmi_p <= 1'b1;
    end
end

endmodule