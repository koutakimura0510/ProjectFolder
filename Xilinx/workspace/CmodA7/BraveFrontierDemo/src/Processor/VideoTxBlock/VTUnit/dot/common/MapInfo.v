//----------------------------------------------------------
// Create 2022/10/15
// Author koutakimura
// -
// MapInfo 情報を管理する
// 
//----------------------------------------------------------
module MapInfo #(
	parameter								pMapInfoBitWidth	= 8,		// マップのマップチップの個数に合わせる
	parameter								pMapXSize			= 150,		// マップの最大サイズ
	parameter								pMapYSize			= 150		// マップの最大サイズ
)(
	// Internal Port
	input	[pMapInfoBitWidth-1:0]			iMapInfoWd,					// MapInfo 更新データ
	input 									iMapInfoCke,				// MapInfo Write Enable
	input 									iMapInfoVd,					// MapInfo 更新期間中 Assert
	//
	input	[15:0]							iMapInfoRAdrs,				// 計算した座標データを指定すると、mapinfo取得
	output 	[pMapInfoBitWidth-1:0]			oMapInfo,
	// Clk rst
    input									iRst,
    input									iClk
);


//-----------------------------------------------------------------------------
// マップ情報格納 BRAM の確保・初期化
//-----------------------------------------------------------------------------
(* ram_style = "BLOCK" *) reg [pMapInfoBitWidth-1:0] rMapInfoFifo [0:(pMapXSize * pMapYSize) - 1];

// initial begin
//     $readmemh(pFileName, rWaveFifo);
// end


//-----------------------------------------------------------------------------
// マップ Info の更新
// ※ Flash Memory から マップ Info の取得を行うため、更新速度は内部CLKよりも大分遅い。
// 更新側で準備可能時に CKE が Assert 状態になるため、VD を設けたほうが制御しやすかった。
// Cke 信号は Csr 経由で自動クリアなどしないため、システム駆動の MCB で Cke を 1clk 単位でトグル
// させるなど工夫が必要である。
//-----------------------------------------------------------------------------
reg [15:0] 					rMapInfoWAdrs;
reg [pMapInfoBitWidth-1:0]	rMapInfoRd;

always @(posedge iClk)
begin
	if (iMapInfoVd)		rMapInfoWAdrs <= rMapInfoWAdrs + iMapInfoCke;
	else 				rMapInfoWAdrs <= 16'd0;

	if (iMapInfoCke) 	rMapInfoFifo[rMapInfoWAdrs] <= iMapInfoWd;

	rMapInfoRd <= rMapInfoFifo[iMapInfoRAdrs];
end

endmodule