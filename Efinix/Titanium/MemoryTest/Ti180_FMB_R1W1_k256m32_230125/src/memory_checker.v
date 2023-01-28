/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : memory_checker.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 27/Jan-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module memory_checker #(
    parameter pWidth		= 16,
    parameter pAlen			= 23,
    parameter pStartAdrs	= 32'h00000000,
    parameter pStopAdrs		= 32'h00100000,
    parameter pAdrsOffset	= (pAlen + 1) * (pWidth / 8)
)(
// AXI4 Read Address Channel
output[  5:0] 	o_arid_0,
input 			i_arready_0,
output 			o_arvalid_0,
output[  7:0] 	o_arlen_0,
output[  2:0] 	o_arsize_0,
output[  1:0] 	o_arburst_0,
output 			o_arlock_0,
output 			o_arqos_0,
output[ 32:0] 	o_araddr_0,
output 			o_arapcmd_0,
// AXI4 Read Data Channel
input [255:0] 	i_rdata_0,
input [  5:0] 	i_rid_0,
input 			i_rlast_0,
output 			o_rready_0,
input [  1:0] 	i_rresp_0,
input 			i_rvalid_0,
// AXI4 Write Address Channel
output[  5:0] 	o_awid_0,
input 			i_awready_0,
output 			o_awvalid_0,
output[  7:0] 	o_awlen_0,
output[  2:0] 	o_awsize_0,
output[  1:0] 	o_awburst_0,
output 			o_awlock_0,
output[  3:0] 	o_awcache_0,
output 			o_awqos_0,
output[ 32:0] 	o_awaddr_0,
output 			o_awallstrb_0,
output 			o_awapcmd_0,
output 			o_awcobuf_0,
// AXI4 Write Data Channel
input 			i_wready_0,
output[255:0] 	o_wdata_0,
output 			o_wlast_0,
output[ 63:0] 	o_wstrb_0,
output 			o_wvalid_0,
// AXI4 Write Response Channel
input [  5:0] 	i_bid_0,
output 			o_bready_0,
input 			i_bvalid_0,
input [  1:0] 	i_bresp_0,
// DDR Status
input			i_cfg_done,
output			o_test_done,	// test Complete
output 			o_test_fail,	// test NG
output 			o_test_run,		// test running
// common
input 			iAxiRST,
input 			iAxiCLK
);
  

//---------------------------------------------------------------------------
// Memory Tester State
//---------------------------------------------------------------------------
localparam lp

reg rs;

always @(posedge iAxiCLK)
begin
	if (iAxiRST)
	begin
		rs <= ;
	end
	else
	begin
	case ( rs )
		: 
		default: 
	endcase
	end
end

endmodule