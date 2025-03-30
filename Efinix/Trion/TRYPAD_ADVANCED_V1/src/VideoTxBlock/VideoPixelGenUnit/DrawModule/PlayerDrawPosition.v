/*-----------------------------------------------------------------------------
 * 24-08-18 : new release
 * 25-03-30 : HposAdd, VposHdd 追加
 *-----------------------------------------------------------------------------*/
module PlayerDrawPosition #(
	parameter	pVHAW			= 11,
	parameter	pVVAW			= 11,
	parameter	pMapChipBasicBs	= 4
)(
	// Dst Pixel Stream I/F
	output	[pVHAW-1:0]					oXpos,		// Player Horizontal Position
	output	[pVVAW-1:0]					oYpos,		// Player Vertical Position
	output	[pVHAW:0]					oXposAdd,	// Player Horizontal Add Position
	output	[pVVAW:0]					oYposAdd,	// Player Vertical Add Position
	output	[pVHAW-1:pMapChipBasicBs]	oXposBs,
	output	[pVVAW-1:pMapChipBasicBs]	oYposBs,
	// Base Draw Position
	input								iFS,
	input								iLS,
	input								iVS,
	// control / status
	input	[pVHAW-1:0]					iXpos,
	input	[pVVAW-1:0]					iYpos,
	input	[pVHAW-1:0]					iXposAdd,
	input	[pVVAW-1:0]					iYposAdd,
	input								iInit,
	// common
	input	iRST,
	input	iCLK
);

/**-----------------------------------------------------------------------------
 * 
 *-----------------------------------------------------------------------------*/
reg	[pVHAW-1:0]	rXpos;			assign oXpos	= rXpos;
reg	[pVVAW-1:0]	rYpos;			assign oYpos	= rYpos;
reg	[pVHAW:0]	rXposAdd;		assign oXposAdd	= rXposAdd;
reg	[pVVAW:0]	rYposAdd;		assign oYposAdd	= rYposAdd;
								assign oXposBs	= rXpos[pVHAW-1:pMapChipBasicBs];
								assign oYposBs	= rYpos[pVVAW-1:pMapChipBasicBs];
reg				qRst, qCke;

always @(posedge iCLK)
begin
	if (qRst)		rXpos <= iXpos;
	else if (qCke)	rXpos <= iXpos;
	else			rXpos <= rXpos;
	
	if (qRst)		rYpos <= iYpos;
	else if (qCke)	rYpos <= iYpos;
	else			rYpos <= rYpos;
	
	if (qRst)		rXposAdd <= iXpos + iXposAdd;
	else if (qCke)	rXposAdd <= iXpos + iXposAdd;
	else			rXposAdd <= rXposAdd;
	
	if (qRst)		rYposAdd <= iYpos + iYposAdd;
	else if (qCke)	rYposAdd <= iYpos + iYposAdd;
	else			rYposAdd <= rYposAdd;
end

always @*
begin
	qCke <= iFS & iVS;
	qRst <= iRST | iInit;
end

endmodule