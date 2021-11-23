/*
 * Create 2021/10/23
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * Pmod 7SegmentLED Decoder
 */
module pmodSeg
(
input  iCLK,
input  iRST,
input  [3:0] selSeg,
input  saSeg;
output [6:0] oSEG,
output oSEL
);

reg [6:0] decoder;  assign oSEG = decoder;
reg sa;             assign oSEL = sa;

/*
 * 7セグデコーダー
 */
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        decoder <= 7'b1001110;
    end else begin
        case(selSeg)
            4'h0:   decoder <= 7'b0111111;
            4'h1:   decoder <= 7'b0110000;
            4'h2:   decoder <= 7'b1011011;
            4'h3:   decoder <= 7'b1111001;
            4'h4:   decoder <= 7'b1110100;
            4'h5:   decoder <= 7'b1101101;
            4'h6:   decoder <= 7'b1101111;
            4'h7:   decoder <= 7'b0111100;
            4'h8:   decoder <= 7'b1111111;
            4'h9:   decoder <= 7'b1111101;
            4'ha:   decoder <= 7'b1111110;
            4'hb:   decoder <= 7'b1100111;
            4'hc:   decoder <= 7'b0001111;
            4'hd:   decoder <= 7'b1110011;
            4'he:   decoder <= 7'b1001111;
            4'hf:   decoder <= 7'b1001110;
            default:decoder <= 7'b1001110;
        endcase
    end
end

/*
 * ダイナミック点灯桁選択
 */
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sa <= 1'b0;
    end else begin
        sa <= saSeg;
    end
end


endmodule