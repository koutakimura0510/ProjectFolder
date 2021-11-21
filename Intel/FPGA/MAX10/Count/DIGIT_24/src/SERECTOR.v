module SERECTOR(CNT10, CNT10M, CNT6, CNT6M, CNT10T, CNT3T,
					 EN_BLINK, MAIN, TSET, SER_OUT,
					 AL_CNT10, AL_CNT10M, AL_CNT6, AL_CNT6M, AL_CNT10T, AL_CNT3T, onoff, ALARMSET);

input [3:0] CNT10, CNT10M, CNT6, CNT6M, CNT10T, CNT3T;
input [3:0] AL_CNT10, AL_CNT10M, AL_CNT6, AL_CNT6M, AL_CNT10T, AL_CNT3T;
input [6:0] TSET, ALARMSET;
input [2:0] MAIN;
input EN_BLINK, onoff;

output [23:0] SER_OUT;

reg [23:0] SER_OUT;
wire [3:0] CNT10, CNT10M, CNT6, CNT6M, CNT10T, CNT3T;
wire [3:0] AL_CNT10, AL_CNT10M, AL_CNT6, AL_CNT6M, AL_CNT10T, AL_CNT3T;


parameter	CLOCK_SET  = 3'b001,
				CLOCK24    = 3'b010,
				ALARM	  	  = 3'b100;

parameter	IDOL   	  = 7'b0000001,
				SER_CNT3T  = 7'b0000010,
				SER_CNT10T = 7'b0000100,
				SER_CNT6M  = 7'b0001000,
				SER_CNT10M = 7'b0010000,
				SER_CNT6   = 7'b0100000,
				SER_CNT10  = 7'b1000000;
				
parameter	ONOFF		  = 7'b0000001,
				SER_AL3T	  = 7'b0000010,
				SER_AL10T  = 7'b0000100,
				SER_AL6M	  = 7'b0001000,
				SER_AL10M  = 7'b0010000,
				SER_AL6	  = 7'b0100000,
				SER_AL10	  = 7'b1000000;
				
            
always @(CNT10 or CNT10M or CNT10T or CNT6 or CNT6M or CNT3T or
		   EN_BLINK or MAIN or TSET or
			AL_CNT10 or AL_CNT10M or AL_CNT10T or AL_CNT6 or AL_CNT6M or AL_CNT3T)
			
	case (MAIN)
		CLOCK_SET : 
			case(TSET)
				IDOL :
				begin
					SER_OUT[3:0]	<= CNT10  | {4{EN_BLINK}};
					SER_OUT[7:4]	<= CNT6	 | {4{EN_BLINK}};
					SER_OUT[11:8]	<= CNT10M | {4{EN_BLINK}};
					SER_OUT[15:12]	<= CNT6M  | {4{EN_BLINK}};
					SER_OUT[19:16]	<= CNT10T | {4{EN_BLINK}};
					SER_OUT[23:20]	<= CNT3T  | {4{EN_BLINK}};
				end
				
				SER_CNT3T :
				begin
					SER_OUT[3:0]	<= CNT10;
					SER_OUT[7:4]	<= CNT6;
					SER_OUT[11:8]	<= CNT10M;
					SER_OUT[15:12]	<= CNT6M;
					SER_OUT[19:16]	<= CNT10T;
					SER_OUT[23:20]	<= CNT3T  | {4{EN_BLINK}};
				end
		
				SER_CNT10T :
				begin
					SER_OUT[3:0]	<= CNT10;
					SER_OUT[7:4]	<= CNT6;
					SER_OUT[11:8]	<= CNT10M;
					SER_OUT[15:12]	<= CNT6M;
					SER_OUT[19:16]	<= CNT10T | {4{EN_BLINK}};
					SER_OUT[23:20]	<= CNT3T;
				end
		
				SER_CNT6M :
				begin
					SER_OUT[3:0]	<= CNT10;
					SER_OUT[7:4]	<= CNT6;
					SER_OUT[11:8]	<= CNT10M;
					SER_OUT[15:12]	<= CNT6M  | {4{EN_BLINK}};
					SER_OUT[19:16]	<= CNT10T;
					SER_OUT[23:20]	<= CNT3T;
				end
		
				SER_CNT10M :
				begin
					SER_OUT[3:0]	<= CNT10;
					SER_OUT[7:4]	<= CNT6;
					SER_OUT[11:8]	<= CNT10M | {4{EN_BLINK}};
					SER_OUT[15:12]	<= CNT6M;
					SER_OUT[19:16]	<= CNT10T;
					SER_OUT[23:20]	<= CNT3T;
				end
				
				SER_CNT6 :
				begin
					SER_OUT[3:0]	<= CNT10;
					SER_OUT[7:4]	<= CNT6	 |{4{EN_BLINK}};
					SER_OUT[11:8]	<= CNT10M;
					SER_OUT[15:12]	<= CNT6M;
					SER_OUT[19:16]	<= CNT10T;
					SER_OUT[23:20]	<= CNT3T;
				end
		
				SER_CNT10 :
				begin
					SER_OUT[3:0]	<= CNT10  |{4{EN_BLINK}};
					SER_OUT[7:4]	<= CNT6;
					SER_OUT[11:8]	<= CNT10M;
					SER_OUT[15:12]	<= CNT6M;
					SER_OUT[19:16]	<= CNT10T;
					SER_OUT[23:20]	<= CNT3T;
				end
		
				default :
				begin
					SER_OUT[3:0]	<= CNT10  |{4{EN_BLINK}};
					SER_OUT[7:4]	<= CNT6	 |{4{EN_BLINK}};
					SER_OUT[11:8]	<= CNT10M |{4{EN_BLINK}};
					SER_OUT[15:12]	<= CNT6M  |{4{EN_BLINK}};
					SER_OUT[19:16]	<= CNT10T |{4{EN_BLINK}};
					SER_OUT[23:20]	<= CNT3T  |{4{EN_BLINK}};
				end
			endcase
			
		CLOCK24 :
			begin
				SER_OUT[3:0]	<= CNT10;
				SER_OUT[7:4]	<= CNT6;
				SER_OUT[11:8]	<= CNT10M;
				SER_OUT[15:12]	<= CNT6M;
				SER_OUT[19:16]	<= CNT10T;
				if (CNT3T == 1'b0) 
					begin
						SER_OUT[23:20]	<= 4'hf;
					end
				else
					begin
						SER_OUT[23:20]	<= CNT3T;
					end
			end
			
		ALARM :
			case(ALARMSET)
				ONOFF :
				begin
					if (onoff == 1'h1)
						begin
						SER_OUT[3:0]	<= 4'hd;
						SER_OUT[7:4]	<= 4'he;
						SER_OUT[11:8]	<= 4'hf;
						SER_OUT[15:12]	<= 4'hf;
						SER_OUT[19:16]	<= 4'hf;
						SER_OUT[23:20]	<= 4'hf;
						end
					else
						begin
						SER_OUT[3:0]	<= 4'hc;
						SER_OUT[7:4]	<= 4'hc;
						SER_OUT[11:8]	<= 4'he;
						SER_OUT[15:12]	<= 4'hf;
						SER_OUT[19:16]	<= 4'hf;
						SER_OUT[23:20]	<= 4'hf;
						end
				end
				SER_AL3T :
				begin
					SER_OUT[3:0]	<= AL_CNT10;
					SER_OUT[7:4]	<= AL_CNT6;
					SER_OUT[11:8]	<= AL_CNT10M;
					SER_OUT[15:12]	<= AL_CNT6M;
					SER_OUT[19:16]	<= AL_CNT10T;
					SER_OUT[23:20]	<= AL_CNT3T  | {4{EN_BLINK}};
				end
		
				SER_AL10T :
				begin
					SER_OUT[3:0]	<= AL_CNT10;
					SER_OUT[7:4]	<= AL_CNT6;
					SER_OUT[11:8]	<= AL_CNT10M;
					SER_OUT[15:12]	<= AL_CNT6M;
					SER_OUT[19:16]	<= AL_CNT10T | {4{EN_BLINK}};
					SER_OUT[23:20]	<= AL_CNT3T;
				end
		
				SER_AL6M :
				begin
					SER_OUT[3:0]	<= AL_CNT10;
					SER_OUT[7:4]	<= AL_CNT6;
					SER_OUT[11:8]	<= AL_CNT10M;
					SER_OUT[15:12]	<= AL_CNT6M  | {4{EN_BLINK}};
					SER_OUT[19:16]	<= AL_CNT10T;
					SER_OUT[23:20]	<= AL_CNT3T;
				end
		
				SER_AL10M :
				begin
					SER_OUT[3:0]	<= AL_CNT10;
					SER_OUT[7:4]	<= AL_CNT6;
					SER_OUT[11:8]	<= AL_CNT10M | {4{EN_BLINK}};
					SER_OUT[15:12]	<= AL_CNT6M;
					SER_OUT[19:16]	<= AL_CNT10T;
					SER_OUT[23:20]	<= AL_CNT3T;
				end
				
				SER_AL6 :
				begin
					SER_OUT[3:0]	<= AL_CNT10;
					SER_OUT[7:4]	<= AL_CNT6	 |{4{EN_BLINK}};
					SER_OUT[11:8]	<= AL_CNT10M;
					SER_OUT[15:12]	<= AL_CNT6M;
					SER_OUT[19:16]	<= AL_CNT10T;
					SER_OUT[23:20]	<= AL_CNT3T;
				end
		
				SER_AL10 :
				begin
					SER_OUT[3:0]	<= AL_CNT10  |{4{EN_BLINK}};
					SER_OUT[7:4]	<= AL_CNT6;
					SER_OUT[11:8]	<= AL_CNT10M;
					SER_OUT[15:12]	<= AL_CNT6M;
					SER_OUT[19:16]	<= AL_CNT10T;
					SER_OUT[23:20]	<= AL_CNT3T;
				end
		
				default :
				begin
					SER_OUT[3:0]	<= AL_CNT10  |{4{EN_BLINK}};
					SER_OUT[7:4]	<= AL_CNT6	 |{4{EN_BLINK}};
					SER_OUT[11:8]	<= AL_CNT10M |{4{EN_BLINK}};
					SER_OUT[15:12]	<= AL_CNT6M  |{4{EN_BLINK}};
					SER_OUT[19:16]	<= AL_CNT10T |{4{EN_BLINK}};
					SER_OUT[23:20]	<= AL_CNT3T  |{4{EN_BLINK}};
				end
			endcase
	endcase           

endmodule