/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : axi4_read_sequence.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 03/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module axi4_read_sequence #(
parameter pAxi4BusWidth = 512,
parameter pDataBitWidth	= 16,
parameter pStartPage	= 0,
parameter pStopPage		= 1024,
parameter pStartBank	= 0,
parameter pStopBank		= 7,
parameter pDdrMemSize 	= "4",
parameter pMemoryTest	= "yes",
parameter pDdrBurstSize = 16
)(
// AXI4 Read Address Channel
output[  7:0] 				o_arlen,
output[  2:0] 				o_arsize,
output[  1:0] 				o_arburst,
output[ 32:0] 				o_araddr,
input 						i_arready,
output 						o_arvalid,
output[  5:0] 				o_arid,
output 						o_arlock,
output 						o_arqos,
output 						o_arapcmd,
// AXI4 Read Data Channel
input [pAxi4BusWidth-1:0] 	i_rdata,
input [  5:0] 				i_rid,
input 						i_rlast,
input [  1:0] 				i_rresp,
output 						o_rready,
input 						i_rvalid,
// Core Logic Port
output[pAxi4BusWidth-1:0]	o_rdata,
output 						o_rvalid,
input 						i_wdone,
// common
input 						iRST,
input 						iCLK
);
  
//-----------------------------------------------------------------------------
// AXI4 Transaction
//-----------------------------------------------------------------------------
localparam [7:0] lpDdrBurstSize = pDdrBurstSize - 1'b1;
localparam [2:0] lpDdrArSize    = (pAxi4BusWidth == 512) ? 3'b110 : 
								  (pDdrBurstSize == 256) ? 3'b101 : 
								  (pDdrBurstSize == 128) ? 3'b100 : 
														   3'b000 ;
// Core Logic Port
reg 					r_rstart, q_rstart_cke;
// AXI4 Read Address Channel
reg 					r_arvalid, q_arvalid_cke;
// AXI4 Read Data Channel
reg [pDataBitWidth-1:0]	r_rdata[0:(pAxi4BusWidth / pDataBitWidth)-1];
reg [pAxi4BusWidth-1:0] q_rdata;
reg 					r_rready, q_rready_cke;
reg 					r_rvalid;
//
genvar x;

generate // rdata を 512bit幅の データに convert
	for (x = 0; x < pAxi4BusWidth / pDataBitWidth; x = x + 1)
	begin
		always @(posedge iCLK)
		begin
			if (i_rvalid)	r_rdata[x] <= i_rdata[((x+1) * pDataBitWidth)-1:x * pDataBitWidth];
			else 			r_rdata[x] <= r_rdata[x];
		end

		always @*
		begin
			q_rdata[((x+1) * pDataBitWidth)-1:x * pDataBitWidth] <= r_rdata[x];
		end
	end
endgenerate

always @(posedge iCLK)
begin
	if (iRST)				r_rstart	<= 1'b0;
	else if (q_rstart_cke)	r_rstart	<= ~r_rstart;
	else 					r_rstart	<=  r_rstart;

	if (iRST) 				r_arvalid 	<= 1'b0;
	else if (q_arvalid_cke)	r_arvalid 	<= ~r_arvalid;
	else 					r_arvalid 	<=  r_arvalid;

	if (iRST) 				r_rready 	<= 1'b0;
	else if (q_rready_cke)	r_rready	<= ~r_rready;
	else 					r_rready 	<=  r_rready;

	if (iRST) 				r_rvalid 	<= 1'b0;
	else 					r_rvalid 	<= i_rvalid;	// 後段への有効データ転送タイミング調整
end

always @*
begin
	casex ( {r_rstart,r_rready,i_rlast,i_rvalid,r_arvalid,i_arready} )
		'b0xxx11:	q_rstart_cke <= 1'b1;	// Assert
		'b1111xx:	q_rstart_cke <= 1'b1;	// Dissert
		default: 	q_rstart_cke <= 1'b0;
	endcase

	casex ( {i_wdone,r_rstart,r_arvalid,i_arready} )
		'b100x:		q_arvalid_cke <= 1'b1;	// Assert
		'bxx11:		q_arvalid_cke <= 1'b1;	// Dissert
		default: 	q_arvalid_cke <= 1'b0;
	endcase

	casex ( {r_rready,i_rlast,i_rvalid,r_arvalid,i_arready} )
		'b0xx11:	q_rready_cke <= 1'b1;	// Assert
		'b111xx:	q_rready_cke <= 1'b1;	// Dissert
		default: 	q_rready_cke <= 1'b0;
	endcase
end


//-----------------------------------------------------------------------------
// Adrs Gen
//-----------------------------------------------------------------------------
wire [32:0] wAdrs;
reg 		qAxi4AdrsCke;

axi4_adrs_generator #(
	.pDataBitWidth(pDataBitWidth),
	.pDdrBurstSize(pDdrBurstSize),
	.pStartPage(pStartPage),
	.pStopPage(pStopPage),
	.pStartBank(pStartBank),
	.pStopBank(pStopBank),
	.pDdrMemSize(pDdrMemSize),
	.pMemoryTest(pMemoryTest)
) axi4_adrs_generator (
	.oAdrs(wAdrs),		.oAdrsDone(),
	// common
	.iRST(iRST),		.iCKE(qAxi4AdrsCke),
	.iCLK(iCLK)
);

always @*
begin
	casex ( {r_rstart,r_rready,i_rlast,i_rvalid} )
		'b1111:		qAxi4AdrsCke <= 1'b1;	// アドレス更新
		default: 	qAxi4AdrsCke <= 1'b0;
	endcase
end


//-----------------------------------------------------------------------------
// LPDDR4 Hard IP Port
//-----------------------------------------------------------------------------
assign o_araddr		= wAdrs;
assign o_arqos		= 1'b0;
assign o_arapcmd	= 1'b0;
assign o_arid		= 6'd0;
assign o_arlock		= 1'b0;
assign o_arlen		= lpDdrBurstSize;
assign o_arsize		= lpDdrArSize;
assign o_arburst	= 2'b01;	// adrs auto inc
assign o_arvalid	= r_arvalid;
assign o_rready 	= r_rready;
//
assign o_rdata		= q_rdata;
assign o_rvalid		= r_rvalid;


//-----------------------------------------------------------------------------
// ILA monitor
//-----------------------------------------------------------------------------
reg 		q_arready;
reg 		q_rvalid;
reg [5:0] 	q_rid;
reg [1:0] 	q_rresp;
reg 		q_rrast;

always @*
begin
	q_arready	<= i_arready;
	q_rvalid	<= i_rvalid;
	q_rid		<= i_rid[5:0];
	q_rresp		<= i_rresp[1:0];
	q_rrast		<= i_rlast;
end

// 転送速度確認用カウンタ
reg [7:0] 	rRSpeedMeas;
reg 		rRSpeedMeasSel, qRSpeedMeasSel;

always @(posedge iCLK)
begin
	if (iRST) 					rRSpeedMeas <= 8'd0;
	else if (rRSpeedMeasSel)	rRSpeedMeas <= rRSpeedMeas + 1'b1;
	else 						rRSpeedMeas <= 8'd0;

	if (iRST) 					rRSpeedMeasSel <= 1'd0;
	else if (qRSpeedMeasSel)	rRSpeedMeasSel <= ~rRSpeedMeasSel;
	else 						rRSpeedMeasSel <=  rRSpeedMeasSel;
end

always @*
begin
	casex ( {rRSpeedMeasSel,i_rvalid,i_rlast,r_arvalid} )
		'b0xx1:		qRSpeedMeasSel <= 1'b1;		// Assert
		'b111x:		qRSpeedMeasSel <= 1'b1;		// Dissert
		default: 	qRSpeedMeasSel <= 1'b0;
	endcase
end



endmodule