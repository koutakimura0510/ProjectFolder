`define	DU	10

module mipi_pi_cam_debayer_top_tb();

localparam	RX_DW	= `DU*4;

reg		mipi_pclk;
reg		r_axi_pclk;
reg		i_arstn;

reg		[3:0]r_mipi_inst1_HSYNC;
reg		r_mipi_inst1_VALID;
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

//-----------------------------------------------------------//
// I2C settings
//-----------------------------------------------------------//
parameter I2C_ID		= 7'h10;                    // I2C ID
parameter INITIAL_CODE	= "piv2_1080p_reg.mem";	 	// Initial code file for 1080p
parameter MEM_DEPTH		= 510;                      // Initial code memory depth
parameter REGISTER_BYTE	= 2;                        // Number of byte of register
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// 1920*1080 VGA 60Hz fps
//-----------------------------------------------------------//
parameter LinePeriod 	= 12'd1100;     
parameter H_SyncPulse	= 8'd22;           
parameter H_BackPorch	= 8'd74;  	          
parameter H_ActivePix	= 12'd960;	           
parameter H_FrontPorch	= 8'd44;         
parameter Hde_start		= 8'd96;	
parameter Hde_end		= 12'd1056;
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// 1920*1080 VGA 60Hz fps
//-----------------------------------------------------------//
parameter FramePeriod 	= 11'd1125;           
parameter V_SyncPulse	= 6'd5;              
parameter V_BackPorch	= 6'd25;
parameter V_ActivePix	= 11'd1080;            
parameter V_FrontPorch	= 6'd15;
parameter Vde_start		= 6'd30;
parameter Vde_end		= 11'd1110;
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// MIPI horizontal size
//-----------------------------------------------------------//
parameter MIPI_H_PIXEL 	= H_ActivePix >> 1;
parameter RAM_Hde_end	= Hde_start + MIPI_H_PIXEL;
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// FIFO size
//-----------------------------------------------------------//
parameter FIFO_ADDR_WIDTH 	= 12;
parameter FIFO_DEPTH 		= (1 << FIFO_ADDR_WIDTH);
parameter HALF_FIFO_DEPTH 	= FIFO_DEPTH >> 1;
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// Input and output pixel depth
//-----------------------------------------------------------//
parameter IN_P_DEPTH 	= 10;
parameter IN_PACKED		= 4;
parameter OUT_P_DEPTH 	= 10;
parameter OUT_PACKED	= 4;
//-----------------------------------------------------------//

initial
begin
	mipi_pclk	<= 1'b1;
	forever
		#4	mipi_pclk	<= ~mipi_pclk;
end

initial
begin
	r_axi_pclk	<= 1'b1;
	forever
		#4	r_axi_pclk	<= ~r_axi_pclk;
end

initial
begin
		i_arstn						<= 1'b0;
		r_in_inst1_DATA[0*`DU+:`DU]	<= `DU'h001;
		r_in_inst1_DATA[1*`DU+:`DU]	<= `DU'h002;
		r_in_inst1_DATA[2*`DU+:`DU]	<= `DU'h003;
		r_in_inst1_DATA[3*`DU+:`DU]	<= `DU'h004;
		
	#10	i_arstn			<= 1'b1;
end

always@(posedge mipi_pclk or negedge i_arstn)
begin
	if (~i_arstn)
	begin
		r_mipi_inst1_HSYNC	<= {4{1'b1}};
		r_mipi_inst1_VALID	<= 1'b0;
		cnt					<= {3{1'b0}};
		
		r_b	<= {3{1'b0}};
		r_x	<= {11{1'b0}};
		r_y	<= {11{1'b0}};
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
		
		if ((r_x > Hde_start-1) && (r_x < RAM_Hde_end))
		begin
			r_mipi_inst1_VALID		<= 1'b1;
			r_in_inst1_DATA[`DU*1-1:`DU*0]	<= r_x;
			r_in_inst1_DATA[`DU*2-1:`DU*1]	<= r_in_inst1_DATA[`DU*2-1:`DU*1]+2'd2;
			r_in_inst1_DATA[`DU*3-1:`DU*2]	<= r_y;
			r_in_inst1_DATA[`DU*4-1:`DU*3]	<= r_in_inst1_DATA[`DU*4-1:`DU*3]+2'd4;
		end
		else
		begin		
			r_mipi_inst1_VALID		<= 1'b0;
			r_in_inst1_DATA[`DU*1-1:`DU*0]	<= 0;
			r_in_inst1_DATA[`DU*2-1:`DU*1]	<= 0;
			r_in_inst1_DATA[`DU*3-1:`DU*2]	<= 0;
			r_in_inst1_DATA[`DU*4-1:`DU*3]	<= 0;			
		end
		
		r_x	<= r_x+1'b1;
				
		if (r_x == 1100)
		begin
			r_mipi_inst1_HSYNC[0]	<= 1'b0;
			r_x	<= {11{1'b0}};
			r_y <= r_y + 1'b1;			
		end
		else if (r_x == H_SyncPulse)
		begin
			r_mipi_inst1_HSYNC[0]	<= 1'b1;
		end
	end
end

/* RGB gain by debugger control */
wire		w_mipi_inst1_CLEAR;
wire		probe_trigger;
wire[2:0]	red_gain;
wire[2:0]	green_gain;
wire[2:0]	blue_gain;

reg	[2:0]	r_red_gain;
reg	[2:0]	r_green_gain;
reg	[2:0]	r_blue_gain;

/* Regen X Y for RAM */
reg			r_de_1P;	
reg			r_vs_1P;
reg [10:0]	r_x_ram_1P;
reg [10:0]	r_y_ram_1P;

/* Debug signals of debugger */
reg			reg_hsync;
reg			reg_vsync;
reg	[3:0]	reg_cnt;
reg			reg_valid;
reg	[5:0]	reg_mtype;
reg [63:0]	reg_mdata;
reg	[1:0]	reg_vc;
reg	[17:0]	reg_error;	

/* Debug signals of debugger */
wire[10:0]				w_xwin;
wire[10:0]				w_xstart;
wire[10:0]				w_ywin;
wire[10:0]				w_ystart;
wire[10:0]				w_xpointer;
wire[10:0]				w_ypointer;
wire[OUT_P_DEPTH-1:0]	w_rback;
wire[OUT_P_DEPTH-1:0]	w_gback;
wire[OUT_P_DEPTH-1:0]	w_bback;

reg	[10:0]	r_xwin;
reg	[10:0]	r_xstart;
reg	[10:0]	r_ywin;
reg	[10:0]	r_ystart;
reg	[10:0]	r_x_pointer;
reg	[10:0]	r_y_pointer;
reg	[3:0]	r_init_start;
reg			r_init_trigger;
reg			r_vio_update;
reg			r_axi_vs_1P;
reg			r_axi_vs_2P;
reg			r_probe_trigger_1P;

/* Frame buffer signals */
reg			r_write_ready;
reg			r_read_ready;

wire        w_out_de;
wire        w_out_hsync;
wire        w_out_vsync;
wire[7:0]	w_out_y;
wire[39:0]	w_out_data;
wire[15:0] 	w_out_rd_00;
wire[15:0] 	w_out_rd_01;
wire[15:0] 	w_out_rd_10;
   
/* MIPI-Rx-to-Pixel Data Depacker for RAW10 to RAW10  */
reg 	  							rx_valid_VC;
reg 	  							rx_vs_VC;
reg       							rx_hs_VC;
reg 	  							rx_valid_VC_1P;
reg 	  							rx_vs_VC_1P;
reg       							rx_hs_VC_1P;
reg [5:0] 							rx_type_VC;
reg [17:0]							rx_error_VC;
reg [1:0] 							rx_vc_VC;
reg [3:0] 							rx_count_VC;
reg	[11:0]							r_x_debug;
reg	[10:0]							r_y_debug;
reg [OUT_P_DEPTH*OUT_PACKED-1:0]	rx_data_VC;

/* Resync mipi_pclk to mipi_pclk */
reg			r_resync_vs_1P;	
reg			r_resync_vs_2P;	
reg			r_resync_vs_3P;	
reg			r_resync_vs_4P;
reg			r_resync_hs_1P;	
reg			r_resync_hs_2P;	
reg			r_resync_hs_3P;	
reg			r_resync_hs_4P;	
reg			r_resync_de_1P;	
reg			r_resync_de_2P;	
reg			r_resync_de_3P;
reg			r_resync_de_4P;
reg			r_resync_4to2;
reg			r_resync_4to2_1P;
reg			r_resync_4to2_2P;
reg	[9:0]	r_resync_x;

wire[OUT_P_DEPTH*OUT_PACKED-1:0]	w_slow_data;

/* RGB gain filter */
wire[OUT_P_DEPTH*OUT_PACKED-1:0]	w_data;
wire								w_hs;
wire								w_vs;
wire								w_de;
wire								w_valid;

/* Remap 4 pixels per clock to 2 pixels per clock */
reg	[OUT_P_DEPTH*2-1:0]	r_slow_data_5P;
reg						r_vs_ram_out_1P;
reg						r_hs_ram_out_1P;
reg						r_de_ram_out_1P;
reg						r_de_ram_4_2;
reg 					r_vs_ram_out_2P;
reg 					r_hs_ram_out_2P;
reg						r_de_ram_4_2_2P;
reg 					r_vs_ram_out_3P;
reg 					r_hs_ram_out_3P;
reg 					r_de_ram_4_2_3P;
reg 					r_vs_ram_out_4P;
reg 					r_hs_ram_out_4P;
reg 					r_de_ram_4_2_4P;
reg 					r_vs_ram_out_5P;
reg 					r_hs_ram_out_5P;
reg 					r_de_ram_4_2_5P;
reg 					r_vs_ram_out_6P;
reg 					r_hs_ram_out_6P;
reg 					r_de_ram_4_2_6P;
reg						valid_r_lvds_mipi_1P;
reg						vsync_r_lvds_mipi_2P;
reg						hsync_r_lvds_mipi_2P;
reg						de_r_lvds_mipi_2P;
reg 					r_oe_cnt;

/* 3 lines buffer */
wire					w_mipi_tx_vsync_00;
wire					w_mipi_tx_hsync_00;
wire					w_mipi_tx_de_00;
wire					fifo_reset_n;
wire[OUT_P_DEPTH*2-1:0]	w_mipi_tx_11;
wire[OUT_P_DEPTH*2-1:0] w_mipi_tx_00;
wire[OUT_P_DEPTH*2-1:0] w_mipi_tx_01;
wire[OUT_P_DEPTH*2-1:0]	w_mipi_delay_11;
wire[OUT_P_DEPTH*2-1:0] w_mipi_delay_00;
wire[OUT_P_DEPTH*2-1:0] w_mipi_delay_01;

/* RAW to RGB */
wire 						w_vsync_00_1P;
wire 						w_hsync_00_1P;
wire 						w_de_00_1P;
wire						w_o_e_pixel_cnt;
wire [OUT_P_DEPTH:0]		w_r_o_00_00_1P;
wire [OUT_P_DEPTH:0]		w_g_o_00_00_1P;
wire [OUT_P_DEPTH:0]		w_b_o_00_00_1P;
wire [OUT_P_DEPTH:0]		w_r_e_00_00_1P;
wire [OUT_P_DEPTH:0]		w_g_e_00_00_1P;
wire [OUT_P_DEPTH:0]		w_b_e_00_00_1P;
wire [OUT_P_DEPTH:0]		w_r_o_00_00_delay;
wire [OUT_P_DEPTH:0]		w_g_o_00_00_delay;
wire [OUT_P_DEPTH:0]		w_b_o_00_00_delay;
wire [OUT_P_DEPTH:0]		w_r_e_00_00_delay;
wire [OUT_P_DEPTH:0]		w_g_e_00_00_delay;
wire [OUT_P_DEPTH:0]		w_b_e_00_00_delay;
wire [OUT_P_DEPTH*2-1:0]	w_r_00_00_1P;
wire [OUT_P_DEPTH*2-1:0]	w_g_00_00_1P;
wire [OUT_P_DEPTH*2-1:0]	w_b_00_00_1P;

/* VGA counter for the output display sync signals generator */
reg [11:0] 	x_cnt_lvds_out;
reg [10:0]  r_ram_o_x_cnt;
reg [10:0]  y_cnt_lvds_out;
reg			de_vsyn_r_lvds_out;
reg			vsync_r_lvds_out;
reg			de_r_lvds_out;
reg			hsync_r_lvds_out;
reg			r_de_ram_in;

wire        w_de_ram_in;
wire        w_hs_ram_in;
wire	    w_vs_ram_in;

/* Remap 2 pixels per clock to odd and even LVDS pixels */
reg						de_r_lvds_1P;
reg						hsync_r_lvds_1P;
reg						vsync_r_lvds_1P;
reg						vsync_r_lvds_2P;
reg	[OUT_P_DEPTH-1:0]	lvds_1_data_r;
reg	[OUT_P_DEPTH-1:0]	lvds_2_data_r;
reg	[OUT_P_DEPTH-1:0]	lvds_1_data_g;
reg	[OUT_P_DEPTH-1:0]	lvds_2_data_g;
reg	[OUT_P_DEPTH-1:0]	lvds_1_data_b;
reg	[OUT_P_DEPTH-1:0]	lvds_2_data_b;
reg	[11:0] 				x_cnt_by2_ram;
reg	[11:0] 				x_cnt_by2_ram_1P;
reg	[10:0]				r_in_y_wr;
reg	[10:0]				r_in_y_wr_1P;

/* Sync MIPI Rx signals to FPGA-core mipi_pclk domain (posedge) */
always @(posedge mipi_pclk)
begin
    if (~i_arstn) 
	begin
		rx_data_VC 		<= 40'b0;
		rx_vs_VC 		<= 1'b0;
		rx_hs_VC 		<= 1'b0;
		rx_valid_VC 	<= 1'b0;
		rx_vs_VC_1P 	<= 1'b0;
		rx_hs_VC_1P		<= 1'b0;
		rx_valid_VC_1P 	<= 1'b0;
		rx_type_VC 		<= 1'b0;
		rx_error_VC 	<= 1'b0;
		rx_vc_VC 		<= 1'b0;
		rx_count_VC 	<= 1'b0;		
		r_red_gain		<= 3'd6;
		r_green_gain 	<= 3'd5;
		r_blue_gain	 	<= 3'd6;
	end
	else
	begin
		rx_vs_VC        <= 1'b1;
		rx_hs_VC		<= r_mipi_inst1_HSYNC[0];
		rx_valid_VC		<= r_mipi_inst1_VALID;
		rx_vs_VC_1P     <= rx_vs_VC;
		rx_hs_VC_1P		<= rx_hs_VC;
		rx_valid_VC_1P	<= rx_valid_VC;

		// Remap 4 x 12 bits data to 4 x 10 bits data
		rx_data_VC 	<= r_in_inst1_DATA[IN_P_DEPTH*IN_PACKED-1:0];
		
		////RGB gain is controlled by debugger
		//if (probe_trigger)
		//begin
		//	r_red_gain		<= red_gain;
		//	r_green_gain 	<= green_gain;
		//	r_blue_gain	 	<= blue_gain;
		//end
		//else
		//begin
			r_red_gain		<= 3'd4;
			r_green_gain 	<= 3'd4;	// RAW of the camera has more green pixel
			r_blue_gain	 	<= 3'd4;
		//end
	end	
end

/* RGB gain filter */
rgb_gain
#(
	.P_DEPTH(OUT_P_DEPTH)
)
inst_rgb_gain_01
(
	.i_arstn	(i_arstn	),
	.i_pclk		(mipi_pclk	),

	.i_hs		(rx_hs_VC	),
	.i_vs		(rx_vs_VC	),
	.i_de		(rx_valid_VC),
	.i_valid	(rx_valid_VC),
	.i_data		(rx_data_VC	),
	
	.red_gain	(r_red_gain		),
	.green_gain	(r_green_gain	),
	.blue_gain	(r_blue_gain	),
	
	.o_hs		(w_hs	),
	.o_vs		(w_vs	),
	.o_de		(w_de	),
	.o_valid	(w_valid),
		
	.o_data		(w_data)
);
 
/* Regen X Y to RAM */
always @ (posedge mipi_pclk)
begin
	if(~i_arstn)
	begin
		r_de_1P		<= 1'b0;
		r_vs_1P		<= 1'b0;
		r_x_ram_1P	<= 11'b0;
		r_y_ram_1P	<= 11'b0;
	end
	else
	begin
		r_vs_1P		<= w_vs;
		r_de_1P		<= w_de;
		
		if (w_de)
			r_x_ram_1P	<= r_x_ram_1P + 1'b1;
		else
			r_x_ram_1P	<= 12'b0;
								
		if (!w_de && r_de_1P)
		begin
			if (r_y_ram_1P == (V_ActivePix - 1))
				r_y_ram_1P	<= 11'b0;
			else
				r_y_ram_1P	<= r_y_ram_1P + 1'b1;
		end
	end
end

/* VGA counter for the output display sync signals generator */
/* x_cnt_lvds_out for HSYNC and DEN */  
always @ (posedge mipi_pclk)
begin
	if(~i_arstn)
	begin    
		x_cnt_lvds_out 		<= 12'b0;
		hsync_r_lvds_out	<= 1'b1;
		de_r_lvds_out 		<= 1'b0;
		r_de_ram_in 		<= 1'b0;
	end
	else if(x_cnt_lvds_out == LinePeriod)
	begin
        x_cnt_lvds_out		<= 12'b0;
		hsync_r_lvds_out 	<= 1'b0;
	end
	else
	begin
        x_cnt_lvds_out <= x_cnt_lvds_out + 1'b1;
		
		if (x_cnt_lvds_out == H_SyncPulse) 
            hsync_r_lvds_out <= 1'b1;
		
		if(x_cnt_lvds_out == (Hde_end))
			de_r_lvds_out <= 1'b0;
		else if((x_cnt_lvds_out == Hde_start) && de_vsyn_r_lvds_out)
			de_r_lvds_out <= 1'b1;
			
		if(x_cnt_lvds_out == (RAM_Hde_end))
			r_de_ram_in <= 1'b0;
		else if((x_cnt_lvds_out == Hde_start) && de_vsyn_r_lvds_out)
			r_de_ram_in <= 1'b1;
	end
end
   
/* y_cnt_lvds_out for VSYNC */  
always @ (posedge mipi_pclk) 
begin
	if(~i_arstn)
        y_cnt_lvds_out <= 11'b0;		
    else if (y_cnt_lvds_out == FramePeriod)
	begin
		y_cnt_lvds_out <= 11'b0;
	end
 	else if(x_cnt_lvds_out == LinePeriod) 
	begin
		if(y_cnt_lvds_out < FramePeriod) 
			y_cnt_lvds_out <= y_cnt_lvds_out + 1'b1;
	end
end

always @(posedge mipi_pclk)
begin
	if(~i_arstn)
		vsync_r_lvds_out <= 1'b1;
	else if(y_cnt_lvds_out == 11'b0)
		vsync_r_lvds_out <= 1'b0;
	else if(y_cnt_lvds_out == V_SyncPulse)
		vsync_r_lvds_out <= 1'b1;
end
      
always @ (posedge mipi_pclk)
begin
	if(~i_arstn) 
	begin
		de_vsyn_r_lvds_out <= 1'b0;		
	end
	else 
	begin		
		if(y_cnt_lvds_out == Vde_start)
			de_vsyn_r_lvds_out <= 1'b1;  	
		else if(y_cnt_lvds_out == Vde_end)
			de_vsyn_r_lvds_out <= 1'b0;
	end
end

//////////////////////////////////////////////////////////////

/* Remap 4 pixels per clock to 2 pixels per clock */
always @ (posedge mipi_pclk)
begin
	if(~i_arstn)
	begin
		r_slow_data_5P	<= 20'b0;
		r_vs_ram_out_1P	<= 1'b0;
		r_hs_ram_out_1P	<= 1'b0;
		r_de_ram_out_1P	<= 1'b0;
		r_de_ram_4_2	<= 1'b0;
		r_vs_ram_out_2P	<= 1'b0;
		r_hs_ram_out_2P	<= 1'b0;		
		r_de_ram_4_2_2P	<= 1'b0;
		r_vs_ram_out_2P	<= 1'b0;
		r_hs_ram_out_2P	<= 1'b0;
		r_de_ram_4_2_2P	<= 1'b0;
		r_vs_ram_out_3P	<= 1'b0;
		r_hs_ram_out_3P	<= 1'b0;
		r_de_ram_4_2_3P	<= 1'b0;
		r_vs_ram_out_4P	<= 1'b0;
		r_hs_ram_out_4P	<= 1'b0;
		r_de_ram_4_2_4P	<= 1'b0;
		r_vs_ram_out_5P	<= 1'b0;
		r_hs_ram_out_5P	<= 1'b0;
		r_de_ram_4_2_5P	<= 1'b0;
		r_vs_ram_out_6P	<= 1'b0;
		r_hs_ram_out_6P	<= 1'b0;
		r_de_ram_4_2_6P	<= 1'b0;
		r_ram_o_x_cnt	<= 11'b0;
	end
	else
	begin
		r_vs_ram_out_1P		<= w_vs;
		r_hs_ram_out_1P		<= w_hs;
		r_de_ram_out_1P		<= w_de;
		r_vs_ram_out_2P		<= r_vs_ram_out_1P;
		r_hs_ram_out_2P		<= r_hs_ram_out_1P;
		r_de_ram_4_2_2P		<= r_de_ram_4_2;   
		
		r_vs_ram_out_3P		<= r_vs_ram_out_2P;
		r_hs_ram_out_3P		<= r_hs_ram_out_2P;
		r_de_ram_4_2_3P		<= r_de_ram_4_2_2P;
		r_vs_ram_out_4P		<= r_vs_ram_out_3P;
		r_hs_ram_out_4P		<= r_hs_ram_out_3P;
		r_de_ram_4_2_4P		<= r_de_ram_4_2_3P;
		r_vs_ram_out_5P		<= r_vs_ram_out_4P;
		r_hs_ram_out_5P		<= r_hs_ram_out_4P;
		r_de_ram_4_2_5P		<= r_de_ram_4_2_4P;
		r_vs_ram_out_6P		<= r_vs_ram_out_5P;
		r_hs_ram_out_6P		<= r_hs_ram_out_5P;
		r_de_ram_4_2_6P		<= r_de_ram_4_2_5P;
		
		if (w_de && !r_de_ram_out_1P)
			r_de_ram_4_2	<= 1'b1;
		
		if (r_de_ram_4_2)
			r_ram_o_x_cnt	<= r_ram_o_x_cnt + 1'b1;
			
		if (r_ram_o_x_cnt == H_ActivePix-1)
		begin
			r_ram_o_x_cnt	<= 11'b0;
			r_de_ram_4_2	<= 1'b0;
		end
		
		if (r_de_ram_4_2_4P)
		begin
			r_oe_cnt	<= ~r_oe_cnt;
			if (!r_oe_cnt)
				r_slow_data_5P	<= w_slow_data[OUT_P_DEPTH*2-1:0];
			else
				r_slow_data_5P	<= w_slow_data[OUT_P_DEPTH*4-1:OUT_P_DEPTH*2];
		end
		else
		begin
			r_oe_cnt		<= 1'b0;
			r_slow_data_5P	<= 20'b0;
		end		
	end
end

/* Resync fast clock to slow clock */
simple_dual_port_ram
#(
	. DATA_WIDTH   	(OUT_P_DEPTH*OUT_PACKED),
	. ADDR_WIDTH	(FIFO_ADDR_WIDTH - 1	)
)
inst_pclk_to_axi_buffer_00
(
	.wclk	(mipi_pclk	),
	.we		(w_de		),
	.waddr	(r_x_ram_1P	),
	.wdata	(w_data		),
		
	.rclk	(mipi_pclk		),
	.re		(r_de_ram_4_2	),
	.raddr	(r_ram_o_x_cnt>>1	),	
	.rdata	(w_slow_data	)
);

/* FIFO reset pulse */
assign fifo_reset_n = i_arstn && !(vsync_r_lvds_2P && !vsync_r_lvds_1P); // falling edge of vsync_r_lvds_1P

/* 3 lines buffer */
line_buffer
#(
	.P_DEPTH	(OUT_P_DEPTH	),	
	.X_CNT_WIDTH(FIFO_ADDR_WIDTH)
)
inst_line_buffer_01
(
	.i_arstn	(fifo_reset_n	),
	.i_pclk		(mipi_pclk		),
		
	.i_vsync	(r_vs_ram_out_5P	),
	.i_hsync	(r_hs_ram_out_5P	),
	.i_de		(r_de_ram_4_2_5P	),
	.i_p		(r_slow_data_5P		),
		
	.o_vsync	(w_mipi_tx_vsync_00	),
	.o_hsync	(w_mipi_tx_hsync_00	),
	.o_de		(w_mipi_tx_de_00	),
	.o_p_11		(w_mipi_tx_11		),
	.o_p_00		(w_mipi_tx_00		),	
	.o_p_01		(w_mipi_tx_01		)
);

reg			r_mipi_tx_vsync_00_1P;
reg			r_mipi_tx_hsync_00_1P;
reg			r_mipi_tx_de_00_1P;
reg	[1:0]	r_hs_delay;
reg			r_hs_en;

wire		w_mipi_tx_vsync_00_1L;
wire		w_mipi_tx_hsync_00_1L;
wire		w_mipi_tx_de_00_1L;

/* Remap 4 pixels per clock to 2 pixels per clock */
always @ (posedge mipi_pclk)
begin
	if(~i_arstn)
	begin
		r_mipi_tx_vsync_00_1P	<= 1'b0;
		r_mipi_tx_hsync_00_1P	<= 1'b0;
		r_mipi_tx_de_00_1P		<= 1'b0;
		r_hs_en					<= 1'b0;
		r_hs_delay				<= 2'b0;
	end
	else
	begin
		r_mipi_tx_vsync_00_1P	<= w_mipi_tx_vsync_00;
		r_mipi_tx_hsync_00_1P	<= w_mipi_tx_hsync_00;
		r_mipi_tx_de_00_1P		<= w_mipi_tx_de_00;
		
		if (!w_mipi_tx_hsync_00 && r_mipi_tx_hsync_00_1P)
			r_hs_delay	<= r_hs_delay + 1'b1;
			
		if (r_hs_delay == 2'b10)
			r_hs_en		<= 1'b1;
	end
end

/* 1 line delay for RGB sync signals */
fifo 
#(
	.DATA_WIDTH(3),
    .ADDR_WIDTH(13)
)	   
fifo_01 
(
  .clk 		(mipi_pclk),
  .nrst 	(i_arstn),
  .we 		(1'b1),
  .re 		(r_hs_en),
  .data_in 	({w_mipi_tx_vsync_00, w_mipi_tx_hsync_00, w_mipi_tx_de_00}),
  .data_out ({w_mipi_tx_vsync_00_1L, w_mipi_tx_hsync_00_1L, w_mipi_tx_de_00_1L})
  );
 
/* FIFO delay for RGB sync signals */
shift_reg
#(
	.D_WIDTH(60),
	.TAPE(11)
)
inst_shift_reg_02
(                                                                    
	.i_arst(~i_arstn),                                               
	.i_clk(mipi_pclk),                                               

	.i_d({w_mipi_tx_11, w_mipi_tx_00, w_mipi_tx_01}),
	.o_q({w_mipi_delay_11, w_mipi_delay_00, w_mipi_delay_01})                  	
);

/* RAW to RGB */
raw_to_rgb
#(
	.P_DEPTH	(OUT_P_DEPTH		),
	.X_CNT_WIDTH(FIFO_ADDR_WIDTH-1	)
)
inst_raw_to_rgb_in0
(                                                                    
	.i_arstn	(i_arstn	),                                               
	.i_pclk		(mipi_pclk	), 
		
	.i_vsync	(w_mipi_tx_vsync_00_1L	),
	.i_hsync	(w_mipi_tx_hsync_00_1L	),
	.i_de		(w_mipi_tx_de_00_1L	),
	.i_p_11		(w_mipi_delay_11		),
	.i_p_00		(w_mipi_delay_00		),
	.i_p_01		(w_mipi_delay_01		),
	
	.o_vsync	(w_vsync_00_1P	),
	.o_hsync	(w_hsync_00_1P	),
	.o_de		(w_de_00_1P		),
	.o_cnt		(w_o_e_pixel_cnt),
	.o_r		(w_r_00_00_1P	),
	.o_g		(w_g_00_00_1P	),	
	.o_b		(w_b_00_00_1P	)              	
);

endmodule