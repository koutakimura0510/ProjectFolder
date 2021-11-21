/**-------------------------------------------------
 * 60Array-Counter
 * -------------------------------------------------*/
module CNT60(CLK, ENABLE, RESET, CNT10, CNT6, CIN, COUT, KEY, TSET, AL_CNT10, AL_CNT6, ALARMSET);
	
input CLK, RESET, ENABLE, CIN, KEY;
input [2:0] TSET;
input [1:0] ALARMSET;

output [3:0] CNT10, AL_CNT10;
output [2:0] CNT6, AL_CNT6;
output COUT;

reg [3:0] CNT10, AL_CNT10;
reg [2:0] CNT6, AL_CNT6;
reg CARRY, COUT;


/**-------------------------------------------------
 * ALARM_CNT10
 * -------------------------------------------------*/
always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			AL_CNT10 <= 4'h0;
		end
	else if (ALARMSET[1] == 1'b1 && KEY == 1'b1)
		begin
			if (AL_CNT10 == 4'h9)
				AL_CNT10 <= 4'h0;
			else
				AL_CNT10 <= AL_CNT10 + 4'h1;
		end
end

/**-------------------------------------------------
 * ALARM_CNT6
 * -------------------------------------------------*/
always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			AL_CNT6 <= 3'h0;
		end
	else if (ALARMSET[0] == 1'b1 && KEY == 1'b1)
		begin
			if (AL_CNT6 == 3'h5)
				AL_CNT6 <= 3'h0;
			else
				AL_CNT6 <= AL_CNT6 + 3'h1;
		end
end


/**-------------------------------------------------
 * CNT10
 * -------------------------------------------------*/
always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			CNT10 <= 4'h0;
		end
	else if (((TSET[0] == 1'b1) && (ENABLE == 1'b1) && (CIN == 1'b1)) || ((TSET[0] == 1'b0) && (TSET[2] == 1'b1) && (KEY == 1'b1)))
		begin
			if (CNT10 == 4'h9)
				CNT10 <= 4'h0;
			else
				CNT10 <= CNT10 + 4'h1;
		end
end


/**-------------------------------------------------
 * CNT10 CARRY
 * -------------------------------------------------*/
always @(CIN or CNT10)
begin
	if ((CNT10 == 4'h9) && (CIN == 1'b1))
		CARRY <= 1'b1;
	else
		CARRY <= 1'b0;
end


/**-------------------------------------------------
 * CNT6
 * -------------------------------------------------*/
always @(posedge CLK)
begin
	if (RESET == 1'b1)
		begin
			CNT6 <= 3'h0;
		end
	else if (((TSET[0] == 1'b1) && (ENABLE == 1'b1) && (CARRY == 1'b1)) || ((TSET[0] == 1'b0) && (TSET[1] == 1'b1) && (KEY == 1'b1)))
		begin
			if (CNT6 == 3'h5)
				CNT6 <= 3'h0;
			else
				CNT6 <= CNT6 + 3'h1;
		end
end		


/**-------------------------------------------------
 * CNT6 CARRY
 * -------------------------------------------------*/
always @(CARRY or CNT6)
begin
	if ((CNT6 == 3'h5) && (CARRY == 1'b1))
		COUT <= 1'b1;
	else
		COUT <= 1'b0;
end



endmodule