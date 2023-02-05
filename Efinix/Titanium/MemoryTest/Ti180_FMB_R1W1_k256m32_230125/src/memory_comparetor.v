/*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*
 *
 * File Name   : memory_comparetor.v
 * Description : 
 * Simulator   : VeritakWin Ver.3.84D Build May.23.2011
 * Implem. Tool: Efinity 2022.2.322.1.8
 * Explanation : Rev.1.0
 * Revision    :
 * 04/Feb-2023 New Release(Rev. 0.10)                                  K.Kimura
 *
 *~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*~`^*/
//---------------------------------------------------------------------------
module memory_comparetor #(
	parameter pAxi4BusWidth = 512,
    parameter pDataBitWidth	= 32,
	parameter pDdrBurstSize = 16
)(
// Core Logic Port
input [pAxi4BusWidth-1:0]	i_rdata,
output 						o_test_fail,
output 						o_test_done,
// common
input 						iRST,
input 						iCKE,			// valid data
input 						iCLK
);


//-----------------------------------------------------------------------------
// DDR ReadData Compere
//-----------------------------------------------------------------------------
reg [pDataBitWidth-1:0]	r_wdata[0:(pAxi4BusWidth / pDataBitWidth)-1];
reg [pAxi4BusWidth-1:0]	q_wdata;
reg [pDataBitWidth-1:0]	q_rdata[0:(pAxi4BusWidth / pDataBitWidth)-1];
reg [pDdrBurstSize-1:0] r_comp;
//
genvar x;

generate
	for (x = 0; x < pAxi4BusWidth / pDataBitWidth; x = x + 1)
	begin
		always @(posedge iCLK)
		begin
			if (iRST)		r_wdata[x] <= x;
			else if (iCKE)	r_wdata[x] <= (pDdrBurstSize <= x) ? 16'h1289 : r_wdata[x] + pDdrBurstSize;
			else 			r_wdata[x] <= r_wdata[x];

			if (iRST)		r_comp[x] <= 1'b1;
			else if (iCKE)	r_comp[x] <= {r_wdata[x] == q_rdata[x]};
			else 			r_comp[x] <= r_comp[x];
		end

		always @*
		begin
			q_wdata[((x+1) * pDataBitWidth)-1:x * pDataBitWidth] <= r_wdata[x];
			q_rdata[x] <= i_rdata[((x+1) * pDataBitWidth)-1:x * pDataBitWidth];
		end
	end
endgenerate


//-----------------------------------------------------------------------------
// Test Done / Fail
//-----------------------------------------------------------------------------
reg r_test_fail, q_test_fail;				assign o_test_fail = r_test_fail;
reg r_test_done, q_test_done;				assign o_test_done = r_test_done;

always @(posedge iCLK)
begin
	if (iRST) 				r_test_fail <= 1'b0;
	else if (q_test_fail)	r_test_fail <= 1'b1;
	else 					r_test_fail <= r_test_fail;

	if (iRST) 				r_test_done <= 1'b0;
	else if (q_test_done)	r_test_done <= 1'b1;
	else 					r_test_done <= r_test_done;
end

always @*
begin
	case ( {r_test_fail,&{r_comp[pDdrBurstSize-1:0]}} )
		'b00: 		q_test_fail <= 1'b1;
		default: 	q_test_fail <= 1'b0;
	endcase

	q_test_done <= 1'b0;
end

endmodule