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
	wire [11:0] bcd;
	assign LED=10'h0;
	
	m_bcd_decorder u0(SW[7:0],bcd);
	m_seven_segment u1(bcd[3:0] ,HEX0);
	m_seven_segment u2(bcd[7:4] ,HEX1);
	m_seven_segment u3(bcd[11:8],HEX2);
	assign HEX3=8'hff;
	m_seven_segment u4(SW[3:0],HEX4);
	m_seven_segment u5(SW[7:4],HEX5);
	
endmodule
