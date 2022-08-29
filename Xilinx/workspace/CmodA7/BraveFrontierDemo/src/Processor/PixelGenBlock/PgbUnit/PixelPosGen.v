//----------------------------------------------------------
// Create 2022/8/29
// Author koutakimura
// -
// システムクロックで内部でのみ使用するピクセル座標データを生成
// 内部のみで使用するため Blank期間は必要ない。
// 
//----------------------------------------------------------
module PixelPosGen
#(
    parameter                   	pHdisplayWidth  = 11,
    parameter                   	pVdisplayWidth  = 11
)(
	input	[pHdisplayWidth-1:0]	iHdisplay,
	input	[pVdisplayWidth-1:0]	iVdisplay,
    output 	[pHdisplayWidth-1:0]	oHpos,
    output 	[pVdisplayWidth-1:0]	oVpos,
    output                      	oFrameEnd,
    // CLK Reset
    input                       	iCke,
    input           				iSysClk,
    input           				iSysRst
);


//----------------------------------------------------------
// 水平同期カウンター
//----------------------------------------------------------
reg [pHdisplayWidth-1:0] rHpos;           assign oHpos = rHpos;
reg qHposMuxSel;

always @(posedge iSysClk) 
begin 
    if (iSysRst)		rHpos <= {pHdisplayWidth{1'b0}};
    else if (iCke)		rHpos <= qHposMuxSel ? {pHdisplayWidth{1'b0}} : rHpos + 1'b1;
    else            	rHpos <= rHpos;
end

always @*
begin
    qHposMuxSel <= (rHpos == (iHdisplay - 1'b1));
end


//----------------------------------------------------------
// 垂直同期カウンター
//----------------------------------------------------------
reg [pVdisplayWidth-1:0] rVpos;           assign oVpos = rVpos;
reg qVposMuxSel;

always @(posedge iSysClk) 
begin
    if (iSysRst)    	rVpos <= {pVdisplayWidth{1'b0}};
    else if (iCke)		rVpos <= qVposMuxSel ? {pVdisplayWidth{1'b0}} : rVpos + qHposMuxSel;
    else                rVpos <= rVpos;
end

always @*
begin
    qVposMuxSel <= (rVpos == (iVdisplay - 1'b1));
end


//----------------------------------------------------------
// Frame End
//----------------------------------------------------------
reg rFrameEnd;                   assign oFrameEnd = rFrameEnd;
reg qFe;

always @(posedge iSysClk) 
begin
    if (iSysRst) 		rFrameEnd <= 1'b0;
    else      			rFrameEnd <= qFe;
end

always @*
begin
    qFe	<= qVposMuxSel & qHposMuxSel;
end
endmodule