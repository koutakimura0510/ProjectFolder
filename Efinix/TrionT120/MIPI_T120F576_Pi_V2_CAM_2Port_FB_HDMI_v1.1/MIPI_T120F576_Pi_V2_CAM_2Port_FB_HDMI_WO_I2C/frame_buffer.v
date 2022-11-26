
`timescale 1ps/1ps
module frame_buffer 
#(
	parameter X_TOTAL		= 1024,
	parameter Y_TOTAL		= 1090,	
	parameter WR_FRAME		= 0,
	parameter RD_FRAME		= 0,
	parameter START_ADDR 	= 32'h00000000,
	parameter STOP_ADDR 	= 32'h04000000
)
(
input rstn,
input wr_p_clk,
input rd_p_clk,
input axi_clk,

input [10:0]		x_win,
input [10:0]		x_start,
input [10:0]		y_win,
input [10:0]		y_start,

output [7:0] 		aid,
output [31:0] 		aaddr,
output [7:0] 		alen,
output [2:0] 		asize,
output [1:0] 		aburst,
output [1:0] 		alock,
output 				avalid,
input 				aready,
output  			atype,

output [7:0] 		wid,
output [255:0] 		wdata,
output [31:0] 		wstrb,
output 	 			wlast,
output 	 			wvalid,
input 				wready,

input [7:0] 		rid,
input [255:0] 		rdata,
input 				rlast,
input 				rvalid,
output 	 			rready,
input [1:0] 		rresp,

input [7:0] 		bid,
input 				bvalid,
output	 			bready,

input [10:0] 		in_x_wr,
input [10:0] 		in_y_wr,
input				in_wr_en,
input				in_hs,

input [7:0]			in_wr_00,
input [7:0]			in_wr_01,
input [7:0]			in_wr_10,
input [7:0]			in_wr_11,
	
input		 		in_de,
input				in_valid,
input				in_hsync,
input				in_vsync,
	
output          	out_de,
output				out_valid,
output          	out_hsync,
output          	out_vsync,
output [7:0] 		out_rd_00,
output [7:0] 		out_rd_01,
output [7:0] 		out_rd_10,
output [7:0] 		out_rd_11
);

reg         r_wr_vs_cnt;
reg         r_rd_vs_cnt;
reg			r_rd_vs_1P;
reg [4:0]	r_b_payload_id;

wire		out_0_aw_valid		;
wire		out_1_aw_valid		;
wire		out_0_ar_valid		;
wire		w_0_aw_valid		;
wire		w_0_aw_ready		;
wire[31:0]	w_0_aw_payload_addr ;
wire		w_0_w_valid		    ;
wire		w_0_w_ready		    ;
wire[31:0]	w_0_w_payload_data  ;
wire		w_0_w_payload_last	;
wire		w_0_b_valid		    ;
wire		w_0_b_ready		    ;
wire[3:0]	w_0_b_payload_id	;
wire[1:0]	w_0_b_payload_resp  ;
wire		w_1_aw_valid		;
wire		w_1_aw_ready		;
wire[31:0]	w_1_aw_payload_addr ;
wire		w_1_w_valid		    ;
wire		w_1_w_ready		    ;
wire[31:0]	w_1_w_payload_data  ;
wire		w_1_w_payload_last	;
wire		w_1_b_valid		    ;
wire		w_1_b_ready		    ;
wire[3:0]	w_1_b_payload_id	;
wire[1:0]	w_1_b_payload_resp  ;
wire		w_0_ar_valid		;
wire		w_0_ar_ready		;
wire[31:0]	w_0_ar_payload_addr ;
wire		w_0_r_valid		    ;
wire		w_0_r_ready		    ;
wire[31:0]	w_0_r_payload_data	;
wire[3:0]	w_0_r_payload_id	;
wire[1:0]	w_0_r_payload_resp	;
wire		w_0_r_payload_last	;

/* Frame count for RD */
always @(posedge rd_p_clk)
begin
    if (~rstn) 
	begin		
		r_rd_vs_cnt	<= 1'b0;
		r_rd_vs_1P	<= 1'b0;		
	end
	else
	begin
		r_rd_vs_1P	<= in_vsync;
		
		if (!in_vsync && r_rd_vs_1P)
			r_rd_vs_cnt	<= ~r_rd_vs_cnt;
	end
end

/* Frame count for WR */
always @(posedge wr_p_clk)
begin
    if (~rstn) 
	begin		
		r_wr_vs_cnt	<= 1'b0;
	end
	else
	begin		
		if ((in_x_wr == X_TOTAL - 1) && (in_y_wr == Y_TOTAL - 1) && in_wr_en)
			r_wr_vs_cnt	<= ~r_wr_vs_cnt;
	end
end

/* 
	RAM read address decoder and repack data
	32bit address and data
*/
rd_address_decoder
#(
	.X_TOTAL	(X_TOTAL)
)
inst_rd_address_decoder_0
(
	.rstn				(rstn		),
	.p_clk				(rd_p_clk	),
	.axi_clk			(axi_clk	),
			
	.x_win				(x_win		),
	.x_start			(x_start	),
	.y_win				(y_win		),
	.y_start			(y_start	),

	.in_de				(in_de		),
	.in_valid			(in_valid	),
	.in_hsync			(in_hsync	),
	.in_vsync			(in_vsync	),
	.in_frame_cnt		(r_rd_vs_cnt),
		
	.in_0_ar_ready		(w_0_ar_ready		),
	.in_0_r_valid		(w_0_r_valid		),
	.in_0_r_payload_data(w_0_r_payload_data	),
	.in_0_r_payload_last(w_0_r_payload_last	),
	
	.out_0_ar_valid		(out_0_ar_valid		),
	.out_0_ar_addr		(w_0_ar_payload_addr),
	.out_0_r_ready		(w_0_r_ready		),
	
	.out_de				(out_de		),
	.out_valid			(out_valid	),
	.out_hsync			(out_hsync	),
	.out_vsync			(out_vsync	),
	.out_rd_00			(out_rd_00	),
	.out_rd_01			(out_rd_01	),
	.out_rd_10			(out_rd_10	),
	.out_rd_11			(out_rd_11	)
);

/* 
	RAM write address decoder and repack data
	32bit address and data
*/
/* Even frame */
wr_address_decoder
#(
	.X_TOTAL	(X_TOTAL)
)
inst_wr_address_decoder_0
(
	.rstn			(rstn && !r_wr_vs_cnt),
	.p_clk			(wr_p_clk	),
	.axi_clk		(axi_clk	),
			
	.x_win			(x_win		),
	.x_start		(x_start	),
	.y_win			(y_win		),
	.y_start		(y_start	),
		
	.in_x_wr		(in_x_wr	),
	.in_y_wr		(in_y_wr	),
	.in_wr_en		(in_wr_en	),
	.in_hs			(in_hs		),
	.in_frame_cnt	(r_wr_vs_cnt),
	
	.in_wr_00		(in_wr_00	),
	.in_wr_01		(in_wr_01	),
	.in_wr_10		(in_wr_10	),
	.in_wr_11		(in_wr_11	),
	
	.in_wr_aready	(w_0_aw_ready	),
	.in_wr_ready	(w_0_w_ready	),	
	.in_wr_bvalid	(w_0_b_valid	),
		
	.out_wr_avalid	(out_0_aw_valid		),
	.out_wr_valid	(w_0_w_valid		),
	.out_wr_bready	(w_0_b_ready		),
	.out_wr_last	(w_0_w_payload_last	),
	.out_wr_addr	(w_0_aw_payload_addr),
	.out_wr_data	(w_0_w_payload_data	)
);

/* Odd frame */
wr_address_decoder
#(
	.X_TOTAL	(X_TOTAL)
)
inst_wr_address_decoder_1
(
	.rstn			(rstn && r_wr_vs_cnt),
	.p_clk			(wr_p_clk	),
	.axi_clk		(axi_clk	),
			
	.x_win			(x_win		),
	.x_start		(x_start	),
	.y_win			(y_win		),
	.y_start		(y_start	),
		
	.in_x_wr		(in_x_wr	),
	.in_y_wr		(in_y_wr	),
	.in_wr_en		(in_wr_en	),
	.in_hs			(in_hs		),
	.in_frame_cnt	(r_wr_vs_cnt),
	
	.in_wr_00		(in_wr_00	),
	.in_wr_01		(in_wr_01	),
	.in_wr_10		(in_wr_10	),
	.in_wr_11		(in_wr_11	),
	
	.in_wr_aready	(w_1_aw_ready	),
	.in_wr_ready	(w_1_w_ready	),	
	.in_wr_bvalid	(w_1_b_valid	),
		
	.out_wr_avalid	(out_1_aw_valid		),
	.out_wr_valid	(w_1_w_valid		),
	.out_wr_bready	(w_1_b_ready		),
	.out_wr_last	(w_1_w_payload_last	),
	.out_wr_addr	(w_1_aw_payload_addr),
	.out_wr_data	(w_1_w_payload_data	)
);

/* Axicrossbar 2x32 in, 1x256 out_0_ar_addr */
Axi4_2x32_1x256
#(
)
inst_Axi4_2x32_1x256_00
(
	.io_inputs_0_aw_valid			(w_0_aw_valid		),
	.io_inputs_0_aw_ready			(w_0_aw_ready		),
	.io_inputs_0_aw_payload_addr	(w_0_aw_payload_addr),
	.io_inputs_0_aw_payload_id		(4'b0				),
	.io_inputs_0_aw_payload_region	(4'b0				),
	.io_inputs_0_aw_payload_len		(8'd63				),
	.io_inputs_0_aw_payload_size	(3'b010				),
	.io_inputs_0_aw_payload_burst	(2'b01				),
	.io_inputs_0_aw_payload_lock	(1'b0				),
	.io_inputs_0_aw_payload_cache	(4'b0				),
	.io_inputs_0_aw_payload_qos		(4'b0				),
	.io_inputs_0_aw_payload_prot	(3'b0				),
	.io_inputs_0_w_valid			(w_0_w_valid		),
	.io_inputs_0_w_ready			(w_0_w_ready		),
	.io_inputs_0_w_payload_data		(w_0_w_payload_data	),
	.io_inputs_0_w_payload_strb		(4'b1111			),
	.io_inputs_0_w_payload_last		(w_0_w_payload_last	),
	.io_inputs_0_b_valid			(w_0_b_valid		),
	.io_inputs_0_b_ready			(w_0_b_ready		),
	.io_inputs_0_b_payload_id		(w_0_b_payload_id	),
	.io_inputs_0_b_payload_resp		(w_0_b_payload_resp	),
	//
	.io_inputs_0_ar_valid			(w_0_ar_valid		),
	.io_inputs_0_ar_ready			(w_0_ar_ready		),
	.io_inputs_0_ar_payload_addr	(w_0_ar_payload_addr),
	.io_inputs_0_ar_payload_id		(4'b0				),
	.io_inputs_0_ar_payload_region	(4'b0				),
	.io_inputs_0_ar_payload_len		(8'd63				),
	.io_inputs_0_ar_payload_size	(3'b010				),
	.io_inputs_0_ar_payload_burst	(2'b01				),
	.io_inputs_0_ar_payload_lock	(1'b0				),
	.io_inputs_0_ar_payload_cache	(4'b0				),
	.io_inputs_0_ar_payload_qos		(4'b0				),
	.io_inputs_0_ar_payload_prot	(3'b0				),
	.io_inputs_0_r_valid			(w_0_r_valid		),
	.io_inputs_0_r_ready			(w_0_r_ready		),
	.io_inputs_0_r_payload_data		(w_0_r_payload_data	),
	.io_inputs_0_r_payload_id		(w_0_r_payload_id	),
	.io_inputs_0_r_payload_resp		(w_0_r_payload_resp	),
	.io_inputs_0_r_payload_last		(w_0_r_payload_last	),
	//
	.io_inputs_1_aw_valid			(w_1_aw_valid		),
	.io_inputs_1_aw_ready			(w_1_aw_ready		),
	.io_inputs_1_aw_payload_addr	(w_1_aw_payload_addr),
	.io_inputs_1_aw_payload_id		(4'b1000			),
	.io_inputs_1_aw_payload_region	(4'b0				),
	.io_inputs_1_aw_payload_len		(8'd63				),
	.io_inputs_1_aw_payload_size	(3'b010				),
	.io_inputs_1_aw_payload_burst	(2'b01				),
	.io_inputs_1_aw_payload_lock	(1'b0				),
	.io_inputs_1_aw_payload_cache	(4'b0				),
	.io_inputs_1_aw_payload_qos		(4'b0				),
	.io_inputs_1_aw_payload_prot	(3'b0				),
	.io_inputs_1_w_valid			(w_1_w_valid		),
	.io_inputs_1_w_ready			(w_1_w_ready		),
	.io_inputs_1_w_payload_data		(w_1_w_payload_data	),
	.io_inputs_1_w_payload_strb		(4'b1111			),
	.io_inputs_1_w_payload_last		(w_1_w_payload_last	),
	.io_inputs_1_b_valid			(w_1_b_valid		),
	.io_inputs_1_b_ready			(w_1_b_ready		),
	.io_inputs_1_b_payload_id		(w_1_b_payload_id	),
	.io_inputs_1_b_payload_resp		(w_1_b_payload_resp	),
	//
	.io_inputs_1_ar_valid			(1'b0			),
	.io_inputs_1_ar_ready			(),               
	.io_inputs_1_ar_payload_addr	(32'b0			),
	.io_inputs_1_ar_payload_id		(4'b1000		),
	.io_inputs_1_ar_payload_region	(4'b0			),
	.io_inputs_1_ar_payload_len		(8'd63			),
	.io_inputs_1_ar_payload_size	(3'b010			),
	.io_inputs_1_ar_payload_burst	(2'b01			),
	.io_inputs_1_ar_payload_lock	(1'b0			),
	.io_inputs_1_ar_payload_cache	(4'b0			),
	.io_inputs_1_ar_payload_qos		(4'b0			),
	.io_inputs_1_ar_payload_prot	(3'b0			),
	.io_inputs_1_r_valid			(),               
	.io_inputs_1_r_ready			(1'b0),           
	.io_inputs_1_r_payload_data		(),               
	.io_inputs_1_r_payload_id		(),               
	.io_inputs_1_r_payload_resp		(),               
	.io_inputs_1_r_payload_last		(),               
	//
	.io_output_arw_valid			(avalid			),
	.io_output_arw_ready			(aready			),
	.io_output_arw_payload_addr		(aaddr			),
	.io_output_arw_payload_id		(aid[4:0]		),
	.io_output_arw_payload_region	(),					
	.io_output_arw_payload_len		(alen			),
	.io_output_arw_payload_size		(asize			),
	.io_output_arw_payload_burst	(aburst			),
	.io_output_arw_payload_lock		(alock			),
	.io_output_arw_payload_cache	(),					
	.io_output_arw_payload_qos		(),					
	.io_output_arw_payload_prot		(),					
	.io_output_arw_payload_write	(atype			),
	//
	.io_output_w_valid				(wvalid				),
	.io_output_w_ready				(wready				),
	.io_output_w_payload_data		(wdata				),
	.io_output_w_payload_strb		(wstrb				),
	.io_output_w_payload_last		(wlast				),
	.io_output_b_valid				(bvalid				),
	.io_output_b_ready				(bready				),
	.io_output_b_payload_id			(r_b_payload_id		),
	.io_output_b_payload_resp		(2'b0				),
	//
	.io_output_r_valid				(rvalid				),
	.io_output_r_ready				(rready				),
	.io_output_r_payload_data		(rdata				),
	.io_output_r_payload_id			(5'b00000			),
	.io_output_r_payload_resp		(2'b0				),
	.io_output_r_payload_last		(rlast				),
	.io_output_arw_id				(wid[4:0]			),
	//
	.clk							(axi_clk			),
	.reset							(~rstn				)
);

/* Payload ID for write */
always @(posedge axi_clk)
begin
    if (~rstn) 
	begin		
		r_b_payload_id	<= 5'b0;	
	end
	else
	begin
		if (atype)
		begin
			if (aid[4] && aid[3])
				r_b_payload_id[4]	<= 1'b1;				
			else
				r_b_payload_id[4]	<= 1'b0;
		end	
	end
end

assign	w_0_aw_valid = out_0_aw_valid;
assign	w_1_aw_valid = out_1_aw_valid;
assign	w_0_ar_valid = (out_0_aw_valid || out_1_aw_valid) ? 1'b0 : out_0_ar_valid;

assign	aid[7:5]	= 3'd0;
assign	wid[7:5] 	= 3'd0;

endmodule
