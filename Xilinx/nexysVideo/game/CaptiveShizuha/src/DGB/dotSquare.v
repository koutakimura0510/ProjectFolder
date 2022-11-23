 //----------------------------------------------------------
 // Create 2022/04/04
 // Author koutakimura
 // Editor VSCode ver1.62.7
 // Build  Vivado20.2
 // Borad  Nexys Video
 // -
 // Latency 2
 // -
 // 指定範囲で指定色の四角形データを出力するモジュール
 // 解像度の拡大に対応したときのため、動作速度向上が必要になるためパイプライン化にしてある。
 //----------------------------------------------------------
module dgbWrapper #(
    parameter                   pColorSize      = 24 
    parameter                   pBitWidth       = 10,
    parameter                   pBitHeight      = 10
)(
    input                       iCLK,           // 指定clk
    input                       iRST,           // Active High Sync RST
    input  [pBitWidth -1:0]     iDwp,           // Display width  pos
    input  [pBitHeight-1:0]     iDhp,           // Display height pos
    input  [pBitWidth -1:0]     iDxs,           // Draw xpos start
    input  [pBitWidth -1:0]     iDxe,           // Draw xpos end
    input  [pBitHeight-1:0]     iDys,           // Draw ypos start
    input  [pBitHeight-1:0]     iDye,           // Draw ypos start
    input  [pColorSize-1:0]     iColor,         // Draw Color 
    output [pPixelWidth-1:0]    oPixel,         // 生成ピクセルデータ
    output                      oVd             // 有効データ出力時High
);


//----------------------------------------------------------
// Color Gen
//----------------------------------------------------------
reg [pColorSize-1:0] rColor [0:1];            assign oPixel = rColor[1];

always @(posedge iCLK)
begin
    {rColor[1], rColor[0]} <= {rColor[0], iColor};
end

//----------------------------------------------------------
// Stage 1
//----------------------------------------------------------
reg [3:0] rCke, qCke;

always @(posedge iCLK)
begin
    if (iRST)   rCke <= 4'd0;
    else        rCke <= qCke;
end

always @*
begin
    qCke[0] <= (iDxs <= iDwp);
    qCke[1] <= (iDwp <= iDxe);
    qCke[2] <= (iDys <= iDhp);
    qCke[3] <= (iDhp <= iDye);
end

//----------------------------------------------------------
// Stage 2
//----------------------------------------------------------
reg rVd, qVd;                            assign oVd = rVd;

always @(posedge iCLK)
begin
    if (iRST)   rVd <= 1'b0;
    else        rVd <= qVd;
end

always @*
begin
    qVd     <= &rCke;
end

endmodule