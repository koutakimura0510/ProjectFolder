/**-----------------------------------------------------------------------------
 * 24-01-21 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module RAMIfPortUnit #(
	parameter pRamDqWidth = 16
)(
	// RAM I/F Port
	output	[pRamDqWidth-1:0] 	oRamDq,
	input	[pRamDqWidth-1:0] 	iRamDq,
	output	[1:0]				oRamDq_OE,
	output	[1:0]				oRamClk,
	output	[1:0]				oRamCe,
	// Config Port
	input	[pRamDqWidth-1:0]	iCfgDq,
	input						iCfgClk,
	input						iCfgCs,
	input						iCfgEn,
	// Mcu Port
	// Vtb Port
	// Memory Test Port
	input	[pRamDqWidth-1:0]	iTestDq,
	input						iTestClk,
	input						iTestCs,
	input						iTestOe,
	input						iTestEn,
	// Read Port
	output	[pRamDqWidth-1:0]	oRamRd,
	output						oRamRe,
	// Clk Reset
	input	iRST,
	input	iCKE,
	input	iCLK
);

/**----------------------------------------------------------------------------
 * MCU が レジスタ制御により Cfg / Dq を切り替える
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth-1:0] 	rRamDq;
reg						rRamClk;
reg						rRamCs;
reg						rRamOe;
//
reg	[pRamDqWidth-1:0]	rRamRd;			assign oRamRd = rRamRd;
reg						rRamRe;			assign oRamRe = rRamRe;
reg						qRamReCke;
reg	[3:0]				rWaitCnt;
reg						qWaitCntCke;

always @(posedge iCLK)
begin
	casex ({iTestEn,iCfgEn})
		'b01: 		rRamDq <= iCfgDq;
		'b10: 		rRamDq <= iTestDq;
		default: 	rRamDq <= 16'd0;
	endcase
	
	case ({iTestEn,iCfgEn})
		'b01: 		rRamClk <= iCfgClk;
		'b10: 		rRamClk <= iTestClk;
		default: 	rRamClk <= 1'b0;
	endcase
	
	case ({iTestEn,iCfgEn})
		'b01: 		rRamCs <= iCfgCs;
		'b10: 		rRamCs <= iTestCs;
		default: 	rRamCs <= 1'b1;
	endcase
	
	case ({iTestEn,iCfgEn})
		'b01: 		rRamOe <= 1'b1;
		'b10: 		rRamOe <= iTestOe;
		default: 	rRamOe <= 1'b1;		// default output
	endcase
	
	if (~rRamClk) 	rRamRd <= iRamDq;
	else			rRamRd <= rRamRd;
	
	if (qRamReCke) 	rRamRe <= 1'b1;
	else			rRamRe <= 1'b0;
	
	if (rRamOe)				rWaitCnt <= 4'd0;
	else if (qWaitCntCke)	rWaitCnt <= rWaitCnt + 1'b1;
	else 					rWaitCnt <= rWaitCnt;
end

always @*
begin
	qRamReCke	<= (~rRamOe) & (~rRamClk) & (rWaitCnt == 4'd6);
	qWaitCntCke	<= (~rRamOe) & (~rRamClk) & (rWaitCnt != 4'd6);
end

assign oRamDq	 	= rRamDq;
assign oRamDq_OE[0] = rRamOe;
assign oRamClk[0]	= rRamClk;
assign oRamCe[0]	= rRamCs;
assign oRamDq_OE[1] = rRamOe;
assign oRamClk[1]	= rRamClk;
assign oRamCe[1]	= rRamCs;

endmodule