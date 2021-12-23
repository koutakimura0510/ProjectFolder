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
    output [9:0]    oHPOS,
    output [9:0]    oVPOS
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


// 信号出力
reg [9:0] hpos;         assign oHPOS    = hpos;
reg [9:0] vpos;         assign oVPOS    = vpos;
reg hsync;              assign oHSYNC   = hsync;
reg vsync;              assign oVSYNC   = vsync;
assign oVDE = (hpos < H_DISPLAY && vpos < V_DISPLAY) ? 1'b1 : 1'b0;


//----------------------------------------------------------
// 水平同期カウンター、信号動作
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        hpos <= 0;
    end else if (hpos == H_MAX) begin
        hpos <= 0;
    end else begin
        hpos <= hpos + 1'b1;
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        hsync <= 0;
    end else if (H_SYNC_START <= hpos && hpos <= H_SYNC_END) begin
        hsync <= 1'b1;
    end else begin
        hsync <= 1'b0;
    end
end


 //----------------------------------------------------------
 // 垂直同期カウンター、信号動作
 //----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        vpos <= 0;
    end else if (hpos == H_MAX) begin
        if (vpos == V_MAX) begin
            vpos <= 0;
        end else begin
            vpos <= vpos + 1;
        end
    end
end

always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        vsync <= 0;
    end else if (V_SYNC_START <= vpos && vpos <= V_SYNC_END) begin
        vsync <= 1'b1;
    end else begin
        vsync <= 1'b0;
    end
end

endmodule