/**-------------------------------------------------
 * LEDデモ動作
 * -------------------------------------------------*/
module LED_FLASH(CLK, ENABLE, LEDR);

input CLK, ENABLE;
output reg [9:0] LEDR;
reg [99:0] flash;
reg [3:0] cnt;

initial begin
	flash[9:0]   = 10'b0000000001;
	flash[19:10] = 10'b0000000010;
	flash[29:20] = 10'b0000000100;
	flash[39:30] = 10'b0000001000;
	flash[49:40] = 10'b0000010000;
	flash[59:50] = 10'b0000100000;
	flash[69:60] = 10'b0001000000;
	flash[79:70] = 10'b0010000000;
	flash[89:80] = 10'b0100000000;
	flash[99:90] = 10'b1000000000;
end

always @(posedge CLK) begin
    if (ENABLE == 1'b1) begin
		if (cnt == 4'd10)
			cnt <= 4'b0;
		else
			cnt <= cnt + 4'b1;
	 end	
end


/**-------------------------------------------------
 * LED動作回路
 * -------------------------------------------------*/
always @(cnt) begin
	case (cnt)
		4'd0 : LEDR <= flash[9:0];
		4'd1 : LEDR <= flash[19:10];
		4'd2 : LEDR <= flash[29:20];
		4'd3 : LEDR <= flash[39:30];
		4'd4 : LEDR <= flash[49:40];
		4'd5 : LEDR <= flash[59:50];
		4'd6 : LEDR <= flash[69:60];
		4'd7 : LEDR <= flash[79:70];
		4'd8 : LEDR <= flash[89:80];
		4'd9 : LEDR <= flash[99:90];
		default : LEDR <= 10'b0;
	endcase
end

endmodule