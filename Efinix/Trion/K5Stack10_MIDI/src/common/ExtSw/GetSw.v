/**-----------------------------------------------------------------------------
 * 24-02-17 v1.00 : new release
 * 
 *-----------------------------------------------------------------------------*/
module GetSw #(
	parameter	[15:0] 	pSampCntMax	= 49999,	// 分周クロックの値を指定
	parameter			pExtSwNum= 7			// 外部接続の SW 個数
)(
	// Internal Clk
	input	[pExtSwNum-1:0]	iPushSw,
	output 	[pExtSwNum-1:0]	oEdgeSw,	// Edge Push Sw
	output	[pExtSwNum-1:0]	oLongSw,	// Long Push Sw
	// Clk Reset
    input	iRST,
    input	iCLK
);

/**----------------------------------------------------------------------------
 * Sampling Edge Gen
 *---------------------------------------------------------------------------*/
reg [15:0] 	rSampCnt;
reg			qSampCntMax;

always @(posedge iCLK)
begin
	if (iRST) 				rSampCnt <= 16'd0;
	else if (qSampCntMax)	rSampCnt <= 16'd0;
	else 					rSampCnt <= rSampCnt + 1'b1;
end

always @*
begin
	qSampCntMax <= (rSampCnt == pSampCntMax);
end


/**----------------------------------------------------------------------------
 * SW Edge Ditect
 *---------------------------------------------------------------------------*/
genvar SwX;

generate
	for (SwX = 0; SwX < pExtSwNum; SwX = SwX + 1)
	begin : SwSamp
		SwSamp SwSamp (
			// Contorl / Status
			.iPushSw(iPushSw[SwX]),	.oEdgeSw(oEdgeSw[SwX]),	.oLongSw(oLongSw[SwX]),
			.iSampCke(qSampCntMax),
			// Clk Reset
			.iRST(iRST),		.iCLK(iCLK)
		);
	end
endgenerate

endmodule