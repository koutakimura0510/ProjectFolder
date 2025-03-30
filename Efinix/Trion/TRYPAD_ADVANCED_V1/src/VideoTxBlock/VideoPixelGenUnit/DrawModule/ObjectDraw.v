/*------------------------------------------------------------------------------
 * Object Draw module
 * 2025-03-29 v1.00 : release
 *-----------------------------------------------------------------------------*/
module ObjectDraw #(
	parameter		pVHAW  			= 11,
	parameter		pVVAW  			= 11,
	parameter		pDstColorDepth	= 16,			// 入出力ピクセルデータの深度
	parameter 		pSynColorDepth	= 24,			// α値を含む内部生成データの深度
	parameter [7:0]	pCacheBaseAdrs	= 8'h10,
	parameter		pRamDepth		= 1024,			// Block Ram Size
	parameter		pObjectAnimeNum	= 8,			// アニメーション可能なオブジェクトの個数
	parameter		pObjectAnimeTime= 8,			// アニメーション指定時間の最大時間 Bit幅で指定する。1フレーム単位で処理するため、8bit幅だったら 最大255フレーム間隔で可能になる。
	parameter		pObjectAnimeXposWidth	= 16,	// [15:11] NC Bit, [10:0] xpos
	parameter		pObjectAnimeYposWidth	= 16	// [15:11] NC Bit, [10:0] ypos
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
	// Draw & Animation Parameter
	input	[(pObjectAnimeNum * pObjectAnimeTime)-1:0]		iAnimeFrameNum,
	input	[(pObjectAnimeNum * pObjectAnimeXposWidth)-1:0] iAnimeXpos,
	input	[(pObjectAnimeNum * pObjectAnimeYposWidth)-1:0] iAnimeYpos,
	// common
	input							iRST,
	input							iCLK
);


/**-----------------------------------------------------------------------------
 * Local CSR Area
 *-----------------------------------------------------------------------------*/


/**-----------------------------------------------------------------------------
 * BRAM
 *-----------------------------------------------------------------------------*/
localparam lpRamAdrsWidth = fBitWidth(pRamDepth);
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rObjectRam1 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rObjectRam2 [0:pRamDepth-1];
(* ram_style = "BLOCK" *) reg [pSynColorDepth-1:0] rObjectRam3 [0:pRamDepth-1];
 
reg [pSynColorDepth-1:0]	rPSB, qPSB;
reg [lpRamAdrsWidth-1:0] 	rRamRadrs;
reg 						qRamRadrsCke, qRamRadrsRst;
reg [7:0]					qRamSel;
reg [7:0]					qRamWe;

always @(posedge iCLK)
begin
	if (qRamWe[0])	rObjectRam1[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[1])	rObjectRam2[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	if (qRamWe[2])	rObjectRam3[iBramAdrs[lpRamAdrsWidth-1:0]] <= iBramWd;
	
	rPSB <= qPSB;
	
	if (iRST)					rRamRadrs <= {lpRamAdrsWidth{1'b0}};
	else if (qRamRadrsRst)		rRamRadrs <= {lpRamAdrsWidth{1'b0}};
	else if (qRamRadrsCke)		rRamRadrs <= rRamRadrs + 1'b1;
	else 						rRamRadrs <= rRamRadrs;
end

always @*
begin
	qRamWe[0]	<= iBramAdrs[31:24] == (pCacheBaseAdrs);
	qRamWe[1]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd1);
	qRamWe[2]	<= iBramAdrs[31:24] == (pCacheBaseAdrs + 4'd2);
	
	casex({qRamRadrsCke,qRamSel[1:0]})
		'b100:		qPSB <= rObjectRam1[rRamRadrs];
		'b101:		qPSB <= rObjectRam2[rRamRadrs];
		'b110:		qPSB <= rObjectRam3[rRamRadrs];
		default:	qPSB <= 24'd0;
	endcase
end

/**-----------------------------------------------------------------------------
 * draw position
 *-----------------------------------------------------------------------------*/
wire [pVHAW-1:0] 	wOdpXpos;
wire [pVVAW-1:0] 	wOdpYpos;
wire [pVHAW:0] 		wOdpXposAdd;
wire [pVVAW:0] 		wOdpYposAdd;
reg					qXposMatch, qYposMatch;

PlayerDrawPosition #(
	.pVHAW(pVHAW),	.pVVAW(pVVAW)
) ObjectDrawPosition (
	.oXpos(wOdpXpos),		.oYpos(wOdpYpos),
	.oXposAdd(wOdpXposAdd),	.oYposAdd(wOdpYposAdd),
	.oXposBs(),				.oYposBs(),
	.iFS(iFS),	.iLS(iLS),	.iVS(iVS),
	// control status
	.iXpos(iAnimeXpos[15:0]),
	.iYpos(iAnimeYpos[15:0]),
	.iXposAdd(6'd32),
	.iYposAdd(6'd32),
	.iInit(1'b0),
	// common
	.iRST(iRST),	.iCLK(iCLK)
);

always @*
begin
	qXposMatch		<= (wOdpXpos <= iBHPS) & (iBHPS < wOdpXposAdd);
	qYposMatch		<= (wOdpYpos <= iBVPS) & (iBVPS < wOdpYposAdd);
	qRamRadrsCke	<= iVS & qXposMatch & qYposMatch;
	qRamRadrsRst	<= iVS & iFS;
end

/**-----------------------------------------------------------------------------
 * animation logic
 *-----------------------------------------------------------------------------*/
reg [7:0] 	rFsCnt;		// フレーム数カウンタ
reg			qFsCntCke, qFsCntMax;
reg [1:0]	rAnimeFrmaeNum;
reg 		qAnimeFrmaeMax;

always @(posedge iCLK)
begin
	if (iRST) 			rFsCnt <= 8'd0;
	else if (qFsCntMax)	rFsCnt <= 8'd0;
	else if (qFsCntCke)	rFsCnt <= rFsCnt + 1'b1;
	else 				rFsCnt <= rFsCnt;
	
	if (iRST) 					rAnimeFrmaeNum <= 2'd0;
	else if (qAnimeFrmaeMax)	rAnimeFrmaeNum <= 2'd0;
	else if (qFsCntMax)			rAnimeFrmaeNum <= rAnimeFrmaeNum + 1'b1;
	else 						rAnimeFrmaeNum <= rAnimeFrmaeNum;
end

always @*
begin
	qFsCntCke		<= iFS & iVS;
	qFsCntMax		<= qFsCntCke & (rFsCnt == iAnimeFrameNum[7:0]);
	qAnimeFrmaeMax	<= qFsCntMax & (rAnimeFrmaeNum == 2'd2);
	qRamSel			<= rAnimeFrmaeNum;
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