module TopModule(
	//////////// CLOCK //////////
	input 		          		CLK1,
	input 		          		CLK2,
	//////////// SEG7 //////////
	output		     [7:0]		HEX0,
	output		     [7:0]		HEX1,
	output		     [7:0]		HEX2,
	output		     [7:0]		HEX3,
	output		     [7:0]		HEX4,
	output		     [7:0]		HEX5,
	//////////// Push Button //////////
	input 		     [1:0]		BTN,
	//////////// LED //////////
	output		     [9:0]		LED,
	//////////// SW //////////
	input 		     [9:0]		SW

	);
	wire iclk,pwm;
	wire w_btn0,w_btn1;
	wire w_up,w_down;
	wire [7:0] updown;
	
	assign w_up=~w_btn0;
	assign w_down=~w_btn1;
	assign LED=(pwm==1'b1) ? 10'h3ff : 10'h0;

	m_chattering u0(CLK1,BTN[0],w_btn0);
	m_chattering u1(CLK1,BTN[1],w_btn1);
	m_10ms_clk u2(CLK1,iclk);
	m_up_down_counter2 u3(iclk,w_up,w_down,updown);
	m_pwm u4(CLK1,updown,pwm);	//pwm module
	m_seven_segment #(1) u5(updown[3:0],HEX0);
	m_seven_segment #(1) u6(updown[7:4],HEX1);
	
	assign HEX2=8'hff;
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
	
endmodule
