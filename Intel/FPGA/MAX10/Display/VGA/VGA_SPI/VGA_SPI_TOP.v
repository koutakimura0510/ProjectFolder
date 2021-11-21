/*
 * VGA
 *
 * DOTCLKは25MHzで動作
 */

module VGA_SPI_TOP (
    input CLK, RESET,
    output [3:0]  VGA_R, VGA_G, VGA_B,
	output        VGA_HS, VGA_VS,
	inout  [15:0] ARDUINO_IO
);

reg clk_gen = 1'b0;
wire display_on;
wire [9:0] hpos;
wire [9:0] vpos;


//* SPI通信
wire SCLK, SENABLE, MOSI;
wire [7:0] SDATA;


//* 同期カウンタのため、メタ・ステーブル対策を行う
FF mosi_ff  (CLK, ARDUINO_IO[2], MOSI);
FF cs_ff    (CLK, ARDUINO_IO[1], SENABLE);
FF sclk_ff  (CLK, ARDUINO_IO[0], SCLK);


//* SPIデータの取得
SPI SPI_GET_DATA (
	.CLK(CLK),
	.RESET(RESET),
	.SCLK(SCLK),
	.SENABLE(SENABLE),
	.MOSI(MOSI),
	.SDATA(SDATA)
);


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


assign VGA_R = (display_on == 1'b1) ? SDATA[7:4] : 0;
assign VGA_G = 0;
assign VGA_B = (display_on == 1'b1) ? 4'b1111 : 0;

/*
 * 25MHzクロックの生成
 */
always @(posedge CLK) begin
	clk_gen <= ~clk_gen;
end

endmodule