/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : MTopFmbTester.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 27/Jan-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module MTopFmbTester
#(
parameter[15:0]	pFpgaVer		= 16'h00_03,	// by 4 Digits BCD
parameter[15:0]	pFpgaRel		= 16'h01_01,	// by 4 Digits BCD
parameter[31:0]	pFpgaCcc		= {"POK2"},		// by 4 Characters for SVO-09
parameter[ 4:0]	pCommitWaitCnt	= 31
)(
//---------------------------------------------------------------------------
// Board User-I/F and Test Port
output[ 7: 2]	oLedX,
input [ 1: 0]	inPbSwX,
//---------------------------------------------------------------------------
// PLL-I/F Block port
// input			iOscDdr,
// input 			iOscSys,
// input 			iDdrCoreCLK,		// 133.33 MHz
input 			iSCLK,				// System CLK 100[MHz]
input 			iPLLBL1Locked,		// BL1 Locked
input 			iPLLTL2Locked,		// TL2 Locked
output 			oPLLBL1nRST,		// PLL BL1 nRST
output 			oPLLTL2nRST,		// PLL TL2 nRST
//
//---------------------------------------------------------------------------
// LPDDR4x-Hard IP port
// config controller
input 			ddr4_CFG_DONE,
output 			ddr4_CFG_RESET,
output 			ddr4_CFG_SEL,
output 			ddr4_CFG_START,
// Controller Status
input 			ddr4_CTRL_CMD_Q_ALMOST_FULL,
input 			ddr4_CTRL_BUSY,
input 			ddr4_CTRL_INT,
input 			ddr4_CTRL_MEM_RST_VALID,
input 			ddr4_CTRL_REFRESH,
input 			ddr4_CTRL_DP_IDLE,
input [  1:0] 	ddr4_CTRL_CKE,
input [  1:0] 	ddr4_CTRL_PORT_BUSY,
// AXI Active Low Reset
output 			ddr4_ARSTN_0,
// AXI4 Read Address Channel
output[  5:0] 	ddr4_ARID_0,
input 			ddr4_ARREADY_0,
output 			ddr4_ARVALID_0,
output[  7:0] 	ddr4_ARLEN_0,
output[  2:0] 	ddr4_ARSIZE_0,
output[  1:0] 	ddr4_ARBURST_0,
output 			ddr4_ARLOCK_0,
output 			ddr4_ARQOS_0,
output[ 32:0] 	ddr4_ARADDR_0,
output 			ddr4_ARAPCMD_0,
// AXI4 Read Data Channel
input [255:0] 	ddr4_RDATA_0,
input [  5:0] 	ddr4_RID_0,
input 			ddr4_RLAST_0,
output 			ddr4_RREADY_0,
input [  1:0] 	ddr4_RRESP_0,
input 			ddr4_RVALID_0,
// AXI4 Write Address Channel
output[  5:0] 	ddr4_AWID_0,
input 			ddr4_AWREADY_0,
output 			ddr4_AWVALID_0,
output[  7:0] 	ddr4_AWLEN_0,
output[  2:0] 	ddr4_AWSIZE_0,
output[  1:0] 	ddr4_AWBURST_0,
output 			ddr4_AWLOCK_0,
output[  3:0] 	ddr4_AWCACHE_0,
output 			ddr4_AWQOS_0,
output[ 32:0] 	ddr4_AWADDR_0,
output 			ddr4_AWALLSTRB_0,
output 			ddr4_AWAPCMD_0,
output 			ddr4_AWCOBUF_0,
// AXI4 Write Data Channel
input 			ddr4_WREADY_0,
output[255:0] 	ddr4_WDATA_0,
output 			ddr4_WLAST_0,
output[ 63:0] 	ddr4_WSTRB_0,
output 			ddr4_WVALID_0,
// AXI4 Write Response Channel
input [  5:0] 	ddr4_BID_0,
output 			ddr4_BREADY_0,
input 			ddr4_BVALID_0,
input [  1:0] 	ddr4_BRESP_0
//
);
  
//---------------------------------------------------------------------------
// System リセット生成
//---------------------------------------------------------------------------
assign oPLLBL1nRST = 1'b1;
assign oPLLTL2nRST = 1'b1;
//
wire wSRST, wnSRST;
reg  rSRST, rnSRST;
reg  qLocked;
  
always @(posedge iSCLK, negedge inPbSwX[0])
begin
	if (!inPbSwX[0])	rSRST <= 1'b1;
	else if (qLocked) 	rSRST <= 1'b0;
	else 				rSRST <= rSRST;

	if (!inPbSwX[0])	rnSRST <= 1'b0;
	else if (qLocked) 	rnSRST <= 1'b1;
	else 				rnSRST <= rnSRST;
end

always @*
begin
	qLocked <= &{iPLLBL1Locked,iPLLTL2Locked};
end

EFX_GBUFCE # (
	.CE_POLARITY(1'b1)
) EFX_GBUFCE_SRST (
	.O(wSRST),		.I(rSRST),		.CE(1'b1)
);

EFX_GBUFCE # (
	.CE_POLARITY(1'b1)
) EFX_GBUFCE_SRST (
	.O(wnSRST),		.I(rnSRST),		.CE(1'b1)
);

//---------------------------------------------------------------------------
// ddr リセット生成
//---------------------------------------------------------------------------
wire w_ddr_axi_nreset;			assign ddr4_ARSTN_0   = w_ddr_axi_nreset;
wire w_ddr_cfg_reset;			assign ddr4_CFG_RESET = w_ddr_cfg_reset;
wire w_ddr_cfg_start;			assign ddr4_CFG_START = w_ddr_cfg_start;
								assign ddr4_CFG_SEL   = 1'b0;
  
ddr_reset_sequencer ddr_reset_sequencer_inst (
	.ddr_rstn_i			(wnSRST),
	.clk				(iSCLK),
	.ddr_rstn			(w_ddr_axi_nreset),
	.ddr_cfg_seq_rst	(w_ddr_cfg_reset),
	.ddr_cfg_seq_start	(w_ddr_cfg_start)
);

//---------------------------------------------------------------------------
// memory check
// LPDDR4x 4G x16:
// [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
//---------------------------------------------------------------------------
wire w_test_done, w_test_fail, w_test_run;

memory_checker #(
	.START_ADDR(32'h0000_0000),
	.STOP_ADDR(32'h0FFF_FE00),
	.ALEN(7)
) memory_checker (
// AXI4 Read Address Channel
	.o_arid_0(ddr4_ARID_0),
	.i_arready_0(ddr4_ARREADY_0),
	.o_arvalid_0(ddr4_ARVALID_0),
	.o_arlen_0(ddr4_ARLEN_0),
	.o_arsize_0(ddr4_ARSIZE_0),
	.o_arburst_0(ddr4_ARBURST_0),
	.o_arlock_0(ddr4_ARLOCK_0),
	.o_arqos_0(ddr4_ARQOS_0),
	.o_araddr_0(ddr4_ARADDR_0),
	.o_arapcmd_0(ddr4_ARAPCMD_0),
// AXI4 Read Data Channel
	.i_rdata_0(ddr4_RDATA_0),
	.i_rid_0(ddr4_RID_0),
	.i_rlast_0(ddr4_RLAST_0),
	.o_rready_0(ddr4_RREADY_0),
	.i_rresp_0(ddr4_RRESP_0),
	.i_rvalid_0(ddr4_RVALID_0),
// AXI4 Write Address Channel
	.o_awid_0(ddr4_AWID_0),
	.i_awready_0(ddr4_AWREADY_0),
	.o_awvalid_0(ddr4_AWVALID_0),
	.o_awlen_0(ddr4_AWLEN_0),
	.o_awsize_0(ddr4_AWSIZE_0),
	.o_awburst_0(ddr4_AWBURST_0),
	.o_awlock_0(ddr4_AWLOCK_0),
	.o_awcache_0(ddr4_AWCACHE_0),
	.o_awqos_0(ddr4_AWQOS_0),
	.o_awaddr_0(ddr4_AWADDR_0),
	.o_awallstrb_0(ddr4_AWALLSTRB_0),
	.o_awapcmd_0(ddr4_AWAPCMD_0),
	.o_awcobuf_0(ddr4_AWCOBUF_0),
// AXI4 Write Data Channel
	.i_wready_0(ddr4_WREADY_0),
	.o_wdata_0(ddr4_WDATA_0),
	.o_wlast_0(ddr4_WLAST_0),
	.o_wstrb_0(ddr4_WSTRB_0),
	.o_wvalid_0(ddr4_WVALID_0),
// AXI4 Write Response Channel
	.i_bid_0(ddr4_BID_0),
	.o_bready_0(ddr4_BREADY_0),
	.i_bvalid_0(ddr4_BVALID_0),
	.i_bresp_0(ddr4_BRESP_0),
// DDR Status
	.i_cfg_done(ddr4_CFG_DONE),
	.o_test_done(w_test_done),
	.o_test_fail(w_test_fail),
	.o_test_run(w_test_run),
// common
	.iAxiRST(wSRST),
	.iAxiCLK(iSCLK)
);


//---------------------------------------------------------------------------
// User Led
//---------------------------------------------------------------------------
assign oLedX[2] = iPLLBL1Locked;
assign oLedX[3] = iPLLTL2Locked;
assign oLedX[4] = 1'b0;
assign oLedX[5] = w_test_fail;
assign oLedX[6] = w_test_done;
assign oLedX[7] = w_test_run;


//---------------------------------------------------------------------------
endmodule	// MTopFmbTester
//---------------------------------------------------------------------------