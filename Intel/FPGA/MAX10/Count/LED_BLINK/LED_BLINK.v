module LED_BLINK(CLK, RESET, LEDR);

parameter SEC1_MAX = 50000000;	// 50Mhz

input CLK, RESET;
output reg [9:0] LEDR = 10'b0000000001;
reg [25:0] tmp_count;
wire ENABLE;

always @(posedge CLK)
begin
	if (RESET == 1'b1)
		tmp_count <= 26'h0;
	else if (ENABLE == 1'b1)
		tmp_count <= 26'h0;
	else
		tmp_count <= tmp_count + 26'h1;
end


/**---------------------------------------------------------
 * 1SEC Counter ENABLE
 *----------------------------------------------------------*/
assign ENABLE = (tmp_count == ((SEC1_MAX/2) - 1)) ? 1'b1 : 1'b0;


/**---------------------------------------------------------
 * 1SEC LED BLINK
 *----------------------------------------------------------*/
always @(posedge CLK)
begin
	if (RESET == 1'b1)
		LEDR <= 10'b0000000001;
	else if (ENABLE == 1'b1)
	begin
		if (LEDR == 10'b1000000000)
			LEDR <= 10'b1;
		else
			LEDR <= LEDR << 1;
	end
end


endmodule