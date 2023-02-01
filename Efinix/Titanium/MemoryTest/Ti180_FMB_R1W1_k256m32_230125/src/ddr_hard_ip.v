/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : ddr_hard_ip.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 01/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module ddr_hard_ip #(
parameter	pAxi4BusWidth 	= 256,
parameter	pWidth			= 16,
parameter	pStartAdrs		= 32'h00000000,
parameter	pStopAdrs		= 32'h00100000,
parameter	pMemorySize		= 8
)(
// AXI4 Read Address Channel
input	[7:0] 				i_arlen,		// Burst Length, arlen + 1
input	[2:0] 				i_arsize,		// Burst Size, 1,2,4,8,16,32,64,128
input	[1:0] 				i_arburst,		// Burst Type, 0.固定アドレス, 1.アドレス自動インクリメント
input	[32:0] 				i_araddr,
output 						o_arready,
input 						i_arvalid,
input	[5:0] 				i_arid,
input 						i_arlock,		// 0.通常, 1.排他的アクセス
input 						i_arqos,
input 						i_arapcmd,
// AXI4 Read Data Channel
output 	[pAxi4BusWidth-1:0] o_rdata,
output 	[5:0] 				o_rid,
output 						o_rlast,
output 	[1:0] 				o_rresp,
input 						i_rready,		// 受信完了
output 						o_rvalid,
// AXI4 Write Address Channel
input	[3:0]				i_awcache,
input 						i_awqos,		// 品質?
input	[32:0]				i_awaddr,
input 						i_awallstrb,
input 						i_awapcmd,
input 						i_awcobuf,
input	[5:0]				i_awid,
input	[7:0]				i_awlen,
input	[2:0]				i_awsize,
input	[1:0]				i_awburst,
input 						i_awlock,
input 						o_awready,
output 						i_awvalid,
// AXI4 Write Data Channel
output 						o_wready,		// 受信完了
input	[pAxi4BusWidth-1:0]	i_wdata,
input 						i_wlast,		// Burst 転送最後のときに Assert
input	[63:0] 				i_wstrb,		// 有効レーンBit
input 						i_wvalid,
// AXI4 Write Response Channel
output 	[5:0] 				o_bid,
output 	[1:0] 				o_bresp,		// 00.通常のアクセス成功, 10.エラー, 11.エラー
input 						i_bready,
output 						o_bvalid,
// Configration
output 						o_ddr_cfg_done,	// DDR_CFG_DONE
// common
input 						iRST,
input 						inRST,
input 						iCLK
);


//-----------------------------------------------------------------------------
// DDR_CFG_DONE
//-----------------------------------------------------------------------------
reg r_ddr_cfg_done;

always @(posedge iCLK, negedge inRST)
begin
	if (!inRST) r_ddr_cfg_done <= 1'b0;
	else 		r_ddr_cfg_done <= 1'b1;
end


//-----------------------------------------------------------------------------
// AXI4 
//-----------------------------------------------------------------------------



endmodule