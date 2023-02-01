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

reg  rRST = 1'b1;
reg  rCLK = 1'b0;
wire wCLK;			assign wCLK = rCLK;
wire wRST;			assign wRST = rRST;

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
localparam lpAxi4BusWidth 	= 256;
localparam lpDataBitWidth	= 16;
localparam lpAlen			= 23;
localparam lpStartAdrs		= 32'h00000000;
localparam lpStopAdrs		= 32'h00100000;
localparam lpAdrsOffset		= (lpAlen + 1) * (lpDataBitWidth / 8);

// AXI4 Read Address Channel
wire[  7:0] 				w_arlen;		// Burst Length, arlen + 1
wire[  2:0] 				w_arsize;		// Burst Size, 1,2,4,8,16,32,64,128
wire[  1:0] 				w_arburst;		// Burst Type, 0.固定アドレス, 1.アドレス自動インクリメント
wire[ 32:0] 				w_araddr;
reg  						w_arready;
wire 						w_arvalid;
wire[  5:0] 				w_arid;
wire 						w_arlock;		// 0.通常, 1.排他的アクセス
wire 						w_arqos;
wire 						w_arapcmd;
// AXI4 Read Data Channel
reg  [pAxi4BusWidth-1:0] 	w_rdata;
reg  [  5:0] 				w_rid;
reg  						w_rlast;
reg  [  1:0] 				w_rresp;
wire 						w_rready;		// 受信完了
reg 						w_rvalid;
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
reg 						w_awready;
wire 						w_awvalid;
// AXI4 Write Data Channel
reg 						w_wready;		// 受信完了
wire[pAxi4BusWidth-1:0] 	w_wdata;
wire 						w_wlast;		// Burst 転送最後のときに Assert
wire[ 63:0] 				w_wstrb;		// 有効レーンBit
wire 						w_wvalid;
// AXI4 Write Response Channel
reg [  5:0] 				w_bid;
reg [  1:0] 				w_bresp;		// 00.通常のアクセス成功, 10.エラー, 11.エラー
wire 						w_bready;
reg 						w_bvalid;
// DDR Status
reg							w_ddr_cfg_done;	// caribration done
wire						w_test_done;	// test Complete
wire 						w_test_fail;	// test NG
wire 						w_test_run;		// test running

// ddr_hard_ip
ddr_hard_ip #(
	.pAxi4BusWidth(lpAxi4BusWidth),
    .pDataBitWidth(lpDataBitWidth),
    .pStartAdrs(lpStartAdrs),
    .pStopAdrs(lpStopAdrs),
    .pAdrsOffset(lpAdrsOffset)
) ddr_hard_ip (
// AXI4 Read Address Channel
	.i_arlen(w_arlen),			.i_arsize(w_arsize),
	.i_arburst(w_arburst),		.i_araddr(w_araddr),
	.i_arid(w_arid),			.i_arlock(w_arlock),
	.i_arqos(w_arqos),			.i_arapcmd(w_arapcmd),
	.o_arready(w_arready),		.i_arvalid(w_arvalid),
// AXI4 Read Data Channel
	.o_rdata(w_rdata),			.o_rlast(w_rlast),
	.o_rid(w_rid),				.o_rresp(w_rresp),
	.i_rready(w_rready),		.o_rvalid(w_rvalid),
// AXI4 Write Address Channel
	.i_awcache(w_awcache),		.i_awqos(w_awqos),
	.i_awaddr(w_awaddr),		.i_awallstrb(w_awallstrb),
	.i_awapcmd(w_awapcmd),		.i_awcobuf(w_awcobuf),
	.i_awlen(w_awlen),
	.i_awsize(w_awsize),		.i_awburst(w_awburst),
	.i_awid(w_awid),			.i_awlock(w_awlock),
	.o_awready(w_awready),		.i_awvalid(w_awvalid),
// AXI4 Write Data Channel
	.i_wdata(w_wdata),			.i_wlast(w_wlast),
	.i_wstrb(w_wstrb),
	.o_wready(w_wready),		.i_wvalid(w_wvalid),
// AXI4 Write Response Channel
	.o_bid(w_bid),				.o_bresp(w_bresp),
	.i_bready(w_bready),		.o_bvalid(w_bvalid),
// Configration
	.o_ddr_cfg_done(w_ddr_cfg_done),
// common
	.iRST(wRST),
	.iCLK(wCLK)
);


//-----------------------------------------------------------------------------
// Local から DDR Hard IP にアクセス
//-----------------------------------------------------------------------------
memory_checker #(
	.pAxi4BusWidth(lpAxi4BusWidth),
    .pDataBitWidth(lpDataBitWidth),
    .pAlen(lpAlen),
    .pStartAdrs(lpStartAdrs),
    .pStopAdrs(lpStopAdrs),
    .pAdrsOffset(lpAdrsOffset)
) memory_checker (
// AXI4 Read Address Channel
	.o_arlen(w_arlen),			.o_arsize(w_arsize),
	.o_arburst(w_arburst),		.o_araddr(w_araddr),
	.o_arid(w_arid),			.o_arlock(w_arlock),
	.o_arqos(w_arqos),			.o_arapcmd(w_arapcmd),
	.i_arready(w_arready),		.o_arvalid(w_arvalid),
// AXI4 Read Data Channel
	.i_rdata(w_rdata),			.i_rlast(w_rlast),
	.i_rid(w_rid),				.i_rresp(w_rresp),
	.o_rready(w_rready),		.i_rvalid(w_rvalid),
// AXI4 Write Address Channel
	.o_awcache(w_awcache),		.o_awqos(w_awqos),
	.o_awaddr(w_awaddr),		.o_awallstrb(w_awallstrb),
	.o_awapcmd(w_awapcmd),		.o_awcobuf(w_awcobuf),
	.o_awlen(w_awlen),
	.o_awsize(w_awsize),		.o_awburst(w_awburst),
	.o_awid(w_awid),			.o_awlock(w_awlock),
	.i_awready(w_awready),		.o_awvalid(w_awvalid),
// AXI4 Write Data Channel
	.o_wdata(w_wdata),			.o_wlast(w_wlast),
	.o_wstrb(w_wstrb),
	.i_wready(w_wready),		.o_wvalid(w_wvalid),
// AXI4 Write Response Channel
	.i_bid(w_bid),				.i_bresp(w_bresp),
	.o_bready(w_bready),		.i_bvalid(w_bvalid),
// DDR Status
	.i_cfg_done(w_ddr_cfg_done),
	.o_test_done(w_test_done),
	.o_test_fail(w_test_fail),
	.o_test_run(w_test_run),
// common
	.iRST(wRST),
	.iCLK(wCLK)
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