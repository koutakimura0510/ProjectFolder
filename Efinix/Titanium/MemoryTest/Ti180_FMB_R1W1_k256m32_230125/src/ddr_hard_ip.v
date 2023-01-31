/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : ddr_hard_ip.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 01/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module ddr_hard_ip #(
parameter	pStartCntBitWidth	= 8
)(
input 		i_ddr_cfg_done,		// DDR_CFG_DONE
/* Connect these three signals to DDR reset interface */
output 		o_ddr_axi_rstn,		// Master Reset
output 		o_ddr_cfg_reset,	// Sequencer Reset
output 		o_ddr_cfg_start,	// Sequencer Start
output 		o_ddr_cfg_done,		// Done status
// common
input 		inRST,
input 		iCLK				// user clock
);



//-----------------------------------------------------------------------------
// CFG Aequenser RESET, START
//-----------------------------------------------------------------------------
localparam 
	lpReset = 2'd0,
	lpStart = 2'd1,
	lpDone 	= 2'd2;

reg r_ddr_axi_rstn;							assign o_ddr_axi_rstn 		= r_ddr_axi_rstn;
reg r_ddr_cfg_seq_rst;						assign o_ddr_cfg_reset		= r_ddr_cfg_seq_rst;
reg r_ddr_cfg_seq_start;					assign o_ddr_cfg_start		= r_ddr_cfg_seq_start;
reg r_ddr_init_done;						assign o_ddr_cfg_done 		= r_ddr_init_done;
//
reg [1:0] rs;
reg [pStartCntBitWidth-1:0] rSeqCnt;
reg rSeqMaxCke;

initial
begin
	r_ddr_axi_rstn		<= 1'b0;
	r_ddr_cfg_seq_rst	<= 1'b1;
	r_ddr_cfg_seq_start	<= 1'b0;
end

always @(posedge iCLK, negedge inRST)
begin
	if (!inRST)
	begin
		rs      			<= lpReset;
		rSeqCnt 			<= {pStartCntBitWidth{1'b0}};
		r_ddr_axi_rstn		<= 1'b0;
		r_ddr_cfg_seq_rst	<= 1'b1;
		r_ddr_cfg_seq_start	<= 1'b0;
		r_ddr_init_done		<= 1'b0;
	end
	else
	begin
		case ( rs )
			lpReset:
			begin
				rs      			<= (rSeqMaxCke) ? lpStart : lpReset;
				rSeqCnt 			<= (rSeqMaxCke) ? {pStartCntBitWidth{1'b0}} : rSeqCnt + 1'b1;
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b0;
				r_ddr_init_done		<= 1'b0;
			end

			lpStart:
			begin
				rs 					<= (i_ddr_cfg_done) ? lpDone : lpStart;
				rSeqCnt 			<= rSeqCnt;
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b1;
				r_ddr_init_done		<= 1'b0;
			end

			lpDone:
			begin
				rs 					<= rs;
				rSeqCnt 			<= rSeqCnt;
				r_ddr_axi_rstn		<= 1'b1;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b1;
				r_ddr_init_done		<= 1'b1;
			end

			default:
			begin
				rs      			<= lpReset;
				rSeqCnt 			<= {pStartCntBitWidth{1'b0}};
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b1;
				r_ddr_cfg_seq_start	<= 1'b0;
				r_ddr_init_done		<= 1'b0;
			end
		endcase
	end
end

always @*
begin
	rSeqMaxCke <= (rSeqCnt == {pStartCntBitWidth{1'b1}});
end
endmodule