/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : ddr_reset_sequencer.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 03/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module ddr_reset_sequencer #(
parameter	pStartCntBitWidth	= 8,
parameter	pDdrCfgDoneThru		= "no"
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
reg 						qDdrCfgDone;
reg [pStartCntBitWidth-1:0] rSeqCnt;
reg  						qSeqMaxCke;

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
				rs      			<= (qSeqMaxCke) ? lpStart : lpReset;
				rSeqCnt 			<= (qSeqMaxCke) ? {pStartCntBitWidth{1'b0}} : rSeqCnt + 1'b1;
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b0;
				r_ddr_init_done		<= 1'b0;
			end

			lpStart:
			begin
				rs 					<= (qDdrCfgDone) ? lpDone : lpStart;
				rSeqCnt 			<= rSeqCnt + 1'b1;
				r_ddr_axi_rstn		<= 1'b0;
				r_ddr_cfg_seq_rst	<= 1'b0;
				r_ddr_cfg_seq_start	<= 1'b1;
				r_ddr_init_done		<= 1'b0;
			end

			lpDone:
			begin
				rs 					<= rs;
				rSeqCnt 			<= {pStartCntBitWidth{1'b0}};
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
	qSeqMaxCke <= (rSeqCnt == {pStartCntBitWidth{1'b1}});
end

generate
begin
	if (pDdrCfgDoneThru == "yes")
	begin
		always @*
		begin
			qDdrCfgDone <= qSeqMaxCke;
		end
	end
	else
	begin
		always @*
		begin
			qDdrCfgDone <= i_ddr_cfg_done;
		end
	end
end
endgenerate

endmodule