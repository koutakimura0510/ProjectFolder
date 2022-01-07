/*
 * Create 2021/12/22
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * RGB色データ生成モジュール
 */
module rgbGen(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    input  [ 9:0]   iHPOS,          // 描画座標horizon
    input  [ 9:0]   iVPOS,          // 描画座標vertical
    input  [ 9:0]   iXS,            // 描画開始x_start座標
    input  [ 9:0]   iXE,            // 描画開始x_end座標
    input  [ 9:0]   iYS,            // 描画開始y_start座標
    input  [ 9:0]   iYE,            // 描画開始y_end座標
    input  [31:0]   iARGB,          // 入力画素
    output [31:0]   oARGB           // 出力画素
);

reg [7:0] red, green, blue;     assign oARGB = {8'h00, red, green, blue};
wire [ 9:0] xstart = iXS;
wire [ 9:0] xend   = (iXE - 1);
wire [ 9:0] ystart = iYS;
wire [ 9:0] yend   = (iYE);

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        red <= iARGB[23:16];
    end else if (xstart <= iHPOS && iHPOS < xend && ystart <= iVPOS && iVPOS < yend) begin
        red <= iARGB[23:16];
    end else begin
        red <= 0;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        green <= iARGB[15:8];
    end else if (xstart <= iHPOS && iHPOS < xend && ystart <= iVPOS && iVPOS < yend) begin
        green <= iARGB[15:8];
    end else begin
        green <= 0;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        blue <= iARGB[7:0];
    end else if (xstart <= iHPOS && iHPOS < xend && ystart <= iVPOS && iVPOS < yend) begin
        blue <= iARGB[7:0];
    end else begin
        blue <= 0;
    end
end

endmodule