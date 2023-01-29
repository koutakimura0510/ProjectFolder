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
output[  7:0] 	o_arlen_0,		// Burst Length, arlen + 1
output[  2:0] 	o_arsize_0,		// Burst Size, 1,2,4,8,16,32,64,128
output[  1:0] 	o_arburst_0,	// Burst Type, 0.固定アドレス, 1.アドレス自動インクリメント
output[ 32:0] 	o_araddr_0,
input 			i_arready_0,
output 			o_arvalid_0,
output[  5:0] 	o_arid_0,
output 			o_arlock_0,		// 0.通常, 1.排他的アクセス
output 			o_arqos_0,
output 			o_arapcmd_0,
// AXI4 Read Data Channel
input [255:0] 	i_rdata_0,
input [  5:0] 	i_rid_0,
input 			i_rlast_0,
input [  1:0] 	i_rresp_0,
output 			o_rready_0,		// 受信完了
input 			i_rvalid_0,
// AXI4 Write Address Channel
output[  3:0] 	o_awcache_0,
output 			o_awqos_0,		// 品質?
output[ 32:0] 	o_awaddr_0,
output 			o_awallstrb_0,
output 			o_awapcmd_0,
output 			o_awcobuf_0,
output[  5:0] 	o_awid_0,
output[  7:0] 	o_awlen_0,
output[  2:0] 	o_awsize_0,
output[  1:0] 	o_awburst_0,
output 			o_awlock_0,
input 			i_awready_0,
output 			o_awvalid_0,
// AXI4 Write Data Channel
input 			i_wready_0,		// 受信完了
output[255:0] 	o_wdata_0,
output 			o_wlast_0,		// Burst 転送最後のときに Assert
output[ 63:0] 	o_wstrb_0,		// 有効レーンBit
output 			o_wvalid_0,
// AXI4 Write Response Channel
input [  5:0] 	i_bid_0,
output 			o_bready_0,
input 			i_bvalid_0,
input [  1:0] 	i_bresp_0,		// 00.通常のアクセス成功, 10.エラー, 11.エラー
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
// 
// 1. 指定アドレス領域にデータ書込
// 2. 指定アドレス領域のデータ読込しつつ、データ化けが起きていたら終了
//---------------------------------------------------------------------------
localparam [2:0]
	lpIdle 		= 0,
	lpWriteCmd 	= 1,
	lpWriteTx	= 2,
	lpReadCmd	= 3,
	lpReadRx 	= 4,
	lpDone 		= 5;

// [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
//------------------------------------------------------------------------------
// AXI4 Write Address Channel
// reg [2:0] 	rs;
reg 		r_wcs;
reg [16:0]	r_wrow;
reg	[2:0]	r_wbank;
reg [9:0]	r_wcol;					assign o_awaddr_0		= {r_wcs,r_wrow,r_wbank,r_wcol,2'b00};
									assign o_awcache_0		= 4'b0000;
									assign o_awqos_0		= 1'b0;
									assign o_awallstrb_0	= 1'b1;
									assign o_awapcmd_0		= 1'b0;
									assign o_awcobuf_0		= 1'b0;
									assign o_awid_0			= 6'd0;
									assign o_awlock_0		= 1'b0;
									assign o_awlen_0		= 8'd1;
									assign o_awsize_0		= 3'b000;
									assign o_awburst_0		= 2'b00;
reg 		r_awvalid_0;			assign o_awvalid_0		= r_awvalid_0;
//------------------------------------------------------------------------------
// AXI4 Write Data Channel
reg [15:0]	r_wdata_0;				assign o_wdata_0		= {{240{1'b0}}, r_wdata_0};
reg 		r_wlast_0;				assign o_wlast_0		= r_wlast_0;
reg 		r_wvalid_0;				assign o_wvalid_0		= r_wvalid_0;
									assign o_wstrb_0		= {64{1'b1}};
reg 		r_awready;
reg 		r_wready;
//------------------------------------------------------------------------------
// AXI4 Write Response Channel
//
reg 		r_bready_0;				assign o_bready_0 		= r_bready_0;
//------------------------------------------------------------------------------
reg 		q_awvalid_0_cke;
reg 		q_wvalid_0_cke;

always @(posedge iAxiCLK)
begin
	if (iAxiRST)
	begin
		r_wcs		<= 1'b0;
		r_wrow		<= 17'd0;
		r_wbank		<= 3'd0;
		r_wcol		<= 2'd0;
		r_awvalid_0 <= 1'b0;
		r_wvalid_0	<= 1'b0;
		r_wdata_0	<= 16'h1234;
		r_wlast_0	<= 1'b0;
		r_bready_0  <= 1'b0;
	end
	else
	begin 
		r_wcs		<= 1'b0;
		r_wrow		<= 17'd0;
		r_wbank		<= 3'd0;
		r_wcol		<= 2'd0;
		r_wdata_0	<= 16'h1234;
		r_wlast_0	<= 1'b1;
		r_bready_0  <= 1'b1;

		if (q_awvalid_0_cke)r_awvalid_0	<= 1'b0;
		else				r_awvalid_0 <= 1'b1;

		if (q_wvalid_0_cke)	r_wvalid_0 <= 1'b0;
		else				r_wvalid_0 <= 1'b1;
	end
end

always @*
begin
	q_awvalid_0_cke <= i_awready_0;
	q_wvalid_0_cke  <= i_wready_0;
end

always @(posedge iAxiCLK)
begin
	r_awready	<= i_awready_0;
	r_wready	<= i_wready_0;
end

//-----------------------------------------------------------------------------
// Read Cycle
//-----------------------------------------------------------------------------
// [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
//-----------------------------------------------------------------------------
// AXI4 Read Address Channel
reg 		r_rcs;
reg [16:0]	r_rrow;
reg	[2:0]	r_rbank;
reg [9:0]	r_rcol;					assign o_araddr_0		= {r_rcs,r_rrow,r_rbank,r_rcol,2'b00};
									assign o_arqos_0		= 1'b0;
									assign o_arapcmd_0		= 1'b0;
									assign o_arid_0			= 6'd0;
									assign o_arlock_0		= 1'b0;
									assign o_arlen_0		= 8'd1;
									assign o_arsize_0		= 3'b000;
									assign o_arburst_0		= 2'b00;
reg 		r_arvalid_0;			assign o_arvalid_0		= r_arvalid_0;
//-----------------------------------------------------------------------------
// AXI4 Read Data Channel
reg 		r_rready_0;				assign o_rready_0 = r_rready_0;
reg [255:0]	r_rdata;
//
reg 		q_arready_0_cke;
reg 		q_rready_0_cke;
reg 		r_arready;
reg 		r_rready;

always @(posedge iAxiCLK)
begin
	if (iAxiRST)
	begin
		r_rcs		<= 1'b0;
		r_rrow		<= 17'd0;
		r_rbank		<= 3'b000;
		r_rcol		<= 10'd0;
		r_arvalid_0 <= 1'b0;
		r_rready_0  <= 1'b0;
		r_rdata		<= 256'd0;
	end
	else
	begin
		r_rcs		<= 1'b0;
		r_rrow		<= 17'd0;
		r_rbank		<= 3'b000;
		r_rcol		<= 10'd0;
		r_rdata		<= i_rdata_0;

		if (q_arready_0_cke) r_arvalid_0 <= 1'b0;
		else 				 r_arvalid_0 <= 1'b1;

		if (q_rready_0_cke) r_rready_0 <= 1'b1;
		else				r_rready_0 <= 1'b0;
	end
end

always @*
begin
	q_arready_0_cke <= i_arready_0;
	q_rready_0_cke  <= i_rvalid_0;
end

always @(posedge iAxiCLK)
begin
	r_arready	<= i_arready_0;
	r_rready	<= i_rvalid_0;
end

//-----------------------------------------------------------------------------
// Rsponce
//-----------------------------------------------------------------------------
reg r_test_done;
reg r_test_fail;
reg r_test_run;

always @(posedge iAxiCLK)
begin
	if (iAxiRST)
	begin
		r_test_done	<= 1'b1;
		r_test_fail	<= 1'b1;
		r_test_run	<= 1'b1;
	end
	else
	begin
		r_test_done	<= 1'b0;
		r_test_fail	<= 1'b0;
		r_test_run	<= 1'b0;
	end
end

assign o_test_done = r_test_done;
assign o_test_fail = r_test_fail;
assign o_test_run  = r_test_run;


// always @(posedge iAxiCLK)
// begin
// 	if (iAxiRST)
// 	begin
// 		rs <= lpIdle;
// 	end
// 	else
// 	begin
// 	case ( rs )
// 		lpIdle:
// 		begin
// 			rs <= lpWriteCmd;
// 		end

// 		lpWriteCmd:
// 		begin
// 			rs <= lpWriteCmd;
// 		end

// 		lpWriteTx:
// 		begin
			
// 		end

// 		lpReadCmd:
// 		begin
			
// 		end

// 		lpReadRx:
// 		begin
			
// 		end

// 		lpDone: 
// 		begin
			
// 		end

// 		default:
// 		begin
			
// 		end
// 	endcase
// 	end
// end

endmodule