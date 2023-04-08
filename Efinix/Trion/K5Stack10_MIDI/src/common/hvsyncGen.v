/*
 * Create 2022/03/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Board  My Board Spartan7
 * -
 * HSync VSync 生成モジュール
 */
module hVSyncGen 
#(
    parameter       pHdisplay       = 640,   // horizontal display width
    parameter       pHback          =  48,   // horizontal left border (back porch)
    parameter       pHfront         =  16,   // horizontal right border (front porch)
    parameter       pHpulse          =  96,   // horizontal sync width
    parameter       pVdisplay       = 480,   // vertical display height
    parameter       pVfront           =  31,   // vertical top border
    parameter       pVback        =  11,   // vertical bottom border
    parameter       pVpulse          =   2    // vertical sync # lines
)(
    input           iCLK,               // clk
    input           iRST,               // system rst
    output          oHSync,             // horizontal area 水平同期信号
    output          oVSync,             // vertical area 垂直同期信号
    output          oVde,               // video data enable 描画エリア時High
    output          oFvde,              // fast video enable oVDEより1clk早くHigh
    output          oFe                 // frame end
);

// declarations for TV-simulator sync parameters
// horizontal constants
// derived constants
localparam lpHpulsestart     = pHdisplay + pHfront;
localparam lpHpulseend       = pHdisplay + pHfront + pHpulse  - 1;
localparam lpHmax           = pHdisplay + pHback  + pHfront + pHpulse - 1;
localparam lpVpulsestart     = pVdisplay + pVback;
localparam lpVpulseend       = pVdisplay + pVback + pVpulse   - 1;
localparam lpVmax           = pVdisplay + pVfront    + pVback + pVpulse - 1;
localparam lpHdisplay       = pHdisplay;
localparam lpVdisplay       = pVdisplay;
localparam lpHbitWidth      = fBitWidth(pHdisplay);
localparam lpVbitWidth      = fBitWidth(pVdisplay);

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 水平同期カウンター、信号動作
//----------------------------------------------------------
reg rHSync[0:1];             assign oHSync = rHSync[1];
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
    if (iRST)           {rHSync[1], rHSync[0]} <= 2'b00;
    else                {rHSync[1], rHSync[0]} <= {rHSync[0], qHrange};
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
reg rVSync[0:1];                assign oVSync   = rVSync[1];
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
    if (iRST)           {rVSync[1], rVSync[0]} <= 2'b00;
    else                {rVSync[1], rVSync[0]} <= {rVSync[0], qVrange};
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
    qVrange <= (lpVpulsestart <= rVpos) && (rVpos <= lpVpulseend);
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