`define	DU	8

module frame_buf_tb();

localparam	RX_DW	= `DU*2;

reg		r_mipi_pclk;
reg		r_axi_pclk;
reg		r_i_arstn;

reg		[3:0]r_mipi_inst1_HSYNC;
reg		r_mipi_inst1_VALID;
reg		in_valid;
reg		[RX_DW-1:0]r_in_inst1_DATA;
reg		[RX_DW-1:0]r_in_inst1_DATA_1P;
reg		[RX_DW-1:0]r_in_inst1_DATA_2P;
reg		[RX_DW-1:0]r_in_inst1_DATA_3P;
reg		[RX_DW-1:0]r_in_inst1_DATA_4P;
reg		[RX_DW-1:0]r_in_inst1_DATA_5P;
reg		[RX_DW-1:0]r_in_inst1_DATA_6P;

reg		[2:0]r_b;
reg		[10:0]r_x;
reg		[10:0]r_y;

reg		[2:0]	cnt;

reg 	r_mipi2_tx_valid_1P;
reg 	[`DU-1:0] r_in_data_1P;	
reg 	[`DU-1:0] r_in_data_2P;

reg	[RX_DW-1:0]	r_slow_data_1P;
reg			vsync_r_lvds_mipi_1P;
reg			hsync_r_lvds_mipi_1P;
reg			de_r_lvds_mipi_1P;
reg			r_4to2_cnt;

wire	w_mipi_tx_hsync_1;
wire	w_mipi_tx_valid_1;

wire	w_mipi_tx_hsync;
wire	w_mipi_tx_valid;

wire	w_mipi2_tx_hsync;
wire	w_mipi2_tx_valid;
wire	[`DU-1:0]w_mipi2_tx_data;

wire			w_mipi2_tx_hsync_00;
wire			w_mipi2_tx_de_00;
wire	[RX_DW-1:0]	w_mipi2_tx_11;
wire	[RX_DW-1:0]  w_mipi2_tx_00;
wire	[RX_DW-1:0]  w_mipi2_tx_01;
wire	[RX_DW-1:0]	w_raw_data;

wire	[`DU-1:0]	w_mipi2_tx_11_0;
wire	[`DU-1:0]	w_mipi2_tx_11_1;
wire	[`DU-1:0]	w_mipi2_tx_11_2;
wire	[`DU-1:0]	w_mipi2_tx_11_3;

initial
begin
	r_mipi_pclk	<= 1'b1;
	forever
		#3	r_mipi_pclk	<= ~r_mipi_pclk;
end

initial
begin
	r_axi_pclk	<= 1'b1;
	forever
		#2	r_axi_pclk	<= ~r_axi_pclk;
end

initial
begin
		r_i_arstn						<= 1'b0;
		r_in_inst1_DATA[0*`DU+:`DU]	<= `DU'h001;
		r_in_inst1_DATA[1*`DU+:`DU]	<= `DU'h002;
		//r_in_inst1_DATA[2*`DU+:`DU]	<= `DU'h003;
		//r_in_inst1_DATA[3*`DU+:`DU]	<= `DU'h004;
		
	#10	r_i_arstn			<= 1'b1;
end

always@(posedge r_mipi_pclk or negedge r_i_arstn)
begin
	if (~r_i_arstn)
	begin
		r_mipi_inst1_HSYNC	<= {4{1'b1}};
		r_mipi_inst1_VALID	<= 1'b0;
		cnt					<= {3{1'b0}};
		
		r_b	<= {3{1'b0}};
		r_x	<= {11{1'b0}};
		r_y	<= {11{1'b0}};
		in_valid	<= 1'b0;
	end
	else
	begin
		r_b	<= r_b+1'b1;
		
		r_in_inst1_DATA_1P <= r_in_inst1_DATA;
		r_in_inst1_DATA_2P <= r_in_inst1_DATA_1P;
		r_in_inst1_DATA_3P <= r_in_inst1_DATA_2P;
		r_in_inst1_DATA_4P <= r_in_inst1_DATA_3P;
		r_in_inst1_DATA_5P <= r_in_inst1_DATA_4P;
		r_in_inst1_DATA_6P <= r_in_inst1_DATA_5P;
		
		if (r_x < 12'd960)
		begin
			r_mipi_inst1_VALID		<= 1'b1;
			r_in_inst1_DATA[`DU*1-3:`DU*0]	<= r_in_inst1_DATA[`DU*1-3:`DU*0]+2'd2;
			r_in_inst1_DATA[`DU*2-3:`DU*1]	<= r_in_inst1_DATA[`DU*2-3:`DU*1]+2'd2;
		end
		else
		begin		
			r_mipi_inst1_VALID		<= 1'b0;
			r_in_inst1_DATA[`DU*1-3:`DU*0]	<= 'h01;
			r_in_inst1_DATA[`DU*2-3:`DU*1]	<= 'h02;		
		end
		
		if (r_mipi_inst1_VALID)
			in_valid	<= ~in_valid;
		else
			in_valid	<= 1'b0;
					
		r_x	<= r_x+1'b1;
				
		if (r_x == 1100)
		begin
			r_mipi_inst1_HSYNC[0]	<= 1'b0;
			r_x	<= {11{1'b0}};
			r_y <= r_y + 1'b1;			
		end
		else if (r_x == 12'd44)
		begin
			r_mipi_inst1_HSYNC[0]	<= 1'b1;
		end
	end
end

//-----------------------------------------------------------//
// 1920*1080 VGA 60Hz fps
//-----------------------------------------------------------//
parameter LinePeriod 	= 12'd2200;        
parameter H_SyncPulse	= 8'd44;            
parameter H_BackPorch	= 8'd148;             
parameter H_ActivePix	= 12'd1920;            
parameter H_FrontPorch	= 8'd88;          
parameter Hde_start		= 8'd192;
parameter Hde_end		= 12'd2112;
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// 1920*1080 VGA 60Hz fps
//-----------------------------------------------------------//
parameter FramePeriod 	= 11'd1125;           
parameter V_SyncPulse	= 6'd5;              
parameter V_BackPorch	= 6'd36;             
parameter V_ActivePix	= 11'd1080;            
parameter V_FrontPorch	= 6'd4;
parameter Vde_start		= 6'd41;
parameter Vde_end		= 11'd1121;
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// FIFO size
//-----------------------------------------------------------//
parameter FIFO_ADDR_WIDTH = 13;
parameter FIFO_DEPTH = (1 << FIFO_ADDR_WIDTH);
parameter HALF_FIFO_DEPTH = FIFO_DEPTH >> 1;
//-----------------------------------------------------------//

parameter X_TOTAL		= 976;
parameter BY4_X_TOTAL	= X_TOTAL >> 2;

//Main states
localparam
	IDLE = 4'b0000, 
	WRITE_ADDR = 4'b0001,
	PRE_WRITE = 4'b0010,
	WRITE = 4'b0011,
	POST_WRITE = 4'b0100,
	READ_ADDR = 4'b0101,
	PRE_READ = 4'b0110,
	READ = 4'b0111,
	POST_READ = 4'b1000,
	DONE = 4'b1001;

wire       		out_0_aw_valid;
wire       		out_1_aw_valid;
wire       		out_aw_valid;
wire       		w_0_aw_valid;
wire       		w_0_aw_ready;
wire[31:0] 		w_0_aw_payload_addr;
wire[3:0]  		w_0_aw_payload_id;
wire       		w_0_w_valid;
wire       		w_0_w_ready;
wire[31:0] 		w_0_w_payload_data;
wire       		w_0_payload_last;		
wire       		w_0_b_valid;
wire       		w_0_b_ready;
wire[3:0]  		w_0_b_payload_id;
wire[1:0]  		w_0_b_payload_resp;
wire       		w_1_aw_valid;
wire       		w_1_aw_ready;
wire[31:0] 		w_1_aw_payload_addr;
wire[3:0]  		w_1_aw_payload_id;
wire       		w_1_w_valid;
wire       		w_1_w_ready;
wire[31:0] 		w_1_w_payload_data;
wire       		w_1_payload_last;		
wire       		w_1_b_valid;
wire       		w_1_b_ready;
wire[3:0]  		w_1_b_payload_id;
wire[1:0]  		w_1_b_payload_resp;
wire       		w_w_valid;
wire[255:0] 	w_w_payload_data;
wire[31:0]  	w_w_payload_strb;
wire       		w_w_payload_last;
wire       		w_b_ready;
wire[4:0]  		w_b_payload_id;
wire[1:0]  		w_b_payload_resp;

wire[31:0]		w_in_rd_addr;
wire[255:0]		w_in_rd_data;
wire[255:0]		w_wr_data;
wire[255:0]		w_g_00_00_1P;
wire[255:0]		w_b_00_00_1P;
wire[255:0]		in_rd_data;
wire[10:0]		w_wr_y;
wire			w_wr_fifo_valid;
wire			w_out_wr_fifo_den;
wire			w_wr_valid;
wire			w_rd_valid;
wire           	w_out_rd_valid;
wire[31:0]      w_out_rd_addr;
wire[31:0]      w_out_wr_addr;
wire[7:0]      out_rd_00;
wire[7:0]      out_rd_01;
wire[7:0]      out_rd_10;
wire[7:0]      out_rd_11;
wire            out_de;
wire            out_hsync;
wire            out_vsync;
wire			w_in_de;
wire			w_rd_en;
wire[10:0]		x_win;
wire[10:0]		x_start;
wire[10:0]		y_win;
wire[10:0]		y_start;

wire      		w_0_ar_valid;
wire      		w_0_ar_ready;
wire[31:0]		w_0_ar_payload_addr;
wire[3:0] 		w_0_ar_payload_id;
wire[3:0] 		w_0_ar_payload_region;
wire[7:0] 		w_0_ar_payload_len;
wire[2:0] 		w_0_ar_payload_size;
wire[1:0] 		w_0_ar_payload_burst;
wire[0:0] 		w_0_ar_payload_lock;
wire[3:0] 		w_0_ar_payload_cache;
wire[3:0] 		w_0_ar_payload_qos;
wire[2:0] 		w_0_ar_payload_prot;
wire      		w_0_r_ready;
wire[31:0]		w_0_r_payload_data;
wire[3:0] 		w_0_r_payload_id;
wire[1:0] 		w_0_r_payload_resp;

wire      		w_arw_valid;
wire			w_arw_ready;
wire[31:0]		w_arw_payload_addr;
wire[4:0] 		w_arw_payload_id;
wire[3:0] 		w_arw_payload_region;
wire[7:0] 		w_arw_payload_len;
wire[2:0] 		w_arw_payload_size;
wire[1:0] 		w_arw_payload_burst;
wire[0:0] 		w_arw_payload_lock;
wire[3:0] 		w_arw_payload_cache;
wire[3:0] 		w_arw_payload_qos;
wire[2:0] 		w_arw_payload_prot;
wire			w_arw_payload_write;
wire			w_aw_valid;
wire			w_ar_valid;
wire      		w_r_ready;
wire[255:0]		w_r_payload_data;
wire[4:0] 		w_r_payload_id;
wire[1:0] 		w_r_payload_resp;
wire      		w_r_payload_last;
wire[4:0]		w_output_arw_id;
wire			w_de_delay;
wire			w_hs_delay;
wire			w_r_valid;

wire[1:0]		debug_rd_states;

reg	[2047:0]	r_fifo_data;
reg	[31:0]		aaddr;
reg	[10:0]		r_x_1P;
reg [11:0]		r_by4_wr_cnt;
reg [11:0]		r_by4_rd_cnt;
reg	[3:0]		wr_states;
reg	[3:0]		rd_states;
reg				r_rd_VALID_1P;
reg				r_rd_VALID_2P;
reg				r_rd_VALID_3P;
reg				r_rd_VALID_4P;
reg				r_start_rd;
reg				r_axi_wr_valid;
reg [4:0]		r_9_wr_cnt;
reg [4:0]		r_9_rd_cnt;
reg				r_axi_rd_valid;
reg				r_in_wr_ready;
reg				avalid;
reg				atype;
reg [1:0]		aburst;
reg	[2:0]		asize;
reg	[7:0]		alen;
reg	[7:0]		aid;
reg	[1:0]		alock;
reg				wvalid;
reg				rvalid;
reg	[2:0]		write_cnt;
reg	[3:0]		per_write_cnt;
reg	[7:0]		r_r_xcnt;
reg	[7:0]		r_r_ycnt;
reg				write_done;
reg	[4:0]		write_cycle;
reg [4:0] 		write_cycle_1P;
reg [4:0] 		write_cycle_2P;
reg [4:0] 		write_cycle_3P;
reg				read_done;
reg	[4:0]		r_read_cycle;
reg [4:0] 		pre_write_cycle;
reg [4:0] 		pre_read_cycle;
reg				wlast;
reg				rlast;
reg				bready;
reg				bvalid;
reg				done;
reg				rready;
reg				wready;
reg				cmp;
reg [3:0]		states;
reg				aready;
reg				r_wr_VALID_1P;
reg [255:0]		r_wr_data;
reg	[255:0]		r_rd_data;
reg				rvalid_1P;
reg	[31:0]		r_addr_1P;
reg	[31:0]		r_addr_2P;
reg 			r_wready_1P;
reg 			r_wready_2P;
reg [10:0]		r_y_1P;
reg				r_mipi_inst1_VALID_1P;
reg [255:0]	r_wdata_0P;
reg [255:0]	r_wdata_1P;
reg [255:0]	r_wdata_2P;
reg [255:0]	r_wdata_3P;
reg [255:0]	r_wdata_4P;
reg [255:0]	r_wdata_5P;
reg [255:0]	r_wdata_6P;
reg [255:0]	r_wdata_7P;
reg [255:0]	wdata;
reg [255:0]	r_out_wr_data;
reg			fifo_done;
reg			rd_load;
reg			wr_load;
reg			wr_start;
reg			burst_start;
reg [255:0]	r_rdata;
reg [31:0]	r_waddr_1P;
reg			rd_new_line;
reg			wr_new_line;
reg			fifo_en;
reg	[10:0]	r_rd_y_ram;
reg	[10:0]	r_wr_y_ram;
reg	[10:0]	r_wr_addr_1P;
reg	[10:0]	r_wr_addr_2P;
reg	[10:0]	r_wr_addr_3P;
reg       	r_aw_ready;	
reg      	r_w_ready;
reg			r_b_valid;
reg      	r_ar_ready;
reg      	r_0_r_valid;
reg			r_0_r_payload_last;
reg			r_r_valid;
reg			r_r_payload_last;
reg			r_axi_delay;
reg         r_0_aw_valid;
reg         r_0_ar_valid;
reg [2:0]	r_rd_last;
reg	[4:0]	r_b_payload_id;

assign	x_win 	= 511;
assign	x_start	= 0;
assign	y_win	= 1079;
assign	y_start = 0;

always@(posedge r_mipi_pclk or negedge r_i_arstn)
begin
	if (~r_i_arstn)
	begin
		r_x_1P			<= 11'b0;
		r_y_1P			<= 11'b0;
		r_mipi_inst1_VALID_1P	<= 1'b0;
		r_axi_delay <= 1'b0;
	end
	else
	begin
		r_mipi_inst1_VALID_1P	<= r_mipi_inst1_VALID;
		if (r_mipi_inst1_VALID)
		begin
			if (in_valid)
				r_x_1P	<= r_x_1P + 1'b1;
		end
		else
			r_x_1P			<= 11'b0;
		
		if (!r_mipi_inst1_VALID && r_mipi_inst1_VALID_1P)
			r_y_1P			<= r_y_1P + 1'b1;
		
		if (r_y_1P[1])
			r_axi_delay <= 1'b1;
	end
end

dual_clock_fifo
#(	
	.DATA_WIDTH(2),
    .ADDR_WIDTH(12)
) 
dual_clock_fifo_in0 
(
	.i_arst 	(~r_i_arstn),
	.i_wclk 	(r_mipi_pclk),
	.i_we 		(r_i_arstn),
	.i_wdata 	({r_mipi_inst1_VALID, r_mipi_inst1_HSYNC[0]}),  
	.i_rclk 	(r_axi_pclk),  
	.i_re 		(r_axi_delay),  
	.o_rdata 	({w_de_delay, w_hs_delay}),
	//
	.o_full		(),
	.o_empty	(),
	.o_afull	(),
	.o_wcnt		(),
	.o_aempty	(),
	.o_rcnt		()
);

reg			r_axi_rstn;

// Axicrossbar 2x32 in, 1x256 out_0_ar_addr
Axi4_2x32_1x256
#(
)
inst_Axi4_2x32_1x256_00
(
	.io_inputs_0_aw_valid			(w_0_aw_valid		),//(1'd0				),//
	.io_inputs_0_aw_ready			(w_0_aw_ready		),//(),					  //
	.io_inputs_0_aw_payload_addr	(w_0_aw_payload_addr),//(32'b0				),//
	.io_inputs_0_aw_payload_id		(4'b0				),//(4'd0				),//
	.io_inputs_0_aw_payload_region	(4'b0				),//(4'b0				),//
	.io_inputs_0_aw_payload_len		(8'd63				),//(8'd7				),//
	.io_inputs_0_aw_payload_size	(3'b010				),//(3'b010				),//
	.io_inputs_0_aw_payload_burst	(2'b01				),//(2'b01				),//
	.io_inputs_0_aw_payload_lock	(1'b0				),//(1'b0				),//
	.io_inputs_0_aw_payload_cache	(4'b0				),//(4'b0				),//
	.io_inputs_0_aw_payload_qos		(4'b0				),//(4'b0				),//
	.io_inputs_0_aw_payload_prot	(3'b0				),//(3'b0				),//
	.io_inputs_0_w_valid			(w_0_w_valid		),//(1'b0				),//
	.io_inputs_0_w_ready			(w_0_w_ready		),//(),					  //
	.io_inputs_0_w_payload_data		(w_0_w_payload_data	),//(32'b0				),//
	.io_inputs_0_w_payload_strb		(4'b1111			),//(4'b1111			),//
	.io_inputs_0_w_payload_last		(w_0_payload_last	),//(1'b0				),//
	.io_inputs_0_b_valid			(w_0_b_valid		),//(),					  //
	.io_inputs_0_b_ready			(w_0_b_ready		),//(1'b0				),//
	.io_inputs_0_b_payload_id		(w_0_b_payload_id	),//(),					  //
	.io_inputs_0_b_payload_resp		(w_0_b_payload_resp	),//(),					  //
	//
	.io_inputs_0_ar_valid			(w_0_ar_valid		),//(1'b0				),//
	.io_inputs_0_ar_ready			(w_0_ar_ready		),//(),                   //
	.io_inputs_0_ar_payload_addr	(w_0_ar_payload_addr),//(32'b0				),//
	.io_inputs_0_ar_payload_id		(4'b0				),//(4'b0				),//
	.io_inputs_0_ar_payload_region	(4'b0				),//(4'b0				),//
	.io_inputs_0_ar_payload_len		(8'd63				),//(8'd7				),//
	.io_inputs_0_ar_payload_size	(3'b010				),//(3'b010				),//
	.io_inputs_0_ar_payload_burst	(2'b01				),//(2'b01				),//
	.io_inputs_0_ar_payload_lock	(1'b0				),//(1'b0				),//
	.io_inputs_0_ar_payload_cache	(4'b0				),//(4'b0				),//
	.io_inputs_0_ar_payload_qos		(4'b0				),//(4'b0				),//
	.io_inputs_0_ar_payload_prot	(3'b0				),//(3'b0				),//
	.io_inputs_0_r_valid			(w_0_r_valid		),//(),                   //
	.io_inputs_0_r_ready			(w_0_r_ready		),//(1'b0),               //
	.io_inputs_0_r_payload_data		(w_0_r_payload_data	),//(),                   //
	.io_inputs_0_r_payload_id		(w_0_r_payload_id	),//(),                   //
	.io_inputs_0_r_payload_resp		(w_0_r_payload_resp	),//(),                   //
	.io_inputs_0_r_payload_last		(w_0_r_payload_last	),//(),                   //
	//
	.io_inputs_1_aw_valid			(1'd0				),//(w_1_aw_valid		),//(1'd0				),//
	.io_inputs_1_aw_ready			(),					  //(w_1_aw_ready		),//(),					  //
	.io_inputs_1_aw_payload_addr	(32'b0				),//(w_1_aw_payload_addr),//(32'b0				),//
	.io_inputs_1_aw_payload_id		(4'b1000			),//(4'b1000			),//(4'b1000			),//
	.io_inputs_1_aw_payload_region	(4'b0				),//(4'b0				),//(4'b0				),//
	.io_inputs_1_aw_payload_len		(8'd7				),//(8'd63				),//(8'd7				),//
	.io_inputs_1_aw_payload_size	(3'b010				),//(3'b010				),//(3'b010				),//
	.io_inputs_1_aw_payload_burst	(2'b01				),//(2'b01				),//(2'b01				),//
	.io_inputs_1_aw_payload_lock	(1'b0				),//(1'b0				),//(1'b0				),//
	.io_inputs_1_aw_payload_cache	(4'b0				),//(4'b0				),//(4'b0				),//
	.io_inputs_1_aw_payload_qos		(4'b0				),//(4'b0				),//(4'b0				),//
	.io_inputs_1_aw_payload_prot	(3'b0				),//(3'b0				),//(3'b0				),//
	.io_inputs_1_w_valid			(1'b0				),//(w_1_w_valid		),//(1'b0				),//
	.io_inputs_1_w_ready			(),					  //(w_1_w_ready		),//(),					  //
	.io_inputs_1_w_payload_data		(32'b0				),//(w_1_w_payload_data	),//(32'b0				),//
	.io_inputs_1_w_payload_strb		(4'b1111			),//(4'b1111			),//(4'b1111			),//
	.io_inputs_1_w_payload_last		(1'b0				),//(w_1_payload_last	),//(1'b0				),//
	.io_inputs_1_b_valid			(),					  //(w_1_b_valid		),//(),					  //
	.io_inputs_1_b_ready			(1'b0				),//(w_1_b_ready		),//(1'b0				),//
	.io_inputs_1_b_payload_id		(),					  //(w_1_b_payload_id	),//(),					  //
	.io_inputs_1_b_payload_resp		(),					  //(w_1_b_payload_resp	),//(),					  //
	//
	.io_inputs_1_ar_valid			(1'b0				),//(w_0_ar_valid		),//(1'b0				),//
	.io_inputs_1_ar_ready			(),                   //(w_0_ar_ready		),//(),                   //
	.io_inputs_1_ar_payload_addr	(32'b0				),//(w_0_ar_payload_addr),//(32'b0				),//
	.io_inputs_1_ar_payload_id		(4'b1000			),//(4'b1000			),//(4'b1000			),//
	.io_inputs_1_ar_payload_region	(4'b0				),//(4'b0				),//(4'b0				),//
	.io_inputs_1_ar_payload_len		(8'd63				),//(8'd7				),//(8'd7				),//
	.io_inputs_1_ar_payload_size	(3'b010				),//(3'b010				),//(3'b010				),//
	.io_inputs_1_ar_payload_burst	(2'b01				),//(2'b01				),//(2'b01				),//
	.io_inputs_1_ar_payload_lock	(1'b0				),//(1'b0				),//(1'b0				),//
	.io_inputs_1_ar_payload_cache	(4'b0				),//(4'b0				),//(4'b0				),//
	.io_inputs_1_ar_payload_qos		(4'b0				),//(4'b0				),//(4'b0				),//
	.io_inputs_1_ar_payload_prot	(3'b0				),//(3'b0				),//(3'b0				),//
	.io_inputs_1_r_valid			(),                   //(w_0_r_valid		),//(),                   //
	.io_inputs_1_r_ready			(1'b0),               //(w_0_r_ready		),//(1'b0),               //
	.io_inputs_1_r_payload_data		(),                   //(w_0_r_payload_data	),//(),                   //
	.io_inputs_1_r_payload_id		(),                   //(w_0_r_payload_id	),//(),                   //
	.io_inputs_1_r_payload_resp		(),                   //(w_0_r_payload_resp	),//(),                   //
	.io_inputs_1_r_payload_last		(),                   //(w_0_r_payload_last	),//(),                   //
	//
	.io_output_arw_valid			(w_arw_valid			),		//(),		
	.io_output_arw_ready			(w_arw_ready			),		//(1'b0),	
	.io_output_arw_payload_addr		(w_arw_payload_addr		),		//(),		
	.io_output_arw_payload_id		(w_arw_payload_id		),		//(),		
	.io_output_arw_payload_region	(w_arw_payload_region	),		//(),		
	.io_output_arw_payload_len		(w_arw_payload_len		),		//(),		
	.io_output_arw_payload_size		(w_arw_payload_size		),		//(),		
	.io_output_arw_payload_burst	(w_arw_payload_burst	),		//(),		
	.io_output_arw_payload_lock		(w_arw_payload_lock		),		//(),		
	.io_output_arw_payload_cache	(w_arw_payload_cache	),		//(),		
	.io_output_arw_payload_qos		(w_arw_payload_qos		),		//(),		
	.io_output_arw_payload_prot		(w_arw_payload_prot		),		//(),		
	.io_output_arw_payload_write	(w_arw_payload_write	),	
	//
	.io_output_w_valid				(w_w_valid			),//(),		
	.io_output_w_ready				(r_w_ready			),//(1'b0),	
	.io_output_w_payload_data		(w_w_payload_data	),//(),		
	.io_output_w_payload_strb		(w_w_payload_strb	),//(),		
	.io_output_w_payload_last		(w_w_payload_last	),//(),		
	.io_output_b_valid				(r_b_valid			),//(1'b0),	
	.io_output_b_ready				(w_b_ready			),//(),		
	.io_output_b_payload_id			(r_b_payload_id		),//(5'b10000			),
	.io_output_b_payload_resp		(2'b0				),
	//
	.io_output_r_valid				(r_r_valid			),
	.io_output_r_ready				(w_r_ready			),
	.io_output_r_payload_data		(w_r_payload_data	),
	.io_output_r_payload_id			(5'b00000			),
	.io_output_r_payload_resp		(2'b0				),
	.io_output_r_payload_last		(r_r_payload_last	),
	.io_output_arw_id				(w_output_arw_id	),
	//
	.clk							(r_axi_pclk			),
	.reset							(~r_axi_rstn		)
);

assign	w_arw_ready	= w_arw_valid;

reg	[2:0]	r_rd_cnt;
reg			r_rd_en;
reg			r_de_delay_1P;


always @(posedge r_axi_pclk)
begin
	if (~r_i_arstn)
	begin
		//r_aw_ready	<= 1'b0;
		r_w_ready	<= 1'b1;
		r_b_valid	<= 1'b0;
		
		//r_ar_ready			<= 1'b0;
		r_r_valid			<= 1'b0;
		r_r_payload_last	<= 1'b0;
		r_r_xcnt			<= 8'b0;
		r_r_ycnt			<= 8'b0;
		r_rd_cnt			<= 3'b0;
		r_rd_en				<= 1'b0;
		r_axi_rstn			<= 1'b0;
		r_de_delay_1P		<= 1'b0;
		r_rd_last			<= 3'b0;
		r_b_payload_id		<= 5'b0;
	end
	else
	begin
		if (w_arw_payload_write)
		begin
			if (w_arw_payload_id[4] && w_arw_payload_id[3])
				r_b_payload_id[4]	<= 1'b1;				
			else
				r_b_payload_id[4]	<= 1'b0;
		end
	
		r_de_delay_1P	<= w_de_delay;
		
		if (!w_de_delay && r_de_delay_1P)
			r_axi_rstn	<= 1'b1;		
		
		if (w_arw_valid && w_arw_payload_write)
			r_w_ready	<= 1'b1;
			
		if (w_w_payload_last && w_w_valid)
		begin
			r_w_ready	<= 1'b0;
			r_b_valid	<= 1'b1;
		end
		
		if (!r_w_ready)
			r_b_valid	<= 1'b0;
		
		if (!w_arw_payload_write && w_arw_valid)
		begin
			r_r_valid			<= 1'b1;
		end	
		
		if (w_r_ready && r_r_valid)
		begin			
			r_rd_last			<= r_rd_last + 1'b1;
			
			if (r_rd_last == 6)
				r_r_payload_last	<= 1'b1;
			else
				r_r_payload_last	<= 1'b0;
			
			if (r_rd_last == 7)
			begin
				r_r_valid	<= 1'b0;
				r_rd_last	<= 3'b0;
				r_r_payload_last	<= 1'b0;
				
				if (r_r_xcnt == (x_win >> 6))
				begin				
					r_r_xcnt	<= 8'b0;
					r_r_ycnt	<= r_r_ycnt + 1'b1;
				end
				else
					r_r_xcnt	<= r_r_xcnt + 1'b1;
			end
		end
		
	end
end

// repack 8 to 256 pixel
wr_address_decoder
#(
	.X_TOTAL	(480)
)
inst_wr_address_decoder_0
(
	.rstn			(r_axi_rstn),
	.p_clk			(r_mipi_pclk),
	.axi_clk		(r_axi_pclk),
			
	.x_win			(x_win	),
	.x_start		(x_start),
	.y_win			(y_win	),
	.y_start		(y_start),
		
	.in_x_wr		(r_x_1P),
	.in_y_wr		(r_y_1P),
	.in_wr_en		(in_valid),
	.in_frame_cnt	(1'b0),	
	
	.in_wr_00		(r_y_1P[7:0]),
	.in_wr_01		(8'b0),
	.in_wr_10		({5'b0, r_x_1P[10:8]}),
	.in_wr_11		(r_x_1P[7:0]),
	
	.in_wr_aready	(w_0_aw_ready),
	.in_wr_ready	(w_0_w_ready),	
	.in_wr_bvalid	(w_0_b_valid),
	
	.out_wr_avalid	(out_0_aw_valid		),
	.out_wr_valid	(w_0_w_valid		),
	.out_wr_bready	(w_0_b_ready		),
	.out_wr_last	(w_0_payload_last	),
	.out_wr_addr	(w_0_aw_payload_addr),
	.out_wr_data	(w_0_w_payload_data	)
);

wr_address_decoder
#(
	.X_TOTAL	(480)
)
inst_wr_address_decoder_1
(
	.rstn			(r_axi_rstn),
	.p_clk			(r_mipi_pclk),
	.axi_clk		(r_axi_pclk),
			
	.x_win			(x_win	),
	.x_start		(x_start),
	.y_win			(y_win	),
	.y_start		(y_start),
		
	.in_x_wr		(r_x_1P),
	.in_y_wr		(r_y_1P),
	.in_wr_en		(in_valid),
	.in_frame_cnt	(1'b0),	
	
	.in_wr_00		(r_y_1P[7:0]),
	.in_wr_01		(8'b0),
	.in_wr_10		({5'b0, r_x_1P[10:8]}),
	.in_wr_11		(r_x_1P[7:0]),
	
	.in_wr_aready	(w_1_aw_ready),
	.in_wr_ready	(w_1_w_ready),	
	.in_wr_bvalid	(w_1_b_valid),
	
	.out_wr_avalid	(out_1_aw_valid		),
	.out_wr_valid	(w_1_w_valid		),
	.out_wr_bready	(w_1_b_ready		),
	.out_wr_last	(w_1_payload_last	),
	.out_wr_addr	(w_1_aw_payload_addr),
	.out_wr_data	(w_1_w_payload_data	)
);

assign	w_r_payload_data	= {r_r_xcnt, r_r_ycnt, 8'd7, r_r_xcnt[4:0], r_rd_last, 
								r_r_xcnt, r_r_ycnt, 8'd6, r_r_xcnt[4:0], r_rd_last, 
								r_r_xcnt, r_r_ycnt, 8'd5, r_r_xcnt[4:0], r_rd_last, 
								r_r_xcnt, r_r_ycnt, 8'd4, r_r_xcnt[4:0], r_rd_last, 
								r_r_xcnt, r_r_ycnt, 8'd3, r_r_xcnt[4:0], r_rd_last, 
								r_r_xcnt, r_r_ycnt, 8'd2, r_r_xcnt[4:0], r_rd_last, 
								r_r_xcnt, r_r_ycnt, 8'd1, r_r_xcnt[4:0], r_rd_last, 
								r_r_xcnt, r_r_ycnt, 8'd0, r_r_xcnt[4:0], r_rd_last};

rd_address_decoder
#(
	.X_TOTAL	(X_TOTAL)
)
inst_rd_address_decoder_0
(
	.rstn				(r_axi_rstn	),
	.p_clk				(r_mipi_pclk),
	.axi_clk			(r_axi_pclk	),
			
	.x_win				(x_win	),
	.x_start			(x_start),
	.y_win				(y_win	),
	.y_start			(y_start),

	.in_de				(r_mipi_inst1_VALID		),
	.in_valid			(in_valid		),
	.in_hsync			(r_mipi_inst1_HSYNC[0]	),
	.in_vsync			(1'b1					),
	.in_frame_cnt		(1'b0),	
	
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
	
	//.debug_rd_states	(debug_rd_states)
);

//assign	w_0_ar_valid = (out_0_aw_valid || out_1_aw_valid) ? 1'b0 : out_0_ar_valid;
//assign	w_0_aw_valid = out_0_aw_valid;
//assign	w_1_aw_valid = out_1_aw_valid;
//assign	w_b_payload_id	= {~r_y_1P[0], 4'b0};

assign	w_0_ar_valid = (out_0_aw_valid || out_1_aw_valid) ? 1'b0 : out_0_ar_valid;
assign	w_0_aw_valid = out_0_aw_valid;
assign	w_1_aw_valid = out_1_aw_valid;


endmodule
