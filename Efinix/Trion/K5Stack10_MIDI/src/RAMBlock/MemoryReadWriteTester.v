/*-----------------------------------------------------------------------------
 * Create  2023/4/29
 * Author  koutakimura
 * -
 * メモリ制御テスト検証 module
 * V1.0 : new Relaese
 * 
 *-----------------------------------------------------------------------------*/
module MemoryReadWriteTester #(
	parameter pRamAdrsWidth = 18,
	parameter pRamDqWidth = 16
)(
	// R/W Signal
	output [31:0] oAdrs,
	output [pRamDqWidth-1:0] oWd,
	input  iWEd,
	input  [pRamDqWidth-1:0] iRd,
	input  iREd,
	// Status
	output oErr,
	output oDone,
	// CLK Reset
    input  iRST,
    input  iCLK
);


//-----------------------------------------------------------------------------
// Read Write Tester State
//-----------------------------------------------------------------------------
localparam [1:0]
	lpIDOL  = 0,
	lpWRITE = 1,
	lpREAD  = 2;

reg  [1:0] rState;
reg  [pRamAdrsWidth-1:0] rAdrs;
reg  [pRamDqWidth-1:0] rWd, rRd;
reg  rCmd;
reg  rCe;
reg  rDone;
reg  qMaxAdrs;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rState 	<= lpIDOL;
		rAdrs  	<= {pRamAdrsWidth{1'b0}};
		rWd 	<= {pRamDqWidth{1'b0}};
		rRd 	<= {pRamDqWidth{1'b0}};
		rCmd 	<= 1'b0;
		rCe 	<= 1'b0;
		rDone 	<= 1'b0;
	end
	else
	begin
		case (rState)
			lpIDOL:
			begin
				rState 	<= lpWRITE;
				rAdrs  	<= {pRamAdrsWidth{1'b0}};
				rWd 	<= {pRamDqWidth{1'b0}};
				rRd 	<= {pRamDqWidth{1'b0}};
				rCmd 	<= 1'b0;
				rCe 	<= 1'b0;
				rDone 	<= 1'b0;
			end 

			lpWRITE:
			begin
				if (iWEd)
				begin
					rState 	<= qMaxAdrs ? lpREAD : lpWRITE;
					rAdrs  	<= rAdrs + 1'b1;
					rWd 	<= rWd + 1'b1;
					rCmd 	<= qMaxAdrs ? 1'b1 : 1'b0;
					rCe 	<= qMaxAdrs ? 1'b0 : 1'b1;
				end
				else
				begin
					rState 	<= lpWRITE;
					rAdrs  	<= rAdrs;
					rWd 	<= rWd;
					rCmd 	<= 1'b0;
					rCe 	<= 1'b0;
				end
				rRd 	<= {pRamDqWidth{1'b0}};
				rDone 	<= 1'b0;
			end

			lpREAD:
			begin
				rState <= qMaxAdrs ? lpIDOL : lpREAD;
				
				if (iREd)
				begin
					rAdrs 	<= rAdrs + 1'b1;
					rRd 	<= iRd;
				end
				else
				begin
					rAdrs 	<= rAdrs;
					rRd 	<= rRd;
				end

				rCmd 	<= qMaxAdrs ? 1'b0 : 1'b1;
				rCe  	<= qMaxAdrs ? 1'b0 : 1'b1;
				rDone 	<= qMaxAdrs ? 1'b1 : 1'b0;
			end

			default:
			begin
				rState 	<= lpIDOL;
				rAdrs  	<= {pRamAdrsWidth{1'b0}};
				rWd 	<= {pRamDqWidth{1'b0}};
				rRd 	<= {pRamDqWidth{1'b0}};
				rCmd 	<= 1'b0;
				rCe 	<= 1'b0;
				rDone 	<= 1'b0;
			end
		endcase
	end
end

always @*
begin
	qMaxAdrs <= rAdrs == {pRamAdrsWidth{1'b1}};
end


//-----------------------------------------------------------------------------
// Comparetor
//-----------------------------------------------------------------------------
reg  [pRamDqWidth-1:0] rComp;
reg  [1:0] rREd;
reg  rErr, qErrCke;

always @(posedge iCLK)
begin
	rREd <= {rREd[0],iREd};

	if (iRST | (rState != lpREAD & ~iREd)) 	rComp <= {pRamDqWidth{1'b0}};
	else if (rREd[1] & (rState == lpREAD))	rComp <= rComp + 1'b1;
	else 			rComp <= rComp;

	if (iRST) 			rErr <= 1'b0;
	else if (qErrCke)	rErr <= 1'b1;
	else 				rErr <= rErr;
end

always @*
begin
	qErrCke <= iREd & (rComp != iRd) & (rState == lpREAD);
end


assign oAdrs = rAdrs;
assign oAdrs[30] = rCmd;
assign oAdrs[31] = rCe;
assign oWd = rWd;
assign oDone = rDone;
assign oErr = rErr;

endmodule