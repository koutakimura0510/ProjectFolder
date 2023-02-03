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
// Core Logic Port
output[pAxi4BusWidth-1:0]	o_rdata,
input 						i_wdone,
// common
input 						iRST,
input 						iCLK
);
  
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
reg [pDataBitWidth-1:0]	r_rdata[0:(pAxi4BusWidth / pDataBitWidth)-1];
reg [pAxi4BusWidth-1:0] q_rdata;

genvar x;

generate
	for (x = 0; x < pDataBitWidth; x = x + 1)
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
assign o_rdata		= q_rdata;


//-----------------------------------------------------------------------------
// ILA monitor
//-----------------------------------------------------------------------------
reg 		rIlaMon;
reg 		q_arready;
reg 		q_rvalid;
reg [5:0] 	q_rid;
reg [1:0] 	q_rresp;
reg 		q_rrast;

always @(posedge iCLK)
begin
	if (iRST)	rIlaMon <= 1'b0;
	else 		rIlaMon <= 1'b1;
end

always @*
begin
	q_arready	<= &{rIlaMon,i_arready};
	q_rvalid	<= &{rIlaMon,i_rvalid};
	q_rid		<= {6{rIlaMon}} & i_rid[5:0];
	q_rresp		<= {2{rIlaMon}} & {i_rresp[1:0]};
	q_rrast		<= &{rIlaMon,i_rlast};
end



endmodule