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
 *---------------------------------------------------------------------------
 * 1. 指定アドレス領域にデータ書込
 * 2. 指定アドレス領域のデータ読込しつつ、データ化けが起きていたら終了
 * [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
 * 
 * AXI4 ハンドシェイクのデッドロック回避のため下記ルールに則る
 * R/W Valid を '1' にするために、同じグループの Ready 信号を待ってはならない。
 * 
 * https://www.acri.c.titech.ac.jp/wordpress/archives/8503
 * https://www.intel.com/content/www/us/en/docs/programmable/683130/22-2/axi-interface-timing-diagram.html
 * https://en.wikipedia.org/wiki/Advanced_eXtensible_Interface#cite_note-axi34difference-10
 *
 * ILA デバッグ時の GTKWave を毎回自動で開かないようにする方法
 * /tools/efinix/2022.2/debugger/bin/efx_dbg/gui.py を開く
 * open_wave_viewer と検索し下記の部分をコメントアウトする。
 * wave_viewer = open_wave_viewer(
 *     gtkw_path, lambda e: self.error(str(e)))
 * if not new_viewer:
 *     self._wave_viewer = wave_viewer
 * else:
 *     self._standalone_wave_viewers.append(wave_viewer)
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module memory_checker #(
	parameter pAxi4BusWidth = 512,
    parameter pDataBitWidth	= 32,
    parameter pStartAdrs	= 32'h00000000,
    parameter pStopAdrs		= 32'h00100000,
	parameter pDdrBurstSize = 16
)(
// AXI4 Read Address Channel
output[  7:0] 				o_arlen,		// Burst Length, arlen + 1
output[  2:0] 				o_arsize,		// 一回に転送するバイト数, 8bit * 000=1,001=2,010=4,011=8,100=16,101=32,110=64,111=128
output[  1:0] 				o_arburst,		// Burst Type, 0.固定アドレス, 1.アドレス自動インクリメント
output[ 32:0] 				o_araddr,
input 						i_arready,
output 						o_arvalid,
output[  5:0] 				o_arid,
output 						o_arlock,		// 0.通常, 1.排他的アクセス
output 						o_arqos,
output 						o_arapcmd,
// AXI4 Read Data Channel
input [pAxi4BusWidth-1:0] 	i_rdata,
input [  5:0] 				i_rid,
input 						i_rlast,
input [  1:0] 				i_rresp,
output 						o_rready,		// 受信完了
input 						i_rvalid,
// AXI4 Write Address Channel
output[  3:0] 				o_awcache,
output 						o_awqos,		// 品質?
output[ 32:0] 				o_awaddr,
output 						o_awallstrb,
output 						o_awapcmd,
output 						o_awcobuf,
output[  5:0] 				o_awid,
output[  7:0] 				o_awlen,
output[  2:0] 				o_awsize,
output[  1:0] 				o_awburst,
output 						o_awlock,
input 						i_awready,
output 						o_awvalid,
// AXI4 Write Data Channel
input 						i_wready,		// 受信完了
output[pAxi4BusWidth-1:0] 	o_wdata,
output 						o_wlast,		// Burst 転送最後のときに Assert
output[ 63:0] 				o_wstrb,		// 有効レーンBit
output 						o_wvalid,
// AXI4 Write Response Channel
input [  5:0] 				i_bid,
input [  1:0] 				i_bresp,		// 00.通常のアクセス成功, 10.エラー, 11.エラー
output 						o_bready,
input 						i_bvalid,
// Core Logic Port
input						i_cfg_done,
output						o_test_done,	// test Complete
output 						o_test_fail,	// test NG
output 						o_test_run,		// test running
// common
input 						iRST,
input 						iCLK
);
  
//-----------------------------------------------------------------------------
// write sequence
//-----------------------------------------------------------------------------
wire w_wdone;

axi4_write_sequence #(
	.pAxi4BusWidth(pAxi4BusWidth),
	.pDataBitWidth(pDataBitWidth),
	.pStartAdrs(pStartAdrs),
	.pStopAdrs(pStopAdrs),
	.pDdrBurstSize(pDdrBurstSize)
) axi4_write_sequence (
	// AXI4 Write Address Channel
	.o_awcache(o_awcache),			.o_awqos(o_awqos),
	.o_awaddr(o_awaddr),			.o_awallstrb(o_awallstrb),
	.o_awapcmd(o_awapcmd),			.o_awcobuf(o_awcobuf),
	.o_awid(o_awid),				.o_awlen(o_awlen),
	.o_awsize(o_awsize),			.o_awburst(o_awburst),
	.o_awlock(o_awlock),			.i_awready(i_awready),
	.o_awvalid(o_awvalid),
	// AXI4 Write Data Channel
	.i_wready(i_wready),			.o_wdata(o_wdata),
	.o_wlast(o_wlast),				.o_wstrb(o_wstrb),
	.o_wvalid(o_wvalid),			.i_bid(i_bid),
	.i_bresp(i_bresp),				.o_bready(o_bready),
	.i_bvalid(i_bvalid),
	// Core Logic Port
	.o_wdone(w_wdone),
	// common
	.iRST(iRST),
	.iCLK(iCLK)
);



//-----------------------------------------------------------------------------
// read sequence
//-----------------------------------------------------------------------------
wire [pAxi4BusWidth-1:0] w_rdata;

axi4_read_sequence #(
	.pAxi4BusWidth(pAxi4BusWidth),
	.pDataBitWidth(pDataBitWidth),
	.pStartAdrs(pStartAdrs),
	.pStopAdrs(pStopAdrs),
	.pDdrBurstSize(pDdrBurstSize)
) axi4_read_sequence (
	// AXI4 Read Address Channel
	.o_arlen(o_arlen),			.o_arsize(o_arsize),
	.o_arburst(o_arburst),		.o_araddr(o_araddr),
	.i_arready(i_arready),		.o_arvalid(o_arvalid),
	.o_arid(o_arid),			.o_arlock(o_arlock),
	.o_arqos(o_arqos),			.o_arapcmd(o_arapcmd),
	// AXI4 Read Data Channel
	.i_rdata(i_rdata),			.i_rid(i_rid),
	.i_rlast(i_rlast),			.i_rresp(i_rresp),
	.o_rready(o_rready),		.i_rvalid(i_rvalid),
	// Core Logic Port
	.o_rdata(w_rdata),
	.i_wdone(w_wdone),
	// common
	.iRST(iRST),
	.iCLK(iCLK)
);


//-----------------------------------------------------------------------------
// test monitor
//-----------------------------------------------------------------------------
localparam lpCntRunBitWidth = 23;

reg [lpCntRunBitWidth-1:0] 	r_test_run;

always @(posedge iCLK)
begin
	if (iRST)	r_test_run <= {lpCntRunBitWidth{1'b0}};
	else 		r_test_run <= r_test_run + 1'b1;
end

assign o_test_run  = r_test_run[lpCntRunBitWidth-1];
assign o_test_fail = 1'b0;
assign o_test_done = &{w_rdata};

endmodule