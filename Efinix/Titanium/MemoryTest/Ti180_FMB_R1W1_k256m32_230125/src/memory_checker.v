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
	parameter pAxi4BusWidth = 512,
    parameter pWidth		= 16,
    parameter pAlen			= 23,
    parameter pStartAdrs	= 32'h00000000,
    parameter pStopAdrs		= 32'h00100000,
    parameter pAdrsOffset	= (pAlen + 1) * (pWidth / 8)
)(
// AXI4 Read Address Channel
output[  7:0] 				o_arlen,		// Burst Length, arlen + 1
output[  2:0] 				o_arsize,		// Burst Size, 1,2,4,8,16,32,64,128
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
// DDR Status
input						i_cfg_done,
output						o_test_done,	// test Complete
output 						o_test_fail,	// test NG
output 						o_test_run,		// test running
// common
input 						iRST,
input 						iCLK
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
reg [9:0]	r_wcol;					assign o_awaddr		= {r_wcs,r_wrow,r_wbank,r_wcol,2'b00};
									assign o_awcache	= 4'b0000;
									assign o_awqos		= 1'b0;
									assign o_awallstrb	= 1'b0;
									assign o_awapcmd	= 1'b0;
									assign o_awcobuf	= 1'b0;
									assign o_awid		= 6'd0;
									assign o_awlock		= 1'b0;
									assign o_awlen		= 8'd1;
									assign o_awsize		= 3'b000;
									assign o_awburst	= 2'b00;
reg 		r_awvalid;				assign o_awvalid	= r_awvalid;
//------------------------------------------------------------------------------
// AXI4 Write Data Channel
reg [pAxi4BusWidth-1:0]	r_wdata;				assign o_wdata		= r_wdata;
reg 					r_wlast;				assign o_wlast		= r_wlast;
reg 					r_wvalid;				assign o_wvalid		= r_wvalid;
												assign o_wstrb		= {64{1'b1}};
reg 					r_awready;
reg 					r_wready;
//------------------------------------------------------------------------------
// AXI4 Write Response Channel
//
reg 					r_bready;				assign o_bready 		= r_bready;
reg 					q_awready;
reg 					q_wready;
reg [5:0] 				r_bid;
reg [1:0] 				r_bresp;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		r_wcs		<= 1'b0;
		r_wrow		<= 17'd0;
		r_wbank		<= 3'd0;
		r_wcol		<= 10'd0;
		r_awvalid 	<= 1'b0;
		r_wvalid	<= 1'b0;
		r_wdata		<= {pAxi4BusWidth{1'b0}};
		r_wlast		<= 1'b0;
		r_bready  	<= 1'b0;
	end
	else
	begin 
		r_wlast		<= 1'b1;
		r_wcs		<= 1'b0;
		r_wbank		<= 3'd0;
		r_wcol		<= 10'd0;

		if (q_awready)		r_wrow	<= r_wrow  + 1'b1;
		else 				r_wrow	<= r_wrow;

		if (q_awready) 		r_wdata	<= r_wdata + 1'b1;
		else 				r_wdata	<= r_wdata;
		
		if (i_bvalid)		r_bready <= 1'b1;
		else 				r_bready <= 1'b0;

		if (q_awready)		r_awvalid <= 1'b0;
		else				r_awvalid <= 1'b1;

		if (q_wready)		r_wvalid <= 1'b0;
		else				r_wvalid <= 1'b1;
	end
end

always @*
begin
	q_awready <= i_awready;
	q_wready  <= i_wready;
end

always @(posedge iCLK)
begin
	r_awready	<= i_awready;
	r_wready	<= i_wready;
	r_bid		<= i_bid;
	r_bresp		<= i_bresp;
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
reg [9:0]	r_rcol;					assign o_araddr		= {r_rcs,r_rrow,r_rbank,r_rcol,2'b00};
									assign o_arqos		= 1'b0;
									assign o_arapcmd	= 1'b0;
									assign o_arid		= 6'd0;
									assign o_arlock		= 1'b0;
									assign o_arlen		= 8'd1;
									assign o_arsize		= 3'b000;
									assign o_arburst	= 2'b00;
reg 		r_arvalid;				assign o_arvalid	= r_arvalid;
//-----------------------------------------------------------------------------
// AXI4 Read Data Channel
reg 					r_rready;				assign o_rready = r_rready;
//
reg [pAxi4BusWidth-1:0] r_rdata;
reg 					q_arready;
reg 					q_valid;
// monitor
reg 					r_rlast;
reg 					r_arready;
reg 					r_rready;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		r_rcs		<= 1'b0;
		r_rrow		<= 17'd0;
		r_rbank		<= 3'b000;
		r_rcol		<= 10'd0;
		r_arvalid 	<= 1'b0;
		r_rready  	<= 1'b0;
	end
	else
	begin
		r_rcs		<= 1'b0;
		r_rbank		<= 3'd0;
		r_rcol		<= 10'd0;
		r_rdata		<= i_rdata;

		if (q_arready)	r_rrow <= r_rrow + 1'b1;
		else			r_rrow <= r_rrow;

		if (q_arready)	r_arvalid <= 1'b0;
		else			r_arvalid <= 1'b1;

		if (q_valid) 	r_rready <= 1'b1;
		else			r_rready <= 1'b0;
	end
end

always @*
begin
	q_arready	<= i_arready;
	q_valid  	<= i_rvalid;
end

always @(posedge iCLK)
begin
	r_rlast		<= i_rlast;
	r_arready	<= i_arready;
end

//-----------------------------------------------------------------------------
// Rsponce
//-----------------------------------------------------------------------------
reg r_test_done;
reg r_test_fail;
reg r_test_run;

always @(posedge iCLK)
begin
	if (iRST)
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


// always @(posedge iCLK)
// begin
// 	if (iRST)
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