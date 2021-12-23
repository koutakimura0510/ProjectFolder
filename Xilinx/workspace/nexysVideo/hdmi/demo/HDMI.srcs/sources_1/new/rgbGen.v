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

reg [7:0] red;          assign oBLUE  = red;
reg [7:0] green;        assign oGREEN = green;
reg [7:0] blue;         assign oRED   = blue;

wire [7:0] W = {8{iHPOS[7:0] == iVPOS[7:0]}};
wire [7:0] A = {8{iHPOS[7:5] == 3'h2 && iVPOS[7:5] == 3'h2}};

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        red <= 0;
    end else begin
        red <= ({iHPOS[5:0] & {6{iVPOS[4:3] == ~iHPOS[4:3]}}, 2'b00} | W) & ~A;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        green <= 0;
    end else begin
        green <= (iHPOS[7:0] & {8{iVPOS[6]}} | W) & ~A;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        blue <= 0;
    end else begin
        blue <= iHPOS[7:0] | W & A;
    end
end

endmodule