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
	lpWIDOL = 0,
	lpWRITE = 1,
	lpRIDOL = 2,
	lpREAD  = 3;

reg  [1:0] rState;
reg  [pRamAdrsWidth-1:0] rAdrs;
reg  [pRamDqWidth-1:0] rWd;
reg  rCmd;
reg  rCe;
reg  rDone;
reg  qMaxAdrs;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rState 	<= lpWIDOL;
		rAdrs  	<= {pRamAdrsWidth{1'b0}};
		rWd 	<= {pRamDqWidth{1'b0}};
		rCmd 	<= 1'b0;
		rCe 	<= 1'b0;
		rDone 	<= 1'b0;
	end
	else
	begin
		case (rState)
			lpWIDOL:
			begin
				if (iWEd)
				begin
					rState 	<= lpWRITE;
					rCe 	<= 1'b1;
				end
				else
				begin
					rState 	<= lpWIDOL;
					rCe 	<= 1'b0;
				end
				rAdrs  	<= {pRamAdrsWidth{1'b0}};
				rWd 	<= {pRamDqWidth{1'b0}};
				rCmd 	<= 1'b0;
				rDone 	<= 1'b0;
			end

			lpWRITE:
			begin
				if (iWEd)
				begin
					rState 	<= qMaxAdrs ? lpRIDOL : lpWRITE;
					rAdrs  	<= qMaxAdrs ? {pRamAdrsWidth{1'b0}} : rAdrs + 1'b1;
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
				rDone 	<= 1'b0;
			end

			lpRIDOL:
			begin
				if (iWEd)
				begin
					rState 	<= lpREAD;
					rCe 	<= 1'b1;
				end
				else
				begin
					rState 	<= lpRIDOL;
					rCe 	<= 1'b0;
				end
				rAdrs  	<= {pRamAdrsWidth{1'b0}};
				rWd 	<= {pRamDqWidth{1'b0}};
				rCmd 	<= 1'b1;
				rDone 	<= 1'b0;
			end

			lpREAD:
			begin
				rState <= qMaxAdrs ? lpWIDOL : lpREAD;
				
				if (iWEd)
				begin
					rAdrs 	<= qMaxAdrs ? {pRamAdrsWidth{1'b0}} : rAdrs + 1'b1;
					rCe  	<= qMaxAdrs ? 1'b0 : 1'b1;
				end
				else
				begin
					rAdrs 	<= rAdrs;
					rCe  	<= 1'b0;
				end

				rCmd 	<= qMaxAdrs ? 1'b0 : 1'b1;
				rDone 	<= qMaxAdrs ? 1'b1 : 1'b0;
			end

			default:
			begin
				rState 	<= lpWIDOL;
				rAdrs  	<= {pRamAdrsWidth{1'b0}};
				rWd 	<= {pRamDqWidth{1'b0}};
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
reg  [pRamDqWidth-1:0] rComp, rRd;
reg  rErr, qErrCke;

always @(posedge iCLK)
begin
	if (iRST) 		rRd <= {pRamDqWidth{1'b0}};
	else if (iREd)	rRd <= iRd;
	else 			rRd	<= rRd;

	casex ({iRST,(rState==lpREAD),iREd})
		'b1xx: 		rComp <= {pRamDqWidth{1'b0}};
		'bx0x: 		rComp <= {pRamDqWidth{1'b0}};
		'b011:		rComp <= rComp + 1'b1;
		default: 	rComp <= rComp;
	endcase

	if (iRST) 			rErr <= 1'b0;
	else if (qErrCke)	rErr <= 1'b1;
	else 				rErr <= rErr;
end

always @*
begin
	casex ({iREd,(rComp==iRd),(rState==lpREAD)})
		'b101: 	 qErrCke <= 1'b1;
		default: qErrCke <= 1'b0;
	endcase
end


assign oAdrs[pRamAdrsWidth-1:0] = rAdrs;
assign oAdrs[29:pRamAdrsWidth]  = {29-pRamAdrsWidth{1'b0}};
assign oAdrs[30] = rCmd;
assign oAdrs[31] = rCe;
assign oWd = rWd;
assign oDone = rDone;
assign oErr = rErr;

endmodule