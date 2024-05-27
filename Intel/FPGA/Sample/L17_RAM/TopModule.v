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
	wire w_we;
	wire w_btn0;
	wire [3:0] rdata;
	m_chattering u0(CLK1,BTN[0],w_btn0);
	assign w_we=~w_btn0;
	
	m_ram u1(SW[9:6],SW[3:0],w_we,rdata);
	assign LED=10'h0;
	m_seven_segment s0(rdata,HEX0);
	m_seven_segment s1(SW[3:0],HEX1);
	m_seven_segment s2(SW[9:6],HEX2);
	assign HEX3=8'hff;
	assign HEX4=8'hff;
	assign HEX5=8'hff;
	
endmodule
