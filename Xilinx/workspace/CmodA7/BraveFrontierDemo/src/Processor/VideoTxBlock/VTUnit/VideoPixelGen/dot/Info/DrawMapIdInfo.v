//----------------------------------------------------------
// Create 2022/11/03
// Author koutakimura
// -
// マップID 情報を管理する Wrapper Module
// 
//----------------------------------------------------------
module DrawMapIdInfo #(
	// Map Info Status
	parameter 							pMapSizeWidth 	= 250,	// マップの最大横幅、ワールドマップ基準
	parameter 							pMapIdWidth		= 8,	// 最大 256個のマップチップ使用可能
	parameter 							pMapInfoNumber	= 4		// マップ情報の数
	//
	parameter							pMapInfoWidth 	= pMapIdWidth * pMapInfoNumber;
)(
	// Internal Port
	input	[pMapInfoWidth-1:0]			iInfoWd,				// MapInfo Write Data
	input	[7:0]						iInfoWAdrs,				// MapInfo Write Adrs, BRAM が 36KB のため 16bit幅
	input 								iInfoWCke,				// MapInfo Write Enable
	// iInfoPos の入力からレイテンシ1で出力
	output 	[pMapIdWidth-1:0]			oInfoFieldId,			// Filed のマップチップID
	output 	[pMapIdWidth-1:0]			oInfoObjectId,			// Object のマップチップID
	output 	[pMapIdWidth-1:0]			oInfoField2Id,			// Filed2 のマップチップID
	output 	[pMapIdWidth-1:0]			oInfoForegroundId,		// Foreground のマップチップID
	//
	input	[7:0]				 		iInfoVpos,				// (DisplayVpos + UnitXpos + FiledXpos) / MapchipXSize の値
	// Clk rst
    input								iRst,
    input								iClk
);


//-----------------------------------------------------------------------------
// マップ情報格納 BRAM の確保・初期化
// レイヤーで分類すると
// Field, Object, Field2, Foreground の 4種類が使用される。
// 各レイヤーに使用されるマップチップID の Bit幅は 8bit で、
// 4種類 x 8bit = 32bit幅の MapInfo として格納される。
// 
// [ 7: 0] Field
// [15: 8] Object
// [23:16] Filed2
// [31:24] Foreground
// 
// BRAM の更新タイミングは下記のように 1Line の端のデータ生成が終了したら
// 親モジュールに更新割り込みを発行する。(16x16 だったら 16Line の端)
// Pixelデータは高速な内部 Sync のタイミングで生成するので、
// このタイミングでも十分間に合う。(外部 Sync には Blank期間もあるので)
// ・・・
// ・・・
// ・・・ <- 最終ラインの描画範囲内が終了したら、次の LineMapInfo に更新する。
//-----------------------------------------------------------------------------
(* ram_style = "block" *) reg [pMapInfoWidth-1:0] rMapInfoFifo [0:pMapSizeWidth];


//-----------------------------------------------------------------------------
// MapInfo R/W
//-----------------------------------------------------------------------------
reg [pMapInfoWidth-1:0]		rMapInfo;
reg [15:0] 					qInfoRAdrs;

always @(posedge iClk)
begin
	if (iInfoWCke)	rMapInfoFifo[iInfoWAdrs] <= iInfoWd;

	rMapInfo <= rMapInfoFifo[iInfoVpos];
end

assign oInfoFieldId			= rMapInfo[ 7: 0];
assign oInfoObjectId		= rMapInfo[15: 8];
assign oInfoField2Id		= rMapInfo[23:16];
assign oInfoForegroundId	= rMapInfo[31:24];

endmodule