//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module VideoTxCsr #(
	parameter 	pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter	pUsiBusWidth	= 16,
	parameter 	pCsrAdrsWidth   = 16,
	parameter	pCsrActiveWidth = 16,
	parameter	pDmaAdrsWidth	= 19,
	//
    parameter	pVHA = 480,
    parameter	pVHB = 8,
    parameter	pVHF = 43,
    parameter	pVHS = 30,
    parameter	pVVA = 272,
    parameter	pVVB = 12,
    parameter	pVVF = 4,
    parameter	pVVS = 10,
	//
    parameter	pVHAW = 11,
    parameter	pVHBW = 7,
    parameter	pVHFW = 7,
    parameter	pVHSW = 7,
    parameter	pVVAW = 11,
    parameter	pVVBW = 5,
    parameter	pVVFW = 5,
    parameter	pVVSW = 5,
	//
	parameter	pColorDepth			= 16
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input	[pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr DMA
	output						oDmaEnable,
	output						oDmaCycleEnable,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsStart,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsEnd,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsAdd,
	input						iDmaDone,
	// Csr Map Info
	output	[7:0] oMapXSize,
	output	[7:0] oMapYSize,
	// Csr Dot Square Gen
	output		   [pColorDepth-1:0]oDotSquareColor1,
	output	signed [pVHAW:0] 		oDotSquareLeft1,
	output	signed [pVHAW:0] 		oDotSquareRight1,
	output	signed [pVVAW:0] 		oDotSquareTop1,
	output	signed [pVVAW:0] 		oDotSquareUnder1,
	output		   [pColorDepth-1:0]oDotSquareColor2,
	output	signed [pVHAW:0] 		oDotSquareLeft2,
	output	signed [pVHAW:0] 		oDotSquareRight2,
	output	signed [pVVAW:0] 		oDotSquareTop2,
	output	signed [pVVAW:0] 		oDotSquareUnder2,
	output		   [pColorDepth-1:0]oDotSquareColor3,
	output	signed [pVHAW:0] 		oDotSquareLeft3,
	output	signed [pVHAW:0] 		oDotSquareRight3,
	output	signed [pVVAW:0] 		oDotSquareTop3,
	output	signed [pVVAW:0] 		oDotSquareUnder3,
	output		   [pColorDepth-1:0]oDotSquareColor4,
	output	signed [pVHAW:0] 		oDotSquareLeft4,
	output	signed [pVHAW:0] 		oDotSquareRight4,
	output	signed [pVVAW:0] 		oDotSquareTop4,
	output	signed [pVVAW:0] 		oDotSquareUnder4,
	output		   [pColorDepth-1:0]oDotSquareColor5,
	output	signed [pVHAW:0] 		oDotSquareLeft5,
	output	signed [pVHAW:0] 		oDotSquareRight5,
	output	signed [pVVAW:0] 		oDotSquareTop5,
	output	signed [pVVAW:0] 		oDotSquareUnder5,
	// Csr SceneChange
    output	[pColorDepth-1:0] 	oSceneColor,
	output 	[6:0] 				oSceneFrameTiming,
	output 						oSceneFrameAddEn,
	output 						oSceneFrameSubEn,
    output 						oSceneFrameRst,
	input						iSceneAlphaMax,
	input 						iSceneAlphaMin,
    // CLK Reset
    input	iSRST,
    input	iSCLK
);

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg rDmaEnable;											assign oDmaEnable 		= rDmaEnable;		// DMA Function Enable
reg rDmaCycleEnable;									assign oDmaCycleEnable	= rDmaCycleEnable;	// Dma Auto Cycle Mode
reg [pDmaAdrsWidth-1:0] rDmaAdrsStart;					assign oDmaAdrsStart 	= rDmaAdrsStart;	// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsEnd;					assign oDmaAdrsEnd 		= rDmaAdrsEnd;		// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsAdd;					assign oDmaAdrsAdd 		= rDmaAdrsAdd;		// 
//
reg [ 7:0] rMapXSize;									assign oMapXSize		= rMapXSize;		// 現在のマップの最大横幅 / 最大255マス固定
reg [ 7:0] rMapYSize;									assign oMapYSize		= rMapYSize;		// 現在のマップの最大縦幅 / 最大255マス固定
//
reg 	   [pColorDepth-1:0]	rDotSquareColor1;		assign oDotSquareColor1 = rDotSquareColor1;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft1;		assign oDotSquareLeft1 	= rDotSquareLeft1;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight1;		assign oDotSquareRight1 = rDotSquareRight1;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop1;			assign oDotSquareTop1 	= rDotSquareTop1;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder1;		assign oDotSquareUnder1 = rDotSquareUnder1;	// 四角形描画 下 座標
reg 	   [pColorDepth-1:0]	rDotSquareColor2;		assign oDotSquareColor2 = rDotSquareColor2;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft2;		assign oDotSquareLeft2 	= rDotSquareLeft2;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight2;		assign oDotSquareRight2 = rDotSquareRight2;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop2;			assign oDotSquareTop2 	= rDotSquareTop2;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder2;		assign oDotSquareUnder2 = rDotSquareUnder2;	// 四角形描画 下 座標
reg 	   [pColorDepth-1:0]	rDotSquareColor3;		assign oDotSquareColor3 = rDotSquareColor3;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft3;		assign oDotSquareLeft3 	= rDotSquareLeft3;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight3;		assign oDotSquareRight3 = rDotSquareRight3;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop3;			assign oDotSquareTop3 	= rDotSquareTop3;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder3;		assign oDotSquareUnder3 = rDotSquareUnder3;	// 四角形描画 下 座標
reg 	   [pColorDepth-1:0]	rDotSquareColor4;		assign oDotSquareColor4 = rDotSquareColor4;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft4;		assign oDotSquareLeft4 	= rDotSquareLeft4;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight4;		assign oDotSquareRight4 = rDotSquareRight4;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop4;			assign oDotSquareTop4 	= rDotSquareTop4;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder4;		assign oDotSquareUnder4 = rDotSquareUnder4;	// 四角形描画 下 座標
reg 	   [pColorDepth-1:0]	rDotSquareColor5;		assign oDotSquareColor5 = rDotSquareColor5;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft5;		assign oDotSquareLeft5 	= rDotSquareLeft5;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight5;		assign oDotSquareRight5 = rDotSquareRight5;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop5;			assign oDotSquareTop5 	= rDotSquareTop5;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder5;		assign oDotSquareUnder5 = rDotSquareUnder5;	// 四角形描画 下 座標
//
reg [pColorDepth-1:0] 	rSceneColor;					assign oSceneColor			= rSceneColor;			// 描画色
reg [6:0] 				rSceneFrameTiming;				assign oSceneFrameTiming	= rSceneFrameTiming;	// SceneChange の更新速度,fps基準
reg 					rSceneFrameAddEn;				assign oSceneFrameAddEn		= rSceneFrameAddEn;		// SceneChange Add Start
reg 					rSceneFrameSubEn;				assign oSceneFrameSubEn		= rSceneFrameSubEn;		// SceneChange Sub Start
reg 					rSceneFrameRst;					assign oSceneFrameRst		= rSceneFrameRst;		// local module Rst 信号
//
reg qCsrWCke000, qCsrWCke004, qCsrWCke008, qCsrWCke00c;
reg qCsrWCke010, qCsrWCke014, qCsrWCke018, qCsrWCke01c;
//
reg qCsrWCke100, qCsrWCke104, qCsrWCke108, qCsrWCke10c;
reg qCsrWCke110, qCsrWCke114, qCsrWCke118, qCsrWCke11c;
reg qCsrWCke120, qCsrWCke124, qCsrWCke128, qCsrWCke12c;
reg qCsrWCke130, qCsrWCke134, qCsrWCke138, qCsrWCke13c;
//
reg qCsrWCke200, qCsrWCke201, qCsrWCke202, qCsrWCke203, qCsrWCke204, qCsrWCke205, qCsrWCke206, qCsrWCke207;
reg qCsrWCke208, qCsrWCke209, qCsrWCke20a, qCsrWCke20b, qCsrWCke20c, qCsrWCke20d, qCsrWCke20e, qCsrWCke20f;
reg qCsrWCke210, qCsrWCke211, qCsrWCke212, qCsrWCke213, qCsrWCke214, qCsrWCke215, qCsrWCke216, qCsrWCke217;
reg qCsrWCke218;
//
reg qCsrWCke300, qCsrWCke301, qCsrWCke302, qCsrWCke303, qCsrWCke304;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rDmaEnable 			<= 1'b0;
		rDmaCycleEnable		<= 1'b0;
		rDmaAdrsStart 		<= {pDmaAdrsWidth{1'b0}};
		rDmaAdrsEnd 		<= {pDmaAdrsWidth{1'b1}};
		rDmaAdrsAdd 		<= {pDmaAdrsWidth{1'b0}};
		rMapXSize			<= 8'd30;		// DisplayX(480) / MapChipX(16) = 30
		rMapYSize			<= 8'd17;		// DisplayY(272) / MapChipY(16) = 17
		rDotSquareColor1	<= {pColorDepth{1'b0}};
		rDotSquareLeft1		<= {(pVHAW+1){1'b0}};
		rDotSquareRight1	<= {(pVHAW+1){1'b0}};
		rDotSquareTop1		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder1	<= {(pVVAW+1){1'b0}};
		rDotSquareColor2	<= {pColorDepth{1'b0}};
		rDotSquareLeft2		<= {(pVHAW+1){1'b0}};
		rDotSquareRight2	<= {(pVHAW+1){1'b0}};
		rDotSquareTop2		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder2	<= {(pVVAW+1){1'b0}};
		rDotSquareColor3	<= {pColorDepth{1'b0}};
		rDotSquareLeft3		<= {(pVHAW+1){1'b0}};
		rDotSquareRight3	<= {(pVHAW+1){1'b0}};
		rDotSquareTop3		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder3	<= {(pVVAW+1){1'b0}};
		rDotSquareColor4	<= {pColorDepth{1'b0}};
		rDotSquareLeft4		<= {(pVHAW+1){1'b0}};
		rDotSquareRight4	<= {(pVHAW+1){1'b0}};
		rDotSquareTop4		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder4	<= {(pVVAW+1){1'b0}};
		rDotSquareColor5	<= {pColorDepth{1'b0}};
		rDotSquareLeft5		<= {(pVHAW+1){1'b0}};
		rDotSquareRight5	<= {(pVHAW+1){1'b0}};
		rDotSquareTop5		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder5	<= {(pVVAW+1){1'b0}};
		rSceneColor			<= {pColorDepth{1'b0}};
		rSceneFrameTiming	<= 7'd0;
		rSceneFrameAddEn	<= 1'b0;
		rSceneFrameSubEn	<= 1'b0;
		rSceneFrameRst		<= 1'b1;
	end
	else
	begin
		//
		rDmaEnable					<= iDmaDone	   ? rDmaCycleEnable : qCsrWCke004 ? iSUsiWd[0:0] : rDmaEnable;
		rDmaCycleEnable				<= qCsrWCke008 ? iSUsiWd[0:0] : rDmaCycleEnable;
		rDmaAdrsStart				<= qCsrWCke00c ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsStart;
		rDmaAdrsEnd					<= qCsrWCke010 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsEnd;
		rDmaAdrsAdd					<= qCsrWCke014 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsAdd;
		// Map Info
		{rMapXSize, rMapYSize}		<= qCsrWCke100 ? iSUsiWd[15:0]				: {rMapXSize, rMapYSize};
		// Dot Square Gen
		rDotSquareColor1			<= qCsrWCke200 ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor1;
		rDotSquareLeft1				<= qCsrWCke201 ? iSUsiWd[pVHAW:0]			: rDotSquareLeft1;
		rDotSquareRight1			<= qCsrWCke202 ? iSUsiWd[pVHAW:0]			: rDotSquareRight1;
		rDotSquareTop1				<= qCsrWCke203 ? iSUsiWd[pVVAW:0]			: rDotSquareTop1;
		rDotSquareUnder1			<= qCsrWCke204 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder1;
		rDotSquareColor2			<= qCsrWCke205 ? iSUsiWd[pVHAW:0]			: rDotSquareColor2;
		rDotSquareLeft2 			<= qCsrWCke206 ? iSUsiWd[pVHAW:0]			: rDotSquareLeft2;
		rDotSquareRight2			<= qCsrWCke207 ? iSUsiWd[pVVAW:0]			: rDotSquareRight2;
		rDotSquareTop2 				<= qCsrWCke208 ? iSUsiWd[pVVAW:0]			: rDotSquareTop2;
		rDotSquareUnder2			<= qCsrWCke209 ? iSUsiWd[pVHAW:0]			: rDotSquareUnder2;
		rDotSquareColor3			<= qCsrWCke20a ? iSUsiWd[pVHAW:0]			: rDotSquareColor3;
		rDotSquareLeft3				<= qCsrWCke20b ? iSUsiWd[pVVAW:0]			: rDotSquareLeft3;
		rDotSquareRight3			<= qCsrWCke20c ? iSUsiWd[pVVAW:0]			: rDotSquareRight3;
		rDotSquareTop3				<= qCsrWCke20d ? iSUsiWd[pVHAW:0]			: rDotSquareTop3;
		rDotSquareUnder3			<= qCsrWCke20e ? iSUsiWd[pVHAW:0]			: rDotSquareUnder3;
		rDotSquareColor4			<= qCsrWCke20f ? iSUsiWd[pVVAW:0]			: rDotSquareColor4;
		rDotSquareLeft4 			<= qCsrWCke210 ? iSUsiWd[pVVAW:0]			: rDotSquareLeft4;
		rDotSquareRight4			<= qCsrWCke211 ? iSUsiWd[pVHAW:0]			: rDotSquareRight4;
		rDotSquareTop4  			<= qCsrWCke212 ? iSUsiWd[pVHAW:0]			: rDotSquareTop4;
		rDotSquareUnder4			<= qCsrWCke213 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder4;
		rDotSquareColor5			<= qCsrWCke214 ? iSUsiWd[pVVAW:0]			: rDotSquareColor5;
		rDotSquareLeft5				<= qCsrWCke215 ? iSUsiWd[pVHAW:0]			: rDotSquareLeft5;
		rDotSquareRight5			<= qCsrWCke216 ? iSUsiWd[pVHAW:0]			: rDotSquareRight5;
		rDotSquareTop5				<= qCsrWCke217 ? iSUsiWd[pVVAW:0]			: rDotSquareTop5;
		rDotSquareUnder5			<= qCsrWCke218 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder5;
		// Scene Change
		rSceneColor					<= qCsrWCke300 ? iSUsiWd[pColorDepth-1:0]	: rSceneColor;
		rSceneFrameTiming			<= qCsrWCke301 ? iSUsiWd[6:0] 				: rSceneFrameTiming;
		rSceneFrameAddEn			<= qCsrWCke302 ? iSUsiWd[0:0]				: rSceneFrameAddEn;
		rSceneFrameSubEn			<= qCsrWCke303 ? iSUsiWd[1:1]				: rSceneFrameSubEn;
		rSceneFrameRst				<= qCsrWCke304 ? iSUsiWd[2:2]				: rSceneFrameRst;
	end
end

always @*
begin
	qCsrWCke000 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h000});
	qCsrWCke004 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h000});
	qCsrWCke008 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h000});
	qCsrWCke00c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h000});
	//
	qCsrWCke010 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h010});
	qCsrWCke014 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h014});
	qCsrWCke018 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h018});
	qCsrWCke01c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h01c});
	qCsrWCke100 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h100});
	qCsrWCke104 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h104});
	qCsrWCke108 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h108});
	qCsrWCke10c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h10c});
	qCsrWCke110 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h110});
	qCsrWCke114 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h114});
	// 200h ~
	qCsrWCke200 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h200});
	qCsrWCke201 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h201});
	qCsrWCke202 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h202});
	qCsrWCke203 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h203});
	qCsrWCke204 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h204});
	qCsrWCke205 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h205});
	qCsrWCke206 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h206});
	qCsrWCke207 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h207});
	qCsrWCke208 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h208});
	qCsrWCke209 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h209});
	qCsrWCke20a <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h20a});
	qCsrWCke20b <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h20b});
	qCsrWCke20c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h20c});
	qCsrWCke20d <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h20d});
	qCsrWCke20e <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h20e});
	qCsrWCke20f <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h20f});
	qCsrWCke210 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h210});
	qCsrWCke211 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h211});
	qCsrWCke212 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h212});
	qCsrWCke213 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h213});
	qCsrWCke214 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h214});
	qCsrWCke215 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h215});
	qCsrWCke216 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h216});
	qCsrWCke217 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h217});
	qCsrWCke218 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h218});
	// 300h ~
	qCsrWCke300 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h300});
	qCsrWCke301 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h301});
	qCsrWCke302 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h302});
	qCsrWCke303 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h303});
	qCsrWCke304 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 12'h304});
end


//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth - 1:0])
		// 'h0000:		rSUsiRd <= {{(32 - 1			 ){1'b0}}, rI2SModuleRst};
		'h004:		rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaEnable};
		'h008:		rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaCycleEnable};
		'h00C:		rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsStart};
		'h010:		rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsEnd};
		'h014:		rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsAdd};
		//
		'h100:		rSUsiRd	<= {{(32 - 16				){1'b0}}, rMapXSize, rMapYSize	};
		//
		'h200:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rDotSquareColor1	};
		'h201:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft1	};
		'h202:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight1	};
		'h203:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop1	};
		'h204:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder1	};
		'h205:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rDotSquareColor2	};
		'h206:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft2	};
		'h207:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight2	};
		'h208:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop2	};
		'h209:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder2	};
		'h20a:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rDotSquareColor3	};
		'h20b:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft3	};
		'h20c:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight3	};
		'h20d:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop3	};
		'h20e:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder3	};
		'h20f:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rDotSquareColor4	};
		'h210:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft4	};
		'h211:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight4	};
		'h212:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop4	};
		'h213:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder4	};
		'h214:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rDotSquareColor5	};
		'h215:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft5	};
		'h216:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight5	};
		'h217:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop5	};
		'h218:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder5	};
		//
		'h300:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rSceneColor										};
		'h301:		rSUsiRd	<= {{(32 - 7				){1'b0}}, rSceneFrameTiming									};
		'h302:		rSUsiRd	<= {{(32 - 3				){1'b0}}, rSceneFrameRst,rSceneFrameSubEn,rSceneFrameAddEn	};
		'h303:		rSUsiRd	<= {{(32 - 2				){1'b0}}, {iSceneAlphaMax,iSceneAlphaMin}					};
		default: 	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule