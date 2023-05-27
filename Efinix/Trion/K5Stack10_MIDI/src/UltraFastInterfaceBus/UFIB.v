/*-----------------------------------------------------------------------------
 * Create  2023/5/21
 * Author  koutakimura
 * -
 * 
 * V1.0 : new Relaese
 * 
 * UfiAdrs Bit Assign
 * [31]    1'b1 Enable,    1'b0 Disable
 * [30]    1'b0 WriteCmd,  1'b1 ReadCmd
 * [28:25] Block ID
 * [24: 0] RAM Adrs
 *-----------------------------------------------------------------------------*/
module UFIB #(
	// variable parameter
	parameter pUfiDqBusWidth	=  16,	// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている
	parameter pUfiAdrsBusWidth	=  32	//
)(
	// Ufi Bus Master Read
	input  [pUfiDqBusWidth-1:0] 	iSUfiRd,
	input  [pUfiAdrsBusWidth-1:0] 	iSUfiAdrs,
	output [pUfiDqBusWidth-1:0] 	oMUfiRd,
	output [pUfiAdrsBusWidth-1:0] 	oMUfiAdrs,
	// Ufi Bus Master Write
	output [pUfiDqBusWidth-1:0] 	oSUfiWd,
	output [pUfiAdrsBusWidth-1:0] 	oSUfiAdrs,
	input  iSUfiRdy,
	input  [pUfiDqBusWidth-1:0] 	iMUfiWd,
	input  [pUfiAdrsBusWidth-1:0] 	iMUfiAdrs,
	output oMUfiRdy,
    // CLK Reset
    input  iRST,
    input  iCLK 
);


//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
// Read
assign oMUfiRd   = iSUfiRd;
assign oMUfiAdrs = iSUfiAdrs;
// Write
assign oSUfiWd   = iMUfiWd;
assign oSUfiAdrs = iMUfiAdrs;
assign oMUfiRdy  = iSUfiRdy;

// always @(posedge iCLK)
// begin

// end

endmodule