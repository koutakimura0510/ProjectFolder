module wr_address_decoder 
#(
	parameter X_TOTAL	= 1024,
	parameter Y_TOTAL	= 1090,
	parameter X_START	= 0,
	parameter Y_START	= 0,
	parameter X_WIN		= X_TOTAL,
	parameter Y_WIN		= Y_TOTAL,
	parameter WR_FRAME	= 0,
	parameter RD_FRAME	= 0
)
(
input 			p_clk,
input 			axi_clk,
input 			rstn,

input [10:0]	x_win,
input [10:0]	x_start,
input [10:0]	y_win,
input [10:0]	y_start,

input [10:0] 	in_x_wr,
input [10:0] 	in_y_wr,
input			in_wr_en,
input			in_hs,
input			in_frame_cnt,

input [7:0]		in_wr_00,
input [7:0]		in_wr_01,
input [7:0]		in_wr_10,
input [7:0]		in_wr_11,

input			in_wr_aready,
input			in_wr_ready,
input			in_wr_bvalid,

output	reg			out_wr_avalid,
output	reg			out_wr_valid,
output	reg			out_wr_bready,
output	reg			out_wr_last,
output	[31:0]		out_wr_addr,
output	reg [31:0]	out_wr_data
);

//Main states
localparam
	IDLE 		= 3'b000, 
	WRITE_ADDR 	= 3'b001,
	PRE_WRITE 	= 3'b010,
	WRITE 		= 3'b011,
	POST_WRITE 	= 3'b100;

parameter	X_3_BY_4	= (X_TOTAL >> 1) + (X_TOTAL >> 2);

/* Remap video XY to DDR address */
reg [2:0]	states;
reg			r_in_en_1P;
reg			r_in_en_2P;
reg	[2:0]	r_cnt;
reg	[3:0]	r_pre_cnt;
reg	[2:0]	r_pre_cnt_1P;
reg	[2:0]	r_pre_cnt_2P;
reg			r_pclk_new_line;
reg	[31:0]	r_wr_data_00;
reg	[31:0]	r_wr_data_01;
reg	[31:0]	r_wr_data_02;
reg	[31:0]	r_wr_data_03;
reg	[31:0]	r_wr_data_04;
reg	[31:0]	r_wr_data_05;
reg	[31:0]	r_wr_data_06;
reg	[31:0]	r_wr_data_07;
reg	[31:0]	r_wr_data_05_1P;
reg	[31:0]	r_wr_data_06_1P;
reg	[31:0]	r_wr_data_07_1P;
reg	[7:0]	write_cycle;
reg	[7:0]	write_cycle_1P;
reg	[7:0]	write_cycle_2P;
reg	[10:0]	r_in_x_wr_1P;
reg	[10:0]	r_in_x_wr_2P;
reg	[10:0]	r_wr_y;
reg	[10:0]	r_wr_y_temp;
reg	[10:0]	r_wr_y_1P;
reg	[10:0]	r_wr_y_2P;
reg	[10:0]	r_y_wr_1P;
reg			r_hs_1P;
reg			r_wr_load;
reg			r_axi_valid;
reg			r_wr_avalid;
reg	[3:0]	r_burst_cnt;
reg	[3:0]	r_burst_cnt_1P;
reg	[3:0]	r_burst_cnt_2P;
reg			r_in_de;
reg			r_in_de_1P;
reg			r_in_de_2P;
reg			r_rd_en;
reg			r_rd_en_1P;
reg			r_rd_en_2P;

reg [31:0]	r_out_wr_data;

wire[31:0]	w_wr_data_00;
wire[31:0]	w_wr_data_01;
wire[31:0]	w_wr_data_02;
wire[31:0]	w_wr_data_03;
wire[31:0]	w_wr_data_04;
wire[31:0]	w_wr_data_05;
wire[31:0]	w_wr_data_06;
wire[31:0]	w_wr_data_07;
wire[10:0]	axi_y_wr;
wire[10:0]	w_wr_y_temp;
wire		w_axi_new_line;

assign	out_wr_addr	= {6'b0, r_wr_y, write_cycle[3:0], 1'b0, in_frame_cnt, write_cycle[4], 8'b0};

/* New line for write */
always @(posedge p_clk)
begin
    if (~rstn) 
	begin
		r_wr_y_temp		<= 11'b0;
		r_pclk_new_line	<= 1'b0;
		r_hs_1P			<= 1'b0;
		r_y_wr_1P		<= 11'b0;
	end
	else
	begin
		r_hs_1P		<= in_hs;
		r_y_wr_1P	<= in_y_wr;
		
		if (!in_hs && r_hs_1P)
		begin
			r_pclk_new_line	<= 1'b1;
			r_wr_y_temp		<= r_y_wr_1P;
		end
		
		if (r_wr_load == 1)
		begin
			r_pclk_new_line	<= 1'b0;
			r_wr_y_temp		<= 11'b0;
		end
	end
end

/* Sync P_CLK to AXI_CLK */
dual_clock_fifo
#(	
	.DATA_WIDTH(12),
    .ADDR_WIDTH(3)
) 
dual_clock_fifo_in0 
(
	.i_arst 	(~rstn),
	.i_wclk 	(p_clk),
	.i_we 		(rstn),
	.i_wdata 	({r_wr_y_temp, r_pclk_new_line}),  
	.i_rclk 	(axi_clk),  
	.i_re 		(rstn),  
	.o_rdata 	({w_wr_y_temp, w_axi_new_line})
);
		
/* Axi4 write 32bit */
always @(posedge axi_clk)
begin
    if (~rstn) 
	begin
		states			<= IDLE;
		r_wr_avalid		<= 1'b0;
		out_wr_valid	<= 1'b0;
		out_wr_bready	<= 1'b0;
		out_wr_last		<= 1'b0;
		out_wr_avalid	<= 1'b0;
		r_out_wr_data		<= 32'b0;
		r_pre_cnt		<= 4'b0;
		r_pre_cnt_1P	<= 3'b0;
		r_pre_cnt_2P	<= 3'b0;
		r_cnt			<= 3'b0;		
		r_wr_data_00	<= 32'b0;
		r_wr_data_01	<= 32'b0;
		r_wr_data_02	<= 32'b0;
		r_wr_data_03	<= 32'b0;
		r_wr_data_04	<= 32'b0;
		r_wr_data_05	<= 32'b0;
		r_wr_data_06	<= 32'b0;
		r_wr_data_07	<= 32'b0;
		r_wr_data_06_1P	<= 32'b0;
		r_wr_data_07_1P	<= 32'b0;
		write_cycle		<= (x_start >> 6);
		r_wr_y			<= 11'b0;		
		r_wr_load		<= 1'b0;
		r_axi_valid		<= 1'b0;
		r_burst_cnt		<= 4'b0;
		r_rd_en			<= 1'b0;
	end
	else
	begin		
		r_rd_en_1P		<= r_rd_en;
		r_rd_en_2P		<= r_rd_en_1P;
		
		r_wr_y_1P		<= r_wr_y;
		r_wr_y_2P		<= r_wr_y_1P;		
		write_cycle_1P	<= write_cycle;
		write_cycle_2P	<= write_cycle_1P;
		r_burst_cnt_1P	<= r_burst_cnt;
		r_burst_cnt_2P	<= r_burst_cnt_1P;
				
		if (r_rd_en)
			r_rd_en	<= ~r_rd_en;
						
		if (r_rd_en_2P)
		begin
			r_wr_data_00	<= w_wr_data_00;
			r_wr_data_01    <= w_wr_data_01;
			r_wr_data_02    <= w_wr_data_02;
			r_wr_data_03    <= w_wr_data_03;
			r_wr_data_04    <= w_wr_data_04;
			r_wr_data_05    <= w_wr_data_05;
			r_wr_data_06    <= w_wr_data_06;
			r_wr_data_07    <= w_wr_data_07;
		end
				
		case (states)
			IDLE:
			begin
				if (!r_wr_load && w_axi_new_line)
				begin
					r_axi_valid		<= 1'b1;
					
					if (r_pre_cnt == 4'b0)
					begin
						r_rd_en		<= 1'b1;
						r_burst_cnt	<= 4'd0;
						write_cycle	<= (x_start >> 6);
						r_wr_y		<= w_wr_y_temp;
					end
						
					if (r_pre_cnt != 4'd3)
					begin
						r_pre_cnt	<= r_pre_cnt + 1'b1;												
					end
					else
					begin
						r_wr_load		<= 1'b1;					
						out_wr_avalid	<= 1'b1;						
						r_pre_cnt		<= r_pre_cnt + 1'b1;
						states			<= WRITE_ADDR;
					end
				end
			end
			
			WRITE_ADDR:
			begin
				if (in_wr_aready)
				begin
					out_wr_avalid	<= 1'b0;
					out_wr_valid	<= 1'b1;
					out_wr_bready	<= 1'b1;
					r_pre_cnt		<= r_pre_cnt + 1'b1;
					out_wr_data		<= r_wr_data_00;
					states			<= WRITE;
				end
			end
			
			WRITE:
			begin
				if (in_wr_ready)
				begin
					r_cnt	<= r_cnt + 1'b1;
					
					if (r_pre_cnt != 4'd15)
						r_pre_cnt	<= r_pre_cnt + 1'b1;
					
					if (r_cnt == 3'd0)
						out_wr_data		<= r_wr_data_01;
					else if (r_cnt == 3'd1)
						out_wr_data		<= r_wr_data_02;
					else if (r_cnt == 3'd2)
						out_wr_data		<= r_wr_data_03;
					else if (r_cnt == 3'd3)
					begin
						out_wr_data		<= r_wr_data_04;
						r_wr_data_05_1P	<= r_wr_data_05;
						r_wr_data_07_1P	<= r_wr_data_07;
						r_wr_data_06_1P	<= r_wr_data_06;
						r_wr_data_07_1P	<= r_wr_data_07;
						r_burst_cnt		<= r_burst_cnt + 1'b1;
						r_rd_en			<= 1'b1;
						
						if (r_burst_cnt == 4'd7)
							write_cycle 	<= write_cycle + 1'b1;												
					end
					else if (r_cnt == 3'd4)
						out_wr_data		<= r_wr_data_05_1P;
					else if (r_cnt == 3'd5)
						out_wr_data		<= r_wr_data_06_1P;
					else if (r_cnt == 3'd6)
					begin
						out_wr_data		<= r_wr_data_07_1P;					
						
						if (r_burst_cnt[3])
							out_wr_last		<= 1'b1;	
					end
					else if (r_cnt == 3'd7)
					begin
						r_cnt			<= 3'b0;												
						
						if (out_wr_last)
						begin
							out_wr_last		<= 1'b0;
							out_wr_valid	<= 1'b0;
							r_pre_cnt		<= 4'b0;
							r_cnt			<= 3'b0;
							out_wr_data		<= 32'b0;														
							states			<= POST_WRITE;
							r_burst_cnt		<= 4'b0;
						end
						else
							out_wr_data		<= r_wr_data_00;
					end
				end
			end
			
			POST_WRITE:
			begin
				if (in_wr_bvalid)
				begin
					if (write_cycle > x_win[10:6])
					begin					
						states			<= IDLE;					
						write_cycle 	<= (x_start >> 6);
						out_wr_valid	<= 1'b0;					
						out_wr_bready	<= 1'b0;
						out_wr_avalid	<= 1'b0;
						r_wr_load		<= 1'b0;
						r_axi_valid		<= 1'b0;	
						r_wr_y			<= 11'b0;
					end			
					else
					begin					
						out_wr_valid	<= 1'b0;					
						out_wr_bready	<= 1'b0;		
						out_wr_avalid	<= 1'b1;
						
						states			<= WRITE_ADDR;
					end
				end
			end
			
			default:
			begin
				write_cycle 	<= (x_start >> 6);
				r_pre_cnt		<= 4'b0;
				r_cnt			<= 3'b0;
				out_wr_data		<= 32'b0;
				out_wr_valid	<= 1'b0;					
				out_wr_bready	<= 1'b0;
				out_wr_avalid	<= 1'b0;
				r_wr_load		<= 1'b0;
				r_axi_valid		<= 1'b0;
				out_wr_last		<= 1'b0;
				r_rd_en			<= 1'b0;
				r_burst_cnt		<= 4'b0;
				r_wr_y			<= 11'b0;
				states			<= IDLE;
			end
		endcase
	end
end

/* Resync from p_clk to axi_clk */
simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_00
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd0)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),	
	.rdata	(w_wr_data_00)
);

simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_01
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd1)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),
	.rdata	(w_wr_data_01)
);

simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_02
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd2)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),
	.rdata	(w_wr_data_02)
);

simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_03
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd3)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),
	.rdata	(w_wr_data_03)
);

simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_04
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd4)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),
	.rdata	(w_wr_data_04)
);

simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_05
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd5)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),
	.rdata	(w_wr_data_05)
);

simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_06
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd6)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),
	.rdata	(w_wr_data_06)
);

simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(9)
)
inst_pclk_to_axi_buffer_07
(
	.wclk	(p_clk),
	.we		(in_wr_en && (in_x_wr[2:0] == 3'd7)),
	.waddr	({in_y_wr[0], in_x_wr[10:3]}),
	.wdata	({in_wr_00, in_wr_01, in_wr_10, in_wr_11}),
		
	.rclk	(axi_clk),
	.re		(r_rd_en),
	.raddr	({r_wr_y[0], write_cycle[4:0], r_burst_cnt[2:0]}),
	.rdata	(w_wr_data_07)
);

endmodule
