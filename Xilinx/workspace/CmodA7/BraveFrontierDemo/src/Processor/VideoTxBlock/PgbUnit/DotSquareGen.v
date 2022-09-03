 //----------------------------------------------------------
 // Create 2022/08/31
 // Author koutakimura
 // -
 // 指定範囲で指定色の四角形データを出力するモジュール
 //----------------------------------------------------------
module DotSquareGen #(
    parameter                   	pHdisplayWidth  = 11,
    parameter                   	pVdisplayWidth  = 11,
	parameter						pColorDepth		= 16
)(
	// Internal Port
    input  [pHdisplayWidth-1:0]     iHpos,		// 現在の横幅の座標
    input  [pVdisplayWidth-1:0]     iVpos,		// 現在の立幅の座標
    input  [pHdisplayWidth-1:0]     iDxs,		// 描画開始 X座標 Draw X Start
    input  [pHdisplayWidth-1:0]     iDxe,		// 描画終了 X座標 Draw X End
    input  [pVdisplayWidth-1:0]     iDys,		// 描画開始 Y座標 Draw Y Start
    input  [pVdisplayWidth-1:0]     iDye,		// 描画終了 Y座標 Draw Y End
    input  [pColorDepth-1:0]		iPixel,		// 描画色
    output [pColorDepth-1:0]    	oPixel,		// 出力ピクセルデータ
    output                      	oVd 		// 有効データ出力時High
	// Clk rst
    input                       	iRst,		// Active High
    input                       	iClk		// 
);


//----------------------------------------------------------
// 色データ入力
//----------------------------------------------------------
reg [pColorDepth-1:0] rPixel;            assign oPixel = rPixel;

always @(posedge iClk)
begin
    rPixel <= iPixel;
end

//----------------------------------------------------------
// Stage 1
// 選択範囲内時 CKE 発行
//----------------------------------------------------------
reg [3:0] rCke;
reg [3:0] qCke;

always @(posedge iClk)
begin
    if (iRst)   rCke <= 4'd0;
    else        rCke <= qCke;
end

always @*
begin
    qCke[0] <= (iDxs  <= iHpos);
    qCke[1] <= (iHpos <= iDxe);
    qCke[2] <= (iDys  <= iVpos);
    qCke[3] <= (iVpos <= iDye);
end

//----------------------------------------------------------
// Stage 2
// 組み合わせ回路で上記の CKE 回路で 1clk で処理をしてもよいが、
// 後々に解像度が上がった時の配線遅延対策のため、1段レジスタ処理にしている
//----------------------------------------------------------
reg rVd;								assign oVd = rVd;
reg qVd;

always @(posedge iClk)
begin
    if (iRst)   	rVd <= 1'b0;
	else if (qVd)	rVd <= 1'b1;
    else        	rVd <= 1'b0;
end

always @*
begin
    qVd <= &rCke;
end

endmodule