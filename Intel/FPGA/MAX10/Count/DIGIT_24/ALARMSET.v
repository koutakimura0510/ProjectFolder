module ALARMSET(CLK, RESET, KEY, MAIN, current_state);
input CLK, RESET, KEY;
input MAIN;
output [6:0] current_state;

parameter	ONOFF  = 7'b0000001,
				CNT3T  = 7'b0000010,
				CNT10T = 7'b0000100,
				CNT6M  = 7'b0001000,
				CNT10M = 7'b0010000,
				CNT6   = 7'b0100000,
				CNT10  = 7'b1000000;

reg [6:0] next_state, current_state;

always @(current_state or MAIN or KEY)
	if(MAIN)
		case(current_state)
			ONOFF :
				if(KEY == 1'b1)
					next_state <= CNT3T;
        	   else
					next_state <= ONOFF;
					
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
					next_state <= ONOFF;
				else
					next_state <= CNT10;
					
         default : 
				next_state <= ONOFF;
		endcase
	else
		next_state <= ONOFF;
       
always @(posedge CLK)
	if (RESET == 1'b1)
		current_state <= ONOFF;
	else
		current_state <= next_state;

endmodule