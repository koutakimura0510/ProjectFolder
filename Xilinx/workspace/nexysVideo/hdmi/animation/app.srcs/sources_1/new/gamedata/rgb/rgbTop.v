//----------------------------------------------------------
// Create 2021/2/13
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// ピクセルデータ生成トップモジュール
//----------------------------------------------------------
module rgbTop # (
    parameter       pDramAddrWidth = 29,
    parameter       pRgbWidth      = 32
)(
    input                       iCLK,       // user clk
    input                       iRST,       // system rst
    output [pRgbWidth-1:0]      oRGB,       // アドレスに書き込むピクセルデータ
    output [pDramAddrWidth-1:0] oAddr       // ddr memoryに確保したフレームバッファ領域に書き込むアドレスを指定
    input                       
);

always @(posedge oUiCLK)
begin
    if (oUiRST) wdata      <= 0;
    else if (qCntEn) wdata <= wdata + 1'b1;
    else wdata             <= wdata;
end

always @(posedge oUiCLK)
begin
    if (oUiRST) waddr      <= 0;
    else if (qCntEn) waddr <= waddr + 4'd8;
    else waddr             <= waddr;
end

endmodule