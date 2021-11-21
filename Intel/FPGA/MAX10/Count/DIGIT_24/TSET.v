module TSET(CLK, RESET, KEY, MAIN, current_state);
input CLK, RESET, KEY;
input MAIN;
output [6:0] current_state;

parameter	IDOL   = 7'b0000001;
parameter   CNT3T  = 7'b0000010;
parameter   CNT10T = 7'b0000100;
parameter   CNT6M  = 7'b0001000;
parameter   CNT10M = 7'b0010000;
parameter   CNT6   = 7'b0100000;
parameter   CNT10  = 7'b1000000;

reg [6:0] next_state, current_state;

always @(current_state or MAIN or KEY)
	if(MAIN)
		case(current_state)
			IDOL :
				if(KEY == 1'b1)
					next_state <= CNT3T;
        	   else
					next_state <= IDOL;
					
			CNT3T :
				if(KEY == 1'b1)
					next_state <= CNT10T;
				else
					next_state <= CNT3T;
					
			CNT10T :
				if(KEY == 1'b1)
					next_state <= CNT6M;
				else
					next_state <= CNT10T;
					
			CNT6M :
				if(KEY == 1'b1)
					next_state <= CNT10M;
				else
					next_state <= CNT6M;
					
			CNT10M :
				if(KEY == 1'b1)
					next_state <= CNT6;
				else
					next_state <= CNT10M;
					
			CNT6 : 
				if(KEY == 1'b1)
					next_state <= CNT10;
				else
					next_state <= CNT6;
					
			CNT10 :
				if(KEY == 1'b1)
					next_state <= IDOL;
				else
					next_state <= CNT10;
					
         default : 
				next_state <= IDOL;
		endcase
	else
		next_state <= IDOL;
       
always @(posedge CLK)
	if (RESET == 1'b1)
		current_state <= IDOL;
	else
		current_state <= next_state;

endmodule
