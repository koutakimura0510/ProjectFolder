/**-------------------------------------------------
 * SYSTEMCLK 50Mhz
 * -------------------------------------------------*/
module ENABLE_GENERATE(CLK, ENABLE, RESET, EN_BLINK, ENABLE_khz, ENABLE_BUZZ);

input CLK, RESET;
output ENABLE, EN_BLINK, ENABLE_khz, ENABLE_BUZZ;

parameter SYSTEM_CLK = 50000000;	// 50MHz cycle
parameter TYATA_CLK  = 250000;
parameter BUZZ_CLK   = 113636;
reg [25:0] tmp_count;


/**-------------------------------------------------
 * CLK Counter
 * -------------------------------------------------*/
always @ (posedge CLK)
begin
	if (RESET == 1'b1) 
		tmp_count <= 26'b0;
	else if (ENABLE == 1'b1)
		tmp_count <= 26'b0;
	else
		tmp_count <= tmp_count + 26'b1;
end


/**-------------------------------------------------
 * selector
 * -------------------------------------------------*/
assign ENABLE      = (tmp_count == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;
assign ENABLE_khz  = (tmp_count[17:0] == (TYATA_CLK - 1)) ? 1'b1 : 1'b0;
assign EN_BLINK    = (tmp_count >= ((SYSTEM_CLK / 2) - 1)) ? 1'b0 : 1'b1;
assign ENABLE_BUZZ = (tmp_count[16:0] == (BUZZ_CLK - 1)) ? 1'b1 : 1'b0; 

endmodule