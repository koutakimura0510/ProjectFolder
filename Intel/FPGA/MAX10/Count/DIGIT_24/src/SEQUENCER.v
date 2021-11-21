module SEQUENCER(CLK, RESET, KEY, current_state);

parameter CLOCK_SET = 3'b001,
			 CLOCK24   = 3'b010,
			 ALARM	  = 3'b100;

input CLK, RESET;
input [2:0] KEY;

output [2:0] current_state;
reg [2:0] next_state, current_state;

always @(current_state or KEY)
begin
	if (KEY == 3'b001)
		begin
			next_state <= CLOCK_SET;
		end
	else if (KEY == 3'b010)
		begin
			next_state <= ALARM;
		end
	else
		begin
			next_state <= CLOCK24;
		end
end

   
always @(posedge CLK)          
begin
	if (RESET == 1'b1)                      
		current_state <= CLOCK_SET;
	else
		current_state <= next_state;
end

endmodule            