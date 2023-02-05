/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : axi4_write_sequence.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 03/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module axi4_write_sequence #(
parameter pAxi4BusWidth = 512,
parameter pDataBitWidth	= 16,
parameter pStartAdrs	= 32'h00000000,
parameter pStopAdrs		= 32'h00100000,
parameter pDdrMemSize 	= "4",	// 単位 Gb
parameter pDdrBurstSize = 16,
parameter pAdrsOffset	= pDdrBurstSize * (pDataBitWidth / 8)
)(
// AXI4 Write Address Channel
output[3:0] 				o_awcache,
output 						o_awqos,
output[32:0] 				o_awaddr,
output 						o_awallstrb,
output 						o_awapcmd,
output 						o_awcobuf,
output[5:0] 				o_awid,
output[7:0] 				o_awlen,
output[2:0] 				o_awsize,
output[1:0] 				o_awburst,
output 						o_awlock,
input 						i_awready,
output 						o_awvalid,
// AXI4 Write Data Channel
input 						i_wready,
output[pAxi4BusWidth-1:0] 	o_wdata,
output 						o_wlast,
output[63:0] 				o_wstrb,
output 						o_wvalid,
// AXI4 Write Response Channel
input [5:0] 				i_bid,
input [1:0] 				i_bresp,
output 						o_bready,
input 						i_bvalid,
// Core Login Port
output 						o_wdone,
// common
input 						iRST,
input 						iCLK
);
  

//-----------------------------------------------------------------------------
// AXI4 Transaction
//-----------------------------------------------------------------------------
localparam [3:0] lpBurstLen		= pDdrBurstSize - 1;
localparam [3:0] lpBurstLen2	= pDdrBurstSize - 2;
localparam [7:0] lpDdrBurstSize = pDdrBurstSize - 1'b1;
localparam [2:0] lpDdrArSize    = (pDdrBurstSize == 16) ? 3'b101 : 
								  (pDdrBurstSize ==  8) ? 3'b100 : 
								  (pDdrBurstSize ==  4) ? 3'b010 : 
								  (pDdrBurstSize ==  2) ? 3'b001 : 
														  3'b000 ;
// Core Logic Port
reg [3:0] 				rBurstCnt;
reg 					qBurstMaxCke;
reg 					q_wseq_cke, q_wdata_cke;
reg 					r_wstart, 	q_wstart_cke;
reg 					r_wdone, 	q_wdone_cke;
// AXI4 Write Address Channel
reg 					r_awvalid, q_awvalid_cke;
// AXI4 Write Data Channel
reg [pDataBitWidth-1:0]	r_wdata[0:(pAxi4BusWidth / pDataBitWidth)-1];
reg [pAxi4BusWidth-1:0]	q_wdata;
reg 					r_wlast, q_wlast_cke;
reg 					r_wvalid, q_wvalid_cke;
// AXI4 Write Response Channel
reg 					r_bready, q_bready_cke;
//
genvar x;

generate
	for (x = 0; x < pAxi4BusWidth / pDataBitWidth; x = x + 1)
	begin
		always @(posedge iCLK)
		begin
			if (iRST)				r_wdata[x] <= x;
			else if (q_wdata_cke)	r_wdata[x] <= (pDdrBurstSize <= x) ? 16'h1289 : r_wdata[x] + pDdrBurstSize;
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
	// Write Sequence Start, done
	if (iRST)				r_wstart 	<= 1'b0;
	else if (q_wstart_cke)	r_wstart 	<= ~r_wstart;
	else 					r_wstart 	<=  r_wstart;

	if (iRST)				r_wdone 	<= 1'b0;
	else if (q_wdone_cke)	r_wdone		<= 1'b1;
	else 					r_wdone 	<= 1'b0;

	// Burst Last Data 
	if (iRST|qBurstMaxCke)	rBurstCnt <= 4'd0;
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
end

always @*
begin
	casex ( {r_wstart,r_bready,i_bvalid,r_awvalid,i_awready} )
		'b0xx00:	q_wstart_cke <= 1'b1;	// Assert
		'b111xx:	q_wstart_cke <= 1'b1;	// Dissert
		default: 	q_wstart_cke <= 1'b0;
	endcase

	case ( {r_wstart,r_bready,i_bvalid} )
		'b111:		q_wdone_cke <= 1'b1;
		default: 	q_wdone_cke <= 1'b0;
	endcase
	//
	casex ( {r_wstart,r_awvalid,i_awready} )
		'b00x:		q_awvalid_cke <= 1'b1;	// Assert
		'bx11:		q_awvalid_cke <= 1'b1;	// Dissert
		default: 	q_awvalid_cke <= 1'b0;
	endcase

	casex ( {qBurstMaxCke,r_awvalid,r_wvalid,i_wready} )
		'bx10x:		q_wvalid_cke <= 1'b1;	// Assert
		'b1x11:		q_wvalid_cke <= 1'b1;	// Dissert
		default: 	q_wvalid_cke <= 1'b0;
	endcase

	casex ( {r_wlast,(rBurstCnt == lpBurstLen2),r_wvalid,i_wready} )
		'b0111:		q_wlast_cke <= 1'b1;	// Assert
		'b1x11:		q_wlast_cke <= 1'b1;	// Dissert
		default: 	q_wlast_cke <= 1'b0;
	endcase

	casex ( {r_bready,i_bvalid} )
		'b01:		q_bready_cke <= 1'b1;	// Assert
		'b11:		q_bready_cke <= 1'b1;	// Dissert
		default: 	q_bready_cke <= 1'b0;
	endcase
	//
	q_wdata_cke  <= &{r_bready,i_bvalid};		// next data
	q_wseq_cke   <= &{r_wvalid,i_wready};		// Master/Slave OK
	qBurstMaxCke <= (rBurstCnt == lpBurstLen);	// Last 信号用
end
//

//-----------------------------------------------------------------------------
// Adrs Gen
//-----------------------------------------------------------------------------
wire [32:0] wAdrs;
reg 		qAxi4AdrsCke;

axi4_adrs_generator #(
	.pDataBitWidth(pDataBitWidth),
	.pDdrBurstSize(pDdrBurstSize),
	.pDdrMemSize(pDdrMemSize)
) axi4_adrs_generator (
	.oAdrs(wAdrs),		.oAdrsDone(),
	// common
	.iRST(iRST),		.iCKE(qAxi4AdrsCke),
	.iCLK(iCLK)
);

always @*
begin
	qAxi4AdrsCke <= q_wdata_cke;
end

//-----------------------------------------------------------------------------
// LPDDR4 Hard IP Port
//-----------------------------------------------------------------------------
assign o_wdata		= q_wdata;
assign o_wlast		= r_wlast;
assign o_wvalid		= r_wvalid;
assign o_wstrb		= {64{1'b1}};
assign o_awaddr		= wAdrs;
assign o_awcache	= 4'b0000;
assign o_awqos		= 1'b0;
assign o_awallstrb	= 1'b0;
assign o_awapcmd	= 1'b0;
assign o_awcobuf	= 1'b0;
assign o_awid		= 6'd0;
assign o_awlock		= 1'b0;
assign o_awlen		= lpDdrBurstSize;
assign o_awsize		= lpDdrArSize;
assign o_awburst	= 2'b01;
assign o_awvalid	= r_awvalid;
assign o_bready 	= r_bready;
assign o_wdone  	= r_wdone;
// assign o_wdone  	= &{q_wdone_cke,(r_wdone==1'b1)};

//-----------------------------------------------------------------------------
// ILA monitor
//-----------------------------------------------------------------------------
reg 		qCLK;
reg 		q_awready;	// IP の input 信号は内部 Logic に変換しないと確認不可
reg 		q_wready;
reg [5:0] 	q_bid;
reg [1:0] 	q_bresp;
reg 		q_bvalid;

always @*
begin
	qCLK		<= iCLK;
	q_awready	<= i_awready;
	q_awready	<= i_awready;
	q_wready	<= i_wready;
	q_bid		<= i_bid[5:0];
	q_bresp		<= i_bresp[1:0];
	q_bvalid	<= i_bvalid;
end


// 転送速度確認用カウンタ
reg [7:0] 	rWSpeedMeas;
reg 		rWSpeedMeasSel, qWSpeedMeasSel;

always @(posedge iCLK)
begin
	if (iRST) 					rWSpeedMeas <= 8'd0;
	else if (rWSpeedMeasSel)	rWSpeedMeas <= rWSpeedMeas + 1'b1;
	else 						rWSpeedMeas <= 8'd0;

	if (iRST) 					rWSpeedMeasSel <= 1'd0;
	else if (qWSpeedMeasSel)	rWSpeedMeasSel <= ~rWSpeedMeasSel;
	else 						rWSpeedMeasSel <=  rWSpeedMeasSel;
end

always @*
begin
	casex ( {rWSpeedMeasSel,q_wdone_cke,r_awvalid} )
		'b0x1:		qWSpeedMeasSel <= 1'b1;		// Assert
		'b11x:		qWSpeedMeasSel <= 1'b1;		// Dissert
		default: 	qWSpeedMeasSel <= 1'b0;
	endcase
end

endmodule