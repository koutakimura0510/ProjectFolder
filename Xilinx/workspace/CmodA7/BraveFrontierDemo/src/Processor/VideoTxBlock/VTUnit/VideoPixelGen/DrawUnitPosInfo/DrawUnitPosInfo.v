//----------------------------------------------------------
// Create 2022/11/18
// Author koutakimura
// -
// キャラクターの座標位置を算出する Module
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