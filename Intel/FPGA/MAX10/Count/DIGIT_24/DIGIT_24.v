/**-------------------------------------------------
 * System Digit24 MAX10 DE-Lite
 * -------------------------------------------------*/
module DIGIT_24(CLK, RESET, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, SW, KEY, LEDR, GPIO);

input [2:0] KEY;
input [8:0] SW;
input CLK, RESET;

output [7:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
output [9:0] LEDR;
output [35:0] GPIO;

wire [2:0] MAIN;
wire [6:0] TSET, ALARMSET;
wire [23:0] SER_OUT;
wire [3:0] CNT10, CNT10M, CNT10T, AL_CNT10, AL_CNT10M, AL_CNT10T;
wire [2:0] CNT6, CNT6M, AL_CNT6, AL_CNT6M;
wire [1:0] CNT3T, AL_CNT3T;
wire [9:0] SW;
wire current_state, onoff;
wire ENABLE, EN_BLINK, ENABLE_khz, ENABLE_BUZZ;
wire carry59, carry5959;
wire MODE, INC;
 
ENABLE_GENERATE	i0(.CLK(CLK), .ENABLE(ENABLE), .RESET(RESET), .EN_BLINK(EN_BLINK), .ENABLE_khz(ENABLE_khz), .ENABLE_BUZZ(ENABLE_BUZZ));						

CNT60					i1(.CLK(CLK), .ENABLE(ENABLE), .RESET(RESET), .CNT10(CNT10), .CNT6(CNT6), .CIN(1'b1), .COUT(carry59),
							.KEY(INC), .TSET({TSET[6:5], TSET[0]}),
							.AL_CNT10(AL_CNT10), .AL_CNT6(AL_CNT6), .ALARMSET({ALARMSET[6:5]}));
							
CNT60					i2(.CLK(CLK), .ENABLE(ENABLE), .RESET(RESET), .CNT10(CNT10M), .CNT6(CNT6M), .CIN(carry59), .COUT(carry5959),
							.KEY(INC), .TSET({TSET[4:3], TSET[0]}),
							.AL_CNT10(AL_CNT10M), .AL_CNT6(AL_CNT6M), .ALARMSET({ALARMSET[4:3]}));
							
CNT24					i3(.CLK(CLK), .ENABLE(ENABLE), .RESET(RESET), .CNT10(CNT10T), .CNT3(CNT3T), .CIN(carry5959),
							.KEY(INC), .TSET({TSET[2:1], TSET[0]}),
							.AL_CNT10(AL_CNT10T), .AL_CNT3(AL_CNT3T), .ALARMSET({ALARMSET[2:1]}));

							
SERECTOR				i4(.CNT10(CNT10), .CNT10M(CNT10M), .CNT10T(CNT10T), .CNT6(CNT6), .CNT6M(CNT6M), .CNT3T(CNT3T),
							.EN_BLINK(EN_BLINK), .SER_OUT(SER_OUT), .MAIN(MAIN), .TSET(TSET),
							.AL_CNT10(AL_CNT10), .AL_CNT10M(AL_CNT10M), .AL_CNT10T(AL_CNT10T),
							.AL_CNT6(AL_CNT6), .AL_CNT6M(AL_CNT6M), .AL_CNT3T(AL_CNT3T), .onoff(onoff), .ALARMSET(ALARMSET));

DECODER				i5_0(.COUNT(SER_OUT[3:0]),   .nSEG(HEX0));
DECODER				i5_1(.COUNT(SER_OUT[7:4]),   .nSEG(HEX1));
DECODER				i5_2(.COUNT(SER_OUT[11:8]),  .nSEG(HEX2));
DECODER				i5_3(.COUNT(SER_OUT[15:12]), .nSEG(HEX3));
DECODER				i5_4(.COUNT(SER_OUT[19:16]), .nSEG(HEX4));
DECODER				i5_5(.COUNT(SER_OUT[23:20]), .nSEG(HEX5));

SW_GEN				i6_0(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(KEY[0]), .EDGE(MODE));
SW_GEN				i6_1(.CLK(CLK), .ENABLE(ENABLE_khz), .KEY(KEY[1]), .EDGE(INC));

SEQUENCER			i7(.CLK(CLK), .RESET(RESET), .KEY(SW), .current_state(MAIN));
TSET					i8(.CLK(CLK), .RESET(RESET), .KEY(MODE), .MAIN(MAIN[0]), .current_state(TSET));
ALARMSET				i9(.CLK(CLK), .RESET(RESET), .KEY(MODE), .MAIN(MAIN[2]), .current_state(ALARMSET));

AL_MOVE				i10(.CLK(CLK), .RESET(RESET), .MAIN(MAIN), .KEY(INC), .onoff(onoff), .LED(LEDR[0]),
							 .CNT10(CNT10), .CNT10M(CNT10M), .CNT10T(CNT10T), .CNT6(CNT6), .CNT6M(CNT6M), .CNT3T(CNT3T),
							 .AL_CNT10(AL_CNT10), .AL_CNT10M(AL_CNT10M), .AL_CNT10T(AL_CNT10T),
							 .AL_CNT6(AL_CNT6), .AL_CNT6M(AL_CNT6M), .AL_CNT3T(AL_CNT3T), .ALARMSET(ALARMSET[0]));
						
BUZZER 				i11(.CLK(CLK), .ENABLE(ENABLE_BUZZ), .KEY({KEY[1:0]}), .GPIO(GPIO[34]));
 
endmodule