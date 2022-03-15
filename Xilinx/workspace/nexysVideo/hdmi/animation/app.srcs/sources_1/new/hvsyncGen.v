/*
 * Create 2021/12/22
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * HDMI Hsync Vsync 生成モジュール
 */
module hvsyncGen 
#(
    parameter H_DISPLAY       = 640, // horizontal display width
    parameter H_BACK          =  48, // horizontal left border (back porch)
    parameter H_FRONT         =  16, // horizontal right border (front porch)
    parameter H_SYNC          =  96, // horizontal sync width
    parameter V_DISPLAY       = 480, // vertical display height
    parameter V_TOP           =  31, // vertical top border
    parameter V_BOTTOM        =  11, // vertical bottom border
    parameter V_SYNC          =   2  // vertical sync # lines
)(
    input           iCLK,           // system clk
    input           iRST,           // system rst
    output          oHSYNC,         // horizontal area 水平同期信号
    output          oVSYNC,         // vertical area 垂直同期信号
    output          oVDE,           // video data enable 描画エリア時High
    output          oFVDE,          // fast video enable oVDEより1clk早くHigh
    output [9:0]    oHPOS,
    output [9:0]    oVPOS,
    output          oFE             // frame end
);

// declarations for TV-simulator sync parameters
// horizontal constants
// derived constants
localparam H_SYNC_START    = H_DISPLAY + H_FRONT;
localparam H_SYNC_END      = H_DISPLAY + H_FRONT + H_SYNC - 1;
localparam H_MAX           = H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1;
localparam V_SYNC_START    = V_DISPLAY + V_BOTTOM;
localparam V_SYNC_END      = V_DISPLAY + V_BOTTOM + V_SYNC - 1;
localparam V_MAX           = V_DISPLAY + V_TOP + V_BOTTOM + V_SYNC - 1;

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 水平同期カウンター、信号動作
//----------------------------------------------------------
reg [9:0] rHriz;        assign oHPOS    = rHriz;
reg rHsync;             assign oHSYNC   = rHsync;
reg qHmatch, qHrange;

always @(posedge iCLK)
begin
    if (iRST)         rHriz <= 0;
    else if (qHmatch) rHriz <= 0;
    else              rHriz <= rHriz + 1'b1;
end

always @(posedge iCLK) begin
    if (iRST)           rHsync <= 0;
    else if (qHrange)   rHsync <= 1'b1;
    else                rHsync <= 1'b0;
end

always @*
begin
    qHmatch <= (rHriz == H_MAX);
    qHrange <= (H_SYNC_START <= rHriz && rHriz <= H_SYNC_END);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 垂直同期カウンター、信号動作
//----------------------------------------------------------
reg [9:0] rVert;        assign oVPOS    = rVert;
reg oVsync;             assign oVSYNC   = oVsync;
reg qVmatch, qVrange;

always @(posedge iCLK) 
begin
    if (iRST)           rVert <= 0;
    else if (qHmatch)   rVert <= (qVmatch) ? 0 : rVert + 1;
    else                rVert <= rVert;
end

always @(posedge iCLK) 
begin
    if (iRST)           oVsync <= 0;
    else if (qVrange)   oVsync <= 1'b1;
    else                oVsync <= 1'b0;
end

always @*
begin
    qVmatch <= (rVert == V_MAX);
    qVrange <= (V_SYNC_START <= rVert && rVert <= V_SYNC_END);
end

assign oVDE  = (rHriz < H_DISPLAY && rVert < V_DISPLAY) ? 1'b1 : 1'b0;

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// fast video timing
// 独自に作成した Dual Clk FIFO の性能上、Enable信号を入力してから最速で3CLK経過後データが出力されるため、
// 3clk + 1clk 有効領域よりも早く DE信号を作成する
//----------------------------------------------------------
reg [9:0] rFHriz, rFVert;     assign oFVDE = (rFHriz < H_DISPLAY && rFVert < V_DISPLAY) ? 1'b1 : 1'b0;
reg qFHmatch, qFVmatch;

always @(posedge iCLK) begin
    if (iRST)           rFHriz <= 3;
    else if (qFHmatch)  rFHriz <= 0;
    else                rFHriz <= rFHriz + 1'b1;
end

always @(posedge iCLK) begin
    if (iRST)           rFVert <= 0;
    else if (qFHmatch)  rFVert <= (qFVmatch) ? 0 : rFVert + 1;
    else                rFVert <= rFVert;
end

always @*
begin
    qFHmatch <= (rFHriz == H_MAX);
    qFVmatch <= (rFVert == V_MAX);
end

assign oFE = qFVmatch & qFHmatch;

endmodule