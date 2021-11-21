module CNT24(CLK, ENABLE, RESET, CNT10, CNT3, CIN, KEY, TSET, AL_CNT10, AL_CNT3, ALARMSET);

input CLK, ENABLE, RESET, CIN, KEY;
input [2:0] TSET;
input [1:0] ALARMSET;

output [3:0] CNT10, AL_CNT10;
output [1:0] CNT3, AL_CNT3;

reg [3:0] CNT10, AL_CNT10;
reg [1:0] CNT3, AL_CNT3;
reg CARRY;


always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			AL_CNT10 <= 4'h0;
		end
	else if (ALARMSET[1] == 1'b1 && KEY == 1'b1)
		begin
			if ((AL_CNT10 == 4'h9) || ((AL_CNT3 == 2'h2) && (AL_CNT10 == 4'h3)))
				AL_CNT10 <= 4'h0;
			else
				AL_CNT10 <= AL_CNT10 + 4'h1;
		end
end


always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			AL_CNT3 <= 2'h0;
		end
	else if (ALARMSET[0] == 1'b1 && KEY == 1'b1)
		begin
			if (AL_CNT3 == 2'h2)
				AL_CNT3 <= 2'h0;
			else
				AL_CNT3 <= AL_CNT3 + 2'h1;
		end
end



always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			CNT10 <= 4'h0;
		end
	else if (((TSET[0] == 1'b1) && (ENABLE == 1'b1) && (CIN == 1'b1)) || ((TSET[0] == 1'b0) && (TSET[2] == 1'b1) && (KEY == 1'b1)))
		begin
			if ((CNT10 == 4'h9) || ((CNT3 == 2'h2) && (CNT10 == 4'h3)))
				CNT10 <= 4'h0;
			else
				CNT10 <= CNT10 + 4'h1;
		end
end


always @(CIN or CNT10)
begin
	if (((CNT10 == 4'h9) && (CIN == 1'b1)) || ((CNT3 == 2'h2) && (CNT10 == 4'h3) && (CIN == 1'b1)))
		CARRY <= 1'b1;
	else
		CARRY <= 1'b0;
end


always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			CNT3 <= 2'h0;
		end
	else if (((TSET[0] == 1'b1) && (ENABLE == 1'b1) && (CARRY == 1'b1)) || ((TSET[0] == 1'b0) && (TSET[1] == 1'b1) && (KEY == 1'b1)))
		begin
			if (CNT3 == 2'h2)
				CNT3 <= 2'h0;
			else
				CNT3 <= CNT3 + 2'h1;
		end
end


endmodule