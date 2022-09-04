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
    output                      	oVd, 		// 有効データ出力時High
	// Clk rst
    input                       	iRst,		// Active High
	input 							iCke,
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
// 選択範囲内時 CKE 発行
//----------------------------------------------------------
reg rVd;								assign oVd = rVd;
reg qCke;
reg [3:0] qPosMatch;

always @(posedge iClk)
begin
    if (iRst)   	rVd <= 1'd0;
	else if (iCke)	rVd <= qCke;
    else        	rVd <= 1'd0;
end

always @*
begin
    qPosMatch[0] <= (iDxs  <= iHpos);
    qPosMatch[1] <= (iHpos <= iDxe);
    qPosMatch[2] <= (iDys  <= iVpos);
    qPosMatch[3] <= (iVpos <= iDye);
	qCke <= &(qPosMatch);
end

endmodule