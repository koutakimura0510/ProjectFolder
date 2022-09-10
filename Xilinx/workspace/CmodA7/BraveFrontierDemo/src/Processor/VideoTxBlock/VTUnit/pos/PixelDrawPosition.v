//----------------------------------------------------------
// Create 2022/8/29
// Author koutakimura
// -
// 指定範囲で座標データを生成する
// 
//----------------------------------------------------------
module PixelDrawPosition #(
	// Display Size
    parameter       				pHdisplayWidth	= 11,
    parameter       				pVdisplayWidth	= 11
)(
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
    output 	[pHdisplayWidth-1:0]	oHpos,
    output 	[pVdisplayWidth-1:0]	oVpos,
    output                      	oAFE,		// Active Frame End
    // CLK Reset
    input           				iRst,
    input                       	iCke,
    input           				iClk
);


//----------------------------------------------------------
// 水平同期カウンター
//----------------------------------------------------------
reg [pHdisplayWidth-1:0] rHpos;           assign oHpos = rHpos;
reg [pHdisplayWidth-1:0] qHposMux;
reg qHposMuxSel;

always @(posedge iClk)
begin 
    if (iRst)		rHpos <= {pHdisplayWidth{1'b0}};
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
reg [pVdisplayWidth-1:0] rVpos;           assign oVpos = rVpos;
reg [pVdisplayWidth-1:0] qVposMux;
reg qVposMuxSel;

always @(posedge iClk) 
begin
    if (iRst)    	rVpos <= {pVdisplayWidth{1'b0}};
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

always @(posedge iClk) 
begin
    if (iRst) 	rAFE <= 1'b0;
    else		rAFE <= qAFE;
end

always @*
begin
    // qAFE <= (qVposMuxSel & qHposMuxSel);
    qAFE <= qVposMuxSel;
end
endmodule