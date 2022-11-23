module Top (
	input 			iClk,
	output 	[7:0]	oLed
);

reg [7:0] rLed = 8'd0;

always @(posedge iClk)
begin
	rLed <= rLed + 1'b1;
end

assign oLed = rLed;

endmodule