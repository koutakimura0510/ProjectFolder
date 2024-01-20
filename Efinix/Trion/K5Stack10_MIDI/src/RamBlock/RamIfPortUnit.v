/**-----------------------------------------------------------------------------
 * HyperRam Port Unit
 * https://www.infineon.com/dgdl/Infineon-AN226576_-_Getting_started_with_HYPERRAM_TM_JA-ApplicationNotes-v02_00-JA.pdf?fileId=8ac78c8c7cdc391c017d0d3995ec66e2
 * 
 * 23-04-04 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module RAMIfPortUnit #(
	parameter pRamDqWidth = 16,
)(
	// RAM I/F Port
	output	[pRamDqWidth-1:0] oRawDq,
	input	[pRamDqWidth-1:0] iRamDq,
	output	oRamDq_OE,
	output	oRamClk,
	output	oRamCe,
	// Write Port
	input	[15:0] 	iWd,
	input	[23:0]	iWa,
	input			iWvd,
	output			oWRdy,
	// Read Port
	output	[15:0] 	oRd,
	output			oVd,
    // Clk Reset
	input	iRST,
	input	iCKE,
	input	iCLK
);

/**----------------------------------------------------------------------------
 *---------------------------------------------------------------------------*/

/**----------------------------------------------------------------------------
 * Config Dq
 *---------------------------------------------------------------------------*/
localparam [3:0]
	lpCfgMode	= 0,
	lpIdol		= 1,
	lpQuadAdrs	= 2,
	lpQuadRead	= 3,
	lpQuadWrite	= 4,
	lpDone		= 5;
	
reg [3:0]	rSt;			reg qNextSt;
reg [10:0]	rDqCnt;
reg [15:0] 	rRamDq;
reg			rSeqStart;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSt <= lpCfgMode;
	end
	else
	begin
		case (rSt)
			lpCfgMode:
			begin
				rSt <= qNextSt ? lpIdol : lpCfgMode;
			end
			
			lpIdol:
			begin
				rSt <= qNextSt ? : lpCfgMode;
			end
			
			lpQuadAdrs:
			begin
				
			end
			
			lpQuadRead:
			begin
				
			end
			
			lpQuadWrite:
			begin
				
			end
			
			lpDone:
			begin
				
			end
			
			default: 
			begin
				
			end
		endcase
	end
	if (wCfgDone) 	rRamDq <= 16'h0035;
	else			rRamDq <= iWd;
end


assign oRawDq	 = iRamDq;
assign oRamDq_OE = 1'b0;
assign oRamClk	 = 1'b0;
assign oRamCe	 = 1'b0;

assign oRd = 0;
assign oRvd = 0;

endmodule