//----------------------------------------------------------
// Create 2022/8/29
// Author koutakimura
// -
// 指定範囲で座標データを生成する
// 
//----------------------------------------------------------
module PixelDrawPosition #(
	// Display Size
    parameter       							pHdisplayWidth	= 11,
    parameter       							pVdisplayWidth	= 11,
	// MapChip
	parameter									pMapChipBasicBs	= 4
)(
	input	[pHdisplayWidth-1:0]				iHdisplay,
	input	[pVdisplayWidth-1:0]				iVdisplay,
    output 	[pHdisplayWidth-1:0]				oHpos,
    output 	[pVdisplayWidth-1:0]				oVpos,
	output	[pHdisplayWidth-1:pMapChipBasicBs]	oHposBs,	// Bit Shift Map Info Read 座標計算のため必要な座標データ
	output	[pVdisplayWidth-1:pMapChipBasicBs]	oVposBs,	// 
    output                      				oAFE,		// Active Frame End
    // CLK Reset
    input           							iRST,
    input                       				iCke,
    input           							iCLK
);


//----------------------------------------------------------
// 水平同期カウンター
//----------------------------------------------------------
reg [pHdisplayWidth-1:0] rHpos;			assign oHpos   = rHpos;
										assign oHposBs = rHpos[pHdisplayWidth-1:pMapChipBasicBs];	// mapchip のサイズによる。今回は縦横 16
reg [pHdisplayWidth-1:0] qHposMux;
reg qHposMuxSel;

always @(posedge iCLK)
begin 
    if (iRST)		rHpos <= {pHdisplayWidth{1'b0}};
    else if (iCke)	rHpos <= qHposMux;
    else			rHpos <= rHpos;
end

always @*
begin
    qHposMuxSel <= (rHpos == iHdisplay);
	qHposMux	<= qHposMuxSel ? {pHdisplayWidth{1'b0}} : rHpos + 1'b1;
end


//----------------------------------------------------------
// 垂直同期カウンター
//----------------------------------------------------------
reg [pVdisplayWidth-1:0] rVpos;         assign oVpos   = rVpos;
										assign oVposBs = rVpos[pVdisplayWidth-1:pMapChipBasicBs];
reg [pVdisplayWidth-1:0] qVposMux;
reg qVposMuxSel;

always @(posedge iCLK) 
begin
    if (iRST)    	rVpos <= {pVdisplayWidth{1'b0}};
    else if (iCke)	rVpos <= qVposMux;
    else			rVpos <= rVpos;
end

always @*
begin
    qVposMuxSel <= (rVpos == iVdisplay) & qHposMuxSel;
	qVposMux	<= qVposMuxSel ? {pVdisplayWidth{1'b0}} : rVpos + qHposMuxSel;
end


//----------------------------------------------------------
// Active Frame End
//----------------------------------------------------------
reg rAFE;                   assign oAFE = rAFE;
reg qAFE;
//
wire [pVdisplayWidth-1:0]	wHFast = iHdisplay - 2'd2;

always @(posedge iCLK) 
begin
    if (iRST) 		rAFE <= 1'b0;
	else if (iCke)	rAFE <= qAFE;
    else			rAFE <= 1'b0;
end

always @*
begin
    qAFE <= (rVpos == iVdisplay) & (rHpos == wHFast);	// 2pixel 速く frameEnd
end
endmodule