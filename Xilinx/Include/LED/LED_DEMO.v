module LED_DEMO (
	input CLK, RESET, ENABLE,
	output reg [9:0] LEDR
);

always @(posedge CLK) begin
	 if (RESET == 1'b1) begin
		 LEDR <= 10'b0;
	 end else if (ENABLE == 1'b1) begin
		 LEDR[0] <= ~LEDR[0];
	 end
end
endmodule 
