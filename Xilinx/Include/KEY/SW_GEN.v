module SW_GEN(CLK, ENABLE, KEY, GET_KEY);

input CLK, ENABLE, KEY;
output GET_KEY;

reg [1:0] meta;
reg [2:0] sft;
reg [1:0] edge;

wire chatta, EDGE;

always @(posedge CLK)
	meta <= {meta[0], ~KEY};
	
always @(posedge CLK)
	if (ENABLE == 1'b1)
		sft <= {sft[1:0], meta[1]};
		
assign chatta = &sft;

always @(posedge CLK)
	edge <= {edge[0], chatta};
	
assign GET_KEY = edge[0] & ~edge[1];

endmodule
