//BCDデコーダ―
module m_bcd_decorder(input [7:0] bin,output [11:0] bcd);
	wire [11:0] dat_l;
	wire [11:0] dat_h;
	m_bcd_table_l u0(bin[3:0],dat_l);
	m_bcd_table_h u1(bin[7:4],dat_h);
	m_bcd_add u2(dat_l,dat_h,bcd);
endmodule
	

//下位4ビットのバイナリー＞BCD変換テーブル
module m_bcd_table_l(input [3:0] adr,output [11:0] dat);
	reg [11:0] data;
	assign dat=data;
	always @(adr) begin
		case (adr)
			4'h0: data=12'h000;
         4'h1: data=12'h001;
         4'h2: data=12'h002;
         4'h3: data=12'h003;
         4'h4: data=12'h004;
         4'h5: data=12'h005;
         4'h6: data=12'h006;
         4'h7: data=12'h007;
         4'h8: data=12'h008;
         4'h9: data=12'h009;
         4'ha: data=12'h010;
         4'hb: data=12'h011;
         4'hc: data=12'h012;
         4'hd: data=12'h013;
         4'he: data=12'h014;
         4'hf: data=12'h015;
			default: data=12'h000;
		endcase 
	end
endmodule

//上位4ビットのバイナリー＞BCD変換テーブル
module m_bcd_table_h(input [3:0] adr,output [11:0] dat);
	reg [11:0] data;
	assign dat=data;
	always @(adr) begin
		case (adr)
         4'h0: data=12'h000;
         4'h1: data=12'h016;
         4'h2: data=12'h032;
         4'h3: data=12'h048;
         4'h4: data=12'h064;
         4'h5: data=12'h080;
         4'h6: data=12'h088;
         4'h7: data=12'h112;
         4'h8: data=12'h128;
         4'h9: data=12'h144;
         4'ha: data=12'h160;
         4'hb: data=12'h176;
         4'hc: data=12'h192;
         4'hd: data=12'h208;
         4'he: data=12'h224;
         4'hf: data=12'h240;
			default: data=12'h000;
		endcase 
	end
endmodule

//12bit BCD加算器
module m_bcd_add(input [11:0] dat_a,input [11:0] dat_b,output [11:0] dout);
	wire [2:0] c;
	m_bcd_add4 u0(dat_a[3:0] ,dat_b[3:0] ,1'b0,c[0],dout[3:0] );
	m_bcd_add4 u1(dat_a[7:4] ,dat_b[7:4] ,c[0],c[1],dout[7:4] );
	m_bcd_add4 u2(dat_a[11:8],dat_b[11:8],c[1],c[2],dout[11:8]);
endmodule

//4bit BCD加算器
module m_bcd_add4(input [3:0] dat_a,input [3:0] dat_b,input cin,output cout,output [3:0] dout);
	wire [4:0] adat;
	wire cry;
	
	assign adat=dat_a+dat_b+cin;
	assign cry=(adat>=5'd10) ? 1'b1 : 1'b0;
	assign dout=(cry==1'b1) ? (adat-5'd10) : adat[3:0];
	assign cout=cry;
endmodule



//7セグメントデコーダ
module m_seven_segment(input [3:0] idat,output [7:0] odat);
	parameter dot=1'b1;
    function [7:0] LedDec;
      input [3:0] num;
      begin
         case (num)
           4'h0:        LedDec = 8'b11000000;  // 0
           4'h1:        LedDec = 8'b11111001;  // 1
           4'h2:        LedDec = 8'b10100100;  // 2
           4'h3:        LedDec = 8'b10110000;  // 3
           4'h4:        LedDec = 8'b10011001;  // 4
           4'h5:        LedDec = 8'b10010010;  // 5
           4'h6:        LedDec = 8'b10000010;  // 6
           4'h7:        LedDec = 8'b11111000;  // 7
           4'h8:        LedDec = 8'b10000000;  // 8
           4'h9:        LedDec = 8'b10011000;  // 9
           4'ha:        LedDec = 8'b10001000;  // A
           4'hb:        LedDec = 8'b10000011;  // B
           4'hc:        LedDec = 8'b10100111;  // C
           4'hd:        LedDec = 8'b10100001;  // D
           4'he:        LedDec = 8'b10000110;  // E
           4'hf:        LedDec = 8'b10001110;  // F
           default:     LedDec = 8'b11111111;  // LED OFF
         endcase
      end 
    endfunction
	wire [7:0] tdat;
	assign tdat=LedDec(idat);
	assign odat={dot,tdat[6:0]};
endmodule

