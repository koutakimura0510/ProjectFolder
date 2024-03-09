/**-----------------------------------------------------------------------------
 * 外部 module と通信を行い、ビデオデータの管理を司る
 * 
 * 24-03-09 v1.00 : new release
 * 
 *-----------------------------------------------------------------------------*/
module VideoInfoManageUnit #(
	parameter 		pUfiBusWidth 		= 48
)(
	// Ufi Bus Master Read
	input	[pUfiBusWidth-1:0] 		iMUfiRd,
	input							iMUfiVd,
	// Ufi Bus Master Write
	output	[pUfiBusWidth-1:0] 		oMUfiWd,
	input							iMUfiRdy,
	// Control Status
	input							iHsyncEndIntr,	// HSYNC 
	input							iVsyncEndIntr,	// VSYNC 
	// CLK Rst
	input 							iSRST,
	input 							inSRST,
	input 							iSCLK
);



endmodule