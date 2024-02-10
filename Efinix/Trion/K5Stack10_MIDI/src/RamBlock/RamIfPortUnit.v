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
	input	[15:0] 	iCfgDq,
	input			iCfgClk,
	input			iCfgCs,
	input			iCfgEn,
	// Mcu Port
	// Vtb Port
	// Memory Test Port
	// Clk Reset
	input	iRST,
	input	iCKE,
	input	iCLK
);

/**----------------------------------------------------------------------------
 * MCU が レジスタ制御により Cfg / Dq を切り替える
 *---------------------------------------------------------------------------*/
reg [15:0] 	rRamDq;
reg			rRamDqOe;
reg			rRamClk;
reg			rRamCs;

always @(posedge iCLK)
begin
	case (iCfgEn)
		'b1: 		rRamDq <= iCfgDq;
		default: 	rRamDq <= 16'd0;
	endcase
	
	case (iCfgEn)
		'b1: 		rRamDqOe <= 1'b1;
		default: 	rRamDqOe <= 1'b0;
	endcase
	
	case (iCfgEn)
		'b1: 		rRamClk <= iCfgClk;
		default: 	rRamClk <= 1'b0;
	endcase
	
	case (iCfgEn)
		'b1: 		rRamCs <= iCfgCs;
		default: 	rRamCs <= 1'b1;
	endcase
end

assign oRamDq	 	= rRamDq;
assign oRamDq_OE[0] = rRamDqOe;
assign oRamClk[0]	= rRamClk;
assign oRamCe[0]	= rRamCs;
assign oRamDq_OE[1] = rRamDqOe;
assign oRamClk[1]	= rRamClk;
assign oRamCe[1]	= rRamCs;

endmodule