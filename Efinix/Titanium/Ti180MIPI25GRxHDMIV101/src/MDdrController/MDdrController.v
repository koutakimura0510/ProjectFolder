/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MDdrController.v
 * Description : Ti180M484 dev Kit MIPI RX to HDMI Output Simple Demo.
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinix Efinity 2022.1.226.2.11
 * Explanation : 
 *
 * Copyright(c) 2011-2022, by Net-Vision Corp. All rights reserved.
 * (Note) For this source code, it is forbidden using and issuing
 *        without permission.
 * （注） このソース・コードの無断使用および無断持ち出しを禁止します．
 *
 * Revision    :
 * 09/Jan-2023 V1.00 New Release, Inh.fr. "MDdrController.v" K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//-----------------------------------------------------------------------------
module MDdrController #(
	parameter pDdrAxiDatWidth0	= 512,
	parameter pDdrAxiDatWidth1	= 512
)(
// DDR Hard-IP
// Startup Sequencer Signals (Configration Controller Signals)
output  							oDDR_CFG_PHY_RSTN,		// Active low reset to DDR PHY.
output  							oDDR_CFG_RST,			// Active-high DDR configuration controller reset.
output  							oDDR_CFG_START,			// Start the DDR configuration controller.
input   							iDDR_CFG_DONE,			// Indicates the controller configuration is done
output  							oDDR_CFG_SEL,			// To select whether to use internal DDR configuration controller or user register ports for configuration:
															// 0: Use internal configuration controller.
															// 1: Use register configuration ports (cfg_rst, cfg_start, cfg_done will be disabled).
// Controller Signals
output 								oDDR_CTRL_RSTN,			// Controller Reset Signal 
input 								iDDR_CTRL_INT,			// Interrupt sign form controller 
input   							iDDR_CTRL_MEM_RST_VALID,// The user should wait until the mem_rst_valid signal is asserted and the DFI command signals have transitioned to the PHY pad outputs to release control of these signals
input 								iDDR_CTRL_REFRESH,		// Controller Refresh Pin Signal 
input 								iDDR_CTRL_BUSY,			// This will only be low when the controller is not reading data, writing data or processing a command
input 								iDDR_CTRL_CMD_Q_ALMOST_FULL,// Command Queue Full Pin 
input 								iDDR_CTRL_DP_IDLE,		// Data Path Idle
input 	[					 1:0] 	iDDR_CTRL_CKE,			// Delayed CKE form Controller
input 	[					 1:0] 	iDDR_CTRL_PORT_BUSY,	// Port Busy Reading Data
// DDR AXI 0 Read Address Channel
output 								oDDR_ARST_0,
output	[					32:0] 	oDDR_ARADDR_0,			// Read address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	oDDR_ARBURST_0,			// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	oDDR_ARID_0,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	oDDR_ARLEN_0,			// Burst length. This signal indicates the number of transfers in a burst.
input								iDDR_ARREADY_0,			// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					 2:0]	oDDR_ARSIZE_0,			// Burst size. This signal indicates the size of each transfer in the burst.
output								oDDR_ARVALID_0,			// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								oDDR_ARLOCK_0,			// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								oDDR_ARAPCMD_0,			// Read auto-precharge.
output								oDDR_ARQOS_0,			// QoS indentifier for read transaction.
// DDR AXI 0 Wrtie Address Channel
output	[					32:0] 	oDDR_AWADDR_0,			// Write address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	oDDR_AWBURST_0,			// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	oDDR_AWID_0,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	oDDR_AWLEN_0,			// Burst length. This signal indicates the number of transfers in a burst.
input								iDDR_AWREADY_0,			// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					 2:0] 	oDDR_AWSIZE_0,			// Burst size. This signal indicates the size of each transfer in the burst.
output								oDDR_AWVALID_0,			// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								oDDR_AWLOCK_0,			// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								oDDR_AWAPCMD_0,			// Write auto-precharge.
output								oDDR_AWQOS_0,			// QoS indentifier for write transaction.
output	[					 3:0] 	oDDR_AWCACHE_0,			// Memory type. This signal indicates how transactions are required to progress through a system.
output								oDDR_AWALLSTRB_0,		// Write all strobes asserted.
output								oDDR_AWCOBUF_0,			// Write coherent bufferable selection.
// DDR AXI 0 Wrtie Response Channel
input	[					 5:0]	iDDR_BID_0,				// Response ID tag. This signal is the ID tag of the write response.
output								oDDR_BREADY_0,			// Response ready. This signal indicates that the master can accept a write response.
input	[					 1:0]	iDDR_BRESP_0,			// Read response. This signal indicates the status of the read transfer.
input								iDDR_BVALID_0,			// Write response valid. This signal indicates that the channel is signaling a valid write response.
// DDR AXI 0 Read Data Channel
input	[	pDdrAxiDatWidth0-1:0]	iDDR_RDATA_0,			// Read data.
input	[					 5:0] 	iDDR_RID_0,				// Read ID tag. This signal is the identification tag for the read data group of signals generated by the slave.
input								iDDR_RLAST_0,			// Read last. This signal indicates the last transfer in a read burst.
output								oDDR_RREADY_0,			// Read ready. This signal indicates that the master can accept the read data and response information.
input	[					 1:0] 	iDDR_RRESP_0,			// Read response. This signal indicates the status of the read transfer.
input								iDDR_RVALID_0,			// Read valid. This signal indicates that the channel is signaling the required read data.
// DDR AXI 0 Write Data Channel Signals 
output	[	pDdrAxiDatWidth0-1:0]	oDDR_WDATA_0,			// Write data. AXI4 port 0 is 256, port 1 is 128.
output								oDDR_WLAST_0,			// Write last. This signal indicates the last transfer in a write burst.
input								iDDR_WREADY_0,			// Write ready. This signal indicates that the slave can accept the write data.
output	[ pDdrAxiDatWidth0/8-1:0]	oDDR_WSTRB_0,			// Write strobes. This signal indicates which byte lanes hold valid data. There is one write strobe bit for each eight bits of the write data bus.
output								oDDR_WVALID_0,			// Write valid. This signal indicates that valid write data and strobes are available.
// DDR AXI 1 Read Address Channel
output  							oDDR_ARST_1,
output	[					32:0] 	oDDR_ARADDR_1,			// Read address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	oDDR_ARBURST_1,			// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	oDDR_ARID_1,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	oDDR_ARLEN_1,			// Burst length. This signal indicates the number of transfers in a burst.
input								iDDR_ARREADY_1,			// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					 2:0]	oDDR_ARSIZE_1,			// Burst size. This signal indicates the size of each transfer in the burst.
output								oDDR_ARVALID_1,			// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								oDDR_ARLOCK_1,			// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								oDDR_ARAPCMD_1,			// Read auto-precharge.
output								oDDR_ARQOS_1,			// QoS indentifier for read transaction.
// DDR AXI 1 Wrtie Address Channel
output	[					32:0] 	oDDR_AWADDR_1,			// Write address. It gives the address of the first transfer in a burst transaction.
output	[					 1:0] 	oDDR_AWBURST_1,			// Burst type. The burst type and the size determine how the address for each transfer within the burst is calculated.
output	[					 5:0] 	oDDR_AWID_1,			// Address ID. This signal identifies the group of address signals.
output	[					 7:0] 	oDDR_AWLEN_1,			// Burst length. This signal indicates the number of transfers in a burst.
input								iDDR_AWREADY_1,			// Address ready. This signal indicates that the slave is ready to accept an address and associated control signals.
output	[					 2:0] 	oDDR_AWSIZE_1,			// Burst size. This signal indicates the size of each transfer in the burst.
output								oDDR_AWVALID_1,			// Address valid. This signal indicates that the channel is signaling valid address and control information.
output								oDDR_AWLOCK_1,			// Lock type. This signal provides additional information about the atomic characteristics of the transfer.
output								oDDR_AWAPCMD_1,			// Write auto-precharge.
output								oDDR_AWQOS_1,			// QoS indentifier for write transaction.
output	[					 3:0] 	oDDR_AWCACHE_1,			// Memory type. This signal indicates how transactions are required to progress through a system.
output								oDDR_AWALLSTRB_1,		// Write all strobes asserted.
output								oDDR_AWCOBUF_1,			// Write coherent bufferable selection.
// DDR AXI 1 Wrtie Response Channel
input	[					 5:0]	iDDR_BID_1,				// Response ID tag. This signal is the ID tag of the write response.
output								oDDR_BREADY_1,			// Response ready. This signal indicates that the master can accept a write response.
input	[					 1:0]	iDDR_BRESP_1,			// Read response. This signal indicates the status of the read transfer.
input								iDDR_BVALID_1,			// Write response valid. This signal indicates that the channel is signaling a valid write response.
//DDR AXI 1 Read Data Channel
input	[	pDdrAxiDatWidth1-1:0]	iDDR_RDATA_1,			// Read data.
input	[					 5:0] 	iDDR_RID_1,				// Read ID tag. This signal is the identification tag for the read data group of signals generated by the slave.
input								iDDR_RLAST_1,			// Read last. This signal indicates the last transfer in a read burst.
output								oDDR_RREADY_1,			// Read ready. This signal indicates that the master can accept the read data and response information.
input	[					 1:0] 	iDDR_RRESP_1,			// Read response. This signal indicates the status of the read transfer.
input								iDDR_RVALID_1,			// Read valid. This signal indicates that the channel is signaling the required read data.
//DDR AXI 1 Write Data Channel Signals 
output	[	pDdrAxiDatWidth1-1:0]	oDDR_WDATA_1,			// Write data. AXI4 port 0 is 256, port 1 is 128.
output								oDDR_WLAST_1,			// Write last. This signal indicates the last transfer in a write burst.
input								iDDR_WREADY_1,			// Write ready. This signal indicates that the slave can accept the write data.
output	[ pDdrAxiDatWidth1/8-1:0] 	oDDR_WSTRB_1,			// Write strobes. This signal indicates which byte lanes hold valid data. There is one write strobe bit for each eight bits of the write data bus.
output								oDDR_WVALID_1,			// Write valid. This signal indicates that valid write data and strobes are available.
// common
input 								iSRST,
input 								inSRST,
input 								iFRST,
input 								inFRST,
input 								iSCLK,
input 								iFCLK
);

assign oDDR_CTRL_RSTN 		= 1'b1;
assign oDDR_ARST_0			= 1'b0;
assign oDDR_ARADDR_0[32:0]	= 33'd0;
assign oDDR_ARBURST_0[1:0]	= 2'd0;
assign oDDR_ARID_0[5:0]		= 6'd0;
assign oDDR_ARLEN_0[7:0]	= 8'd0;
assign oDDR_ARSIZE_0[2:0]	= 3'd0;
assign oDDR_ARVALID_0		= 1'd0;
assign oDDR_ARLOCK_0		= 1'd0;
assign oDDR_ARAPCMD_0		= 1'd0;
assign oDDR_ARQOS_0			= 1'd0;
assign oDDR_AWADDR_0[32:0]	= 33'd0;
assign oDDR_AWBURST_0[1:0]	= 2'd0;
assign oDDR_AWID_0[5:0]		= 6'd0;
assign oDDR_AWLEN_0[7:0]	= 8'd0;
assign oDDR_AWSIZE_0[2:0]	= 3'd0;
assign oDDR_AWVALID_0		= 1'b0;
assign oDDR_AWLOCK_0		= 1'b0;
assign oDDR_AWAPCMD_0		= 1'b0;
assign oDDR_AWQOS_0			= 1'b0;
assign oDDR_AWCACHE_0[3:0]	= 4'd0;
assign oDDR_AWALLSTRB_0		= 1'b0;
assign oDDR_AWCOBUF_0		= 1'b0;
assign oDDR_BREADY_0		= 1'b0;
assign oDDR_RREADY_0		= 1'b0;
assign oDDR_WDATA_0[pDdrAxiDatWidth0-1:0] = {pDdrAxiDatWidth0{1'b0}};
assign oDDR_WLAST_0			= 1'b0;
assign oDDR_WSTRB_0[pDdrAxiDatWidth0/8-1:0]	= {(pDdrAxiDatWidth0/8){1'b0}};
assign oDDR_WVALID_0		= 1'b0;
//
assign oDDR_ARST_1			= 1'b0;
assign oDDR_ARADDR_1[32:0]	= 33'd0;
assign oDDR_ARBURST_1[1:0]	= 2'd0;
assign oDDR_ARID_1[5:0]		= 6'd0;
assign oDDR_ARLEN_1[7:0]	= 8'd0;
assign oDDR_ARSIZE_1[2:0]	= 3'd0;
assign oDDR_ARVALID_1		= 1'd0;
assign oDDR_ARLOCK_1		= 1'd0;
assign oDDR_ARAPCMD_1		= 1'd0;
assign oDDR_ARQOS_1			= 1'd0;
assign oDDR_AWADDR_1[32:0]	= 33'd0;
assign oDDR_AWBURST_1[1:0]	= 2'd0;
assign oDDR_AWID_1[5:0]		= 6'd0;
assign oDDR_AWLEN_1[7:0]	= 8'd0;
assign oDDR_AWSIZE_1[2:0]	= 3'd0;
assign oDDR_AWVALID_1		= 1'b0;
assign oDDR_AWLOCK_1		= 1'b0;
assign oDDR_AWAPCMD_1		= 1'b0;
assign oDDR_AWQOS_1			= 1'b0;
assign oDDR_AWCACHE_1[3:0]	= 4'd0;
assign oDDR_AWALLSTRB_1		= 1'b0;
assign oDDR_AWCOBUF_1		= 1'b0;
assign oDDR_BREADY_1		= 1'b0;
assign oDDR_RREADY_1		= 1'b0;
assign oDDR_WDATA_1[pDdrAxiDatWidth0-1:0] = {pDdrAxiDatWidth0{1'b0}};
assign oDDR_WLAST_1			= 1'b0;
assign oDDR_WSTRB_1[pDdrAxiDatWidth0/8-1:0]	= {(pDdrAxiDatWidth0/8){1'b0}};
assign oDDR_WVALID_1		= 1'b0;



endmodule
//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------