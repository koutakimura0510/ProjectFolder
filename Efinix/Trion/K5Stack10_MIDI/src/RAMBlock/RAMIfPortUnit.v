/**-----------------------------------------------------------------------------
 * HyperRam Port Unit
 * https://www.infineon.com/dgdl/Infineon-AN226576_-_Getting_started_with_HYPERRAM_TM_JA-ApplicationNotes-v02_00-JA.pdf?fileId=8ac78c8c7cdc391c017d0d3995ec66e2
 * 
 * 23-04-04 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module RAMIfPortUnit #(
	parameter pRamAdrsWidth	= 19,
	parameter pRamDqWidth = 8
)(
	// SRAM I/F Port
	output	[pRamDqWidth-1:0] oSRAMD,
	input	[pRamDqWidth-1:0] iSRAMD,
	output	oSRAMD_OE,
	output	oSRAM_RWDS,
	input	iSRAM_RWDS,
	output	oSRAM_RWDS_OE,
	output	oSRAM_pCLK,
	output	oSRAM_nCLK,
	output	oSRAM_nCE,
	output	oSRAM_nRST,
	// Write Port
	input	[31:0] 	iSUfiWd,
	input			iSUfiVd,
	output			oSUfiRdy,
	// Read Port
	output	[31:0] 	oSUfiRd,
	output			oSUfiVd,
    // Clk Reset
	input	iRST,
	input	iCKE,
	input	iCLK
);

/**----------------------------------------------------------------------------
  Hyper RAM はステートマシンを組んで制御する
  CA Bit
  47 	R/W#, 			"1" R, "0" W
  46 	AS, 			"1" Reg空間にアクセス "0" メモリアレイにアクセス
  45 	Burst type, 	"1" linear burst, "0" wrapped burst
  44-16 Row/Col Adrs,	A31-3
  15- 3 Reserved		nc
   2- 0 Lower ColAdrs	A2-0
 *---------------------------------------------------------------------------*/
// localparam
// 	lpIdol		= 3'd0,
// 	lpCsAssert	= 3'd1,
// 	lpCmdAdrs	= 3'd2,
// 	lplatency1	= 3'd3,	// CA RWDS "L", Memory が出力するレイテンシ期間
// 	lplatency2	= 3'd4,	// CA RWDS "H", Memory が出力するレイテンシ期間
// 	lpReadSeq	= 3'd5,
// 	lpWriteSeq	= 3'd6;
	
// // Ufib Control Status
// reg rRdy;
// reg rAdrsSpace;
// reg rBurstType;
// reg [7:0] rBurstLen;
// reg [7:0] rUfibId;
// reg rRwSel;
// //
// reg [2:0] 	rSt;
// reg rMemPclk, rMemNclk;
// reg rMemCs;

// always @(negedge iCLK)
// begin
// 	if (iRST)	rMemPclk <= 1'b0;
// 	else if	()	rMemPclk <= ~rMemPclk;
// 	else		rMemPclk <= rMemPclk;
	
// 	if (iRST)	rMemNclk <= 1'b0;
// 	else if	()	rMemNclk <= ~rMemNclk;
// 	else		rMemNclk <=  rMemNclk;
// end

// always @(posedge iCLK)
// begin
// 	if (iRST)	rMemCs <= 1'b1;
// 	else if ()	rMemCs <= ~rMemCs;
// 	else		rMemCs <=  rMemCs;
	
// 	if (iRST)
// 	begin
// 		rAdrsSpace	<= ;
// 		rBurstType	<= ;
// 		rBurstLen	<= ;
// 		rUfibId		<= ;
// 	end
// 	else if (qUfib1stPacketGet)
// 	begin
// 		rAdrsSpace	<= irAdrsSpace;
// 		rBurstType	<= rBurstType;
// 		rBurstLen	<= rBurstLen;
// 		rUfibId		<= rUfibId;
// 	end
// 	else
// 	begin
// 		rAdrsSpace	<= rAdrsSpace;
// 		rBurstType	<= rBurstType;
// 		rBurstLen	<= rBurstLen;
// 		rUfibId		<= rUfibId;
// 	end
	
// 	if (iRST)
// 	begin
// 		rSt 	<= lpIdol;
// 		rRdy	<= 1'b0;
// 		rRwSel	<= 1'b0;
// 	end
// 	else
// 	begin
// 	case (rSt)
// 		lpIdol:
// 		begin
// 			rRdy	<= 1'b1;
// 			rSt 	<= qNectStCke ? lpCsAssert : lpIdol;
// 		end
		
// 		lpCsAssert:
// 		begin
// 			rSt <= lpCmdAdrs;
// 		end
		
// 		lpCmdAdrs:
// 		begin
			
// 		end
		
// 		lplatency1:
// 		begin
			
// 		end
		
// 		lplatency2:
// 		begin
			
// 		end
		
// 		lpReadSeq:
// 		begin
			
// 		end
		
// 		lpWriteSeq:
// 		begin
			
// 		end
		
// 		default:
// 		begin
			
// 		end
// 	endcase
// 	end
	
// 	rAdrs 	<= iAdrs;
// 	rWd 	<= iWd;

// 	if (iCKE)
// 	begin
// 		rOE <= ~iCmd;
// 		rWE <=  iCmd;
// 		rCE <=  1'b0;
// 	end
// 	else
// 	begin
// 		rOE <= 1'b1;
// 		rWE <= 1'b0;
// 		rCE <= 1'b1;
// 	end

// 	if (rWE) rRd <= iSRAMD;
// 	else  	 rRd <= rRd;

// 	if (iRST)		rRvd <= 1'b0;
// 	else if (rWE) 	rRvd <= 1'b1;
// 	else  			rRvd <= 1'b0;
// end

assign oSRAMA = 0;
assign oSRAMD = 0;
assign oSRAM_OE = 1'b1;
assign oSRAM_RWDS = 1'b1;
assign oSRAM_pCLK = 1'b1;
assign oSRAM_nCLK = 1'b1;
assign oSRAM_nCE = 1'b1;
assign oSRAM_nRST = 1'b1;
assign oRd = 0;
assign oRvd = 0;

endmodule