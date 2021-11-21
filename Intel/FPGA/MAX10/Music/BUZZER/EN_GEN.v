/**-------------------------------------------------
 * SYSTEMCLK 50Mhz
 * -------------------------------------------------*/
module EN_GEN(
    CLK, RESET,
    ENABLE, ENABLE_KEY, ENABLE_BCK
);

input CLK, RESET;
output ENABLE, ENABLE_KEY, ENABLE_BCK;

parameter SYSTEM_CLK = 50000000;	// 50MHz cycle
parameter TYATA_CLK  = 250000;   // 5ms
parameter BCK_CLK    = 2;
reg [25:0] tmp_count;


/**-------------------------------------------------
 * CLK Counter
 * -------------------------------------------------*/
always @ (posedge CLK) begin
	if (RESET == 1'b1)
		tmp_count <= 26'b0;
	else if (ENABLE == 1'b1)
		tmp_count <= 26'b0;
	else
		tmp_count <= tmp_count + 26'b1;
end


/**-------------------------------------------------
 * ENABLE OutPut
 * -------------------------------------------------*/
assign ENABLE     = (tmp_count == (SYSTEM_CLK - 1)) ? 1'b1 : 1'b0;
assign ENABLE_KEY = (tmp_count[17:0] == (TYATA_CLK - 1)) ? 1'b1 : 1'b0;
assign ENABLE_BCK = (tmp_count[1:0] == (BCK_CLK - 1)) ? 1'b1 : 1'b0;

endmodule