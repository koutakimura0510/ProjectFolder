module AL_MOVE(
	CLK, RESET, MAIN, KEY, onoff, LED,
	CNT10, CNT10M, CNT6, CNT6M, CNT10T, CNT3T,
	AL_CNT10, AL_CNT10M, AL_CNT6, AL_CNT6M, AL_CNT10T, AL_CNT3T, ALARMSET);

input [3:0] CNT10, CNT10M, CNT6, CNT6M, CNT10T, CNT3T;
input [3:0] AL_CNT10, AL_CNT10M, AL_CNT6, AL_CNT6M, AL_CNT10T, AL_CNT3T;
input [2:0] MAIN;
input ALARMSET;
input CLK, RESET, KEY;
output onoff, LED;
reg onoff, LED;

wire [3:0] CNT10, CNT10M, CNT6, CNT6M, CNT10T, CNT3T;
wire [3:0] AL_CNT10, AL_CNT10M, AL_CNT6, AL_CNT6M, AL_CNT10T, AL_CNT3T;
	

always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			onoff <= 1'h0;
		end
	else if (MAIN[2] == 1'b1 && ALARMSET == 1'b1 && KEY == 1'b1)
		begin
			if (onoff == 1'b1)
				onoff <= 1'b0;
			else
				onoff <= 1'b1;
		end
end


always @(posedge CLK)
begin
	if (onoff == 1'b1)
		begin
			if (CNT10M == AL_CNT10M && CNT6M == AL_CNT6M && CNT10T == AL_CNT10T && CNT3T == AL_CNT3T && MAIN[1] == 1'b1)
				LED <= 1'b1;
			else
				LED <= 1'b0;
		end
end
	

endmodule