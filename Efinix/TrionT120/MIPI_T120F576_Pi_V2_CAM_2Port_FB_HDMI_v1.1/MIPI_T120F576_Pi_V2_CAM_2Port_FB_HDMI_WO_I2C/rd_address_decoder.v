module rd_address_decoder 
#(
	parameter X_TOTAL	= 1024,
	parameter Y_TOTAL	= 1090,
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

input		 	in_de,
input			in_valid,
input			in_hsync,
input			in_vsync,
input			in_frame_cnt,
                
input			in_0_ar_ready,
input			in_0_r_valid,
input [31:0]	in_0_r_payload_data,
input           in_0_r_payload_last,
 	
output reg     	out_0_ar_valid,
output [31:0]	out_0_ar_addr,
output reg		out_0_r_ready,
			
output       	out_de,
output			out_valid,
output       	out_hsync,
output       	out_vsync,
output	[7:0]	out_rd_00,
output	[7:0]   out_rd_01,
output	[7:0]   out_rd_10,
output	[7:0]   out_rd_11
);

//Main states
localparam
	IDLE 		= 2'b00, 	
	READ_ADDR 	= 2'b01,
	READ 		= 2'b10;

/* Remap video XY to DDR address */
reg	[10:0]	r_y_cnt;
reg	[2:0]	ba;
reg 		r_hs_1P;
reg 		r_vs_1P;
reg [10:0]	r_rd_addr;
reg [10:0]	r_rd_addr_1P;
reg [10:0]	r_rd_addr_2P;
reg [10:0]	r_rd_addr_3P;
reg	[1:0]	r_line_cnt;
reg	[1:0]	r_frame_cnt;
reg			r_line_in_1L;
reg			r_line_in_2L;
reg	[7:0]	r_rd_00;
reg	[7:0]	r_rd_01;
reg	[7:0]	r_rd_10;
reg	[7:0]	r_rd_11;
reg			r_de_2L_1P;
reg			r_de_2L_2P;
reg			r_de_2L_3P;
reg	[10:0]	r_y_cnt_2L_1P;
reg	[10:0]	r_y_cnt_2L_2P;
reg	[10:0]	r_y_cnt_2L_3P;
reg			r_in_de_0L_1P;
reg			r_in_de_0L_2P;
reg	[1:0]	states;
reg	[10:0]	r_rd_ycnt;
reg	[10:0]	r_axi_xcnt;
reg	[10:0]	r_axi_ycnt;
reg	[10:0]	r_rd_xcnt;
reg			r_axi_new_line;
reg			r_rd_load;
reg			r_axi_de;
reg			r_axi_hsync_1P;

wire		w_de_2L;
wire		w_valid_2L;
wire		w_hsync_2L;
wire		w_vsync_2L;
wire		axi_de;
wire		axi_valid;
wire		axi_hsync;
wire		axi_vsync;
wire[255:0]	w_in_rd_data;

assign	out_0_ar_addr	= {6'b0, r_rd_ycnt, r_rd_xcnt[9:6], 1'b0, in_frame_cnt, r_rd_xcnt[10], r_rd_xcnt[5:3], 5'b0};

/* Sync P_CLK to AXI_CLK */
dual_clock_fifo
#(	
	.DATA_WIDTH(4),
    .ADDR_WIDTH(3)
) 
dual_clock_fifo_in0 
(                                                      
	.i_arst 	(~rstn),                               
	.i_wclk 	(p_clk),                               
	.i_we 		(rstn),                                
	.i_wdata 	({in_de, in_valid, in_hsync, in_vsync}),  
	.i_rclk 	(axi_clk),  
	.i_re 		(rstn),  
	.o_rdata 	({axi_de, axi_valid, axi_hsync, axi_vsync})
);
			
/* Rd count from DDR data valid */
always @(posedge axi_clk)
begin
    if (~rstn) 
	begin
		ba				<= 3'b0;		
		r_in_de_0L_1P	<= 1'b0;
		r_in_de_0L_2P	<= 1'b0;
		r_axi_hsync_1P	<= 1'b0;
		states			<= IDLE;
		r_rd_ycnt		<= 11'b0;
		r_axi_xcnt		<= 11'b0;
		r_axi_ycnt		<= 11'b0;
		r_rd_xcnt		<= 11'b0;
		out_0_ar_valid	<= 1'b0;
		out_0_r_ready	<= 1'b0;
		r_axi_new_line	<= 1'b0;
		r_rd_load		<= 1'b0;
	end
	else
	begin
		r_in_de_0L_1P	<= axi_de;
		r_in_de_0L_2P	<= r_in_de_0L_1P;		
		
		if (r_in_de_0L_1P && !r_in_de_0L_2P)
		begin
			r_axi_new_line 	<= 1'b1;
			r_rd_ycnt		<= r_axi_ycnt;
		end
			
		if (!r_in_de_0L_1P && r_in_de_0L_2P)
		begin
			if (r_axi_ycnt == y_start + y_win)
				r_axi_ycnt	<= y_start;
			else
				r_axi_ycnt	<= r_axi_ycnt + 1'b1;
		end	
		
		if (!axi_vsync)
			r_axi_ycnt	<= y_start;
					
		////////////////////////////////////////////////////////////				
		case (states)						
			IDLE:
			begin
				if (!r_rd_load)
				begin
					if (r_axi_new_line)
					begin					
						out_0_ar_valid	<= 1'b1;
						r_rd_load		<= 1'b1;
						r_axi_new_line	<= 1'b0;
						states			<= READ_ADDR;
					end
				end
			end
			
			READ_ADDR:
			begin
				if (in_0_ar_ready)
				begin
					out_0_ar_valid	<= 1'b0;
					out_0_r_ready	<= 1'b1;
					states			<= READ;
				end
			end
			
			READ:
			begin
				if (in_0_r_valid)
				begin
					if (r_rd_xcnt == x_win)
					begin
						r_rd_load		<= 1'b0;					
						r_rd_xcnt		<= 11'b0;
						out_0_r_ready	<= 1'b0;
						out_0_ar_valid	<= 1'b0;
						states			<= IDLE;
					end								
					else
					begin
						r_rd_xcnt	<= r_rd_xcnt + 1'b1;
						
						if (in_0_r_payload_last)
						begin						
							out_0_r_ready	<= 1'b0;
							out_0_ar_valid	<= 1'b1;
							states			<= READ_ADDR;									
						end		
					end		
				end
			end	

			default:
			begin
				r_rd_load		<= 1'b0;					
				r_rd_xcnt		<= 11'b0;
				out_0_r_ready	<= 1'b0;
				out_0_ar_valid	<= 1'b0;
				
				states			<= IDLE;
			end
		endcase
	end
end

/* Resync RAM data to RGB video */
always @(posedge p_clk)
begin
    if (~rstn) 
	begin	
		r_y_cnt			<= 11'b0;
		r_hs_1P			<= 1'b0;
		r_vs_1P			<= 1'b0;
		r_rd_addr		<= x_start;
		r_rd_addr_1P	<= 11'b0;
		r_rd_addr_2P	<= 11'b0;
		r_rd_addr_3P	<= 11'b0;
		r_rd_00         <= 8'b0;
		r_rd_01         <= 8'b0;
		r_rd_10         <= 8'b0;
		r_rd_11         <= 8'b0;
		r_de_2L_1P	<= 1'b0;
		r_de_2L_2P	<= 1'b0;
		r_de_2L_3P	<= 1'b0;
		r_y_cnt_2L_1P<= y_start;
		r_y_cnt_2L_2P<= 11'b0;
		r_y_cnt_2L_3P<= 11'b0;
		r_line_in_1L	<= 1'b0;
		r_line_in_2L	<= 1'b0;
		r_line_cnt		<= 2'b0;
		r_frame_cnt		<= 2'b0;
	end
	else
	begin		
		r_hs_1P			<= in_hsync;
		r_vs_1P			<= in_vsync;
		r_rd_addr_1P	<= r_rd_addr;
		r_rd_addr_2P	<= r_rd_addr_1P;
		r_rd_addr_3P	<= r_rd_addr_2P;
		r_de_2L_1P		<= w_de_2L;
		r_de_2L_2P		<= r_de_2L_1P;
		r_de_2L_3P		<= r_de_2L_2P;
		r_y_cnt_2L_2P	<= r_y_cnt_2L_1P;
		r_y_cnt_2L_3P	<= r_y_cnt_2L_2P;
		
		if (!w_de_2L && r_de_2L_1P)
		begin
			if (r_y_cnt_2L_1P == y_start + y_win)
				r_y_cnt_2L_1P	<= y_start;
			else
				r_y_cnt_2L_1P	<= r_y_cnt_2L_1P + 1'b1;
		end
		
		if (!w_vsync_2L)
			r_y_cnt_2L_1P	<= y_start;
				
		if (w_de_2L)
		begin		
			if (w_valid_2L)
				r_rd_addr	<= r_rd_addr + 1'b1;
		end
		else
			r_rd_addr	<= x_start;
				
		if (in_hsync && !r_hs_1P)
			r_line_cnt	<= r_line_cnt + 1'b1;
		
		if (r_line_cnt[0])
			r_line_in_1L	<= 1'b1;
		
		if (r_line_cnt[1])
			r_line_in_2L	<= 1'b1;
	end
end

/* Resync RED data from axi_clk to p_clk */
simple_dual_port_ram
#(
	. DATA_WIDTH   	(32),
	. ADDR_WIDTH	(12)
)
inst_simple_dual_port_ram_00
(
	.wclk	(axi_clk					),
	.we		(in_0_r_valid				),
	.waddr	({r_rd_ycnt[0], r_rd_xcnt}),
	.wdata	(in_0_r_payload_data		),
		
	.rclk	(p_clk											),
	.re		(r_de_2L_1P										),
	.raddr	({r_y_cnt_2L_1P[0], r_rd_addr_1P}				),	
	.rdata	({out_rd_00, out_rd_01, out_rd_10, out_rd_11}	)
);

/* FIFO delay for RGB sync signals */
shift_reg
#(
	.D_WIDTH(4),
	.TAPE(3)
)
inst_shift_reg_02
(                                                                    
	.i_arst(~rstn	),                                               
	.i_clk(p_clk	),                                               

	.i_d({w_de_2L, w_valid_2L, w_hsync_2L, w_vsync_2L}	),
	.o_q({out_de, out_valid, out_hsync, out_vsync}		)                  	
);

/* 1 line delay for RGB sync signals */
fifo 
#(
	.DATA_WIDTH(4),
    .ADDR_WIDTH(13)
)	   
fifo_01 
(
  .clk 		(p_clk	),
  .nrst 	(rstn	),
  .we 		(r_line_in_1L),
  .re 		(r_line_in_2L),
  .data_in 	({in_de, in_valid, in_hsync, in_vsync}			),
  .data_out ({w_de_2L, w_valid_2L, w_hsync_2L, w_vsync_2L}	)
  );

endmodule
