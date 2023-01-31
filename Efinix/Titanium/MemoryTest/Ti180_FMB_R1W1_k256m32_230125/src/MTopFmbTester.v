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
module MTopFmbTester #(
	pAxi4BusWidth = 256
)(
//---------------------------------------------------------------------------
// LPDDR4x-Hard IP port
// config controller
input 						ddr4_CFG_DONE,
output 						ddr4_CFG_RESET,
output 						ddr4_CFG_SEL,
output 						ddr4_CFG_START,
// Controller Status
// input 			ddr4_CTRL_CMD_Q_ALMOST_FULL,
// input 			ddr4_CTRL_BUSY,
// input 			ddr4_CTRL_INT,
// input 			ddr4_CTRL_MEM_RST_VALID,
// input 			ddr4_CTRL_REFRESH,
// input 			ddr4_CTRL_DP_IDLE,
// input [  1:0] 	ddr4_CTRL_CKE,
// input [  1:0] 	ddr4_CTRL_PORT_BUSY,
// AXI Active Low Reset
output 						ddr4_ARSTN_0,
// AXI4 Read Address Channel
output[  5:0] 				ddr4_ARID_0,
input 						ddr4_ARREADY_0,
output 						ddr4_ARVALID_0,
output[  7:0] 				ddr4_ARLEN_0,
output[  2:0] 				ddr4_ARSIZE_0,
output[  1:0] 				ddr4_ARBURST_0,
output 						ddr4_ARLOCK_0,
output 						ddr4_ARQOS_0,
output[ 32:0] 				ddr4_ARADDR_0,
output 						ddr4_ARAPCMD_0,
// AXI4 Read Data Channel
input [pAxi4BusWidth-1:0] 	ddr4_RDATA_0,
input [  5:0] 				ddr4_RID_0,
input 						ddr4_RLAST_0,
output 						ddr4_RREADY_0,
input [  1:0] 				ddr4_RRESP_0,
input 						ddr4_RVALID_0,
// AXI4 Write Address Channel
output[  5:0] 				ddr4_AWID_0,
input 						ddr4_AWREADY_0,
output 						ddr4_AWVALID_0,
output[  7:0] 				ddr4_AWLEN_0,
output[  2:0] 				ddr4_AWSIZE_0,
output[  1:0] 				ddr4_AWBURST_0,
output 						ddr4_AWLOCK_0,
output[  3:0] 				ddr4_AWCACHE_0,
output 						ddr4_AWQOS_0,
output[ 32:0] 				ddr4_AWADDR_0,
output 						ddr4_AWALLSTRB_0,
output 						ddr4_AWAPCMD_0,
output 						ddr4_AWCOBUF_0,
// AXI4 Write Data Channel
input 						ddr4_WREADY_0,
output[pAxi4BusWidth-1:0] 	ddr4_WDATA_0,
output 						ddr4_WLAST_0,
output[ 63:0] 				ddr4_WSTRB_0,
output 						ddr4_WVALID_0,
// AXI4 Write Response Channel
input [  5:0] 				ddr4_BID_0,
output 						ddr4_BREADY_0,
input 						ddr4_BVALID_0,
input [  1:0] 				ddr4_BRESP_0,
// AXI Active Low Reset
// output 						ddr4_ARSTN_1,
// // AXI4 Read Address Channel
// output[  5:0] 				ddr4_ARID_1,
// input 						ddr4_ARREADY_1,
// output 						ddr4_ARVALID_1,
// output[  7:0] 				ddr4_ARLEN_1,
// output[  2:0] 				ddr4_ARSIZE_1,
// output[  1:0] 				ddr4_ARBURST_1,
// output 						ddr4_ARLOCK_1,
// output 						ddr4_ARQOS_1,
// output[ 32:0] 				ddr4_ARADDR_1,
// output 						ddr4_ARAPCMD_1,
// // AXI4 Read Data Channel
// input [pAxi4BusWidth-1:0] 	ddr4_RDATA_1,
// input [  5:0] 				ddr4_RID_1,
// input 						ddr4_RLAST_1,
// output 						ddr4_RREADY_1,
// input [  1:0] 				ddr4_RRESP_1,
// input 						ddr4_RVALID_1,
// // AXI4 Write Address Channel
// output[  5:0] 				ddr4_AWID_1,
// input 						ddr4_AWREADY_1,
// output 						ddr4_AWVALID_1,
// output[  7:0] 				ddr4_AWLEN_1,
// output[  2:0] 				ddr4_AWSIZE_1,
// output[  1:0] 				ddr4_AWBURST_1,
// output 						ddr4_AWLOCK_1,
// output[  3:0] 				ddr4_AWCACHE_1,
// output 						ddr4_AWQOS_1,
// output[ 32:0] 				ddr4_AWADDR_1,
// output 						ddr4_AWALLSTRB_1,
// output 						ddr4_AWAPCMD_1,
// output 						ddr4_AWCOBUF_1,
// // AXI4 Write Data Channel
// input 						ddr4_WREADY_1,
// output[pAxi4BusWidth-1:0] 	ddr4_WDATA_1,
// output 						ddr4_WLAST_1,
// output[ 63:0] 				ddr4_WSTRB_1,
// output 						ddr4_WVALID_1,
// // AXI4 Write Response Channel
// input [  5:0] 				ddr4_BID_1,
// output 						ddr4_BREADY_1,
// input 						ddr4_BVALID_1,
// input [  1:0] 				ddr4_BRESP_1,
//---------------------------------------------------------------------------
// Board User-I/F and Test Port
output[ 7: 2]	oLedX,
input [ 1: 0]	inPbSwX,
//---------------------------------------------------------------------------
// PLL-I/F Block port
input 			iSCLK,				// System CLK 100[MHz]
input 			iACLK,				// Axi CLK 100[MHz]
input 			iDdrFCLK,
input 			iPLLBL1Locked,		// BL1 Locked
input 			iPLLBR0Locked,		// BR0 Locked
input 			iPLLTL2Locked,		// TL2 Locked
output 			oPLLBL1nRST,		// PLL BL1 nRST
output 			oPLLBR0nRST,		// PLL BR0 nRST
output 			oPLLTL2nRST			// PLL TL2 nRST
//
);
  
//---------------------------------------------------------------------------
// System リセット生成
//---------------------------------------------------------------------------
assign 	oPLLBL1nRST = 1'b1;
assign 	oPLLBR0nRST = 1'b1;
assign 	oPLLTL2nRST = 1'b1;
//
reg  	rSRST, rnSRST;
reg  	rARST, rnARST;
reg  	qLocked;
  
always @(posedge iSCLK, negedge qLocked)
begin
	if (!qLocked) 		rSRST <= 1'b1;
	else 				rSRST <= 1'b0;

	if (!qLocked) 		rnSRST <= 1'b0;
	else 				rnSRST <= 1'b1;
end

always @(posedge iACLK, negedge qLocked)
begin
	if (!qLocked) 		rARST  <= 1'b1;
	else 				rARST  <= 1'b0;

	if (!qLocked) 		rnARST <= 1'b0;
	else 				rnARST <= 1'b1;
end

always @*
begin
	qLocked <= &{inPbSwX[0],iPLLBL1Locked,iPLLBR0Locked,iPLLTL2Locked};
end

// EFX_GBUFCE # (
// 	.CE_POLARITY(1'b1)
// ) EFX_GBUFCE_SRST (
// 	.O(wLocked),		.I(qLocked),		.CE(1'b1)
// );

// EFX_GBUFCE # (
// 	.CE_POLARITY(1'b1)
// ) EFX_GBUFCE_nSRST (
// 	.O(wnSRST),		.I(rnSRST),		.CE(1'b1)
// );

//---------------------------------------------------------------------------
// ddr hard ip I/F リセット回路
//---------------------------------------------------------------------------
wire w_ddr_axi_nreset;
wire w_ddr_cfg_reset;
wire w_ddr_cfg_start;
wire w_ddr_cfg_done;

ddr_reset_sequencer #(
	.pStartCntBitWidth	(8)
) ddr_reset_sequencer (
	.i_ddr_cfg_done		(ddr4_CFG_DONE),
	.o_ddr_axi_rstn		(w_ddr_axi_nreset),
	.o_ddr_cfg_reset	(w_ddr_cfg_reset),
	.o_ddr_cfg_start	(w_ddr_cfg_start),
	.o_ddr_cfg_done		(w_ddr_cfg_done),
	.inRST				(rnARST),
	.iCLK				(iACLK)
);

assign ddr4_ARSTN_0	  = w_ddr_axi_nreset;
// assign ddr4_ARSTN_1 = w_ddr_axi_nreset;
assign ddr4_CFG_RESET = w_ddr_cfg_reset;
assign ddr4_CFG_START = w_ddr_cfg_start;
assign ddr4_CFG_SEL   = 1'b0;	// 自動キャリブレーション使用時は Low固定


//---------------------------------------------------------------------------
// memory check
// DDRx 4G x16:
// [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
//---------------------------------------------------------------------------
wire w_test_done, w_test_fail, w_test_run;

memory_checker #(
	.pAxi4BusWidth(pAxi4BusWidth)
) memory_checker_0 (
// AXI4 Read Address Channel
	.o_arid(ddr4_ARID_0),				.o_arapcmd(ddr4_ARAPCMD_0),
	.i_arready(ddr4_ARREADY_0),			.o_arvalid(ddr4_ARVALID_0),
	.o_arlen(ddr4_ARLEN_0),				.o_arsize(ddr4_ARSIZE_0),
	.o_arburst(ddr4_ARBURST_0),			.o_arlock(ddr4_ARLOCK_0),
	.o_arqos(ddr4_ARQOS_0),				.o_araddr(ddr4_ARADDR_0),
// AXI4 Read Data Channel
	.i_rdata(ddr4_RDATA_0),				.i_rid(ddr4_RID_0),
	.i_rlast(ddr4_RLAST_0),				.i_rresp(ddr4_RRESP_0),
	.i_rvalid(ddr4_RVALID_0),			.o_rready(ddr4_RREADY_0),
// AXI4 Write Address Channel
	.o_awid(ddr4_AWID_0),
	.i_awready(ddr4_AWREADY_0),			.o_awvalid(ddr4_AWVALID_0),
	.o_awlen(ddr4_AWLEN_0),				.o_awsize(ddr4_AWSIZE_0),
	.o_awburst(ddr4_AWBURST_0),			.o_awlock(ddr4_AWLOCK_0),
	.o_awcache(ddr4_AWCACHE_0),			.o_awqos(ddr4_AWQOS_0),
	.o_awaddr(ddr4_AWADDR_0),			.o_awallstrb(ddr4_AWALLSTRB_0),
	.o_awapcmd(ddr4_AWAPCMD_0),			.o_awcobuf(ddr4_AWCOBUF_0),
// AXI4 Write Data Channel
	.o_wdata(ddr4_WDATA_0),				.o_wlast(ddr4_WLAST_0),
	.o_wstrb(ddr4_WSTRB_0),
	.o_wvalid(ddr4_WVALID_0),			.i_wready(ddr4_WREADY_0),
// AXI4 Write Response Channel
	.i_bid(ddr4_BID_0),					.i_bresp(ddr4_BRESP_0),
	.o_bready(ddr4_BREADY_0),			.i_bvalid(ddr4_BVALID_0),
// DDR Status
	.i_cfg_done(w_ddr_cfg_done),		.o_test_done(w_test_done),
	.o_test_fail(w_test_fail),			.o_test_run(w_test_run),
// common
	.iARST(rARST),
	.iACLK(iACLK)
);




//-----------------------------------------------------------------------------
// debug
//-----------------------------------------------------------------------------
localparam lpCntDgBitWidth = 23;
reg [lpCntDgBitWidth-1:0] rCntDg;
reg rCntDgSel, qCntDgCke;

always @(posedge iDdrFCLK)
begin
	if (rSRST)			rCntDgSel <= 1'b1;
	else if (qCntDgCke)	rCntDgSel <= ~rCntDgSel;
	else 				rCntDgSel <=  rCntDgSel;

	if (rSRST)			rCntDg <= {lpCntDgBitWidth{1'b0}};
	else if (qCntDgCke) rCntDg <= {lpCntDgBitWidth{1'b0}};
	else 				rCntDg <= rCntDg + 1'b1;
end

always @*
begin
	qCntDgCke <= ({lpCntDgBitWidth{1'b1}} == rCntDg);
end

//---------------------------------------------------------------------------
// User Led
//---------------------------------------------------------------------------
assign oLedX[2] = qLocked;
assign oLedX[3] = w_ddr_cfg_start;
assign oLedX[4] = w_ddr_cfg_done;
assign oLedX[5] = 1'b0;
assign oLedX[6] = 1'b0;
assign oLedX[7] = rCntDgSel;

//---------------------------------------------------------------------------
endmodule	// MTopFmbTester
//---------------------------------------------------------------------------

/*


DQ は 16bit幅だが 32bit幅接続されているので、NC(DQpin) プルダウンしている
Ti180ボード搭載の LPDDR4x は MAX 2133MHz まで対応 = 差動1066でつじつまが合う

「FPGA Settings」

「Memory Mode Register Settings」
datasheet P53,56
ODT = On-Die-Termination(終端抵抗) 反射を抑える/波形を整える
CA Bus Receiver On-Die-Tremination , default = Disable = RZQ/6
DQ Bus Receiver On-Die-Tremination , default = Disable = RZQ/4
Pull Down Drive Strength(PDDS) , default = RZQ/6

datasheet P57,P59
CA,DQ VREF

VDDPHY = 0.85V
VDDQ   = PT15 0.6V,1.1V 切り替え対応 = now 0.6V, ZQ接続
VDD2   = 1.1V, ODT CA_A, ODT_CA_B 接続
VDD1   = 1.8V

MR22 Register
datasheet P65

「Memory Timing Settings」
datasheet P263
*/