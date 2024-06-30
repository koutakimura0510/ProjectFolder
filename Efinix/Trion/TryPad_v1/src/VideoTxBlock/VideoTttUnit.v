/*------------------------------------------------------------------------------
 * Create 2024/06/30
 * Author Kouta Kimura
 * 
 * new release : v1.00
 *-----------------------------------------------------------------------------*/
module VideoTttUnit (
	// Video Output Part
	output [23:0]					oTftDQ,
	output							oTftWRX,
	output							oTftDCX,
	output							oTftRDX,
	output							oTftCSX,
	// Data Stream Input Part
	input  [23:0]					iDq,
	input							iWe,
	// Ufi Bus Master Write
	input 							iVRST,
	input 							inVRST,
	input 							iVCLK
);


endmodule