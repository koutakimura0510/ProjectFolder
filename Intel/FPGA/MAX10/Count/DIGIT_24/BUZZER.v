module BUZZER(
	input CLK, ENABLE,
	input [1:0] KEY,
	output reg GPIO
);

reg [4:0] state;

always @(posedge CLK) begin
	if (ENABLE == 1'b1 && (KEY[0] == 1'b0 || KEY[1] == 1'b0))
		begin
		if (state == 5'b11111)
			begin
				GPIO <= 1'b0;
			end
		else
			begin
				GPIO <= ~GPIO;
				state <= state + 5'b1;
			end
		end
	else if (KEY[0] == 1'b1 && KEY[1] == 1'b1)
		begin
			state <= 5'b0;
		end
end

endmodule