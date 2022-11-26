/////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// mipi_pi_cam_debayer_wo_i2c_top.v
//
// *******************************
// Revisions:
// 1.0 Initial rev
// *******************************
/////////////////////////////////////////////////////////////////////////////

`include "mipi_parameter.vh"

module mipi_pi_cam_debayer_wo_i2c_top
#(
)
(
	// Clock and Reset Pins
	input	i_arstn,
	input	i_sysclk,
	input	i_pll_locked,
	input	ddr_clk_locked,
	input	mipi_pclk,		// 74.25MHz
	input	tx_slowclk,		// 74.25MHz
	input	axi_clk,		// 100MHz
	
	// DDR RESET
	output	ddr_inst1_RSTN,
	output	ddr_inst1_CFG_SEQ_RST,
	output	ddr_inst1_CFG_SEQ_START,
		
	// Camera I2C Pins
	input	i_sda,
	output	o_sda_oe,
	input	i_scl,
	output	o_scl_oe,
	output	o_xclr,
	output	cam_rstn,
	
	output	cfg_ENA,
	output	cfg_CONFIG,
	output	[1:0]	cfg_CBSEL,
	
	// MIPI Control
	output			mipi_inst1_DPHY_RSTN,
	output			mipi_inst1_RSTN,
	output	[3:0]	mipi_inst1_VC_ENA,
	output	[1:0]	mipi_inst1_LANES,
	output			mipi_inst1_CLEAR,
	
	// MIPI Video input
	input	[3:0]	mipi_inst1_HSYNC,
	input	[3:0]	mipi_inst1_VSYNC,
	input	[3:0]	mipi_inst1_CNT,
	input			mipi_inst1_VALID,
	input	[5:0]	mipi_inst1_TYPE,
	input	[63:0]	mipi_inst1_DATA,
	input	[1:0]	mipi_inst1_VC,	
	input	[17:0]	mipi_inst1_ERROR,
	
	// LVDS Video output
	output	[6:0]	lvds_1a_DATA,
	output	[6:0]	lvds_1b_DATA,
	output	[6:0]	lvds_1c_DATA,
	output	[6:0]	lvds_1d_DATA,
	//output	[6:0]	lvds_1e_DATA,
	output	[6:0]	lvds_2a_DATA,
	output	[6:0]	lvds_2b_DATA,
	output	[6:0]	lvds_2c_DATA,
	output	[6:0]	lvds_2d_DATA,
	//output	[6:0]	lvds_2e_DATA,
	output	[6:0]	lvds_clk,
	
	// Flashing LEDs to indicate successful comparison of MIPI data
	output	led5,
	output	led6,
	
	// Debug signals
	output	[3:0]	o_dbg_mipi,
	
	// Debugger
	input  jtag_inst1_CAPTURE,
	input  jtag_inst1_DRCK,
	input  jtag_inst1_RESET,
	input  jtag_inst1_RUNTEST,
	input  jtag_inst1_SEL,
	input  jtag_inst1_SHIFT,
	input  jtag_inst1_TCK,
	input  jtag_inst1_TDI,
	input  jtag_inst1_TMS,
	input  jtag_inst1_UPDATE,
	output jtag_inst1_TDO,
	
	// LPDDR3
	output [7:0] 	aid_0,
	output [31:0] 	aaddr_0,
	output [7:0] 	alen_0,
	output [2:0] 	asize_0,
	output [1:0] 	aburst_0,
	output [1:0] 	alock_0,
	output 			avalid_0,
	input 			aready_0,
	output 			atype_0,
		
	output [7:0] 	wid_0,
	output [255:0] 	wdata_0,
	output [31:0] 	wstrb_0,
	output 			wlast_0,
	output 			wvalid_0,
	input 			wready_0,
	
	input [7:0] 	rid_0,
	input [255:0] 	rdata_0,
	input 			rlast_0,
	input 			rvalid_0,
	output 			rready_0,
	input [1:0] 	rresp_0,
	
	input [7:0] 	bid_0,
	input 			bvalid_0,
	output 			bready_0
);

/* RESET signals for HDMI chip and camera */
assign	cam_rstn 	= i_pll_locked;
assign	resetn		= i_pll_locked;

/* Control signals for multi images */
assign	cfg_ENA		= 1'b0;
assign	cfg_CONFIG	= 1'b0;
assign	cfg_CBSEL	= 2'b01;
		
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
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// FIFO size
//-----------------------------------------------------------//
parameter FIFO_ADDR_WIDTH 	= 11;
//-----------------------------------------------------------//

//-----------------------------------------------------------//
// Input and output pixel depth
//-----------------------------------------------------------//
parameter IN_P_DEPTH 	= 10;
parameter IN_PACKED		= 4;
parameter OUT_P_DEPTH 	= 10;
parameter OUT_PACKED	= 2;
//-----------------------------------------------------------//


/* I2C debugger control */
wire		w_i2c_reg_we;
wire		w_i2c_reg_reconfig;
wire[7:0]	w_i2c_reg_din;
wire[9:0]	w_i2c_reg_addr;
wire[7:0]	w_i2c_reg_dout;
wire[2:0]	w_i2c_state;
wire		w_confdone;

/* RGB gain by debugger control */
wire		w_mipi_inst1_CLEAR;
wire		probe_trigger;
wire[2:0]	red_gain;
wire[2:0]	green_gain;
wire[2:0]	blue_gain;

reg	[2:0]	r_red_gain;
reg	[2:0]	r_green_gain;
reg	[2:0]	r_blue_gain;
	
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
wire[15:0] 	w_out_rd_00;
wire[15:0] 	w_out_rd_01;
wire[15:0] 	w_out_rd_10;

/* MIPI RX HOOKUP */   
wire [63:0] rx_data       	= mipi_inst1_DATA;
wire        rx_valid      	= mipi_inst1_VALID;
wire        rx_vs         	= mipi_inst1_VSYNC[0];
wire        rx_hs         	= mipi_inst1_HSYNC[0];
wire [5:0]  rx_type       	= mipi_inst1_TYPE;
wire [17:0] rx_error      	= mipi_inst1_ERROR;
wire [1:0]  rx_vc         	= mipi_inst1_VC;
wire [3:0]  rx_count      	= mipi_inst1_CNT;
   
   
/* MIPI-Rx-to-Pixel Data Depacker for RAW10 to RAW10  */
reg 	  	rx_valid_VC;
reg 	  	rx_vs_VC;
reg       	rx_hs_VC;
reg 	  	rx_valid_VC_1P;
reg 	  	rx_vs_VC_1P;
reg       	rx_hs_VC_1P;
reg [5:0] 	rx_type_VC;
reg [17:0]	rx_error_VC;
reg [1:0] 	rx_vc_VC;
reg [3:0] 	rx_count_VC;
reg	[11:0]	r_x_debug;
reg	[10:0]	r_y_debug;
reg	[10:0]	r_x_mipi;
reg	[10:0]	r_x_mipi_1P;
reg	[10:0]	r_y_mipi;
reg	[10:0]	r_x_total;
reg	[63:0]	r_rx_data_1P;
reg	[63:0]	r_rx_data_2P;

/* Resync mipi_pclk to tx_slowclk */
reg							r_resync_vs_1P;	
reg							r_resync_vs_2P;	
reg							r_resync_vs_3P;	
reg							r_resync_vs_4P;
reg							r_resync_hs_1P;	
reg							r_resync_hs_2P;	
reg							r_resync_hs_3P;	
reg							r_resync_hs_4P;
reg							r_resync_de;
reg							r_resync_de_1P;
reg							r_resync_de_2P;
reg							r_resync_de_3P;
reg							r_resync_de_4P;
reg							r_resync_4to2;
reg							r_resync_4to2_1P;
reg							r_resync_4to2_2P;
reg	[10:0]					r_resync_x;
reg	[10:0]					r_resync_x_1P;
reg	[10:0]					r_resync_x_2P;
reg	[10:0]					r_resync_x_3P;
reg	[10:0]					r_resync_y;
reg	[10:0]					r_resync_y_1P;
reg	[10:0]					r_resync_y_2P;
reg	[10:0]					r_resync_y_3P;
reg							r_out_valid;
reg							r_out_de_1P;
reg							r_out_valid_1P;
reg							r_out_hsync_1P;
reg							r_out_vsync_1P;
reg	[OUT_P_DEPTH*4-1:0]		r_out_data_1P;
reg							r_fb_reset;
	
wire[OUT_P_DEPTH*2-1:0]		w_resync_data_3P;
wire[OUT_P_DEPTH*2-1:0]		w_resync_data_0;
wire[OUT_P_DEPTH*2-1:0]		w_resync_data_1;
wire[OUT_P_DEPTH*4-1:0]		w_resync_data;
wire[OUT_P_DEPTH*4-1:0]		w_out_data;
wire						w_slow_vs;
wire						w_slow_hs;
	
/* RGB gain filter */	
wire[OUT_P_DEPTH*4-1:0]		w_data;
wire						w_hs;
wire						w_vs;
wire						w_de;
wire						w_valid;

/* Remap 4 pixels per clock to 2 pixels per clock */
reg	[OUT_P_DEPTH*2-1:0]	r_slow_data_1P;
reg						vsync_r_lvds_mipi_1P;
reg						hsync_r_lvds_mipi_1P;
reg						de_r_lvds_mipi_1P;
reg						valid_r_lvds_mipi_1P;
reg						vsync_r_lvds_mipi_2P;
reg						hsync_r_lvds_mipi_2P;
reg						de_r_lvds_mipi_2P;

/* 3 lines buffer */
wire					w_mipi_tx_vsync_00;
wire					w_mipi_tx_hsync_00;
wire					w_mipi_tx_de_00;
wire[OUT_P_DEPTH*2-1:0]	w_mipi_tx_11;
wire[OUT_P_DEPTH*2-1:0] w_mipi_tx_00;
wire[OUT_P_DEPTH*2-1:0] w_mipi_tx_01;

/* RAW to RGB */
wire 						w_vsync_00_1P;
wire 						w_hsync_00_1P;
wire 						w_de_00_1P;
wire [10:0]					w_pixel_cnt;
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
reg [10:0]  y_cnt_lvds_out;
reg			de_vsyn_r_lvds_out;
reg			vsync_r_lvds_out;
reg			de_r_lvds_out;
reg			hsync_r_lvds_out;
reg			de_r_lvds_out_1P;
reg			hsync_r_lvds_out_1P;
reg			vsync_r_lvds_out_1P;
reg			valid_r_lvds_out;

/* Remap 2 pixels per clock to odd and even LVDS pixels */
reg						de_r_lvds_1P;
reg						de_r_test_1P;
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

/* LED5 and LED6 flash count */
reg			vsync_LED;
reg [4:0]	flash_cnt;

//-----------------------------------------------------------//
// MIPI Rx settings
//-----------------------------------------------------------//
assign	mipi_inst1_DPHY_RSTN			= 1'b1;
assign	mipi_inst1_RSTN					= 1'b1;
assign	mipi_inst1_VC_ENA[`MIPI_VC0]	= 1'b1;
assign	mipi_inst1_VC_ENA[`MIPI_VC1]	= 1'b0;
assign	mipi_inst1_VC_ENA[`MIPI_VC2]	= 1'b0;
assign	mipi_inst1_VC_ENA[`MIPI_VC3]	= 1'b0;
assign	mipi_inst1_CLEAR				= 1'b0;
assign	mipi_inst1_LANES				= 2'b01;
//-----------------------------------------------------------//

/* DDR RESET */
ddr_reset_sequencer
#(	
)
inst_ddr_reset
(
	.ddr_rstn_i			(i_pll_locked	),
	.clk				(axi_clk		),
	
	.ddr_rstn			(ddr_inst1_RSTN),
	.ddr_cfg_seq_rst	(ddr_inst1_CFG_SEQ_RST),
	.ddr_cfg_seq_start	(ddr_inst1_CFG_SEQ_START)
);

/* I2C initialization for IMX219 camera 1080p */
piv2_config
#(
	.I2C_ID			(I2C_ID			),		// I2C ID
	.INITIAL_CODE	(INITIAL_CODE	),		// Initial code file
	.MEM_DEPTH		(MEM_DEPTH		),		// Initial code memory depth
	.REGISTER_BYTE	(REGISTER_BYTE	)		// Number of byte of register
)
inst_piv2_config
(
	.i_arst			(~resetn		),
	.i_sysclk		(i_sysclk		),
	.i_pll_locked	(i_pll_locked	),
	.o_state		(w_i2c_state	),
	.o_confdone		(w_confdone		),
	
	.i_dbg_we		(w_i2c_reg_we		),
	.i_dbg_din		(w_i2c_reg_din		),
	.i_dbg_addr		(w_i2c_reg_addr		),
	.o_dbg_dout		(w_i2c_reg_dout		),
	.i_dbg_reconfig	(w_i2c_reg_reconfig	),
		
	.i_sda			(i_sda		),
	.o_sda_oe		(o_sda_oe	),
	.i_scl			(i_scl		),
	.o_scl_oe		(o_scl_oe	),
	.o_rstn			(o_xclr		)
);
   
/* Sync MIPI Rx signals to FPGA-core mipi_pclk domain (posedge) */
always @(posedge mipi_pclk)
begin
    if (~resetn) 
	begin
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
		r_green_gain 	<= 3'd3;
		r_blue_gain	 	<= 3'd5;
		r_x_mipi		<= 11'b0;
		r_y_mipi		<= 11'b0;
		r_rx_data_1P	<= 64'b0;
		r_rx_data_2P	<= 64'b0;
		r_x_total		<= 11'b0;
		r_fb_reset		<= 1'b0;
	end
	else
	begin
		rx_vs_VC        <= rx_vs;
		rx_hs_VC		<= rx_hs;
		rx_valid_VC		<= rx_valid;
		rx_vs_VC_1P     <= rx_vs_VC;
		rx_hs_VC_1P		<= rx_hs_VC;
		rx_valid_VC_1P	<= rx_valid_VC;
		rx_type_VC      <= rx_type;
		rx_error_VC     <= rx_error;
		rx_vc_VC        <= rx_vc;
		rx_count_VC     <= rx_count;
		r_rx_data_1P	<= rx_data;
		r_rx_data_2P	<= r_rx_data_1P;
		
		if (rx_hs_VC)
		begin
			if (rx_valid_VC)
				r_x_mipi	<= r_x_mipi + 1'b1;
		end	
		else
			r_x_mipi	<= 11'b0;
		
		if (!rx_hs_VC && rx_hs_VC_1P)
		begin
			if (r_y_mipi == V_ActivePix - 1)
				r_y_mipi	<= 11'b0;
			else			
				r_y_mipi	<= r_y_mipi + 1'b1;
				
			r_x_total	<= r_x_mipi;
		end
		
		if (!rx_vs_VC && rx_vs_VC_1P)
		begin
			r_y_mipi	<= 11'b0;
			r_x_mipi	<= 11'b0;
			r_fb_reset	<= 1'b1;
		end
			
		//RGB gain is controlled by debugger
		if (probe_trigger)
		begin
			r_red_gain		<= red_gain;
			r_green_gain 	<= green_gain;
			r_blue_gain	 	<= blue_gain;
		end
		else
		begin
			r_red_gain		<= 3'd7;
			r_green_gain 	<= 3'd4;	// RAW of the camera has more green pixel
			r_blue_gain	 	<= 3'd6;
		end
	end	
end

/*
	DDR3 2G x16: ROW address = 14 bits, COL address = 10 bits, bank address = 3 bits
	Address space : 32'h0000_0000 => 32'h07FF_FFFF 
*/
frame_buffer
#(
	.X_TOTAL	(H_ActivePix >> 1),
	.Y_TOTAL	(V_ActivePix	),	
	.START_ADDR	(32'h00000000	),
	.STOP_ADDR	(32'h04000000	)
  )
inst_frame_buffer_01
(    
	.wr_p_clk	(mipi_pclk		),
	.rd_p_clk	(tx_slowclk		),
	.axi_clk	(axi_clk		),
	.rstn	(r_fb_reset		),
	.x_win	(r_xwin			),
	.x_start(r_xstart		),
	.y_win	(r_ywin			),
	.y_start(r_ystart		),
	.aid	(aid_0			),
	.aaddr	(aaddr_0		),
	.alen	(alen_0			),
	.asize	(asize_0		),
	.aburst	(aburst_0		),
	.alock	(alock_0		),
	.avalid	(avalid_0		),
	.aready	(aready_0		),
	.atype	(atype_0		),
	.wid	(wid_0			),
	.wdata	(wdata_0		),
	.wstrb	(wstrb_0		),
	.wlast	(wlast_0		),
	.wvalid	(wvalid_0		),
	.wready	(wready_0		),
	.rid	(rid_0			),
	.rdata	(rdata_0		),
	.rlast	(rlast_0		),
	.rvalid	(rvalid_0		),
	.rready	(rready_0		),
	.rresp	(rresp_0		),
	.bid	(bid_0			),
	.bvalid	(bvalid_0		),
	.bready	(bready_0		),
	
	.in_x_wr	(r_x_mipi + (r_x_pointer >> 1)),
	.in_y_wr	(r_y_mipi + r_y_pointer		),
	.in_wr_en	(rx_valid_VC				),
	.in_hs		(rx_hs_VC					),
	.in_wr_00	(r_rx_data_1P[39:32]	),           
	.in_wr_01	(r_rx_data_1P[29:22]	),         
	.in_wr_10	(r_rx_data_1P[19:12]	),
	.in_wr_11	(r_rx_data_1P[9:2]		),
	
	.in_de		(de_r_lvds_out		),
	.in_valid	(valid_r_lvds_out	),
	.in_hsync	(hsync_r_lvds_out	),                  
	.in_vsync	(vsync_r_lvds_out	),
			
	.out_de		(w_out_de			),
	.out_valid	(w_out_valid		),
	.out_hsync	(w_out_hsync		),
	.out_vsync	(w_out_vsync		),
	.out_rd_00	(w_out_data[39:32]	),
	.out_rd_01	(w_out_data[29:22]	),
	.out_rd_10	(w_out_data[19:12]	),
	.out_rd_11	(w_out_data[9:2]	)
);

assign	w_out_data[31:30]	=	w_out_data[39:38];
assign	w_out_data[21:20]	=	w_out_data[29:28];
assign	w_out_data[11:10]	=	w_out_data[19:18];
assign	w_out_data[1:0]		=	w_out_data[9:8];

always @ (posedge tx_slowclk)
begin
	if(~resetn)
	begin
		r_resync_x_2P	<= 11'b0;
		r_resync_y_2P	<= 11'b0;
		r_resync_de_2P	<= 1'b0;
	end
	else
	begin
		r_resync_de_2P	<= w_out_de;
	
		if (w_out_de)
		begin
			if (w_out_valid)
				r_resync_x_2P	<= r_resync_x_2P + 1'b1;
		end
		else
			r_resync_x_2P	<= 11'b0;
				
		if (!w_out_de && r_resync_de_2P)
			r_resync_y_2P	<= r_resync_y_2P + 1'b1;
			
		if (!w_out_vsync)
			r_resync_y_2P	<= 11'b0;
	end
end

/* RGB gain filter */
rgb_gain
#(
	.P_DEPTH(OUT_P_DEPTH)
)
inst_rgb_gain_01
(
	.i_arstn	(resetn		),
	.i_pclk		(tx_slowclk	),

	.i_hs		(w_out_hsync), 
	.i_vs		(w_out_vsync), 
	.i_de		(w_out_de	),     
	.i_valid	(w_out_valid),         
	.i_data		(w_out_data	),
	
	.red_gain	(r_red_gain		),
	.green_gain	(r_green_gain	),
	.blue_gain	(r_blue_gain	),
	
	.o_de		(w_de	),
	.o_valid	(w_valid),
	.o_hs		(w_hs	),
	.o_vs		(w_vs	),
		
	.o_data		(w_data)
);

/* Remap 4 pixels per clock to 2 pixels per clock */
always @ (posedge tx_slowclk)
begin
	if(~resetn)
	begin
		r_slow_data_1P			<= 20'b0;
		vsync_r_lvds_mipi_1P	<= 1'b0;
		hsync_r_lvds_mipi_1P	<= 1'b0;
		de_r_lvds_mipi_1P		<= 1'b0;
		valid_r_lvds_mipi_1P	<= 1'b0;
		vsync_r_lvds_mipi_2P	<= 1'b0;
		hsync_r_lvds_mipi_2P	<= 1'b0;
		de_r_lvds_mipi_2P		<= 1'b0;
	end
	else
	begin
		vsync_r_lvds_mipi_1P	<= w_vs;
		hsync_r_lvds_mipi_1P	<= w_hs;
		de_r_lvds_mipi_1P		<= w_de;
		valid_r_lvds_mipi_1P	<= w_valid;
		vsync_r_lvds_mipi_2P	<= vsync_r_lvds_mipi_1P;
		hsync_r_lvds_mipi_2P	<= hsync_r_lvds_mipi_1P;
		de_r_lvds_mipi_2P		<= de_r_lvds_mipi_1P;	
		if (w_de)
		begin
			if (!w_valid)
				r_slow_data_1P	<= w_data[OUT_P_DEPTH*2-1:0];
			else
				r_slow_data_1P	<= w_data[OUT_P_DEPTH*4-1:OUT_P_DEPTH*2];
		end
		else
			r_slow_data_1P		<= 20'b0;
	end
end

/* 3 lines buffer */
line_buffer
#(
	.P_DEPTH	(OUT_P_DEPTH	),	
	.X_CNT_WIDTH(FIFO_ADDR_WIDTH)
)
inst_line_buffer_01
(
	.i_arstn	(resetn),
	.i_pclk		(tx_slowclk	),
		
	.i_vsync	(vsync_r_lvds_mipi_1P	),
	.i_hsync	(hsync_r_lvds_mipi_1P	),
	.i_de		(de_r_lvds_mipi_1P		),
	.i_p		(r_slow_data_1P			),
		
	.o_vsync	(w_mipi_tx_vsync_00	),
	.o_hsync	(w_mipi_tx_hsync_00	),
	.o_de		(w_mipi_tx_de_00	),
	.o_p_11		(w_mipi_tx_11		),
	.o_p_00		(w_mipi_tx_00		),	
	.o_p_01		(w_mipi_tx_01		)
);

/* RAW to RGB */
raw_to_rgb
#(
	.P_DEPTH	(OUT_P_DEPTH		),
	.X_CNT_WIDTH(FIFO_ADDR_WIDTH	)
)
inst_raw_to_rgb_in0
(                                                                    
	.i_arstn	(resetn		),                                               
	.i_pclk		(tx_slowclk	), 
		
	.i_vsync	(w_mipi_tx_vsync_00	),
	.i_hsync	(w_mipi_tx_hsync_00	),
	.i_de		(w_mipi_tx_de_00	),
	.i_p_11		(w_mipi_tx_11		),
	.i_p_00		(w_mipi_tx_00		),
	.i_p_01		(w_mipi_tx_01		),
	
	.o_vsync	(w_vsync_00_1P	),
	.o_hsync	(w_hsync_00_1P	),
	.o_de		(w_de_00_1P		),
	.o_cnt		(w_pixel_cnt	),
	.o_r		(w_r_00_00_1P	),
	.o_g		(w_g_00_00_1P	),	
	.o_b		(w_b_00_00_1P	)              	
);

/* VGA counter for the output display sync signals generator */
/* x_cnt_lvds_out for HSYNC and DEN */  
always @ (posedge tx_slowclk)
begin
	if(~resetn)
	begin    
		x_cnt_lvds_out 		<= 12'b0;		
		de_r_lvds_out 		<= 1'b0;
		hsync_r_lvds_out	<= 1'b1;
		de_r_lvds_out_1P	<= 1'b0;
		hsync_r_lvds_out_1P	<= 1'b1;
		valid_r_lvds_out	<= 1'b0;
		vsync_r_lvds_out_1P	<= 1'b1;
	end	
	else
	begin
		de_r_lvds_out_1P	<= de_r_lvds_out;
	    hsync_r_lvds_out_1P	<= hsync_r_lvds_out;
		vsync_r_lvds_out_1P	<= vsync_r_lvds_out;
		
		if(x_cnt_lvds_out == LinePeriod - 1'b1)
		begin
			x_cnt_lvds_out		<= 12'b0;
			hsync_r_lvds_out 	<= 1'b0;
		end
		else
			x_cnt_lvds_out <= x_cnt_lvds_out + 1'b1;
		
		if (x_cnt_lvds_out == H_SyncPulse - 1'b1) 
            hsync_r_lvds_out <= 1'b1;
		
		if (de_vsyn_r_lvds_out)
		begin
			if(x_cnt_lvds_out == (Hde_end - 1'b1))
				de_r_lvds_out 		<= 1'b0;
			else if(x_cnt_lvds_out == Hde_start - 1'b1)
				de_r_lvds_out 		<= 1'b1;
		end
		else
			de_r_lvds_out 		<= 1'b0;
			
		if (de_r_lvds_out)
			valid_r_lvds_out	<= ~valid_r_lvds_out;
		else
			valid_r_lvds_out	<= 1'b0;
	end
end
   
/* y_cnt_lvds_out for VSYNC */  
always @ (posedge tx_slowclk) 
begin
	if(~resetn)
	begin
        y_cnt_lvds_out <= 11'b0;
		vsync_r_lvds_out <= 1'b1;
	end
    else
	begin
		if(x_cnt_lvds_out == LinePeriod - 1'b1) 
		begin
			if (y_cnt_lvds_out == FramePeriod - 1'b1)
			begin
				y_cnt_lvds_out <= 11'b0;
				vsync_r_lvds_out <= 1'b0;
			end
			else
				y_cnt_lvds_out <= y_cnt_lvds_out + 1'b1;		
		end
		
		if(y_cnt_lvds_out == V_SyncPulse - 1'b1)
			vsync_r_lvds_out <= 1'b1;
	end
end
      
always @ (posedge tx_slowclk)
begin
	if(~resetn) 
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
  
/* Remap 2 pixels per clock to odd and even LVDS pixels */
always @(posedge tx_slowclk) 
begin 
    if(~resetn)
	begin
		lvds_1_data_r 		<= {OUT_P_DEPTH{1'b0}};                                            
		lvds_1_data_g 		<= {OUT_P_DEPTH{1'b0}};                                                    
		lvds_1_data_b 		<= {OUT_P_DEPTH{1'b0}};                                                    
		lvds_2_data_r 		<= {OUT_P_DEPTH{1'b0}};                                                    
		lvds_2_data_g 		<= {OUT_P_DEPTH{1'b0}};
		lvds_2_data_b 		<= {OUT_P_DEPTH{1'b0}};
		x_cnt_by2_ram 		<= 12'b0;
		x_cnt_by2_ram_1P	<= 12'b0;
		r_in_y_wr			<= 11'b0;
		r_in_y_wr_1P		<= 11'b0;
		de_r_lvds_1P		<= 1'b0;
		hsync_r_lvds_1P		<= 1'b0;
		vsync_r_lvds_1P		<= 1'b0;
		vsync_r_lvds_2P		<= 1'b0;
	end
	else 
	begin
		if(w_de_00_1P)                                                            
		begin
			x_cnt_by2_ram	<= x_cnt_by2_ram + 1'b1;	
			lvds_1_data_r	<= w_r_00_00_1P[OUT_P_DEPTH-1:0];  
			lvds_1_data_g	<= w_g_00_00_1P[OUT_P_DEPTH-1:0];  
			lvds_1_data_b	<= w_b_00_00_1P[OUT_P_DEPTH-1:0];  
			lvds_2_data_r	<= w_r_00_00_1P[OUT_P_DEPTH*2-1:OUT_P_DEPTH];
			lvds_2_data_g	<= w_g_00_00_1P[OUT_P_DEPTH*2-1:OUT_P_DEPTH];
			lvds_2_data_b	<= w_b_00_00_1P[OUT_P_DEPTH*2-1:OUT_P_DEPTH];
	
			if (x_cnt_by2_ram < (r_xwin >> 1))
			begin
				de_r_test_1P		<= w_de_00_1P;
				x_cnt_by2_ram_1P	<= x_cnt_by2_ram;
			end
			else
			begin
				de_r_test_1P		<= 1'b0;		
			end
		end                                                             
		else
		begin
			x_cnt_by2_ram		<= 12'b0;
			lvds_1_data_r		<= {OUT_P_DEPTH{1'b0}};
			lvds_1_data_g		<= {OUT_P_DEPTH{1'b0}};
			lvds_1_data_b		<= {OUT_P_DEPTH{1'b0}};
			lvds_2_data_r		<= {OUT_P_DEPTH{1'b0}};
			lvds_2_data_g		<= {OUT_P_DEPTH{1'b0}};
			lvds_2_data_b		<= {OUT_P_DEPTH{1'b0}};		
			x_cnt_by2_ram_1P	<= 12'b0;
			de_r_test_1P		<= 1'b0;
		end
	
		de_r_lvds_1P		<= w_de_00_1P;  		
		hsync_r_lvds_1P		<= w_hsync_00_1P;
		vsync_r_lvds_1P		<= w_vsync_00_1P;
		vsync_r_lvds_2P		<= vsync_r_lvds_1P;
		r_in_y_wr_1P		<= r_in_y_wr;
	
		if (!w_de_00_1P && de_r_lvds_1P)
		begin
			if (r_in_y_wr < V_ActivePix)
				r_in_y_wr	<= r_in_y_wr + 1'b1;
			else
				r_in_y_wr	<= 11'b0;
		end
		
		if (!w_vsync_00_1P && vsync_r_lvds_1P)
			r_in_y_wr		<= 11'b0;
	end
end

/* 
	Output to LVDS
	24bit color, RGB888	pixel arrangement
*/
assign 	lvds_1a_DATA 	= {lvds_1_data_r[2], lvds_1_data_r[3], lvds_1_data_r[4], lvds_1_data_r[5], lvds_1_data_r[6], lvds_1_data_r[7], lvds_1_data_g[2]};
assign 	lvds_1b_DATA 	= {lvds_1_data_g[3], lvds_1_data_g[4], lvds_1_data_g[5], lvds_1_data_g[6], lvds_1_data_g[7], lvds_1_data_b[2], lvds_1_data_b[3]};
assign 	lvds_1c_DATA 	= {lvds_1_data_b[4], lvds_1_data_b[5], lvds_1_data_b[6], lvds_1_data_b[7], hsync_r_lvds_1P, vsync_r_lvds_1P, de_r_lvds_1P};
assign 	lvds_1d_DATA 	= {lvds_1_data_r[8], lvds_1_data_r[9], lvds_1_data_g[8], lvds_1_data_g[9], lvds_1_data_b[8], lvds_1_data_b[9], 1'b0};

assign 	lvds_2a_DATA 	= {lvds_2_data_r[2], lvds_2_data_r[3], lvds_2_data_r[4], lvds_2_data_r[5], lvds_2_data_r[6], lvds_2_data_r[7], lvds_2_data_g[2]};
assign 	lvds_2b_DATA 	= {lvds_2_data_g[3], lvds_2_data_g[4], lvds_2_data_g[5], lvds_2_data_g[6], lvds_2_data_g[7], lvds_2_data_b[2], lvds_2_data_b[3]};
assign 	lvds_2c_DATA 	= {lvds_2_data_b[4], lvds_2_data_b[5], lvds_2_data_b[6], lvds_2_data_b[7], hsync_r_lvds_1P, vsync_r_lvds_1P, de_r_lvds_1P};
assign 	lvds_2d_DATA 	= {lvds_2_data_r[8], lvds_2_data_r[9], lvds_2_data_g[8], lvds_2_data_g[9], lvds_2_data_b[8], lvds_2_data_b[9], 1'b0};

assign	lvds_clk		= 7'b1100011;

/* LED5 and LED6 will toggle if there MIPI Rx has VS */
always @(posedge mipi_pclk)
begin
	if (~resetn)
		flash_cnt <= 5'b0;
	else 
	if (mipi_inst1_ERROR[9])	// bit9 will be "1"	if there is no error
	begin
		vsync_LED	<= mipi_inst1_VSYNC[0];
		if (!vsync_LED && mipi_inst1_VSYNC[0])
			flash_cnt <= flash_cnt + 1'b1;
		else
		if (flash_cnt == 5'b11111)
			flash_cnt <= 1;
	end
end

assign 	led5 = flash_cnt[4];
assign 	led6 = ~flash_cnt[4];

/* Debug signals */
always@(posedge mipi_pclk)
begin
	if (~resetn) 
	begin
		reg_hsync			<= 1'b0;
		reg_vsync			<= 1'b0;
		reg_cnt				<= 4'h0;
		reg_valid			<= 1'b0;
		reg_mdata			<= 64'b0;
		reg_mtype			<= 6'b0;
		reg_vc				<= 2'b0;
		reg_error			<= 18'b0;		
		r_init_start		<= 4'b0;
		r_init_trigger		<= 1'b0;
		r_vio_update		<= 1'b0;
		r_axi_vs_1P			<= 1'b0;
		r_axi_vs_2P			<= 1'b0;
		r_probe_trigger_1P	<= 1'b0;
	end
	else
	begin
		reg_mtype	<= rx_type;
		reg_hsync	<= rx_hs;
		reg_vsync	<= rx_vs;
		reg_cnt		<= rx_count;
		reg_valid	<= rx_valid;
		reg_mdata	<= rx_data;		
		reg_vc		<= rx_vc;
		reg_error	<= rx_error;
		r_axi_vs_1P	<= w_vsync_00_1P;
		r_axi_vs_2P	<= r_axi_vs_1P;
		
		r_probe_trigger_1P	<= probe_trigger;
		
		if (probe_trigger && !r_probe_trigger_1P)
			r_init_trigger	<= 1'b1;
		
		if (!probe_trigger && r_probe_trigger_1P)
			r_vio_update	<= 1'b0;
		
		if (r_vio_update)
		begin
			r_xwin		<= w_xwin_rp + w_xstart_rp;
			r_xstart	<= w_xstart_rp;
			
			r_ywin		<= w_ywin + w_ystart;
			r_ystart	<= w_ystart;
			
			r_x_pointer	<= w_xpointer;
			r_y_pointer	<= w_ypointer;
		end
		else
		begin
			r_xwin		<= 11'd511;
			r_xstart 	<= 11'd0;
			
			r_ywin		<= V_ActivePix - 1'b1;
			r_ystart 	<= 11'd0;
			
			r_x_pointer	<= 11'd0;
			r_y_pointer	<= 11'd0;
		end
		
		if(r_init_trigger)
		begin
			if (!r_axi_vs_1P && r_axi_vs_2P)
			begin
				r_init_start	<= r_init_start + 1'b1;
			end
			if (r_init_start == 4'b1111)
			begin
				r_init_trigger	<= 1'b0;
				r_init_start	<= 4'b0;
				r_vio_update	<= 1'b1;
			end
		end
	end
end

assign	w_xwin_rp	= (w_xwin[5:0] == 6'd63)	?	w_xwin		:	{w_xwin[10:6], 6'd63};
assign	w_xstart_rp	= (w_xstart[5:0] == 6'd0)	?	w_xstart	:	{w_xstart[10:6], 6'd0};

/* Debugger */
edb_top efx_dbg_top_U (
    .bscan_CAPTURE        	( jtag_inst1_CAPTURE ),
    .bscan_DRCK           	( jtag_inst1_DRCK ),
    .bscan_RESET          	( jtag_inst1_RESET ),
    .bscan_RUNTEST        	( jtag_inst1_RUNTEST ),
    .bscan_SEL            	( jtag_inst1_SEL ),
    .bscan_SHIFT          	( jtag_inst1_SHIFT ),
    .bscan_TCK            	( jtag_inst1_TCK ),
    .bscan_TDI            	( jtag_inst1_TDI ),
    .bscan_TMS            	( jtag_inst1_TMS ),
    .bscan_UPDATE         	( jtag_inst1_UPDATE ),
    .bscan_TDO            	( jtag_inst1_TDO ),
	
	.VIO_0_clk            	( mipi_pclk ),
    .VIO_0_MIPI_TYPE      	( reg_mtype ),
    .VIO_0_MIPI_HSYNC     	( reg_hsync ),
    .VIO_0_MIPI_VSYNC     	( reg_vsync ),
    .VIO_0_MIPI_SCNT      	( reg_cnt ),
    .VIO_0_MIPI_DATA      	( reg_mdata ),
    .VIO_0_MIPI_VALID     	( reg_valid ),
    .VIO_0_MIPI_VC        	( reg_vc ),
    .VIO_0_MIPI_ERROR     	( reg_error ),
	.VIO_0_MIPI_CLEAR       ( w_mipi_inst1_CLEAR ),
	.VIO_0_PROBE_TRIGGER	( probe_trigger ),
	.VIO_0_RED_GAIN			( red_gain ),
	.VIO_0_GREEN_GAIN		( green_gain ),
	.VIO_0_BLUE_GAIN		( blue_gain ),
	.VIO_0_X_WIN			( w_xwin ),
	.VIO_0_X_START			( w_xstart ),
	.VIO_0_Y_WIN			( w_ywin ),
	.VIO_0_Y_START			( w_ystart ),
	.VIO_0_X_POINTER		( w_xpointer ),
	.VIO_0_Y_POINTER		( w_ypointer ),
	.VIO_0_RED_BACK			( w_rback ),
	.VIO_0_GREEN_BACK		( w_gback ),
	.VIO_0_BLUE_BACK		( w_bback ),
	.VIO_0_I2C_STATE		( w_i2c_state ),
	.VIO_0_I2C_REG_DOUT		( w_i2c_reg_dout ),
	.VIO_0_I2C_REG_WE		( w_i2c_reg_we ),
	.VIO_0_I2C_REG_DIN		( w_i2c_reg_din ),
	.VIO_0_I2C_REG_ADDR		( w_i2c_reg_addr ),
	.VIO_0_I2C_REG_RECONFIG	( w_i2c_reg_reconfig )
);

/* Output debug signal */
assign	o_dbg_mipi	= {w_out_hsync, w_out_vsync, w_out_de, w_out_rd_10[0]};

endmodule

//////////////////////////////////////////////////////////////////////////////
// Copyright (C) 2013-2020 Efinix Inc. All rights reserved.
//
// This   document  contains  proprietary information  which   is
// protected by  copyright. All rights  are reserved.  This notice
// refers to original work by Efinix, Inc. which may be derivitive
// of other work distributed under license of the authors.  In the
// case of derivative work, nothing in this notice overrides the
// original author's license agreement.  Where applicable, the 
// original license agreement is included in it's original 
// unmodified form immediately below this header.
//
// WARRANTY DISCLAIMER.  
//     THE  DESIGN, CODE, OR INFORMATION ARE PROVIDED “AS IS” AND 
//     EFINIX MAKES NO WARRANTIES, EXPRESS OR IMPLIED WITH 
//     RESPECT THERETO, AND EXPRESSLY DISCLAIMS ANY IMPLIED WARRANTIES, 
//     INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF 
//     MERCHANTABILITY, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR 
//     PURPOSE.  SOME STATES DO NOT ALLOW EXCLUSIONS OF AN IMPLIED 
//     WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO LICENSEE.
//
// LIMITATION OF LIABILITY.  
//     NOTWITHSTANDING ANYTHING TO THE CONTRARY, EXCEPT FOR BODILY 
//     INJURY, EFINIX SHALL NOT BE LIABLE WITH RESPECT TO ANY SUBJECT 
//     MATTER OF THIS AGREEMENT UNDER TORT, CONTRACT, STRICT LIABILITY 
//     OR ANY OTHER LEGAL OR EQUITABLE THEORY (I) FOR ANY INDIRECT, 
//     SPECIAL, INCIDENTAL, EXEMPLARY OR CONSEQUENTIAL DAMAGES OF ANY 
//     CHARACTER INCLUDING, WITHOUT LIMITATION, DAMAGES FOR LOSS OF 
//     GOODWILL, DATA OR PROFIT, WORK STOPPAGE, OR COMPUTER FAILURE OR 
//     MALFUNCTION, OR IN ANY EVENT (II) FOR ANY AMOUNT IN EXCESS, IN 
//     THE AGGREGATE, OF THE FEE PAID BY LICENSEE TO EFINIX HEREUNDER 
//     (OR, IF THE FEE HAS BEEN WAIVED, $100), EVEN IF EFINIX SHALL HAVE 
//     BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGES.  SOME STATES DO 
//     NOT ALLOW THE EXCLUSION OR LIMITATION OF INCIDENTAL OR 
//     CONSEQUENTIAL DAMAGES, SO THIS LIMITATION AND EXCLUSION MAY NOT 
//     APPLY TO LICENSEE.
//
/////////////////////////////////////////////////////////////////////////////