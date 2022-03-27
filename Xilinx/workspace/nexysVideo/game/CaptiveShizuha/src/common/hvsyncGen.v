/*
 * Create 2022/03/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
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
    input           iSCLK,               // sync clk
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
localparam lpHsyncstart    = pHdisplay + pHfront;
localparam lpHsyncend      = pHdisplay + pHfront + pHsync  - 1;
localparam lpHmax          = pHdisplay + pHback  + pHfront + pHsync - 1;
localparam lpVsyncstart    = pVdisplay + pVbottom;
localparam lpVsyncend      = pVdisplay + pVbottom + pVsync   - 1;
localparam lpVmax          = pVdisplay + pVtop    + pVbottom + pVsync - 1;

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 水平同期カウンター、信号動作
//----------------------------------------------------------
reg rHsync;             assign oHsync = rHsync;
reg [9:0] rHpos;
reg qHmatch, qHrange;

always @(posedge iSCLK) 
begin 
    if (iRST)           rHpos <= 0;
    else if (qHmatch)   rHpos <= 0;
    else                rHpos <= rHpos + 1'b1;
end

always @(posedge iSCLK) 
begin 
    if (iRST)           rHsync <= 0;
    else                rHsync <= qHrange;
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
reg rVsync;                     assign oVsync   = rVsync;
reg qVde;                       assign oVde     = qVde;
reg qFe;                        assign oFe      = qFe;
reg [9:0] rVpos;
reg qVmatch, qVrange;

always @(posedge iSCLK) 
begin
    if (iRST)           rVpos <= 0;
    else if (qHmatch)   rVpos <= (qVmatch) ? 0 : rVpos + 1;
    else                rVpos <= rVpos;
end

always @(posedge iSCLK) 
begin
    if (iRST)           rVsync <= 1'b0;
    else                rVsync <= qVrange;
end

always @*
begin
    qVmatch <= (rVpos == lpVmax);
    qVrange <= (lpVsyncstart <= rVpos && rVpos <= lpVsyncend);
    qVde    <= (rHpos < lpHdisplay && rVpos < lpVdisplay);
    qFe     <= lpVdisplay < rVpos;
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// fast video timing
// 独自に作成した Dual Clk FIFO の性能上、Enable信号を入力してから最速で3CLK経過後データが出力されるため、
// 3clk + 1clk 有効領域よりも早く DE信号を作成する
//----------------------------------------------------------
reg qFvde;                      assign oFVDE = qFvde;
reg qFHmatch, qFVmatch;
reg [9:0] rFHriz, rFVert;

always @(posedge iSCLK) begin
    if (iRST)           rFHriz <= 4;
    else if (qFHmatch)  rFHriz <= 0;
    else                rFHriz <= rFHriz + 1'b1;
end

always @(posedge iSCLK) begin
    if (iRST)           rFVert <= 0;
    else if (qFHmatch)  rFVert <= (qFVmatch) ? 0 : rFVert + 1;
    else                rFVert <= rFVert;
end

always @*
begin
    qFHmatch <= (rFHriz == lpHmax);
    qFVmatch <= (rFVert == lpVmax);
    qFvde    <= (rFHriz < lpHdisplay && rFVert < lpVdisplay);
end

endmodule