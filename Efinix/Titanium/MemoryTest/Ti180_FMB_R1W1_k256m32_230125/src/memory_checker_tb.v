/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : memory_checker_tb.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 01/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
`timescale 1ns/1ps
module memory_checker_tb;


//-----------------------------------------------------------------------------
// CLK, RST 回路
//-----------------------------------------------------------------------------
localparam lpCLK = 2;

reg rRST = 1'b1;
reg rCLK = 1'b0;

always
begin
	#(lpCLK / 2);
	rCLK = ~rCLK;
end

task task_system_reset()
begin
	rRST = 1'b1;
	#(lpCLK * 16);
	rRST = 1'b0;
end
endtask

//-----------------------------------------------------------------------------
// AMBA AXI4 I/F reg,wire list
//-----------------------------------------------------------------------------
localparam lpAxi4BusWidth 	= 512,
localparam lpWidth			= 16,
localparam lpAlen			= 23,
localparam lpStartAdrs		= 32'h00000000,
localparam lpStopAdrs		= 32'h00100000,
localparam lpAdrsOffset		= (pAlen + 1) * (pWidth / 8)

// AXI4 Read Address Channel
wire[  7:0] 				w_arlen;		// Burst Length, arlen + 1
wire[  2:0] 				w_arsize;		// Burst Size, 1,2,4,8,16,32,64,128
wire[  1:0] 				w_arburst;		// Burst Type, 0.固定アドレス, 1.アドレス自動インクリメント
wire[ 32:0] 				w_araddr;
reg  						r_arready;
wire 						w_arvalid;
wire[  5:0] 				w_arid;
wire 						w_arlock;		// 0.通常, 1.排他的アクセス
wire 						w_arqos;
wire 						w_arapcmd;
// AXI4 Read Data Channel
reg  [pAxi4BusWidth-1:0] 	r_rdata;
reg  [  5:0] 				r_rid;
reg  						r_rlast;
reg  [  1:0] 				r_rresp;
wire 						w_rready;		// 受信完了
reg 						r_rvalid;
// AXI4 Write Address Channel
wire[  3:0] 				w_awcache;
wire 						w_awqos;		// 品質?
wire[ 32:0] 				w_awaddr;
wire 						w_awallstrb;
wire 						w_awapcmd;
wire 						w_awcobuf;
wire[  5:0] 				w_awid;
wire[  7:0] 				w_awlen;
wire[  2:0] 				w_awsize;
wire[  1:0] 				w_awburst;
wire 						w_awlock;
reg 						r_awready;
wire 						w_awvalid;
// AXI4 Write Data Channel
reg 						r_wready;		// 受信完了
wire[pAxi4BusWidth-1:0] 	w_wdata;
wire 						w_wlast;		// Burst 転送最後のときに Assert
wire[ 63:0] 				w_wstrb;		// 有効レーンBit
wire 						w_wvalid;
// AXI4 Write Response Channel
reg [  5:0] 				r_bid;
reg [  1:0] 				r_bresp;		// 00.通常のアクセス成功, 10.エラー, 11.エラー
wire 						w_bready;
reg 						e_bvalid;
// DDR Status
reg							r_cfg_done;
wire						w_test_done;	// test Complete
wire 						w_test_fail;	// test NG
wire 						w_test_run;		// test running


//-----------------------------------------------------------------------------
// DDR Hard IP に見立てた module
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// Local から DDR Hard IP にアクセス
//-----------------------------------------------------------------------------
memory_checker #(
	.pAxi4BusWidth(),
    .pWidth(),
    .pAlen(),
    .pStartAdrs(),
    .pStopAdrs(),
    .pAdrsOffset()
) memory_checker (
// AXI4 Read Address Channel
	.o_arlen(o_arlen),
	.o_arsize(o_arsize),
	.o_arburst(o_arburst),
	.o_araddr(o_araddr),
	.i_arready(i_arready),
	.o_arvalid(o_arvalid),
	.o_arid(o_arid),
	.o_arlock(o_arlock),
	.o_arqos(o_arqos),
	.o_arapcmd(o_arapcmd),
// AXI4 Read Data Channel
	.i_rdata(i_rdata),
	.i_rid(i_rid),
	.i_rlast(i_rlast),
	.i_rresp(i_rresp),
	.o_rready(o_rready),
	.i_rvalid(i_rvalid),
// AXI4 Write Address Channel
	.o_awcache(o_awcache),
	.o_awqos(o_awqos),
	.o_awaddr(o_awaddr),
	.o_awallstrb(o_awallstrb),
	.o_awapcmd(o_awapcmd),
	.o_awcobuf(o_awcobuf),
	.o_awid(o_awid),
	.o_awlen(o_awlen),
	.o_awsize(o_awsize),
	.o_awburst(o_awburst),
	.o_awlock(o_awlock),
	.i_awready(i_awready),
	.o_awvalid(o_awvalid),
// AXI4 Write Data Channel
	.i_wready(i_wready),
	.o_wdata(o_wdata),
	.o_wlast(o_wlast),
	.o_wstrb(o_wstrb),
	.o_wvalid(o_wvalid),
// AXI4 Write Response Channel
	.i_bid(i_bid),
	.i_bresp(i_bresp),
	.o_bready(o_bready),
	.i_bvalid(i_bvalid),
// DDR Status
	.i_cfg_done(i_cfg_done),
	.o_test_done(o_test_done),
	.o_test_fail(o_test_fail),
	.o_test_run(o_test_run),
// common
	.iRST(rARST),
	.iCLK(rACLK)
);


initial
begin
	$dumpfile("memory_checker_tb.vcd");
	$dumpvars(0, memory_checker_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	task_system_reset();
	#(lpCLK*100);
	$finish;
end

endmodule