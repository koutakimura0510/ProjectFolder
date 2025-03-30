/*------------------------------------------------------------------------------
 * Author  kouta kimura
 * 
 * Filed Draw module
 * 2025-03-27 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module FieldDraw #(
	parameter		pVHAW  			= 11,
	parameter		pVVAW  			= 11,
	parameter		pDstColorDepth	= 16,					// 入出力ピクセルデータの深度
	parameter 		pSynColorDepth	= 24,					// α値を含む内部生成データの深度
	parameter [7:0]	pCacheBaseAdrs	= 8'h08,
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
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rMapchipRam1 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rMapchipRam2 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [7:0] rMapIdRam [0:80];
 
reg [pSynColorDepth-1:0]	rPSB, qPSB;
reg [lpRamAdrsWidth-1:0] 	qMapchipRamRadrs;
reg 						qRamRadrsCke;
reg	[7:0]					qRamWe;

always @(posedge iCLK)
begin
	if (qRamWe[0]) rMapchipRam1[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[1]) rMapIdRam[iBramAdrs[6:0]] <= iBramWd[7:0];
	if (qRamWe[2]) rMapchipRam2[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	
	rPSB <= qPSB;
	
end

always @*
begin
	qRamWe[0] <= iBramAdrs[31:24] == (pCacheBaseAdrs);
	qRamWe[1] <= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd1);
	qRamWe[2] <= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd2);
end

/**-----------------------------------------------------------------------------
 * position match 
 *-----------------------------------------------------------------------------*/
reg [7:0]	qMapIdAdrs;
reg [4:0] 	rXpos,		rYpos;
reg [6:0] 	rYidpos;
reg 		qXposCke,	qYposCke, qYidposCke;
reg 		qXposRst,	qYposRst;

always @(posedge iCLK)
begin
	if (qXposRst)			rXpos <= 5'd0;
	else if (qXposCke)		rXpos <= rXpos + 1'b1;
	else					rXpos <= rXpos;
	
	if (qYposRst)			rYpos <= 5'd0;
	else if (qYposCke)		rYpos <= rYpos + 1'b1;
	else					rYpos <= rYpos;
	
	if (qYposRst)			rYidpos <= 7'd0;
	else if (qYidposCke)	rYidpos <= rYidpos + 4'd10;
	else					rYidpos <= rYidpos;
end

always @*
begin
	qXposRst			<= |{iRST,{iLS & iVS}};
	qYposRst			<= |{iRST,{iFS & iVS}};
	qXposCke			<= iVS;
	qYposCke			<= &{iLS,iVS};
	qYidposCke			<= &{iLS,iVS,rYpos==5'd31};
	qMapchipRamRadrs	<= {rYpos,rXpos};
	qMapIdAdrs			<= rYidpos + iBHPS[pVHAW-1:5];
	
	case ({iVS,rMapIdRam[qMapIdAdrs]})
		'h101:	qPSB <= rMapchipRam1[qMapchipRamRadrs];
		'h102:	qPSB <= rMapchipRam2[qMapchipRamRadrs];
		default	qPSB <= 24'd0;
	endcase
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