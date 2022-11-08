//----------------------------------------------------------
// Create 2022/11/03
// Author koutakimura
// -
// Field,Object,Field2,マップ情報を管理する Wrapper Module
// 
//----------------------------------------------------------
module DrawMapIdInfo #(
	// Display Size
    parameter       					pHdisplayWidth	= 11,
    parameter       					pVdisplayWidth	= 11,
	// Map Info Status
	parameter 							pMapSizeWidth 	= 250,	// マップの最大横幅、ワールドマップ基準
	parameter 							pMapIdWidth		= 8,	// 最大 256個のマップチップ使用可能
	parameter 							pMapInfoNumber	= 4		// マップ情報の数
)(
	// Internal Port
	input	[pMapInfoBitWidth-1:0]		iInfoWd,					// MapInfo Write Data
	input	[15:0]						iInfoWAdrs,					// MapInfo Write Adrs, BRAM が 36KB のため 16bit幅
	input 								iInfoWCke,					// MapInfo Write Enable
	//
	output 	[pMapInfoBitWidth-1:0]		oMapInfo,
	//
	input	[pHdisplayWidth-1:4] 		iInfoHposBs;
	input	[pVdisplayWidth-1:4] 		iInfoVposBs;
	// Clk rst
    input								iRst,
    input								iClk
);


//-----------------------------------------------------------------------------
// マップ情報格納 BRAM の確保・初期化
//-----------------------------------------------------------------------------
(* ram_style = "block" *) reg [pMapIdWidth-1:0] rMapInfoFifo [0:(pMapSizeWidth * pMapInfoNumber) - 1];


//-----------------------------------------------------------------------------
// MapInfo R/W
// 基本ステータス 
//-----------------------------------------------------------------------------
reg [15:0] 					rMapInfoWAdrs;
reg [pMapInfoBitWidth-1:0]	rMapInfoRd;

always @(posedge iClk)
begin
	// TODO info処理追加
	if (i)
end

endmodule