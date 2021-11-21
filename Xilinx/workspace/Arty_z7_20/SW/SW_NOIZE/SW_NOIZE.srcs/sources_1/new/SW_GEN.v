/*
 * スイッチのチャタリング除去回路
 */
module SW_GEN(CLK, ENABLE, KEY, EDGE);

input CLK, ENABLE, KEY;
output EDGE;

reg [1:0] meta;
reg [2:0] sft;
reg [1:0] edg;

wire chatta, EDGE;

always @(posedge CLK) begin
	meta <= {meta[0], KEY};
end

always @(posedge CLK) begin
	if (ENABLE == 1'b1) begin
		sft <= {sft[1:0], meta[1]};
	end
end

assign chatta = &sft;

always @(posedge CLK) begin
	edg <= {edg[0], chatta};
end

assign EDGE = edg[0] & ~edg[1];

endmodule
