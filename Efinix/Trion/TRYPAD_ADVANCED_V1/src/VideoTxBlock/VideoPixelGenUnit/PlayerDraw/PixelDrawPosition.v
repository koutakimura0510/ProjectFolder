/*-----------------------------------------------------------------------------
 * 24-08-18 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module PlayerDrawPosition #(
	parameter	pVHAW			= 11,
	parameter	pVVAW			= 11,
	parameter	pMapChipBasicBs	= 4
)(
	//
	output	[pVHAW-1:0]					oPHPD,
	output	[pVVAW-1:0]					oPVPD,
	// Base Draw Position
	input	[pVHAW-1:0]					iBHPS,
	input	[pVVAW-1:0]					iBVPS,
	input	[pVHAW-1:pMapChipBasicBs]	iHposBs,
	input	[pVVAW-1:pMapChipBasicBs]	iVposBs,
	input								iFS,
	input								iVS,
	// control / status
	input	[pVHAW-1:0]					iInitXpos,
	input	[pVVAW-1:0]					iInitYpos,
	input								iInitEn,
	// SW Input
	input								iRight,
	input								iLeft,
	input								iUp,
	input								iDown,
	// common
	input	iRST,
	input	iCKE,
	input	iCLK
);

/**-----------------------------------------------------------------------------
 * 
 *-----------------------------------------------------------------------------*/
reg	[pVHAW-1:0]	rXpos;			assign oPHPD = rXpos;
reg	[pVVAW-1:0]	rYpos;			assign oPVPD = rYpos;
reg	[pVHAW-1:0]	qXpos;
reg	[pVVAW-1:0]	qYpos;
reg				qPosRst;

always @(posedge iCLK)
begin
	if (qPosRst)	rXpos <= iInitXpos;
	else if ()		rXpos <= qXpos;
	else			rXpos <= rXpos;
	
	if (qPosRst)	rYpos <= iInitYpos;
	else if ()		rYpos <= qYpos;
	else			rYpos <= rYpos;
end

always @*
begin
	case ({iFS,iRight,iLeft})
		'b101:		qXpos	<= rXpos - 1'b1;
		'b110:		qXpos	<= rXpos + 1'b1;
		default: 	qXpos	<= rXpos;
	endcase
end

/**-----------------------------------------------------------------------------
 * RST Logic
 *-----------------------------------------------------------------------------*/

always @*
begin
	qPosRst <= |{iRST,iInitEn}
end


endmodule