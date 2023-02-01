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
    parameter pDataBitWidth	= 16,
    parameter pAlen			= 23,
    parameter pStartAdrs	= 32'h00000000,
    parameter pStopAdrs		= 32'h00100000
    // parameter pAdrsOffset	= (pAlen + 1) * (pWidth / 8)
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
// localparam  lpWriteSeq;
reg [2:0] 	rs;
reg [1:0] 	rBurstCnt;
reg 		qBurstMaxCke;
reg 		q_wseq_cke;
// AXI4 Write Address Channel
reg 					r_wcs;
reg [16:0]				r_wrow;
reg	[2:0]				r_wbank;
reg [9:0]				r_wcol;
reg 					r_awvalid, q_awvalid_cke;
// AXI4 Write Data Channel
reg [pAxi4BusWidth-1:0]	r_wdata;
reg 					r_wlast;
reg 					r_wvalid, q_wvalid_cke;
// AXI4 Write Response Channel
reg 					r_bready;

always @(posedge iCLK)
begin
	// adrs
	if (iRST)	r_wcs	<= 1'b0;
	else 		r_wcs	<= 1'b0;

	if (iRST)	r_wbank	<= 3'd0;
	else 		r_wbank	<= 3'd0;

	if (iRST)	r_wrow	<= 17'd0;
	else 		r_wrow	<= 17'd0;

	if (iRST)	r_wcol	<= 10'd0;
	else 		r_wcol	<= 10'd0;

	// Data
	if (iRST)				r_wdata	<= {pAxi4BusWidth{1'b0}};
	else if (q_wseq_cke) 	r_wdata	<= r_wdata + 1'b1;
	else 					r_wdata	<= r_wdata;

	if (iRST) 				r_wlast <= 1'b0;
	else if (qBurstMaxCke)	r_wlast <= 1'b1;
	else					r_wlast <= 1'b0;

	// ready, valid
	if (iRST)				r_awvalid 	<= 1'b0;
	else if (q_awvalid_cke)	r_awvalid 	<= ~r_awvalid;
	else 					r_awvalid 	<=  r_awvalid;

	if (iRST)				r_wvalid 	<= 1'b0;
	else if (q_wvalid_cke)	r_wvalid 	<= ~r_wvalid;
	else 					r_wvalid 	<=  r_wvalid;

	if (iRST)				r_bready 	<= 1'b0;
	else 					r_bready 	<= 1'b1;	// テスト用なので Master は常時 Assert
end

always @(posedge iCLK)
begin
	if (iRST) 				rBurstCnt <= 2'd0;
	else if (q_wseq_cke)	rBurstCnt <= rBurstCnt + 1'b1;
	else 					rBurstCnt <= rBurstCnt;
end

always @*
begin
	casex ( {r_awvalid,i_awready,r_wvalid} )
		'b0x0:		q_awvalid_cke <= 1'b1;	// Assert
		'b11x:		q_awvalid_cke <= 1'b1;	// Dissert
		default: 	q_awvalid_cke <= 1'b0;
	endcase

	casex ( {r_awvalid,qBurstMaxCke,r_wvalid,i_wready} )
		'b1x0x:		q_wvalid_cke <= 1'b1;	// Assert
		'bx111:		q_wvalid_cke <= 1'b1;	// Dissert
		default: 	q_wvalid_cke <= 1'b0;
	endcase
	//
	q_wseq_cke   <= &{r_wvalid,i_wready};	// Master/Slave OK
	qBurstMaxCke <= rBurstCnt == 2'd3;		// Last 信号用
end

assign o_wdata		= r_wdata;
assign o_wlast		= r_wlast;
assign o_wvalid		= r_wvalid;
assign o_wstrb		= {64{1'b1}};
//
assign o_awaddr		= {r_wcs,r_wrow,r_wbank,r_wcol,2'b00};
assign o_awcache	= 4'b0000;
assign o_awqos		= 1'b0;
assign o_awallstrb	= 1'b0;
assign o_awapcmd	= 1'b0;
assign o_awcobuf	= 1'b0;
assign o_awid		= 6'd0;
assign o_awlock		= 1'b0;
assign o_awlen		= 8'd3;
assign o_awsize		= 3'd0;
assign o_awburst	= 2'b01;
assign o_awvalid	= r_awvalid;
//
assign o_bready 	= r_bready;

//-----------------------------------------------------------------------------
// ILA monitor
//-----------------------------------------------------------------------------
reg 		oWcs_mon;
reg [16:0] 	oWrow_mon;
reg [2:0] 	oWbank_mon;
reg [9:0] 	oWcol_mon;
reg 		oAWvalid_mon;
reg 		oWvalid_mon;
reg [31:0] 	oWdata_mon;
reg 		oWlast_mon;
reg 		iAWready_mon;
reg 		iWready_mon;
//
reg [5:0]	iBid_mon;
reg 		oBready_mon;
reg [1:0]	iBresp_mon;
reg 		iBvalid_mon;

always @(posedge iCLK)
begin
	oWcs_mon		<= r_wcs;
	oWrow_mon		<= r_wrow;
	oWbank_mon		<= r_wbank;
	oWcol_mon		<= r_wcol;
	oAWvalid_mon	<= r_awvalid;
	oWvalid_mon		<= r_wvalid;
	oWdata_mon		<= r_wdata[31:0];
	oWlast_mon		<= r_wlast;
	iAWready_mon	<= i_awready;
	iWready_mon		<= i_wready;
	//
	iBid_mon		<= i_bid;
	oBready_mon		<= r_bready;
	iBresp_mon		<= i_bresp;
	iBvalid_mon		<= i_bvalid;
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
reg [pAxi4BusWidth-1:0] r_rdata;
reg 					q_arready;
reg 					q_valid;
reg 					q_radrs_cke;

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

		// if (q_arready)	r_rrow <= r_rrow;
		r_rrow <= r_rrow;

		// if (q_arready)	r_arvalid <= 1'b0;
		// else			r_arvalid <= 1'b1;
		r_arvalid <= 1'b0;

		// if (q_valid) 	r_rready <= 1'b1;
		// else			r_rready <= 1'b0;
		r_rready <= 1'b0;
	end
end

always @*
begin
	q_radrs_cke <= (r_rcol == r_wcol);
	q_arready	<= i_arready;
	q_valid  	<= i_rvalid;
end


//-----------------------------------------------------------------------------
// ILA monitor
//-----------------------------------------------------------------------------
reg [31:0]	oRdata_mon;
reg 		oRcs_mon;
reg [16:0] 	oRrow_mon;
reg [2:0]  	oRbank_mon;
reg [9:0]  	oRcol_mon;
reg 		oARvalid_mon;
reg 		oRready_mon;
reg			iRlast_mon;
reg [5:0]	iRid_mon;
reg [1:0]	iRresp_mon;
reg 		iRvalid_mon;
reg			iARready_mon;

always @(posedge iCLK)
begin
	oRdata_mon		<= r_rdata[31:0];
	oRcs_mon		<= r_rcs;
	oRrow_mon		<= r_rrow;
	oRbank_mon		<= r_rbank;
	oRcol_mon		<= r_rcol;
	oARvalid_mon	<= r_arvalid;
	oRready_mon		<= r_rready;
	iRlast_mon		<= i_rlast;
	iRid_mon		<= i_rid;
	iRresp_mon		<= i_rresp;
	iRvalid_mon		<= i_rvalid;
	iARready_mon	<= i_arready;
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