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
    parameter pStartAdrs	= 32'h00000000,
    parameter pStopAdrs		= 32'h00100000,
    parameter pBurstSize	= pAxi4BusWidth / pDataBitWidth,
    parameter pAdrsOffset	= pBurstSize * (pDataBitWidth / 8)	// LSB 2bit * DataWidth
)(
// AXI4 Read Address Channel
output[  7:0] 				o_arlen,		// Burst Length, arlen + 1
output[  2:0] 				o_arsize,		// 一回に転送する場バイト数, 8bit * 000=1,001=2,010=4,011=8,100=16,101=32,110=64,111=128
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
output[  2:0] 				o_awsize,		// 一回に転送する場バイト数, 3bit = 1,2,4,8,16,32,64,128
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
// [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
// 
// AXI4 ハンドシェイクのデッドロック回避のため下記ルールに則る
// R/W Valid を '1' にするために、同じグループの Ready 信号を待ってはならない。
// 
// https://www.acri.c.titech.ac.jp/wordpress/archives/8503
// https://www.intel.com/content/www/us/en/docs/programmable/683130/22-2/axi-interface-timing-diagram.html
// https://en.wikipedia.org/wiki/Advanced_eXtensible_Interface#cite_note-axi34difference-10
//---------------------------------------------------------------------------
localparam [3:0] 		lpBurstLen = pBurstSize - 1;

reg [3:0] 				rBurstCnt;
reg 					qBurstMaxCke;
reg 					q_wseq_cke, q_wdata_cke;
reg 					r_wstart, q_wstart_cke;
// AXI4 Write Address Channel
reg 					r_wcs;
reg [16:0]				r_wrow;
reg	[2:0]				r_wbank;
reg [9:0]				r_wcol;
reg 					q_adrs_cke;
reg 					r_awvalid, q_awvalid_cke;
// AXI4 Write Data Channel
// reg [pDataBitWidth-1:0]	r_wdata;
reg [pDataBitWidth-1:0]	r_wdata[0:(pAxi4BusWidth / pDataBitWidth)-1];
reg [pAxi4BusWidth-1:0]	q_wdata;
reg 					r_wlast, q_wlast_cke;
reg 					r_wvalid, q_wvalid_cke;
// AXI4 Write Response Channel
reg 					r_bready, q_bready_cke;
//
genvar x;

generate
	for (x = 0; x < pDataBitWidth; x = x + 1)
	begin
		always @(posedge iCLK)
		begin
			if (iRST)				r_wdata[x] <= x;
			else if (q_wdata_cke)	r_wdata[x] <= r_wdata[x] + pDataBitWidth;
			else 					r_wdata[x] <= r_wdata[x];
		end

		always @*
		begin
			q_wdata[((x+1) * pDataBitWidth)-1:x * pDataBitWidth] <= r_wdata[x];
		end
	end
endgenerate

always @(posedge iCLK)
begin
	// adrs
	if (iRST)	r_wcs	<= 1'b0;
	else 		r_wcs	<= r_wcs;

	if (iRST)	r_wbank	<= 3'd0;
	else 		r_wbank	<= r_wbank;

	if (iRST)	r_wcol	<= 10'd0;
	else 		r_wcol	<= r_wcol;

	if (iRST)				r_wrow	<= 17'd0;
	else if (q_adrs_cke)	r_wrow	<= r_wrow + pAdrsOffset;
	else 					r_wrow	<= r_wrow;

	// Data
	// if (iRST)				r_wdata		<= {pDataBitWidth{1'b0}};
	// else if (q_wdata_cke) 	r_wdata		<= r_wdata + 1'b1;
	// else 					r_wdata		<= r_wdata;

	// Burst Last Data 
	if (iRST) 				rBurstCnt <= 4'd0;
	else if (q_wseq_cke)	rBurstCnt <= rBurstCnt + 1'b1;
	else 					rBurstCnt <= rBurstCnt;

	if (iRST) 				r_wlast 	<= 1'b0;
	else if (q_wlast_cke)	r_wlast 	<= ~r_wlast;
	else					r_wlast 	<=  r_wlast;

	// ready, valid
	if (iRST)				r_awvalid 	<= 1'b0;
	else if (q_awvalid_cke)	r_awvalid 	<= ~r_awvalid;
	else 					r_awvalid 	<=  r_awvalid;

	if (iRST)				r_wvalid 	<= 1'b0;
	else if (q_wvalid_cke)	r_wvalid 	<= ~r_wvalid;
	else 					r_wvalid 	<=  r_wvalid;

	if (iRST)				r_bready 	<= 1'b0;
	else if (q_bready_cke)	r_bready 	<= ~r_bready;
	else 					r_bready 	<=  r_bready;

	// Write Sequence Start
	if (iRST)				r_wstart 	<= 1'b0;
	else if (q_wstart_cke)	r_wstart 	<= ~r_wstart;
	else 					r_wstart 	<=  r_wstart;
end

always @*
begin
	casex ( {r_wstart,r_bready,i_bvalid,r_awvalid,i_arready} )
		'b0xx11:	q_wstart_cke <= 1'b1;	// Assert
		'b111xx:	q_wstart_cke <= 1'b1;	// Dissert
		default: 	q_wstart_cke <= 1'b0;
	endcase

	casex ( {r_wstart,r_awvalid,i_awready} )
		'b00x:		q_awvalid_cke <= 1'b1;	// Assert
		'bx11:		q_awvalid_cke <= 1'b1;	// Dissert
		default: 	q_awvalid_cke <= 1'b0;
	endcase

	casex ( {qBurstMaxCke,r_wstart,r_awvalid,r_wvalid,i_wready} )
		'bx010x:	q_wvalid_cke <= 1'b1;	// Assert
		'b1xx11:	q_wvalid_cke <= 1'b1;	// Dissert
		default: 	q_wvalid_cke <= 1'b0;
	endcase

	casex ( {r_wlast,(rBurstCnt == 4'd14),r_wvalid,i_wready} )
		'b0111:		q_wlast_cke <= 1'b1;	// Assert
		'b1x11:		q_wlast_cke <= 1'b1;	// Dissert
		default: 	q_wlast_cke <= 1'b0;
	endcase

	case ( {r_wstart,r_bready,i_bvalid} )
		'b111:		q_adrs_cke <= 1'b1;
		default: 	q_adrs_cke <= 1'b0;
	endcase

	casex ( {r_bready,i_bvalid} )
		'b01:		q_bready_cke <= 1'b1;	// Assert
		'b11:		q_bready_cke <= 1'b1;	// Dissert
		default: 	q_bready_cke <= 1'b0;
	endcase
	//
	q_wdata_cke  <= &{r_bready,i_bvalid};
	q_wseq_cke   <= &{r_wvalid,i_wready};		// Master/Slave OK
	qBurstMaxCke <= rBurstCnt == lpBurstLen;	// Last 信号用
end
//
assign o_wdata		= q_wdata;
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
assign o_awlen		= 8'd15;
assign o_awsize		= 3'b101;
assign o_awburst	= 2'b01;
assign o_awvalid	= r_awvalid;
//
assign o_bready 	= r_bready;

//-----------------------------------------------------------------------------
// ILA monitor
//-----------------------------------------------------------------------------
reg 		rAWready_mon;
reg 		rWready_mon;
//
reg [5:0]	rBid_mon;
reg [1:0]	rBresp_mon;
reg 		rBvalid_mon;

always @(posedge iCLK)
begin
	rAWready_mon<= i_awready;
	rWready_mon	<= i_wready;
	//
	rBid_mon	<= i_bid;
	rBresp_mon	<= i_bresp;
	rBvalid_mon	<= i_bvalid;
end

//-----------------------------------------------------------------------------
// Read Cycle
// [32] CS, [31:15] Row = 17bit, [14:12] Bank, [11:2] Col =10 bit, [1:0] Datapath
//-----------------------------------------------------------------------------
reg 					r_rstart, q_rstart_cke;
reg 					q_radrs_cke;
// AXI4 Read Address Channel
reg 					r_rcs;
reg [16:0]				r_rrow;
reg	[2:0]				r_rbank;
reg [9:0]				r_rcol;
reg 					r_arvalid, q_arvalid_cke;
// AXI4 Read Data Channel
reg 					r_rready, q_rready_cke;
reg [pDataBitWidth-1:0]	r_rdata[0:(pAxi4BusWidth / pDataBitWidth)-1], q_rdata[0:(pAxi4BusWidth / pDataBitWidth)-1];

generate
	for (x = 0; x < pDataBitWidth; x = x + 1)
	begin
		always @(posedge iCLK)
		begin
			if (i_rvalid)	r_rdata[x] <= q_rdata[x];
			else 			r_rdata[x] <= r_rdata[x];
		end

		always @*
		begin
			q_rdata[x] <= i_rdata[((x+1) * pDataBitWidth)-1:x * pDataBitWidth];
		end
	end
endgenerate

always @(posedge iCLK)
begin
	// adrs
	if (iRST)	r_rcs	<= 1'b0;
	else 		r_rcs	<= r_rcs;

	if (iRST)	r_rbank	<= 1'b0;
	else 		r_rbank	<= r_rbank;

	if (iRST)	r_rcol	<= 1'b0;
	else 		r_rcol	<= r_rcol;

	if (iRST)				r_rrow	<= 1'b0;
	else if (q_radrs_cke)	r_rrow	<= r_rrow + pAdrsOffset;
	else 					r_rrow	<= r_rrow;


	// ready,valid
	if (iRST) 				r_arvalid 	<= 1'b0;
	else if (q_arvalid_cke)	r_arvalid 	<= ~r_arvalid;
	else 					r_arvalid 	<=  r_arvalid;

	if (iRST) 				r_rready 	<= 1'b0;
	else if (q_rready_cke)	r_rready	<= ~r_rready;
	else 					r_rready 	<=  r_rready;

	// バストランザクション start
	if (iRST)				r_rstart	<= 1'b0;
	else if (q_rstart_cke)	r_rstart	<= ~r_rstart;
	else 					r_rstart	<=  r_rstart;
end

always @*
begin
	casex ( {r_rstart,r_rready,i_rlast,i_rvalid,r_arvalid,i_arready} )
		'b0xxx11:	q_rstart_cke <= 1'b1;	// Assert
		'b1111xx:	q_rstart_cke <= 1'b1;	// Dissert
		default: 	q_rstart_cke <= 1'b0;
	endcase

	casex ( {qBurstMaxCke,r_rstart,r_arvalid,i_arready} )
		'b100x:		q_arvalid_cke <= 1'b1;	// Assert
		'bxx11:		q_arvalid_cke <= 1'b1;	// Dissert
		default: 	q_arvalid_cke <= 1'b0;
	endcase

	casex ( {r_rready,i_rlast,i_rvalid,r_arvalid,i_arready} )
		'b0xx11:	q_rready_cke <= 1'b1;	// Assert
		'b111xx:	q_rready_cke <= 1'b1;	// Dissert
		default: 	q_rready_cke <= 1'b0;
	endcase

	// case ( {r_rready,i_rlast,i_rvalid} )
	casex ( {r_rstart,r_rready,i_rlast,i_rvalid} )
		'b1111:		q_radrs_cke <= 1'b1;	// アドレス更新
		default: 	q_radrs_cke <= 1'b0;
	endcase
end

assign o_araddr		= {r_rcs,r_rrow,r_rbank,r_rcol,2'b00};
assign o_arqos		= 1'b0;
assign o_arapcmd	= 1'b0;
assign o_arid		= 6'd0;
assign o_arlock		= 1'b0;
assign o_arlen		= 8'd0;
assign o_arsize		= 3'b101;
assign o_arburst	= 2'b00;	// adrs auto inc
assign o_arvalid	= r_arvalid;
assign o_rready 	= r_rready;


//-----------------------------------------------------------------------------
// ILA monitor
//-----------------------------------------------------------------------------
reg			rRlast_mon;
reg [5:0]	rRid_mon;
reg [1:0]	rRresp_mon;
reg 		rRvalid_mon;
reg			rARready_mon;

always @(posedge iCLK)
begin
	rRlast_mon	<= i_rlast;
	rRid_mon	<= i_rid;
	rRresp_mon	<= i_rresp;
	rRvalid_mon	<= i_rvalid;
	rARready_mon<= i_arready;
end


//-----------------------------------------------------------------------------
// test monitor
//-----------------------------------------------------------------------------
localparam lpCntRunBitWidth = 23;

reg [lpCntRunBitWidth-1:0] 	rCntRun;
reg 						rCntRunSel, qCntRunCke;
reg [pDataBitWidth-1:0] 	q_test_done;

always @(posedge iCLK)
begin
	if (iRST)				rCntRunSel <= 1'b1;
	else if (qCntRunCke)	rCntRunSel <= ~rCntRunSel;
	else 					rCntRunSel <=  rCntRunSel;

	if (iRST)		 		rCntRun <= {lpCntRunBitWidth{1'b0}};
	else if (qCntRunCke) 	rCntRun <= {lpCntRunBitWidth{1'b0}};
	else 				 	rCntRun <= rCntRun + 1'b1;
end

always @*
begin
	qCntRunCke <= ({lpCntRunBitWidth{1'b1}} == rCntRun);
end

generate
	for (x = 0; x < pDataBitWidth; x = x + 1) begin
		always @*
		begin
			q_test_done[x] <= &{r_rdata[x]};
		end
	end
endgenerate

assign o_test_run  = rCntRunSel;
assign o_test_fail = 1'b0;
assign o_test_done = &{q_test_done};


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