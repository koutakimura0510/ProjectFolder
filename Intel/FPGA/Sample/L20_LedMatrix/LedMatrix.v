//フォントROM
module m_font_rom(input [5:0] radr,output [9:0] dat);
	function [9:0] FontDec;
		input [5:0] dadr;
		begin
			case(dadr)
			6'd03:	FontDec=10'h1ff;
			6'd04:	FontDec=10'h010;
			6'd05:	FontDec=10'h010;
			6'd06:	FontDec=10'h010;
			6'd07:	FontDec=10'h1ff;
			6'd11:	FontDec=10'h1ff;
			6'd12:	FontDec=10'h111;
			6'd13:	FontDec=10'h111;
			6'd14:	FontDec=10'h111;
			6'd15:	FontDec=10'h101;
			6'd19:	FontDec=10'h1ff;
			6'd20:	FontDec=10'h100;
			6'd21:	FontDec=10'h100;
			6'd22:	FontDec=10'h100;
			6'd23:	FontDec=10'h100;
			6'd27:	FontDec=10'h1ff;
			6'd28:	FontDec=10'h021;
			6'd29:	FontDec=10'h021;
			6'd30:	FontDec=10'h021;
			6'd31:	FontDec=10'h01e;
			default: FontDec=10'h000;
			endcase
		end
	endfunction
	assign dat=FontDec(radr);
endmodule

//1ms秒のクロック生成
module m_1ms_clk(input clk,output clk1ms);
	reg [19:0] cnt;
	reg r1ms;
	wire wcout;
	
	assign wcout=(cnt==20'd24999) ? 1'b1 : 1'b0;
	assign clk1ms=r1ms;
	always @(posedge clk) begin
		if(wcout==1'b1) begin
			cnt=0;
			r1ms=~r1ms;
		end
		else begin
			cnt=cnt+1;
		end
	end
		
endmodule	

