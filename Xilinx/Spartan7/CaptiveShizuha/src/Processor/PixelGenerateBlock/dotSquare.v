 //----------------------------------------------------------
 // Create 2022/04/04
 // Author koutakimura
 // -
 // Latency 2
 // -
 // 指定範囲で指定色の四角形データを出力するモジュール
 // 解像度の拡大に対応したときのため、動作速度向上が必要になるためパイプライン化にしてある。
 //----------------------------------------------------------
module dgbWrapper #(
    parameter                   pPixelSize      = 24 
    parameter                   pBitWidth       = 10,
    parameter                   pBitHeight      = 10
)(
    input                       iClk,           // 指定clk
    input                       iRst,           // Active High Sync RST
    input  [pBitWidth -1:0]     iDwp,           // 現在の横幅の座標
    input  [pBitHeight-1:0]     iDhp,           // 現在の立幅の座標
    input  [pBitWidth -1:0]     iDxs,           // 描画開始 X座標 Draw X Start
    input  [pBitWidth -1:0]     iDxe,           // 描画終了 X座標 Draw X End
    input  [pBitHeight-1:0]     iDys,           // 描画開始 Y座標 Draw Y Start
    input  [pBitHeight-1:0]     iDye,           // 描画終了 Y座標 Draw Y End
    input  [pPixelSize-1:0]     iPixel,         // 描画色
    output [pPixelWidth-1:0]    oPixel,         // 出力ピクセルデータ
    output                      oVd             // 有効データ出力時High
);


//----------------------------------------------------------
// Pixel Gen
// 入力色データをシフトレジスタで受信
//----------------------------------------------------------
reg [pPixelSize-1:0] rPixel [0:1];            assign oPixel = rPixel[1];

always @(posedge iClk)
begin
    {rPixel[1], rPixel[0]} <= {rPixel[0], iPixel};
end

//----------------------------------------------------------
// Stage 1
// 選択範囲内時 CKE 発行
//----------------------------------------------------------
reg [3:0] rCke, qCke;

always @(posedge iClk)
begin
    if (iRst)   rCke <= 4'd0;
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

always @(posedge iClk)
begin
    if (iRst)   rVd <= 1'b0;
    else        rVd <= qVd;
end

always @*
begin
    qVd     <= &rCke;
end

endmodule