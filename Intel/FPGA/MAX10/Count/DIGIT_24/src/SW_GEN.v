/**---------------------------------
 * 40hz get_sw
 *----------------------------------*/
module SW_GEN(CLK, ENABLE, KEY, EDGE);

input CLK, ENABLE, KEY;
output EDGE;

reg [1:0] meta;
reg [2:0] sft;
reg [1:0] edg;

wire chatta, EDGE;

always @(posedge CLK)
	meta <= {meta[0], ~KEY};
	
always @(posedge CLK)
	if (ENABLE == 1'b1)
		sft <= {sft[1:0], meta[1]};
		
assign chatta = &sft;

always @(posedge CLK)
	edg <= {edg[0], chatta};
	
assign EDGE = edg[0] & ~edg[1];

endmodule
