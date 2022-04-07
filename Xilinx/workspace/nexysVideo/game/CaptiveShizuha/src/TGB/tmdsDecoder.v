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
    input   iCLK,
    // input   iRST,
    input   iTmdsSeri,  // tmds serial data
    output  oHDMI_n,
    output  oHDMI_p
);

// assign oHDMI_n = (iTmdsSeri == 1'b1) ? 1'b1 : 1'b0;
// assign oHDMI_p = (iTmdsSeri == 1'b1) ? 1'b0 : 1'b1;

reg rHdmin;        assign oHDMI_n = rHdmin;
reg rHdmip;        assign oHDMI_p = rHdmip;

always @(posedge iCLK) begin
    if (iTmdsSeri)  {rHdmin, rHdmip} <= {1'b1, 1'b0};
    else            {rHdmin, rHdmip} <= {1'b0, 1'b1};
end

endmodule