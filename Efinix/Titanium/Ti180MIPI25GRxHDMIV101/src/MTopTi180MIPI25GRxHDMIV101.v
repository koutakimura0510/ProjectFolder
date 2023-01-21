/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MTopTi180MIPI25GRxHDMIV101.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Revision    :
 * 29/Dec-2022 V1.00 New Release, Inh.fr. "MTopTi180MIPI25GRxHDMIV100.v" K.Kimura
 * 13/Jan-2023 V1.01 MIPI D-PHY Decoder を自作に変更                     K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
// efx_run.bat .\Ti180BramPrimitiveV100.xml --flow program --pgm_opts mode=jtag .\outflow\Ti180BramPrimitiveV100.bit
// efx_run.bat .\Ti180BramPrimitiveV100.xml --flow compile
// efx_run.bat .\Ti180BramPrimitiveV100.xml --flow full
module MTopTi180MIPI25GRxHDMIV101 #(
	parameter pDdrAxiDatWidth0	= 512,
	parameter pDdrAxiDatWidth1	= 512
)(
// D-PHY Hard-IP
// Controls and Status Signals
output 			MipiDphyRx1_RESET_N,					// Disables PHY and Digital Logic
output 			MipiDphyRx1_RST0_N,						// Async FIFO RST and sync out of RST
input 			MipiDphyRx1_STOPSTATE_CLK,				// Lane in Stop State
input 			MipiDphyRx1_STOPSTATE_LAN0,				// Data Lane in Stop State
input 			MipiDphyRx1_STOPSTATE_LAN1,				// Data Lane in Stop State
input 			MipiDphyRx1_ERR_ESC_LAN0,				// Lane Escape Command Error
input 			MipiDphyRx1_ERR_ESC_LAN1,				// Lane Escape Command Error
input 			MipiDphyRx1_ERR_CONTROL_LAN0,			// Lane Has Line State Error
input 			MipiDphyRx1_ERR_CONTROL_LAN1,			// Lane Has Line State Error
output 			MipiDphyRx1_TX_REQUEST_ESC,				// Lane0 Request TX Escape Mode , TX_CLK_ESC
output 			MipiDphyRx1_TURN_REQUEST,				// Lane0 Request Trunaround , TX_CLK_ESC
output 			MipiDphyRx1_FORCE_RX_MODE,
output	[3:0] 	MipiDphyRx1_TX_TRIGGER_ESC,				// Lane0 Send a Trigger Event , TX_CLK_ESC
input	[3:0] 	MipiDphyRx1_RX_TRIGGER_ESC,				// Lane0 Received Trigger Event , RX_CLK_ESC_LAN
input 			MipiDphyRx1_DIRECTION,
input 			MipiDphyRx1_ERR_CONTENTION_LP0,			// Lane0 Contention Error when Driving
input 			MipiDphyRx1_ERR_CONTENTION_LP1,			// Lane0 Contention Error when Driving
// HS Mode Signals
input 			MipiDphyRx1_RX_CLK_ACTIVE_HS,			// HS Clock Lane Active
input 			MipiDphyRx1_RX_ACTIVE_HS_LAN0,			// HS Reception Active
input 			MipiDphyRx1_RX_ACTIVE_HS_LAN1,			// HS Reception Active
input 			MipiDphyRx1_RX_VALID_HS_LAN0,			// HS Data Receive Valid
input 			MipiDphyRx1_RX_VALID_HS_LAN1,			// HS Data Receive Valid
input 			MipiDphyRx1_RX_SYNC_HS_LAN0,			// HS Reveiver Sync. Observed
input 			MipiDphyRx1_RX_SYNC_HS_LAN1,			// HS Reveiver Sync. Observed
input 			MipiDphyRx1_RX_SKEW_CAL_HS_LAN0,		// HS Reveiver DeSkew Burst Received.
input 			MipiDphyRx1_RX_SKEW_CAL_HS_LAN1,		// HS Reveiver DeSkew Burst Received.
input	[7:0] 	MipiDphyRx1_RX_DATA_HS_LAN0,			// HS Receive Data
input	[7:0] 	MipiDphyRx1_RX_DATA_HS_LAN1,			// HS Receive Data
input 			MipiDphyRx1_ERR_SOT_HS_LAN0,			// State-of-Transmission(SOT)Error
input 			MipiDphyRx1_ERR_SOT_HS_LAN1,
input 			MipiDphyRx1_ERR_SOT_SYNC_HS_LAN0,		// SOT SYnc Error
input 			MipiDphyRx1_ERR_SOT_SYNC_HS_LAN1,
// LP Mode Signals
input 			MipiDphyRx1_RX_LPDT_ESC,				// Lane enter LPDT RX Mode. , RX_CLK_ESC_LAN0
input	[7:0] 	MipiDphyRx1_RX_DATA_ESC,				// Lane LPDT RX Data , RX_CLK_ESC_LAN0
input 			MipiDphyRx1_RX_VALID_ESC,				// Lane LPDT RX Data Valid , RX_CLK_ESC_LAN0
input 			MipiDphyRx1_RX_ERR_SYNC_ESC,			// LPDT RX Data Sync Error
output 			MipiDphyRx1_TX_LPDT_ESC,				// Lane0 Enter LPDT TX Mode , TX_CLK_ESC
output	[7:0]	MipiDphyRx1_TX_DATA_ESC,				// Lane0 LPDT TX Data , TX_CLK_ESC
output 			MipiDphyRx1_TX_VALID_ESC,				// Lane0 LPDT TX Data Valid , TX_CLK_ESC
output 			MipiDphyRx1_TX_READY_ESC,				// Lane0 LPDT TX Data Ready , TX_CLK_ESC
// Ultra Low Power Sleep Mode Signals
output			MipiDphyRx1_TX_ULPS_ESC,				// Lane 0 Enter ULPS Mode. , TX_CLK_ESC
output			MipiDphyRx1_TX_ULPS_EXIT,				// Lane 0 Exit ULPS Mode. , TX_CLK_ESC
input 			MipiDphyRx1_RX_ULPS_CLK_NOT,			// CLK0 Enter ULPS Mode
input 			MipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT,		// CLK0 is in ULPS (Active Low)
input 			MipiDphyRx1_RX_ULPS_ESC_LAN0,			// Lane n Enter ULPS Mode. RX_CLK_ESC_LANn
input 			MipiDphyRx1_RX_ULPS_ESC_LAN1,			// RX_CLK_ESC_LANn
input 			MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0,	// Lane n is in ULPS (Active Low)
input 			MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1,
// Clock Domain
// output 		MipiDphyRx1_TX_CFG_CLK,					// Configration CLK
input  			MipiDphyRx1_WORD_CLKOUT_HS,				// HS Receive Byte/Word CLK
input 			MipiDphyRx1_LP_CLK,						// Low Power State CLK
input 			MipiDphyRx1_RX_CLK_ESC_LAN0,			// Escape Mode Receive CLK
input 			MipiDphyRx1_RX_CLK_ESC_LAN1,			// Escape Mode Receive CLK
output 			MipiDphyRx1_TX_CLK_ESC,					// Escape Mode TX CLK must be lower than 20[MHz]
//
// DDR Hard-IP
// Startup Sequencer Signals
output  							DDR_CFG_PHY_RSTN,	// Active low reset to DDR PHY.
output  							DDR_CFG_RST,		// Active-high DDR configuration controller reset.
output  							DDR_CFG_START,		// Start the DDR configuration controller.
input   							DDR_CFG_DONE,		// Indicates the controller configuration is done
output  							DDR_CFG_SEL,		// To select whether to use internal DDR configuration controller or user register ports for configuration:
														// 0: Use internal configuration controller.
														// 1: Use register configuration ports (cfg_rst, cfg_start, cfg_done will be disabled).
// Controller Signal 
output 								DDR_CTRL_RSTN,		// Controller Reset Signal 
input 								DDR_CTRL_INT,		// Interrupt sign form controller 
input   							DDR_CTRL_MEM_RST_VALID,	// The user should wait until the mem_rst_valid signal is asserted and the DFI command signals have transitioned to the PHY pad outputs to release control of these signals
input 								DDR_CTRL_REFRESH,	// Controller Refresh Pin Signal 
input 								DDR_CTRL_BUSY,		// This will only be low when the controller is not reading data, writing data or processing a command
input 								DDR_CTRL_CMD_Q_ALMOST_FULL,// Command Queue Full Pin 
input 								DDR_CTRL_DP_IDLE,	// Data Path Idle
input 	[					 1:0] 	DDR_CTRL_CKE,		// Delayed CKE form Controller
input 	[					 1:0] 	DDR_CTRL_PORT_BUSY,	// Port Busy Reading Data
// DDR AXI 0 Read Address Channel
output 								DDR_ARST_0,
output	[					32:0] 	DDR_ARADDR_0,		// Read address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	DDR_ARBURST_0,		// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	DDR_ARID_0,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	DDR_ARLEN_0,		// Burst length. This signal indicates the number of transfers in a burst.
input								DDR_ARREADY_0,		// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					 2:0]	DDR_ARSIZE_0,		// Burst size. This signal indicates the size of each transfer in the burst.
output								DDR_ARVALID_0,		// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								DDR_ARLOCK_0,		// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								DDR_ARAPCMD_0,		// Read auto-precharge.
output								DDR_ARQOS_0,		// QoS indentifier for read transaction.
// DDR AXI 0 Wrtie Address Channel
output	[					32:0] 	DDR_AWADDR_0,		// Write address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	DDR_AWBURST_0,		// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	DDR_AWID_0,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	DDR_AWLEN_0,		// Burst length. This signal indicates the number of transfers in a burst.
input								DDR_AWREADY_0,		// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					 2:0] 	DDR_AWSIZE_0,		// Burst size. This signal indicates the size of each transfer in the burst.
output								DDR_AWVALID_0,		// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								DDR_AWLOCK_0,		// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								DDR_AWAPCMD_0,		// Write auto-precharge.
output								DDR_AWQOS_0,		// QoS indentifier for write transaction.
output	[					 3:0] 	DDR_AWCACHE_0,		// Memory type. This signal indicates how transactions are required to progress through a system.
output								DDR_AWALLSTRB_0,	// Write all strobes asserted.
output								DDR_AWCOBUF_0,		// Write coherent bufferable selection.
// DDR AXI 0 Wrtie Response Channel
input	[					 5:0]	DDR_BID_0,			// Response ID tag. This signal is the ID tag of the write response.
output								DDR_BREADY_0,		// Response ready. This signal indicates that the master can accept a write response.
input	[					 1:0]	DDR_BRESP_0,		// Read response. This signal indicates the status of the read transfer.
input								DDR_BVALID_0,		// Write response valid. This signal indicates that the channel is signaling a valid write response.
// DDR AXI 0 Read Data Channel
input	[	pDdrAxiDatWidth0-1:0]	DDR_RDATA_0,		// Read data.
input	[					 5:0] 	DDR_RID_0,			// Read ID tag. This signal is the identification tag for the read data group of signals generated by the slave.
input								DDR_RLAST_0,		// Read last. This signal indicates the last transfer in a read burst.
output								DDR_RREADY_0,		// Read ready. This signal indicates that the master can accept the read data and response information.
input	[					 1:0] 	DDR_RRESP_0,		// Read response. This signal indicates the status of the read transfer.
input								DDR_RVALID_0,		// Read valid. This signal indicates that the channel is signaling the required read data.
// DDR AXI 0 Write Data Channel Signals 
output	[	pDdrAxiDatWidth0-1:0]	DDR_WDATA_0,		// Write data. AXI4 port 0 is 256, port 1 is 128.
output								DDR_WLAST_0,		// Write last. This signal indicates the last transfer in a write burst.
input								DDR_WREADY_0,		// Write ready. This signal indicates that the slave can accept the write data.
output	[ pDdrAxiDatWidth0/8-1:0]	DDR_WSTRB_0,		// Write strobes. This signal indicates which byte lanes hold valid data. There is one write strobe bit for each eight bits of the write data bus.
output								DDR_WVALID_0,		// Write valid. This signal indicates that valid write data and strobes are available.
// DDR AXI 1 Read Address Channel
output  							DDR_ARST_1,
output	[					32:0] 	DDR_ARADDR_1,		// Read address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	DDR_ARBURST_1,		// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	DDR_ARID_1,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	DDR_ARLEN_1,		// Burst length. This signal indicates the number of transfers in a burst.
input								DDR_ARREADY_1,		// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					2:0]	DDR_ARSIZE_1,		// Burst size. This signal indicates the size of each transfer in the burst.
output								DDR_ARVALID_1,		// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								DDR_ARLOCK_1,		// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								DDR_ARAPCMD_1,		// Read auto-precharge.
output								DDR_ARQOS_1,		// QoS indentifier for read transaction.
// DDR AXI 1 Wrtie Address Channel
output	[					32:0] 	DDR_AWADDR_1,		// Write address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	DDR_AWBURST_1,		// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	DDR_AWID_1,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	DDR_AWLEN_1,		// Burst length. This signal indicates the number of transfers in a burst.
input								DDR_AWREADY_1,		// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					 2:0] 	DDR_AWSIZE_1,		// Burst size. This signal indicates the size of each transfer in the burst.
output								DDR_AWVALID_1,		// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								DDR_AWLOCK_1,		// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								DDR_AWAPCMD_1,		// Write auto-precharge.
output								DDR_AWQOS_1,		// QoS indentifier for write transaction.
output	[					 3:0] 	DDR_AWCACHE_1,		// Memory type. This signal indicates how transactions are required to progress through a system.
output								DDR_AWALLSTRB_1,	// Write all strobes asserted.
output								DDR_AWCOBUF_1,		// Write coherent bufferable selection.
// DDR AXI 1 Wrtie Response Channel
input	[					 5:0]	DDR_BID_1,			// Response ID tag. This signal is the ID tag of the write response.
output								DDR_BREADY_1,		// Response ready. This signal indicates that the master can accept a write response.
input	[					 1:0]	DDR_BRESP_1,		// Read response. This signal indicates the status of the read transfer.
input								DDR_BVALID_1,		// Write response valid. This signal indicates that the channel is signaling a valid write response.
//DDR AXI 1 Read Data Channel
input	[	pDdrAxiDatWidth1-1:0]	DDR_RDATA_1,		// Read data.
input	[					 5:0] 	DDR_RID_1,			// Read ID tag. This signal is the identification tag for the read data group of signals generated by the slave.
input								DDR_RLAST_1,		// Read last. This signal indicates the last transfer in a read burst.
output								DDR_RREADY_1,		// Read ready. This signal indicates that the master can accept the read data and response information.
input	[					 1:0] 	DDR_RRESP_1,		// Read response. This signal indicates the status of the read transfer.
input								DDR_RVALID_1,		// Read valid. This signal indicates that the channel is signaling the required read data.
//DDR AXI 1 Write Data Channel Signals 
output	[	pDdrAxiDatWidth1-1:0]	DDR_WDATA_1,		// Write data. AXI4 port 0 is 256, port 1 is 128.
output								DDR_WLAST_1,		// Write last. This signal indicates the last transfer in a write burst.
input								DDR_WREADY_1,		// Write ready. This signal indicates that the slave can accept the write data.
output	[ pDdrAxiDatWidth1/8-1:0] 	DDR_WSTRB_1,		// Write strobes. This signal indicates which byte lanes hold valid data. There is one write strobe bit for each eight bits of the write data bus.
output								DDR_WVALID_1,		// Write valid. This signal indicates that valid write data and strobes are available.
//
// YCbCr video output for ADV7511(HDMI)
output 			oAdv7511Vs,			// VSYNC Gpio
output 			oAdv7511Hs,			// HSYNC Gpio
output 			oAdv7511De,			// Data Enable Gpio
output	[15:0]	oAdv7511Data,		// YUV Output Gpio
input			iAdv7511Sda,		// I2C SDA Gpio
output			oAdv7511SdaOe,		// SDA TriState Sel Port
input			iAdv7511Scl,		// I2C SCL Gpio
output			oAdv7511SclOe,		// SCL TriState Sel Port
//
// User Interface LED, SW
output	[ 5:0] 	oLed,				// Led Gpio
input  	[ 1:0]	iPushSw,			// Pusw Sw Gpio
//
// PLL1 Control
input			iSCLK,				// 100 [MHz] Port
input			iBCLK,				// 25 [MHz] Port
input			iPCLK,				// 25 [MHz] Port
input			iFCLK,				// 200 [MHz] Port
input			pll_inst1_LOCKED,	// PLL1 Locked Port
output			pll_inst1_RSTN,		// PLL1 Rst Active Low Port
//
// PLL2 Control
input			iVCLK,				// 74.25 [MHz] Port
input			pll_inst2_LOCKED,	// PLL2 Locked Port
output			pll_inst2_RSTN,		// PLL2 Rst Active Low Port
//
// PLL3 Control
input 			pll_ddr_LOCKED,		// PLL Ddr Locked Port
output 			pll_ddr_RSTN,		// PLL Ddr Rst Active Low Port
//
// TestPort
output	[25:0]	oTestPort,			// Signals Test Gpio
//
// Jtag I/F
input  			jtag_inst1_TDI,
input  			jtag_inst1_TCK,
input  			jtag_inst1_TMS,
output 			jtag_inst1_TDO,
input  			jtag_inst1_SEL,
input  			jtag_inst1_DRCK,
input  			jtag_inst1_RUNTEST,
input  			jtag_inst1_CAPTURE,
input  			jtag_inst1_SHIFT,
input  			jtag_inst1_UPDATE,
input  			jtag_inst1_RESET
);


//-----------------------------------------------------------------------------
// RST 生成
//-----------------------------------------------------------------------------
assign 	pll_inst1_RSTN = 1'b1;
assign 	pll_inst2_RSTN = 1'b1;
//
reg 	qLocked;
reg 	rSRST,		rnSRST, 	qSRST,		qnSRST;
reg 	rPRST,		rnPRST, 	qPRST,		qnPRST;
reg 	rFRST,		rnFRST, 	qFRST,		qnFRST;
reg 	rBRST,		rnBRST,		qBRST,		qnBRST;
reg 	rVRST, 		rnVRST,		qVRST,		qnVRST;

always @(posedge iSCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rSRST  <= 1'b1;
	else if (qLocked)			rSRST  <= 1'b0;
	else 						rSRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnSRST <= 1'b0;
	else if (qLocked)			rnSRST <= 1'b1;
	else 						rnSRST <= 1'b0;
end
//
always @(posedge iPCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rPRST  <= 1'b1;
	else if (qLocked)			rPRST  <= 1'b0;
	else 						rPRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnPRST <= 1'b0;
	else if (qLocked)			rnPRST <= 1'b1;
	else 						rnPRST <= 1'b0;
end
//
always @(posedge iFCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rFRST  <= 1'b1;
	else if (qLocked)			rFRST  <= 1'b0;
	else 						rFRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnFRST <= 1'b0;
	else if (qLocked)			rnFRST <= 1'b1;
	else 						rnFRST <= 1'b0;
end
//
always @(posedge iBCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rBRST  <= 1'b1;
	else if (qLocked)			rBRST  <= 1'b0;
	else 						rBRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnBRST <= 1'b0;
	else if (qLocked)			rnBRST <= 1'b1;
	else 						rnBRST <= 1'b0;
end
//
always @(posedge iVCLK, negedge iPushSw[0])
begin
	if (!iPushSw[0])			rVRST  <= 1'b1;
	else if (qLocked)			rVRST  <= 1'b0;
	else 						rVRST  <= 1'b1;
	//
	if (!iPushSw[0])			rnVRST <= 1'b0;
	else if (qLocked)			rnVRST <= 1'b1;
	else 						rnVRST <= 1'b0;
end

always @*
begin
	qLocked 	<= &{pll_inst1_LOCKED,pll_inst2_LOCKED};
	qSRST 		<= rSRST;
	qnSRST 		<= rnSRST;
	qPRST 		<= rPRST;
	qnPRST 		<= rnPRST;
	qFRST 		<= rFRST;
	qnFRST 		<= rnFRST;
	qBRST 	 	<= rBRST;
	qnBRST 	 	<= rnBRST;
	qVRST  		<= rVRST;
	qnVRST 		<= rnVRST;
end


//-----------------------------------------------------------------------------
// MIPI DPHY RX
//-----------------------------------------------------------------------------
wire	[ 5:0]	wHsDatatype;
wire 	[15:0]	wHsWordCnt;
wire 	[ 7:0]	wHsEcc;
//
wire 	[31:0]	wVideoPixel;
wire 			wVideoVd;
wire 			wVideofull;
//
wire 			wCdcFifoFull;

MCsiRxController MCsiRxController (
	// Hard D-PHY Port
	// Controls and Status Signals
	.oMipiDphyRx1_RESET_N					(MipiDphyRx1_RESET_N),
	.oMipiDphyRx1_RST0_N					(MipiDphyRx1_RST0_N),
	.iMipiDphyRx1_STOPSTATE_CLK				(MipiDphyRx1_STOPSTATE_CLK),
	.iMipiDphyRx1_STOPSTATE_LAN0			(MipiDphyRx1_STOPSTATE_LAN0),
	.iMipiDphyRx1_STOPSTATE_LAN1			(MipiDphyRx1_STOPSTATE_LAN1),
	.iMipiDphyRx1_ERR_ESC_LAN0				(MipiDphyRx1_ERR_ESC_LAN0),
	.iMipiDphyRx1_ERR_ESC_LAN1				(MipiDphyRx1_ERR_ESC_LAN1),
	.iMipiDphyRx1_ERR_CONTROL_LAN0			(MipiDphyRx1_ERR_CONTROL_LAN0),
	.iMipiDphyRx1_ERR_CONTROL_LAN1			(MipiDphyRx1_ERR_CONTROL_LAN1),
	.oMipiDphyRx1_TX_REQUEST_ESC			(MipiDphyRx1_TX_REQUEST_ESC),
	.oMipiDphyRx1_TURN_REQUEST				(MipiDphyRx1_TURN_REQUEST),
	.oMipiDphyRx1_FORCE_RX_MODE				(MipiDphyRx1_FORCE_RX_MODE),
	.oMipiDphyRx1_TX_TRIGGER_ESC			(MipiDphyRx1_TX_TRIGGER_ESC),
	.iMipiDphyRx1_RX_TRIGGER_ESC			(MipiDphyRx1_RX_TRIGGER_ESC),
	.iMipiDphyRx1_DIRECTION					(MipiDphyRx1_DIRECTION),
	.iMipiDphyRx1_ERR_CONTENTION_LP0		(MipiDphyRx1_ERR_CONTENTION_LP0),
	.iMipiDphyRx1_ERR_CONTENTION_LP1		(MipiDphyRx1_ERR_CONTENTION_LP1),
	// HS Mode Signals
	.iMipiDphyRx1_RX_CLK_ACTIVE_HS			(MipiDphyRx1_RX_CLK_ACTIVE_HS),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN0			(MipiDphyRx1_RX_ACTIVE_HS_LAN0),
	.iMipiDphyRx1_RX_ACTIVE_HS_LAN1			(MipiDphyRx1_RX_ACTIVE_HS_LAN1),
	.iMipiDphyRx1_RX_VALID_HS_LAN0			(MipiDphyRx1_RX_VALID_HS_LAN0),
	.iMipiDphyRx1_RX_VALID_HS_LAN1			(MipiDphyRx1_RX_VALID_HS_LAN1),
	.iMipiDphyRx1_RX_SYNC_HS_LAN0			(MipiDphyRx1_RX_SYNC_HS_LAN0),
	.iMipiDphyRx1_RX_SYNC_HS_LAN1			(MipiDphyRx1_RX_SYNC_HS_LAN1),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN0		(MipiDphyRx1_RX_SKEW_CAL_HS_LAN0),
	.iMipiDphyRx1_RX_SKEW_CAL_HS_LAN1		(MipiDphyRx1_RX_SKEW_CAL_HS_LAN1),
	.iMipiDphyRx1_RX_DATA_HS_LAN0			(MipiDphyRx1_RX_DATA_HS_LAN0),
	.iMipiDphyRx1_RX_DATA_HS_LAN1			(MipiDphyRx1_RX_DATA_HS_LAN1),
	.iMipiDphyRx1_ERR_SOT_HS_LAN0			(MipiDphyRx1_ERR_SOT_HS_LAN0),
	.iMipiDphyRx1_ERR_SOT_HS_LAN1			(MipiDphyRx1_ERR_SOT_HS_LAN1),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN0		(MipiDphyRx1_ERR_SOT_SYNC_HS_LAN0),
	.iMipiDphyRx1_ERR_SOT_SYNC_HS_LAN1		(MipiDphyRx1_ERR_SOT_SYNC_HS_LAN1),
	// LP Mode Signals
	.iMipiDphyRx1_RX_LPDT_ESC				(MipiDphyRx1_RX_LPDT_ESC),
	.iMipiDphyRx1_RX_DATA_ESC				(MipiDphyRx1_RX_DATA_ESC),
	.iMipiDphyRx1_RX_VALID_ESC				(MipiDphyRx1_RX_VALID_ESC),
	.iMipiDphyRx1_RX_ERR_SYNC_ESC			(MipiDphyRx1_RX_ERR_SYNC_ESC),
	.oMipiDphyRx1_TX_LPDT_ESC				(MipiDphyRx1_TX_LPDT_ESC),
	.oMipiDphyRx1_TX_DATA_ESC				(MipiDphyRx1_TX_DATA_ESC),
	.oMipiDphyRx1_TX_VALID_ESC				(MipiDphyRx1_TX_VALID_ESC),
	.oMipiDphyRx1_TX_READY_ESC				(MipiDphyRx1_TX_READY_ESC),
	// Ultra Low Power Sleep Mode Signals
	.oMipiDphyRx1_TX_ULPS_ESC				(MipiDphyRx1_TX_ULPS_ESC),
	.oMipiDphyRx1_TX_ULPS_EXIT				(MipiDphyRx1_TX_ULPS_EXIT),
	.iMipiDphyRx1_RX_ULPS_CLK_NOT			(MipiDphyRx1_RX_ULPS_CLK_NOT),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT	(MipiDphyRx1_RX_ULPS_ACTIVE_CLK_NOT),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN0			(MipiDphyRx1_RX_ULPS_ESC_LAN0),
	.iMipiDphyRx1_RX_ULPS_ESC_LAN1			(MipiDphyRx1_RX_ULPS_ESC_LAN1),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0	(MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN0),
	.iMipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1	(MipiDphyRx1_RX_ULPS_ACTIVE_NOT_LAN1),
	// Clock Domain
	//oMipiDphyRx1_TX_CFG_CLK(MipiDphyRx1_TX_CFG_CLK),
	.iMipiDphyRx1_WORD_CLKOUT_HS			(MipiDphyRx1_WORD_CLKOUT_HS),
	.iMipiDphyRx1_LP_CLK					(MipiDphyRx1_LP_CLK),
	.iMipiDphyRx1_RX_CLK_ESC_LAN0			(MipiDphyRx1_RX_CLK_ESC_LAN0),
	.iMipiDphyRx1_RX_CLK_ESC_LAN1			(MipiDphyRx1_RX_CLK_ESC_LAN1),
	.oMipiDphyRx1_TX_CLK_ESC				(MipiDphyRx1_TX_CLK_ESC),
	// CSI-2 controller ouptut I/F port
	.oHsDatatype(wHsDatatype),			.oHsWordCnt(wHsWordCnt),
	.oHsEcc(wHsEcc),
	// Video Signals
	.oVideoPixel(wVideoPixel),
	.oVideoVd(wVideoVd),				.iVideofull(wVideofull),
	// Status
	.oCdcFifoFull(wCdcFifoFull),
	// Common
	.iSRST(qSRST),						.inSRST(qnSRST),
	.iVRST(qVRST),						.inVRST(qnVRST),
	.iFRST(qFRST),						.inFRST(qnFRST),
	.iSCLK(iSCLK),						.iVCLK(iVCLK),
	.iFCLK(iFCLK)
);


//-----------------------------------------------------------------------------
// DDR Memory Controller
//-----------------------------------------------------------------------------
MDdrController #(
	.pDdrAxiDatWidth0	(pDdrAxiDatWidth0),
	.pDdrAxiDatWidth1	(pDdrAxiDatWidth1)
) MDdrController (
	// DDR CFG
	.oDDR_CFG_PHY_RSTN(DDR_CFG_PHY_RSTN),			.oDDR_CFG_RST(DDR_CFG_RST),
	.oDDR_CFG_START(DDR_CFG_START),					.iDDR_CFG_DONE(DDR_CFG_DONE),
	.oDDR_CFG_SEL(DDR_CFG_SEL),
	// DDR Control
	.oDDR_CTRL_RSTN(DDR_CTRL_RSTN),					.iDDR_CTRL_INT(DDR_CTRL_INT),
	.iDDR_CTRL_MEM_RST_VALID(DDR_CTRL_MEM_RST_VALID),.iDDR_CTRL_REFRESH(DDR_CTRL_REFRESH),
	.iDDR_CTRL_BUSY(DDR_CTRL_BUSY),					.iDDR_CTRL_CMD_Q_ALMOST_FULL(DDR_CTRL_CMD_Q_ALMOST_FULL),
	.iDDR_CTRL_DP_IDLE(DDR_CTRL_DP_IDLE),			.iDDR_CTRL_CKE(DDR_CTRL_CKE),
	.iDDR_CTRL_PORT_BUSY(DDR_CTRL_PORT_BUSY),
	// AXI Port 0
	.oDDR_ARST_0(DDR_ARST_0),						.oDDR_ARADDR_0(DDR_ARADDR_0),
	.oDDR_ARBURST_0(DDR_ARBURST_0),					.oDDR_ARID_0(DDR_ARID_0),
	.oDDR_ARLEN_0(DDR_ARLEN_0),						.iDDR_ARREADY_0(DDR_ARREADY_0),
	.oDDR_ARSIZE_0(DDR_ARSIZE_0),					.oDDR_ARVALID_0(DDR_ARVALID_0),
	.oDDR_ARLOCK_0(DDR_ARLOCK_0),					.oDDR_ARAPCMD_0(DDR_ARAPCMD_0),
	.oDDR_ARQOS_0(DDR_ARQOS_0),						.oDDR_AWADDR_0(DDR_AWADDR_0),
	.oDDR_AWBURST_0(DDR_AWBURST_0),					.oDDR_AWID_0(DDR_AWID_0),
	.oDDR_AWLEN_0(DDR_AWLEN_0),						.iDDR_AWREADY_0(DDR_AWREADY_0),
	.oDDR_AWSIZE_0(DDR_AWSIZE_0),					.oDDR_AWVALID_0(DDR_AWVALID_0),
	.oDDR_AWLOCK_0(DDR_AWLOCK_0),					.oDDR_AWAPCMD_0(DDR_AWAPCMD_0),
	.oDDR_AWQOS_0(DDR_AWQOS_0),						.oDDR_AWCACHE_0(DDR_AWCACHE_0),
	.oDDR_AWALLSTRB_0(DDR_AWALLSTRB_0),				.oDDR_AWCOBUF_0(DDR_AWCOBUF_0),
	.iDDR_BID_0(DDR_BID_0),							.oDDR_BREADY_0(DDR_BREADY_0),
	.iDDR_BRESP_0(DDR_BRESP_0),						.iDDR_BVALID_0(DDR_BVALID_0),
	.iDDR_RDATA_0(DDR_RDATA_0),						.iDDR_RID_0(DDR_RID_0),
	.iDDR_RLAST_0(DDR_RLAST_0),						.oDDR_RREADY_0(DDR_RREADY_0),
	.iDDR_RRESP_0(DDR_RRESP_0),						.iDDR_RVALID_0(DDR_RVALID_0),
	.oDDR_WDATA_0(DDR_WDATA_0),						.oDDR_WLAST_0(DDR_WLAST_0),
	.iDDR_WREADY_0(DDR_WREADY_0),					.oDDR_WSTRB_0(DDR_WSTRB_0),
	.oDDR_WVALID_0(DDR_WVALID_0),
	// AXI Port 1
	.oDDR_ARST_1(DDR_ARST_1),						.oDDR_ARADDR_1(DDR_ARADDR_1),
	.oDDR_ARBURST_1(DDR_ARBURST_1),					.oDDR_ARID_1(DDR_ARID_1),
	.oDDR_ARLEN_1(DDR_ARLEN_1),						.iDDR_ARREADY_1(DDR_ARREADY_1),
	.oDDR_ARSIZE_1(DDR_ARSIZE_1),					.oDDR_ARVALID_1(DDR_ARVALID_1),
	.oDDR_ARLOCK_1(DDR_ARLOCK_1),					.oDDR_ARAPCMD_1(DDR_ARAPCMD_1),
	.oDDR_ARQOS_1(DDR_ARQOS_1),						.oDDR_AWADDR_1(DDR_AWADDR_1),
	.oDDR_AWBURST_1(DDR_AWBURST_1),					.oDDR_AWID_1(DDR_AWID_1),
	.oDDR_AWLEN_1(DDR_AWLEN_1),						.iDDR_AWREADY_1(DDR_AWREADY_1),
	.oDDR_AWSIZE_1(DDR_AWSIZE_1),					.oDDR_AWVALID_1(DDR_AWVALID_1),
	.oDDR_AWLOCK_1(DDR_AWLOCK_1),					.oDDR_AWAPCMD_1(DDR_AWAPCMD_1),
	.oDDR_AWQOS_1(DDR_AWQOS_1),						.oDDR_AWCACHE_1(DDR_AWCACHE_1),
	.oDDR_AWALLSTRB_1(DDR_AWALLSTRB_1),				.oDDR_AWCOBUF_1(DDR_AWCOBUF_1),
	.iDDR_BID_1(DDR_BID_1),							.oDDR_BREADY_1(DDR_BREADY_1),
	.iDDR_BRESP_1(DDR_BRESP_1),						.iDDR_BVALID_1(DDR_BVALID_1),
	.iDDR_RDATA_1(DDR_RDATA_1),						.iDDR_RID_1(DDR_RID_1),
	.iDDR_RLAST_1(DDR_RLAST_1),						.oDDR_RREADY_1(DDR_RREADY_1),
	.iDDR_RRESP_1(DDR_RRESP_1),						.iDDR_RVALID_1(DDR_RVALID_1),
	.oDDR_WDATA_1(DDR_WDATA_1),						.oDDR_WLAST_1(DDR_WLAST_1),
	.iDDR_WREADY_1(DDR_WREADY_1),					.oDDR_WSTRB_1(DDR_WSTRB_1),
	.oDDR_WVALID_1(DDR_WVALID_1),
	// common
	.iSRST(qSRST),		.inSRST(qnSRST),
	.iFRST(qFRST),		.inFRST(qnFRST),
	.iSCLK(iSCLK),		.iFCLK(iFCLK)
);



//-----------------------------------------------------------------------------
// HDMI Output part
//-----------------------------------------------------------------------------
localparam 			lpVideoMaxHRES	= 11'd1920;
localparam 			lpVideoMaxVRES	= 11'd1080;
localparam 			lpVideoHSP		= 8'd44;
localparam 			lpVideoHBP		= 8'd148;
localparam 			lpVideoHFP		= 8'd88;
localparam 			lpVideoVSP		= 6'd5;
localparam 			lpVideoVBP		= 6'd36;
localparam 			lpVideoVFP		= 6'd4;

wire 		wAdv7511Vs;			assign oAdv7511Vs 	= wAdv7511Vs;
wire 		wAdv7511Hs;			assign oAdv7511Hs 	= wAdv7511Hs;
wire 		wAdv7511De;			assign oAdv7511De 	= wAdv7511De;
wire [15:0]	wAdv7511Data;		assign oAdv7511Data = wAdv7511Data;

MVideoPostProcess #(
	.pVideoMaxHRES(lpVideoMaxHRES),	.pVideoHBP(lpVideoHBP),
	.pVideoHFP(lpVideoHFP),			.pVideoHSP(lpVideoHSP),
	.pVideoMaxVRES(lpVideoMaxVRES),	.pVideoVBP(lpVideoVBP),
	.pVideoVFP(lpVideoVFP),			.pVideoVSP(lpVideoVSP)
) MVideoPostProcess (
	// ADV7511 GPIO
	.oAdv7511Vs(wAdv7511Vs),		.oAdv7511Hs(wAdv7511Hs),
	.oAdv7511De(wAdv7511De),		.oAdv7511Data(wAdv7511Data),
	.iAdv7511Sda(iAdv7511Sda),		.oAdv7511SdaOe(oAdv7511SdaOe),
	.iAdv7511Scl(iAdv7511Scl),		.oAdv7511SclOe(oAdv7511SclOe),
	// Video Signal
	.iVideoPixel(wVideoPixel),
	.iVideoVd(wVideoVd),			.oVideofull(wVideofull),
	// Status
	.iVideoSignalSel(1'b0),
	.i_pll_locked(pll_inst1_LOCKED),
	// common
	.iSRST(qSRST),					.inSRST(qnSRST),
	.iPRST(qPRST),					.inPRST(qnPRST),
	.iVRST(qVRST),					.inVRST(qnVRST),
	.iBRST(qBRST),					.inBRST(qnBRST),
	.iFRST(qFRST),					.inFRST(qnFRST),
	.iSCLK(iSCLK),					.iPCLK(iPCLK),
	.iVCLK(iVCLK),					.iBCLK(iBCLK),
	.iFCLK(iFCLK)
);


//-----------------------------------------------------------------------------
// Debug 信号生成、下記用途用
// Top に入力される PLL が正常に動作しているか確認
// Top に入力される PLL が設定通りの周波数で CLK を生成しているか確認
// Mipi IP の CLK, Sync 信号が動作しているか確認
// TestPort に適当な信号を出力して 拡張ボードと GPIO の割り当てを確認
//-----------------------------------------------------------------------------
localparam lpPulseGenNumber	= 5;						// pulse 生成個数
localparam [32*lpPulseGenNumber-1:0] lpClkDivCnt = {	// 分周値
	32'd3,
	32'd3,
	32'd5000,
	32'd3,
	32'd5000
};

wire [lpPulseGenNumber-1:0] wSampling = {
	wVideofull,
	wCdcFifoFull,
	1'b0,
	1'b0,
	wVideoVd
};
wire [lpPulseGenNumber-1:0] wPulse;
//
genvar n;

generate
begin
	for (n = 0; n < lpPulseGenNumber; n = n + 1)
	begin
		MPulseGenerator #(
			.pCntMax(lpClkDivCnt[32*(n+1)-1:32*n]), .pStartPulse(1'b0)
		) mPulseGenerator (
			.oPulse(wPulse[n]),	.iSampling(wSampling[n]),
			.iRST(qFRST),		.iCLK(iFCLK)
		);
	end
end
endgenerate


//-----------------------------------------------------------------------------
// TestPort / Led Coonect
//-----------------------------------------------------------------------------
assign oLed[0] = wPulse[0];
assign oLed[1] = wPulse[1];
assign oLed[2] = wPulse[2];
assign oLed[3] = wPulse[3];
assign oLed[4] = wPulse[4];
assign oLed[5] = qLocked;
// FMC to QSE Adapter Card to J3 MIPI and LVDS Expansion Daughter Card
// ※ 一部 回路図・データシートと異なる IO の位置
assign oTestPort[0]  = MipiDphyRx1_RX_SYNC_HS_LAN0;		// Pin2
assign oTestPort[1]  = MipiDphyRx1_RX_CLK_ESC_LAN0;		// Pin4
assign oTestPort[2]  = MipiDphyRx1_STOPSTATE_LAN1;		// Pin7
assign oTestPort[3]  = MipiDphyRx1_RX_SKEW_CAL_HS_LAN1;	// Pin8
assign oTestPort[4]  = MipiDphyRx1_RX_DATA_HS_LAN0[0];	// Pin9
assign oTestPort[5]  = 1'b0;	// Pin10
assign oTestPort[6]  = 1'b0;	// Pin13
assign oTestPort[7]  = MipiDphyRx1_RX_CLK_ACTIVE_HS;	// Pin14
assign oTestPort[8]  = 1'b0;	// Pin15
assign oTestPort[9]  = 1'b0;	// Pin16
assign oTestPort[10] = MipiDphyRx1_RX_ACTIVE_HS_LAN0;	// Pin19
assign oTestPort[11] = 1'b0;	// Pin20
assign oTestPort[12] = 1'b0;	// Pin21
assign oTestPort[13] = 1'b0;	// Pin22
assign oTestPort[14] = 1'b0;	// Pin25
assign oTestPort[15] = 1'b0;	// Pin26
assign oTestPort[16] = 1'b0;	// Pin27
assign oTestPort[17] = MipiDphyRx1_WORD_CLKOUT_HS;	// Pin28
assign oTestPort[18] = 1'b0;	// Pin31
assign oTestPort[19] = 1'b0;	// Pin32
assign oTestPort[20] = 1'b0;	// Pin33
assign oTestPort[21] = 1'b0;	// Pin34
assign oTestPort[22] = 1'b0;	// Pin37 -> Pin39
assign oTestPort[23] = 1'b0;	// Pin38
assign oTestPort[24] = MipiDphyRx1_RX_VALID_HS_LAN0;	// Pin39 -> Pin37
assign oTestPort[25] = MipiDphyRx1_RX_VALID_HS_LAN1;	// Pin40
// Pin5,6,11,12,17,18,23,24,29,30,35,36 = GND


//-----------------------------------------------------------------------------
// VIO
// 手動ロジアナ、VIO を使用する場合は、
// プロジェクトのカレントディレクトリに debug_TEMPLATE.v が生成されるのでコピーして使用する。
// Project Editor -> タブの Debugger 選択 -> Debugger Auto Instantiation のチェックマークを OFF にする。
// Open Debug Wizard の USER2 などで 自動ロジアナ生成をすると自動でチェックマークが ON になるので注意。
// 
// 自動生成のロジアナを使用する場合は、手動生成 module をコメントアウトする
// 
// デフォルトの GTKWave は遅いため、下記リンクを参考にアップデートすること
// https://rightxlight.co.jp/technical/efinix-efinty-iverilog-simulation/
//-----------------------------------------------------------------------------
// edb_top edb_top_inst (
//     .bscan_CAPTURE      ( jtag_inst1_CAPTURE ),
//     .bscan_DRCK         ( jtag_inst1_DRCK ),
//     .bscan_RESET        ( jtag_inst1_RESET ),
//     .bscan_RUNTEST      ( jtag_inst1_RUNTEST ),
//     .bscan_SEL          ( jtag_inst1_SEL ),
//     .bscan_SHIFT        ( jtag_inst1_SHIFT ),
//     .bscan_TCK          ( jtag_inst1_TCK ),
//     .bscan_TDI          ( jtag_inst1_TDI ),
//     .bscan_TMS          ( jtag_inst1_TMS ),
//     .bscan_UPDATE       ( jtag_inst1_UPDATE ),
//     .bscan_TDO          ( jtag_inst1_TDO ),
//     .vio0_clk       	( iSCLK ),
// 	.vio0_Datatype		( wHsDatatype ),
// 	.vio0_WordCnt		( wHsWordCnt ),
// 	.vio0_HsEcc			( wHsEcc )
// );




endmodule
//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------