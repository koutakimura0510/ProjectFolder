module HVSYNC_GEN (
    CLK, RESET, VGA_HS, VGA_VS, display_on, hpos, vpos
);

input CLK, RESET;
output reg VGA_HS, VGA_VS;
output display_on;
output reg [9:0] hpos, vpos;


// declarations for TV-simulator sync parameters
// horizontal constants
parameter H_DISPLAY       = 640; // horizontal display width
parameter H_BACK          =  48; // horizontal left border (back porch)
parameter H_FRONT         =  16; // horizontal right border (front porch)
parameter H_SYNC          =  96; // horizontal sync width
// vertical constants
parameter V_DISPLAY       = 480; // vertical display height
parameter V_TOP           =  31; // vertical top border
parameter V_BOTTOM        =  11; // vertical bottom border
parameter V_SYNC          =   2; // vertical sync # lines
// derived constants
parameter H_SYNC_START    = H_DISPLAY + H_FRONT;
parameter H_SYNC_END      = H_DISPLAY + H_FRONT + H_SYNC - 1;
parameter H_MAX           = H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1;
parameter V_SYNC_START    = V_DISPLAY + V_BOTTOM;
parameter V_SYNC_END      = V_DISPLAY + V_BOTTOM + V_SYNC - 1;
parameter V_MAX           = V_DISPLAY + V_TOP + V_BOTTOM + V_SYNC - 1;

wire hmax, vmax;

assign hmax = (hpos == H_MAX && RESET == 1'b0) ? 1'b1 : 1'b0;
assign vmax = (vpos == V_MAX && RESET == 1'b0) ? 1'b1 : 1'b0;

/*
 * 水平同期カウンター
 */
always @(posedge CLK) begin
    VGA_HS <= (hpos >= H_SYNC_START && hpos <= H_SYNC_END) ? 1'b1 : 1'b0;
    if (RESET == 1'b1) begin
        hpos <= 0;
    end else if (hmax == 1'b1) begin
        hpos <= 0;
    end else begin
        hpos <= hpos + 1;
    end
end

/*
 * 垂直同期カウンター
 */
always @(posedge CLK) begin
    VGA_VS <= (vpos >= V_SYNC_START && vpos <= V_SYNC_END) ? 1'b1 : 1'b0;
    if (RESET == 1'b1) begin
        vpos <= 0;
    end else if (hmax == 1'b1) begin
        if (vmax == 1'b1) begin
            vpos <= 0;
        end else begin
            vpos <= vpos + 1;
        end
    end
end

/*
 * 有効領域のディスプレイON信号の生成
 */
assign display_on = (hpos < H_DISPLAY && vpos < V_DISPLAY) ? 1'b1 : 1'b0;

endmodule