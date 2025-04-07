/*------------------------------------------------------------------------------
 * Create  2024/07/30
 * Author  kouta kimura
 * 
 * Player Draw module
 * 2024-07-30 v1.00 : release
 * 2025-03-22 v1.01 : Line Valid に対応
 *-----------------------------------------------------------------------------*/
module PlayerDraw #(
	parameter		pVHAW  			= 11,
	parameter		pVVAW  			= 11,
	parameter		pDstColorDepth	= 16,					// 入出力ピクセルデータの深度
	parameter 		pSynColorDepth	= 24,					// α値を含む内部生成データの深度
	parameter [7:0]	pCacheBaseAdrs	= 8'h01,
	parameter		pRamDepth		= 1024					// Block Ram Size
)(
	// Dst Pixel Stream I/F
	output	[pDstColorDepth-1:0]	oPD,		// Pixel Data
	output 							oVD,		// Pixel Valid
	output 							oFD,		// Frame Valid
	output 							oLD,		// Line Valid
	output	[pVHAW-1:0]				oBHPD,
	output	[pVVAW-1:0]				oBVPD,
	output	[pVHAW-1:0]				oPHPD,		// Player Horizontal Position
	output	[pVVAW-1:0]				oPVPD,		// Player Vertical Position
	// Src Pixel Stream I/F
	input	[pDstColorDepth-1:0]	iPS,		// Pixel Data
	input							iVS,		// Pixel Valid
	input							iFS,		// Frame Valid
	input							iLS,		// Line Valid
	input	[pVHAW-1:0]				iBHPS,		// Base Horizontal Position
	input	[pVVAW-1:0]				iBVPS,		// Base Vertical Position
	input	[pVHAW-1:0]				iPHPS,		// Player Horizontal Position
	input	[pVVAW-1:0]				iPVPS,		// Player Vertical Position
	// Control / Status
	input	[3:0]					iDrawPlayerSel,	// プレイヤー描画データの指定
	// Memory Mapchip Access
	input 	[23:0]					iBramWd,
	input 	[31:0]					iBramAdrs,
	// common
	input							iRST,
	input							iCLK
);


/**-----------------------------------------------------------------------------
 * BRAM
 *-----------------------------------------------------------------------------*/
localparam lpRamAdrsWidth = fBitWidth(pRamDepth);
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rPlayerRam1 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rPlayerRam2 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rPlayerRam3 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rPlayerRam4 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rPlayerRam5 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rPlayerRam6 [0:pRamDepth-1];
 
reg [pSynColorDepth-1:0]	rPSB,			qPSB;
reg [lpRamAdrsWidth-1:0] 	rRamRadrs;
reg 						qRamRadrsCke, 	qRamRadrsRst;
reg	[5:0]					qRamWe;

always @(posedge iCLK)
begin
	if (qRamWe[0])	rPlayerRam1[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[1])	rPlayerRam2[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[2])	rPlayerRam3[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[3])	rPlayerRam4[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[4])	rPlayerRam5[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[5])	rPlayerRam6[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	
	if (iRST)				rRamRadrs <= {lpRamAdrsWidth{1'b0}};
	else if (qRamRadrsRst)	rRamRadrs <= {lpRamAdrsWidth{1'b0}};
	else if (qRamRadrsCke)	rRamRadrs <= rRamRadrs + 1'b1;
	else 					rRamRadrs <= rRamRadrs;
	
	rPSB <= qPSB;
end

always @*
begin
	qRamWe[0]	<= iBramAdrs[31:24] == (pCacheBaseAdrs);
	qRamWe[1]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd1);
	qRamWe[2]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd2);
	qRamWe[3]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd3);
	qRamWe[4]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd4);
	qRamWe[5]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd5);
	
	case ({qRamRadrsCke,iDrawPlayerSel[3:0]})
		'b1_0000:	qPSB <= rPlayerRam1[rRamRadrs];
		'b1_0001:	qPSB <= rPlayerRam2[rRamRadrs];
		'b1_0010:	qPSB <= rPlayerRam3[rRamRadrs];
		'b1_0011:	qPSB <= rPlayerRam4[rRamRadrs];
		'b1_0100:	qPSB <= rPlayerRam5[rRamRadrs];
		'b1_0101:	qPSB <= rPlayerRam6[rRamRadrs];
		default:	qPSB <= 24'd0;
	endcase
end

/**-----------------------------------------------------------------------------
 * position match
 *-----------------------------------------------------------------------------*/
reg qXposMatch;
reg qYposMatch;

always @*
begin
	qXposMatch		<= (iPHPS <= iBHPS) & (iBHPS < (iPHPS + 6'd32));
	qYposMatch		<= (iPVPS <= iBVPS) & (iBVPS < (iPVPS + 6'd32));
	qRamRadrsCke	<= iVS & qXposMatch & qYposMatch;
	qRamRadrsRst	<= iFS & iVS;
end

/**-----------------------------------------------------------------------------
 * PipeLine Alpha Blend
 *-----------------------------------------------------------------------------*/
PipeLineBlend #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(pDstColorDepth),
	.pSynColorDepth(pSynColorDepth),
	.pPipeLine(1)
) PipeLineBlend (
	// Dst Pixel Stream I/F
	.oPD(oPD),			.oVD(oVD),		.oFD(oFD),	.oLD(oLD),
	.oBHPD(oBHPD),		.oBVPD(oBVPD),
	.oPHPD(oPHPD),		.oPVPD(oPVPD),
	// Src Pixel Stream I/F
	.iPSA(iPS),			.iPSB(rPSB),
	.iVSA(iVS),			.iFS(iFS),		.iLS(iLS),
	.iBHPS(iBHPS),		.iBVPS(iBVPS),
	.iPHPS(iPHPS),		.iPVPS(iPVPS),
	// common
	.iRST(iRST),		.iCLK(iCLK)
);

//-----------------------------------------------------------------------------
// MSB の Bitを検出
//-----------------------------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction

endmodule