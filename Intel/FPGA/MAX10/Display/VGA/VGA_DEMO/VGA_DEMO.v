/*
 * VGA 640x480 デモ動作
 * DOTCLKは25MHzで動作
 */

module VGA_DEMO (
    input CLK, RESET,
    output [9:0]  LEDR,
    output [3:0]  VGA_R, VGA_G, VGA_B,
	output        VGA_HS, VGA_VS,
	inout  [15:0] ARDUINO_IO
);

reg clk_gen = 1'b0;
wire ENABLE;
wire display_on;
wire [9:0] hpos;
wire [9:0] vpos;


/*
 * VGA信号の生成
 */
HVSYNC_GEN SYNC_GEN (
    .CLK(clk_gen),
    .RESET(RESET),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .display_on(display_on),
    .hpos(hpos),
    .vpos(vpos)
);

/*
 * 動作確認のため1秒間隔でLEDを点滅
 */
EN_GEN 	EN (CLK, RESET, ENABLE);
LED_DEMO LED (CLK, RESET, ENABLE, LEDR);

assign VGA_R = (display_on == 1'b1) && (((hpos & 4'b1111) == 0) || ((vpos & 4'b1111) == 0));
assign VGA_G = display_on & vpos[5];
assign VGA_B = display_on & hpos[5];

/*
 * 25MHzクロックの生成
 */
always @(posedge CLK) begin
	clk_gen <= ~clk_gen;
end

endmodule