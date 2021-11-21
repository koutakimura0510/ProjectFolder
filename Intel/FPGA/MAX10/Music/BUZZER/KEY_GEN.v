/**---------------------------------
 * スイッチのチャタリング除去回路
 *----------------------------------*/
module KEY_GEN(
	CLK, ENABLE_KEY, KEY,
	KEY_UP
);

input CLK, ENABLE_KEY, KEY;
output wire KEY_UP;

reg [1:0] META;
reg [2:0] SFT;
reg [1:0] EDGE;

wire CHATTA;

always @(posedge CLK) begin
	META <= {META[0], ~KEY};
end

always @(posedge CLK) begin
	if (ENABLE_KEY == 1'b1) begin
		SFT <= {SFT[1:0], META[1]};
	end
end

assign CHATTA = &SFT;

always @(posedge CLK) begin
	EDGE <= {EDGE[0], CHATTA};
end

assign KEY_UP = EDGE[0] & ~EDGE[1];

endmodule
