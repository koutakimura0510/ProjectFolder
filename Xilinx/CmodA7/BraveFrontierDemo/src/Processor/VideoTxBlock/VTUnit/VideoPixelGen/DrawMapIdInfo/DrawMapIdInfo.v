//----------------------------------------------------------
// Create 2022/11/03
// Author koutakimura
// -
// マップID 情報の R/W を管理する Module
// 
//----------------------------------------------------------
module DrawMapIdInfo #(
	// Map Info Status
	parameter 							pMapSizeWidth 	= 250,	// マップの最大横幅、ワールドマップ基準
	parameter 							pMapIdWidth		= 8,	// 最大 256個のマップチップ使用可能
	parameter 							pMapInfoNumber	= 4		// マップ情報の数
	// not variable
	parameter							pMapInfoWidth 	= pMapIdWidth * pMapInfoNumber;
	parameter							pMapSizeBitWidth= fBitWidth(pMapSizeWidth);		// BRAM アクセスのアドレス幅はマップサイズによるので可変
)(
	// Internal Port
	input	[pMapInfoWidth-1:0]			iMapInfoWd,				// MapInfo Write Data
	input	[pMapSizeBitWidth-1:0]		iMapInfoWAdrs,			// MapInfo Write Adrs	
	input 								iMapInfoWCke,			// MapInfo Write Enable
	//
	input	[pMapSizeBitWidth-1:0]		iMapInfoRAdrs,			// (DisplayVpos + UnitXpos + FiledXpos) / MapchipXSize の値
	// iInfoPos の入力からレイテンシ1で出力
	output 	[pMapIdWidth-1:0]			oInfoFieldId,			// Filed のマップチップID
	output 	[pMapIdWidth-1:0]			oInfoObjectId,			// Object のマップチップID
	output 	[pMapIdWidth-1:0]			oInfoField2Id,			// Filed2 のマップチップID
	output 	[pMapIdWidth-1:0]			oInfoForegroundId,		// Foreground のマップチップID
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

always @(posedge iClk)
begin
	if (iMapInfoWCke)	rMapInfoFifo[iMapInfoWAdrs] <= iMapInfoWd;

	rMapInfo <= rMapInfoFifo[iMapInfoRAdrs];
end

assign oInfoFieldId			= rMapInfo[ 7: 0];
assign oInfoObjectId		= rMapInfo[15: 8];
assign oInfoField2Id		= rMapInfo[23:16];
assign oInfoForegroundId	= rMapInfo[31:24];


//-----------------------------------------------------------------------------
// パラメータ設定用の便利な関数
//-----------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction

endmodule