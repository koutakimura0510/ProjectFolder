//----------------------------------------------------------
// Create 2022/11/03
// Author koutakimura
// -
// マップ情報を管理する Wrapper Module
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
	//
	parameter							pMapInfoWidth 	= pMapIdWidth * pMapInfoNumber;
)(
	// Internal Port
	input	[pMapInfoWidth-1:0]			iInfoWd,					// MapInfo Write Data
	input	[15:0]						iInfoWAdrs,					// MapInfo Write Adrs, BRAM が 36KB のため 16bit幅
	input 								iInfoWCke,					// MapInfo Write Enable
	//
	output 	[pMapIdWidth-1:0]			oInfoField,
	output 	[pMapIdWidth-1:0]			oInfoObject,
	output 	[pMapIdWidth-1:0]			oInfoField2,
	output 	[pMapIdWidth-1:0]			oInfoForeground,
	//
	input	[pHdisplayWidth-1:4] 		iInfoHposBs,				// BitShift した状態の Hpos,Vpos
	input	[pVdisplayWidth-1:4] 		iInfoVposBs,				// 
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
//-----------------------------------------------------------------------------
(* ram_style = "block" *) reg [pMapInfoWidth-1:0] rMapInfoFifo [0:pMapSizeWidth];


//-----------------------------------------------------------------------------
// MapInfo R/W
//-----------------------------------------------------------------------------
reg [pMapInfoWidth-1:0]		rMapInfo;		assign {oInfoField, oInfoObject, oInfoField2, oInfoForeground} = rInfoField;
reg [15:0] 					qInfoRAdrs;

always @(posedge iClk)
begin
	if (iInfoWCke)	rMapInfoFifo[iInfoWAdrs] <= iInfoWd;

	rMapInfo <= rMapInfoFifo[wInfoRAdrs];
end

always @*
begin
	//adrs
end

endmodule