module DECODER(
	input RESET,
	input  [7:0] COUNT,
	output reg [9:0] LEDR
);

initial begin
	LEDR = 10'b0;
end

always @(COUNT) begin
	 if (RESET == 1'b1) begin
		 LEDR <= 10'b0;
	 end else begin
		 LEDR <= COUNT;
	 end
end
endmodule 