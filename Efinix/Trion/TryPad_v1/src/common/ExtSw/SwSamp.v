/**-----------------------------------------------------------------------------
 * 24-02-17 v1.00 : new release
 * 
 *-----------------------------------------------------------------------------*/
module SwSamp (
	// Control / Status
	input	iPushSw,
	output 	oEdgeSw,	// Edge Push Sw
	output	oLongSw,	// Long Push Sw
	input	iSampCke,	// チャタリング除去周期
	// Clk Reset
	input	iRST,
	input	iCLK
);


/**----------------------------------------------------------------------------
 * SW Edge Ditect
 *---------------------------------------------------------------------------*/
reg 		rPushSw;
reg [2:0] 	rPushSwSft;
reg			rPushSwEdge,	qPushSwEdgeCke;			assign oEdgeSw	= rPushSwEdge;
reg			rPushSwRun,		qPushSwRunCke;			assign oLongSw	= rPushSwRun;

always @(posedge iCLK)
begin
	if (iSampCke) 			rPushSwSft <= {rPushSwSft[1:0],~iPushSw};	// Ext Pull Up
	else 					rPushSwSft <= rPushSwSft;
	
	if (iRST) 				rPushSwEdge <= 1'b0;
	else if (qPushSwEdgeCke)rPushSwEdge <= 1'b1;
	else 					rPushSwEdge <= 1'b0;
	
	if (iRST) 				rPushSwRun <= 1'b0;
	else if (qPushSwRunCke)	rPushSwRun <= 1'b1;
	else 					rPushSwRun <= 1'b0;
end

always @*
begin
	qPushSwEdgeCke	<= (rPushSwSft == 3'b110) & iSampCke;
	qPushSwRunCke	<= (rPushSwSft == 3'b111) & iSampCke;
end


endmodule