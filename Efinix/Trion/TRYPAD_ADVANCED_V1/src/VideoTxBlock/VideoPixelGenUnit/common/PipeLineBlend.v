/*------------------------------------------------------------------------------
 * Create  2024/07/28
 * Author  Kouta Kimura
 *
 * ピクセルデータのαブレンドを行いつつ、制御信号のパイプライン処理を行う。
 *
 * 2024-07-28 : new release: 
 * 2025-03-27 : iLS,oLD に対応
 *-----------------------------------------------------------------------------*/
module PipeLineBlend #(
	parameter 		pVHAW  			= 11,
	parameter 		pVVAW  			= 11,
	parameter		pDstColorDepth	= 16,
	parameter 		pSynColorDepth	= 24,
	parameter [3:0] pPipeLine 		= 1			// パイプラインの段数, 最低"1",iPSB 重複色のデータ生成(入力)のレイテンシに合わせて調整する。
)(
	// Dst Side
	output	[pDstColorDepth-1:0]oPD,		// Pixel Dst
	output 						oVD,		// Valid Dst
	output 						oFD,		// Frame Dst
	output 						oLD,		// Line Dst
	output	[pVHAW-1:0]			oBHPD,		// Base Horizontal Position
	output	[pVVAW-1:0]			oBVPD,		// Base Vertical Position
	output	[pVHAW-1:0]			oPHPD,		// Player Horizontal Position
	output	[pVVAW-1:0]			oPVPD,		// Player Vertical Position
	// Src Side
	input	[pDstColorDepth-1:0]iPSA,		// 背景色 (Background=Bg), 合成される側
	input						iVSA,		// PSA Valid Src
	input	[pSynColorDepth-1:0]iPSB,		// αを含んだ重複色 (Overlay=Ov), 合成する側
	input 						iFS,		// Frame Src
	input 						iLS,		// Line Src
	input	[pVHAW-1:0]			iBHPS,		// Base Horizontal Position
	input	[pVVAW-1:0]			iBVPS,		// Base Vertical Position
	input	[pVHAW-1:0]			iPHPS,		// Player Horizontal Position
	input	[pVVAW-1:0]			iPVPS,		// Player Vertical Position
	// common
	input			iRST,
	input			iCLK
);

/**-----------------------------------------------------------------------------
 * alpha blend Part
 * Cycle min 1 delay
 *-----------------------------------------------------------------------------*/
wire [pDstColorDepth-1:0]	wAlbPD;
wire 						wAlbVD;
reg [pDstColorDepth-1:0] 	qAlbPS;
reg							qAlbVS;
 
AlphaBlend AlphaBlend (
	// Dst Pixel Stream I/F
	.oPD(wAlbPD),	.oVD(wAlbVD),
	// Src Pixel Stream I/F
	.iPSA(qAlbPS),	.iPSB(iPSB[15:0]),	.iAlpha(iPSB[23:16]),
	.iVS(qAlbVS),
	// common
	.iRST(iRST),	.iCLK(iCLK)
);


/**-----------------------------------------------------------------------------
 * Parameter PipeLine
 * 制御信号 : Cycle min 2 delay = (Data + 1) delay
 *-----------------------------------------------------------------------------*/
genvar genPipe;
reg  [pDstColorDepth-1:0]	rPS   [0:pPipeLine-1];
reg  [pPipeLine-1:0] 		rVS;
reg  [pPipeLine:0] 			rFS;
reg  [pPipeLine:0] 			rLS;
reg  [pVHAW-1:0] 			rBHPS [0:pPipeLine];
reg  [pVVAW-1:0] 			rBVPS [0:pPipeLine];
reg  [pVHAW-1:0] 			rPHPS [0:pPipeLine];
reg  [pVVAW-1:0] 			rPVPS [0:pPipeLine];

generate
	for (genPipe = 0; genPipe < pPipeLine; genPipe = genPipe + 1)
	begin
		always @(posedge iCLK)
		begin
			if (genPipe == 0)
			begin
				rPS[0]	<= iPSA;
				rVS[0]	<= iVSA;
			end
			else
			begin
				rPS[genPipe] 	<= rPS[genPipe-1];
				rVS[genPipe] 	<= rVS[genPipe-1];
			end
		end
	end
	
	always @*
	begin
		qAlbPS		<= rPS[pPipeLine-1];
		qAlbVS		<= rVS[pPipeLine-1];
	end
	
	for (genPipe = 0; genPipe < pPipeLine+1; genPipe = genPipe + 1)
	begin
		always @(posedge iCLK)
		begin
			if (genPipe == 0)
			begin
				rFS[0]		<= iFS;
				rLS[0]		<= iLS;
				rBHPS[0]	<= iBHPS;
				rBVPS[0]	<= iBVPS;
				rPHPS[0]	<= iPHPS;
				rPVPS[0]	<= iPVPS;
			end
			else
			begin
				rFS[genPipe]	<= rFS[genPipe-1];
				rLS[genPipe]	<= rLS[genPipe-1];
				rBHPS[genPipe]	<= rBHPS[genPipe-1];
				rBVPS[genPipe]	<= rBVPS[genPipe-1];
				rPHPS[genPipe]	<= rPHPS[genPipe-1];
				rPVPS[genPipe]	<= rPVPS[genPipe-1];
			end
		end
	end
endgenerate


/**-----------------------------------------------------------------------------
 * Dst Part
 *-----------------------------------------------------------------------------*/
assign oPD   = wAlbPD;
assign oVD	 = wAlbVD;
assign oFD	 = rFS[pPipeLine];
assign oLD	 = rLS[pPipeLine];
assign oBHPD = rBHPS[pPipeLine];
assign oBVPD = rBVPS[pPipeLine];
assign oPHPD = rPHPS[pPipeLine];
assign oPVPD = rPVPS[pPipeLine];

endmodule