/*
 * Create 2021/12/22
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * HDMI RGB色データ生成モジュール
 */
module rgbGen(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    input [9:0]     iHPOS,
    input [9:0]     iVPOS,
    output [7:0]    oBLUE,
    output [7:0]    oGREEN,
    output [7:0]    oRED
);

reg [7:0] blue;         assign oBLUE  = blue;
reg [7:0] green;        assign oGREEN = green;
reg [7:0] red;          assign oRED   = red;


always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        red <= 0;
    end else if (0 <= iHPOS && iHPOS < 100 && 0 <= iVPOS && iVPOS < 100) begin
        red <= 8'hff;
    end else begin
        red <= 0;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        green <= 0;
    end else if (100 <= iHPOS && iHPOS < 200 && 100 <= iVPOS && iVPOS < 200) begin
        green <= 8'hff;
    end else begin
        green <= 0;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        blue <= 0;
    end else if (540 <= iHPOS && iHPOS < 640 && 1 <= iVPOS && iVPOS < 101) begin
        blue <= 8'hff;
    end else begin
        blue <= 0;
    end
end

endmodule