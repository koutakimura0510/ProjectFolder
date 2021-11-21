module PWM(CLK, RESET, GPIO, LEDR);

parameter COUNT_1SEC  = 50000000;	//1000ms count
parameter COUNT_1MSEC = 50000;		//1ms count

input CLK, RESET;
output [34:0] GPIO;
output [9:0] LEDR;
reg [25:0] tmp_count;
reg [7:0] pwm_cnt;	//8bit timer

wire EN_1SEC, EN_1MS;

//initial
//begin
//	pwm_cnt = 4'h0;
//end

always @(posedge CLK)
begin
	if (RESET == 1'b1)
		tmp_count <= 26'h0;
	else if (EN_1SEC == 1'b1)
		tmp_count <= 26'h0;
	else
		tmp_count <= tmp_count + 26'h1;
end

assign EN_1SEC = (tmp_count == (COUNT_1SEC - 1)) ? 1'b1 : 1'b0;
assign EN_1MS  = (tmp_count[15:0] == (COUNT_1MSEC - 1)) ? 1'b1 : 1'b0;

always @(posedge CLK)
begin
	if (RESET == 1'b1)
	begin
		pwm_cnt <= 8'h0;
	end
	else// if (EN_1MS == 1'b1)
	begin
		if (pwm_cnt == 8'hff)
			pwm_cnt <= 8'h0;
		else
			pwm_cnt <= pwm_cnt + 8'h1;
	end
end

assign GPIO[34] = (pwm_cnt < 8'h7f) ? 1'b1 : 1'b0;
assign LEDR[0]  = (pwm_cnt < 8'h05) ? 1'b1 : 1'b0;
assign LEDR[1]  = (pwm_cnt < 8'h10) ? 1'b1 : 1'b0;
assign LEDR[2]  = (pwm_cnt < 8'h20) ? 1'b1 : 1'b0;
assign LEDR[3]  = (pwm_cnt < 8'h30) ? 1'b1 : 1'b0;
assign LEDR[4]  = (pwm_cnt < 8'h40) ? 1'b1 : 1'b0;
assign LEDR[5]  = (pwm_cnt < 8'h50) ? 1'b1 : 1'b0;
assign LEDR[6]  = (pwm_cnt < 8'h60) ? 1'b1 : 1'b0;
assign LEDR[7]  = (pwm_cnt < 8'h80) ? 1'b1 : 1'b0;
assign LEDR[8]  = (pwm_cnt < 8'ha0) ? 1'b1 : 1'b0;
assign LEDR[9]  = (pwm_cnt < 8'hff) ? 1'b1 : 1'b0;

	
endmodule