/**-------------------------------------------------
 * PLL回路デモ動作
 * 125MHzの入力CLKを2倍の250MHzで動作させる
 *
 * 2021/3/20 Author Kimura
 *
 * Vivado 20.2
 * Ubuntu LTS 20.04
 * Board ArtyZ7-20
 * -------------------------------------------------*/
module clk_demo (
	input CLK, RESET,
	output reg LED1
);

/* 125Mhz */
parameter SYSTEM_CLK = 125000000;

reg out_p, out_n;
reg [26:0] tmpcount;

wire CLK_250Mhz;
wire ENABLE;

assign CLK_250Mhz = out_p ^ out_n;
assign ENABLE = (tmpcount == (SYSTEM_CLK - 1)) ? 1'b1: 1'b0;

always @(posedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		tmpcount <= 27'b0;
	end else if (ENABLE == 1'b1) begin
		tmpcount <= 27'b0;
		LED1 <= ~LED1;
	end else begin
		tmpcount <= tmpcount + 27'b1;
	end
end

always @(posedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		out_p <= 1'b0;
	end else begin
		out_p <= ~out_p;
	end
end

always @(negedge CLK, negedge RESET) begin
	if (RESET == 1'b0) begin
		out_n <= 1'b0;
	end else begin
		out_n <= ~out_n;
	end
end

endmodule