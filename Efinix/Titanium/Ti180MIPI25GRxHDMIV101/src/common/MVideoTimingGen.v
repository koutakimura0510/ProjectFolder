/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MVideoTimingGen.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Copyright(c) 2011-2022, by Net-Vision Corp. All rights reserved.
 * (Note) For this source code, it is forbidden using and issuing
 *        without permission.
 * （注） このソース・コードの無断使用および無断持ち出しを禁止します．
 *
 * Revision    :
 * 31/Dec-2022 V1.00 New Release, Inh.fr. "MVideoTimingGen.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MVideoTimingGen
#(
	parameter				pHdisplay		= 640,   // horizontal display width
	parameter				pHback			= 48,   // horizontal left border (back porch)
	parameter				pHfront			= 16,   // horizontal right border (front porch)
	parameter				pHpulse			= 96,   // horizontal sync width
	parameter				pVdisplay		= 480,   // vertical display height
	parameter				pVfront			= 31,   // vertical top border
	parameter				pVback			= 11,   // vertical bottom border
	parameter				pVpulse			= 2,   // vertical sync # lines
	parameter				pPipeLine 		= 4,	// 最低1
	parameter				pFastVdTiming	= 2,	// 最低1
	parameter				pHbitWidth		= fBitWidth(pHdisplay),
	parameter				pVbitWidth		= fBitWidth(pVdisplay)
)(
	output					oHSync,			// horizontal area 水平同期信号
	output					oVSync,			// vertical area 垂直同期信号
	output					oVde,			// video data enable 描画エリア時High
	output					oFvde,			// fast video enable oVDEより1clk早くHigh
	output					oFe,			// frame end
	output [pHbitWidth:0]	oHpos,
	output [pVbitWidth:0]	oVpos,
	input					iClk,			// clk
	input					iRst			// system rst
);

// declarations for TV-simulator sync parameters
// horizontal constants
// derived constants
localparam lpHpulsestart 	= pHdisplay + pHfront;
localparam lpHpulseend 		= pHdisplay + pHfront + pHpulse  - 1;
localparam lpHmax			= pHdisplay + pHback  + pHfront + pHpulse - 1;
localparam lpVpulsestart	= pVdisplay + pVback;
localparam lpVpulseend 		= pVdisplay + pVback  + pVpulse   - 1;
localparam lpVmax			= pVdisplay + pVfront + pVback + pVpulse - 1;
localparam lpHdisplay		= pHdisplay;
localparam lpVdisplay		= pVdisplay;

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 水平同期カウンター、信号動作
//----------------------------------------------------------
reg [pPipeLine:0]		rHSync;		assign oHSync = rHSync[pPipeLine];
reg [pHbitWidth:0] 		rHpos;		assign oHpos  = rHpos;
reg [pHbitWidth:0] 		rFHpos;
reg qHmatch, qHrange;

always @(posedge iClk)
begin 
    if (iRst)           rHpos <= 0;
    else if (qHmatch)   rHpos <= 0;
    else                rHpos <= rHpos + 1'b1;

    if (iRst)           rHSync <= {(pPipeLine+1'b1){1'b0}};
    else                rHSync <= {rHSync[pPipeLine-1:0], qHrange};
end

always @*
begin
    qHmatch <= (rHpos == lpHmax);
    qHrange <= (lpHpulsestart <= rHpos && rHpos <= lpHpulseend);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 垂直同期カウンター、信号動作
//----------------------------------------------------------
reg [pPipeLine:0]		rVSync;				assign oVSync   = rVSync[pPipeLine];
reg 					qFe, rFe;			assign oFe      = rFe;
reg [pVbitWidth:0] 		rVpos;				assign oVpos 	= rVpos;
reg 					qVmatch, qVrange;

always @(posedge iClk) 
begin
    if (iRst)           rVpos <= 0;
    else if (qHmatch)   rVpos <= (qVmatch) ? 0 : rVpos + 1;
    else                rVpos <= rVpos;

    if (iRst)			rVSync <= {(pPipeLine+1'b1){1'b0}};
    else				rVSync <= {rVSync[pPipeLine-1:0], qVrange};

    if (iRst)           rFe <= 1'b0;
    else                rFe <= qFe;
end

always @*
begin
    qVmatch <= rVpos == lpVmax;
    qVrange <= (lpVpulsestart <= rVpos) && (rVpos <= lpVpulseend);
    qFe     <= (rHpos == lpHdisplay) && (rVpos == lpVdisplay);
end


//-----------------------------------------------------------------------------
// Data Enable
//-----------------------------------------------------------------------------
reg [pPipeLine:0] 		rVde;				assign oVde     = rVde[pPipeLine];
reg [pFastVdTiming:0]	rFvde;				assign oFvde	= rFvde[pFastVdTiming];
reg 					qVde;
always @(posedge iClk) 
begin
    if (iRst)           rVde <= {(pPipeLine+1'b1){1'b0}};
    else                rVde <= {rVde[pPipeLine-1:0], qVde};

    if (iRst)           rFvde <= {pFastVdTiming{1'b0}};
    else                rFvde <= {rFvde[pFastVdTiming-1:0], qVde};
end

always @*
begin
    qVde    <= (rHpos  < lpHdisplay) && (rVpos  < lpVdisplay);
end

////////////////////////////////////////////////////////////
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule