/*
 * Create 2022/03/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * Hsync Vsync 生成モジュール
 */
module hvsyncGen 
#(
    parameter       pHdisplay       = 640,   // horizontal display width
    parameter       pHback          =  48,   // horizontal left border (back porch)
    parameter       pHfront         =  16,   // horizontal right border (front porch)
    parameter       pHsync          =  96,   // horizontal sync width
    parameter       pVdisplay       = 480,   // vertical display height
    parameter       pVtop           =  31,   // vertical top border
    parameter       pVbottom        =  11,   // vertical bottom border
    parameter       pVsync          =   2    // vertical sync # lines
)(
    input           iCLK,               // clk
    input           iRST,               // system rst
    output          oHsync,             // horizontal area 水平同期信号
    output          oVsync,             // vertical area 垂直同期信号
    output          oVde,               // video data enable 描画エリア時High
    output          oFvde,              // fast video enable oVDEより1clk早くHigh
    output          oFe                 // frame end
);

// declarations for TV-simulator sync parameters
// horizontal constants
// derived constants
localparam lpHsyncstart     = pHdisplay + pHfront;
localparam lpHsyncend       = pHdisplay + pHfront + pHsync  - 1;
localparam lpHmax           = pHdisplay + pHback  + pHfront + pHsync - 1;
localparam lpVsyncstart     = pVdisplay + pVbottom;
localparam lpVsyncend       = pVdisplay + pVbottom + pVsync   - 1;
localparam lpVmax           = pVdisplay + pVtop    + pVbottom + pVsync - 1;
localparam lpHdisplay       = pHdisplay;
localparam lpVdisplay       = pVdisplay;
localparam lpHbitWidth      = fBitWidth(pHdisplay);
localparam lpVbitWidth      = fBitWidth(pVdisplay);

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 水平同期カウンター、信号動作
//----------------------------------------------------------
reg rHsync[0:1];             assign oHsync = rHsync[1];
reg [lpHbitWidth:0] rHpos;
reg qHmatch, qHrange;

always @(posedge iCLK)
begin 
    if (iRST)           rHpos <= 0;
    else if (qHmatch)   rHpos <= 0;
    else                rHpos <= rHpos + 1'b1;
end

always @(posedge iCLK)
begin 
    if (iRST)           {rHsync[1], rHsync[0]} <= 2'b00;
    else                {rHsync[1], rHsync[0]} <= {rHsync[0], qHrange};
end

always @*
begin
    qHmatch <= (rHpos == lpHmax);
    qHrange <= (lpHsyncstart <= rHpos && rHpos <= lpHsyncend);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 垂直同期カウンター、信号動作
//----------------------------------------------------------
reg rVsync[0:1];                assign oVsync   = rVsync[1];
reg qVde, rVde;                 assign oVde     = rVde;
reg qFe, rFe;                   assign oFe      = rFe;
reg [lpVbitWidth:0] rVpos;
reg qVmatch, qVrange;

always @(posedge iCLK) 
begin
    if (iRST)           rVpos <= 0;
    else if (qHmatch)   rVpos <= (qVmatch) ? 0 : rVpos + 1;
    else                rVpos <= rVpos;
end

always @(posedge iCLK) 
begin
    if (iRST)           {rVsync[1], rVsync[0]} <= 2'b00;
    else                {rVsync[1], rVsync[0]} <= {rVsync[0], qVrange};
end

always @(posedge iCLK) 
begin
    if (iRST)           rVde <= 1'b0;
    else                rVde <= qVde;
end

always @(posedge iCLK) 
begin
    if (iRST)           rFe <= 1'b0;
    else                rFe <= qFe;
end

always @*
begin
    qVmatch <= rVpos == lpVmax;
    qVrange <= (lpVsyncstart <= rVpos) && (rVpos <= lpVsyncend);
    qVde    <= (rHpos  < lpHdisplay) && (rVpos  < lpVdisplay);
    qFe     <= (rHpos == lpHdisplay) && (rVpos == lpVdisplay);
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// fast video timing
// 独自に作成した Dual Clk FIFO の性能上、Enable信号を入力してから最速で3CLK経過後データが出力されるため、
// 2clk 有効領域よりも早く DE信号を作成する
//----------------------------------------------------------
reg qFvde, rFvde;                      assign oFvde = rFvde;
reg rFs;
reg qFHmatch, qFVmatch;
reg [lpHbitWidth:0] rFHriz, rFVert;

always @(posedge iCLK)
begin
    if (iRST)           rFHriz <= 2;
    else if (qFHmatch)  rFHriz <= 0;
    else                rFHriz <= rFHriz + 1'b1;
end

always @(posedge iCLK)
begin
    if (iRST)           rFVert <= 0;
    else if (qFHmatch)  rFVert <= (qFVmatch) ? 0 : rFVert + 1;
    else                rFVert <= rFVert;
end

always @(posedge iCLK)
begin
    if (iRST)           rFs <= 1'b0;
    else if (qFe)       rFs <= 1'b1;
    else                rFs <= rFs;
end

always @(posedge iCLK)
begin
    if (iRST)           rFvde <= 1'b0;
    else                rFvde <= qFvde;
end

always @*
begin
    qFHmatch <= (rFHriz == lpHmax);
    qFVmatch <= (rFVert == lpVmax);
    qFvde    <= rFs & (rFHriz < pHdisplay && rFVert < pVdisplay);
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