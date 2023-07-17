/*-----------------------------------------------------------------------------
 * Create  2023/7/15
 * Author  kimura
 * -
 * USI,UFI のスイッチングを行う
 * 
 *-----------------------------------------------------------------------------*/
module McbBusSwitch #(
	parameter pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth 		= 32,
	parameter pUfiDqBusWidth 	= 16,
	parameter pUfiAdrsBusWidth	= 32,
	parameter pUfiEnableBit 	= 32,
	parameter pCsrAdrsWidth 	= 8,
	parameter pCsrActiveWidth 	= 8
)(
	// Usi Bus Master Read
	input	[pUsiBusWidth-1:0] iMUsiRd,
	output	[pUsiBusWidth-1:0] oSUsiRd,
	// Usi Bus Master Write
	output	[pUsiBusWidth-1:0] oMUsiWd,
	output	[pUsiBusWidth-1:0] oMUsiAdrs,
	input	[pUsiBusWidth-1:0] iSUsiWd,
	input	[pUsiBusWidth-1:0] iSUsiAdrs,
	// Ufi Bus Master Read
	input	[pUfiDqBusWidth-1:0] iMUfiRd,
	input	[pUfiAdrsBusWidth-1:0] iMUfiAdrs,
	// Ufi Bus Master Write
	output	[pUfiDqBusWidth-1:0] oMUfiWd,
	output	[pUfiAdrsBusWidth-1:0] oMUfiAdrs,
	input	iMUfiRdy,
	// common
	input	iSRST,
	input	iSCLK
);



endmodule