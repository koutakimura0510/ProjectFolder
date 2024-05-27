module m_rom(input [3:0] adr,output [7:0] dat);
	reg [7:0] data;
	assign dat=data;
	always @(adr) begin
		case (adr)
			4'h0:	data=8'b10100001;	//d
			4'h1:	data=8'b10000110;	//E
			4'h2: data=8'b11000000; //0
      	4'h3: data=8'b01111111;	//.
      	4'h4: data=8'b11111111;	//SP
			4'h5:	data=8'b10100001;	//d
			4'h6:	data=8'b10000110;	//E
      	4'h7: data=8'b11111001; //1
	      4'h8: data=8'b01111111;	//.
   	   4'h9: data=8'b11111111;	//SP
			4'ha:	data=8'b10100001;	//d
			4'hb:	data=8'b10000110;	//E
   	   4'hc: data=8'b11111001; //1
      	4'hd: data=8'b11000000; //0
	      4'he: data=8'b01111111;	//.
   	   4'hf: data=8'b11111111;	//SP
			default: data=8'hff;
		endcase 
	end
endmodule

//チャタリング除去
module m_chattering(input clk,input sw_in,output sw_out);
	reg [15:0] cnt;	//16bit counter
	reg swreg;			//Switch Latch
	wire iclk;			//1/65536 clock
	
	assign sw_out=swreg;
	
	//16bit Counter
	always @(posedge clk) begin
		cnt=cnt+1;
	end
	assign iclk=cnt[15];	//clock for chattering inhibit
	
	//switch latch 
	always @(posedge iclk) begin
		swreg=sw_in;
	end

endmodule

		