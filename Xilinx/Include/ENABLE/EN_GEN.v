/**-------------------------------------------------
 * SYSTEMCLK 50Mhz
 * -------------------------------------------------*/
module EN_GEN(CLK, RESET, ENABLE, ENABLE_khz);

input CLK, RESET;
output ENABLE, ENABLE_khz;

parameter SYSTEM_CLK = 50000000;	// 50MHz cycle
parameter TYATA_CLK  = 250000;
reg [25:0] tmp_count;

always @ (posedge CLK)
begin
	if (RESET == 1'b1) 
		tmp_count <= 26'b0;
	else if (ENABLE == 1'b1)
		tmp_count <= 26'b0;
	else
		tmp_count <= tmp_count + 26'b1;
end

assign ENABLE      = (tmp_count == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;		 // 1s  ENABLE
assign ENABLE_khz  = (tmp_count[17:0] == (TYATA_CLK - 1)) ? 1'b1 : 1'b0; // 5ms ENABLE

endmodule
