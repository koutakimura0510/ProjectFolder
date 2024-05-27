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
	parameter	pColorDepth	= 32
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0]		oSUsiRd,	// Read Data
	// Bus Master Write
	input	[pUsiBusWidth-1:0]		iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0]		iSUsiAdrs,  // R/W Adrs
	// Csr DMA
	output							oDmaEnable,
	output							oDmaCycleEnable,
	output	[pDmaAdrsWidth-1:0] 	oDmaAdrsStart,
	output	[pDmaAdrsWidth-1:0] 	oDmaAdrsEnd,
	output	[pDmaAdrsWidth-1:0] 	oDmaAdrsAdd,
	input							iDmaDone,
	// Csr Vsg
	output							oVsgRst,
	// Csr TFT Config
	output	[7:0]					oTftData,
	output							oTftRST,
	output							oTftWR,
	output							oTftRD,
	output							oTftRS,
	output							oTftCS,
	output	[3:0]					oTftIM,
	output							oTftGate,
	// Csr Map Info
	output	[7:0] 					oMapXSize,
	output	[7:0] 					oMapYSize,
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
	output		   [pColorDepth-1:0]oDotSquareColor6,
	output	signed [pVHAW:0] 		oDotSquareLeft6,
	output	signed [pVHAW:0] 		oDotSquareRight6,
	output	signed [pVVAW:0] 		oDotSquareTop6,
	output	signed [pVVAW:0] 		oDotSquareUnder6,
	output		   [pColorDepth-1:0]oDotSquareColor7,
	output	signed [pVHAW:0] 		oDotSquareLeft7,
	output	signed [pVHAW:0] 		oDotSquareRight7,
	output	signed [pVVAW:0] 		oDotSquareTop7,
	output	signed [pVVAW:0] 		oDotSquareUnder7,
	// Csr SceneChange
    output	[pColorDepth-1:0] 	oSceneColor,
	output 	[6:0] 				oSceneFrameTiming,
	output 						oSceneFrameAddEn,
	output 						oSceneFrameSubEn,
    output 						oSceneFrameRst,
	input						iSceneAlphaMax,
	input 						iSceneAlphaMin,
	//
	input	[pVHAW-1:0]			iPdpHpos,
	input	[pVVAW-1:0]			iPdpVpos,
    // CLK Reset
    input	iSRST,
    input	iSCLK
);

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
//
reg rDmaEnable;											assign oDmaEnable 		= rDmaEnable;		// DMA Function Enable
reg rDmaCycleEnable;									assign oDmaCycleEnable	= rDmaCycleEnable;	// Dma Auto Cycle Mode
reg [pDmaAdrsWidth-1:0] rDmaAdrsStart;					assign oDmaAdrsStart 	= rDmaAdrsStart;	// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsEnd;					assign oDmaAdrsEnd 		= rDmaAdrsEnd;		// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsAdd;					assign oDmaAdrsAdd 		= rDmaAdrsAdd;		//
//
reg			rVsgRst;									assign	oVsgRst			= rVsgRst;
//
reg [7:0] 	rTftData;									assign  oTftData		= rTftData;
reg 		rTftRST;									assign  oTftRST		 	= rTftRST;
reg 		rTftWR;										assign  oTftWR		 	= rTftWR;
reg 		rTftRD;										assign  oTftRD		 	= rTftRD;
reg 		rTftRS;										assign  oTftRS		 	= rTftRS;
reg 		rTftCS;										assign  oTftCS		 	= rTftCS;
reg [3:0] 	rTftIM;										assign  oTftIM		 	= rTftIM;
reg 		rTftGate;									assign  oTftGate		= rTftGate;
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
reg 	   [pColorDepth-1:0]	rDotSquareColor6;		assign oDotSquareColor6 = rDotSquareColor6;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft6;		assign oDotSquareLeft6 	= rDotSquareLeft6;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight6;		assign oDotSquareRight6 = rDotSquareRight6;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop6;			assign oDotSquareTop6 	= rDotSquareTop6;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder6;		assign oDotSquareUnder6 = rDotSquareUnder6;	// 四角形描画 下 座標
reg 	   [pColorDepth-1:0]	rDotSquareColor7;		assign oDotSquareColor7 = rDotSquareColor7;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft7;		assign oDotSquareLeft7 	= rDotSquareLeft7;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight7;		assign oDotSquareRight7 = rDotSquareRight7;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop7;			assign oDotSquareTop7 	= rDotSquareTop7;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder7;		assign oDotSquareUnder7 = rDotSquareUnder7;	// 四角形描画 下 座標
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
reg qCsrWCke020;
//
reg qCsrWCke050, qCsrWCke051, qCsrWCke052, qCsrWCke053;
reg qCsrWCke054, qCsrWCke055, qCsrWCke056, qCsrWCke057;
//
reg qCsrWCke100, qCsrWCke104, qCsrWCke108, qCsrWCke10c;
reg qCsrWCke110, qCsrWCke114, qCsrWCke118, qCsrWCke11c;
reg qCsrWCke120, qCsrWCke124, qCsrWCke128, qCsrWCke12c;
reg qCsrWCke130, qCsrWCke134, qCsrWCke138, qCsrWCke13c;
//
reg qCsrWCke200, qCsrWCke201, qCsrWCke202, qCsrWCke203, qCsrWCke204, qCsrWCke205, qCsrWCke206, qCsrWCke207;
reg qCsrWCke208, qCsrWCke209, qCsrWCke20a, qCsrWCke20b, qCsrWCke20c, qCsrWCke20d, qCsrWCke20e, qCsrWCke20f;
reg qCsrWCke210, qCsrWCke211, qCsrWCke212, qCsrWCke213, qCsrWCke214, qCsrWCke215, qCsrWCke216, qCsrWCke217;
reg qCsrWCke218, qCsrWCke219, qCsrWCke21a, qCsrWCke21b, qCsrWCke21c, qCsrWCke21d, qCsrWCke21e, qCsrWCke21f;
reg qCsrWCke220, qCsrWCke221, qCsrWCke222;
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
		rVsgRst				<= 1'b1;
		rTftData			<= 8'h00;
		rTftRST				<= 1'b0;
		rTftWR				<= 1'b0;		// WRX
		rTftRD				<= 1'b0;		// RCMD
		rTftRS				<= 1'b0;		// DCX
		rTftCS				<= 1'b1;		// CS
		rTftIM				<= 4'b0000;
		rTftGate			<= 1'b1;
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
		rDotSquareColor6	<= {pColorDepth{1'b0}};
		rDotSquareLeft6		<= {(pVHAW+1){1'b0}};
		rDotSquareRight6	<= {(pVHAW+1){1'b0}};
		rDotSquareTop6		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder6	<= {(pVVAW+1){1'b0}};
		rDotSquareColor7	<= {pColorDepth{1'b0}};
		rDotSquareLeft7		<= {(pVHAW+1){1'b0}};
		rDotSquareRight7	<= {(pVHAW+1){1'b0}};
		rDotSquareTop7		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder7	<= {(pVVAW+1){1'b0}};
		rSceneColor			<= {pColorDepth{1'b0}};
		rSceneFrameTiming	<= 7'd0;
		rSceneFrameAddEn	<= 1'b0;
		rSceneFrameSubEn	<= 1'b0;
		rSceneFrameRst		<= 1'b1;
	end
	else
	begin
		// DMA Info
		rDmaEnable					<= iDmaDone	   ? rDmaCycleEnable : qCsrWCke004 ? iSUsiWd[0:0] : rDmaEnable;
		rDmaCycleEnable				<= qCsrWCke008 ? iSUsiWd[0:0] : rDmaCycleEnable;
		rDmaAdrsStart				<= qCsrWCke00c ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsStart;
		rDmaAdrsEnd					<= qCsrWCke010 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsEnd;
		rDmaAdrsAdd					<= qCsrWCke014 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsAdd;
		// Video Sync Gen
		rVsgRst						<= qCsrWCke020 ? iSUsiWd[0:0] : rVsgRst;
		// TFT Config
		rTftData					<= qCsrWCke050 ? iSUsiWd[7:0] : rTftData;
		rTftRST						<= qCsrWCke051 ? iSUsiWd[0:0] : rTftRST;
		rTftWR						<= qCsrWCke052 ? iSUsiWd[0:0] : rTftWR;
		rTftRD						<= qCsrWCke053 ? iSUsiWd[0:0] : rTftRD;
		rTftRS						<= qCsrWCke054 ? iSUsiWd[0:0] : rTftRS;
		rTftIM						<= qCsrWCke055 ? iSUsiWd[3:0] : rTftIM;
		rTftGate					<= qCsrWCke056 ? iSUsiWd[0:0] : rTftGate;
		rTftCS						<= qCsrWCke057 ? iSUsiWd[0:0] : rTftCS;
		// Map Info
		{rMapXSize, rMapYSize}		<= qCsrWCke100 ? iSUsiWd[15:0]				: {rMapXSize, rMapYSize};
		// Dot Square Gen
		rDotSquareColor1			<= qCsrWCke200 ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor1;
		rDotSquareLeft1				<= qCsrWCke201 ? iSUsiWd[pVHAW:0]			: rDotSquareLeft1;
		rDotSquareRight1			<= qCsrWCke202 ? iSUsiWd[pVHAW:0]			: rDotSquareRight1;
		rDotSquareTop1				<= qCsrWCke203 ? iSUsiWd[pVVAW:0]			: rDotSquareTop1;
		rDotSquareUnder1			<= qCsrWCke204 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder1;
		rDotSquareColor2			<= qCsrWCke205 ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor2;
		rDotSquareLeft2 			<= qCsrWCke206 ? iSUsiWd[pVHAW:0]			: rDotSquareLeft2;
		rDotSquareRight2			<= qCsrWCke207 ? iSUsiWd[pVHAW:0]			: rDotSquareRight2;
		rDotSquareTop2 				<= qCsrWCke208 ? iSUsiWd[pVVAW:0]			: rDotSquareTop2;
		rDotSquareUnder2			<= qCsrWCke209 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder2;
		rDotSquareColor3			<= qCsrWCke20a ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor3;
		rDotSquareLeft3				<= qCsrWCke20b ? iSUsiWd[pVHAW:0]			: rDotSquareLeft3;
		rDotSquareRight3			<= qCsrWCke20c ? iSUsiWd[pVHAW:0]			: rDotSquareRight3;
		rDotSquareTop3				<= qCsrWCke20d ? iSUsiWd[pVVAW:0]			: rDotSquareTop3;
		rDotSquareUnder3			<= qCsrWCke20e ? iSUsiWd[pVVAW:0]			: rDotSquareUnder3;
		rDotSquareColor4			<= qCsrWCke20f ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor4;
		rDotSquareLeft4 			<= qCsrWCke210 ? iSUsiWd[pVHAW:0]			: rDotSquareLeft4;
		rDotSquareRight4			<= qCsrWCke211 ? iSUsiWd[pVHAW:0]			: rDotSquareRight4;
		rDotSquareTop4  			<= qCsrWCke212 ? iSUsiWd[pVVAW:0]			: rDotSquareTop4;
		rDotSquareUnder4			<= qCsrWCke213 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder4;
		rDotSquareColor5			<= qCsrWCke214 ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor5;
		rDotSquareLeft5				<= qCsrWCke215 ? iSUsiWd[pVHAW:0]			: rDotSquareLeft5;
		rDotSquareRight5			<= qCsrWCke216 ? iSUsiWd[pVHAW:0]			: rDotSquareRight5;
		rDotSquareTop5				<= qCsrWCke217 ? iSUsiWd[pVVAW:0]			: rDotSquareTop5;
		rDotSquareUnder5			<= qCsrWCke218 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder5;
		rDotSquareColor6			<= qCsrWCke219 ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor6;
		rDotSquareLeft6				<= qCsrWCke21a ? iSUsiWd[pVHAW:0]			: rDotSquareLeft6;
		rDotSquareRight6			<= qCsrWCke21b ? iSUsiWd[pVHAW:0]			: rDotSquareRight6;
		rDotSquareTop6				<= qCsrWCke21c ? iSUsiWd[pVVAW:0]			: rDotSquareTop6;
		rDotSquareUnder6			<= qCsrWCke21d ? iSUsiWd[pVVAW:0]			: rDotSquareUnder6;
		rDotSquareColor7			<= qCsrWCke21e ? iSUsiWd[pColorDepth-1:0]	: rDotSquareColor7;
		rDotSquareLeft7				<= qCsrWCke21f ? iSUsiWd[pVHAW:0]			: rDotSquareLeft7;
		rDotSquareRight7			<= qCsrWCke220 ? iSUsiWd[pVHAW:0]			: rDotSquareRight7;
		rDotSquareTop7				<= qCsrWCke221 ? iSUsiWd[pVVAW:0]			: rDotSquareTop7;
		rDotSquareUnder7			<= qCsrWCke222 ? iSUsiWd[pVVAW:0]			: rDotSquareUnder7;
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
	qCsrWCke000 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke004 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke008 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke00c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	// 010h ~
	qCsrWCke010 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke014 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke018 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
	qCsrWCke01c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h001c});
	// 020h
	qCsrWCke020 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0020});
	// 050h ~
	qCsrWCke050 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0050});
	qCsrWCke051 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0051});
	qCsrWCke052 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0052});
	qCsrWCke053 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0053});
	qCsrWCke054 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0054});
	qCsrWCke055 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0055});
	qCsrWCke056 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0056});
	qCsrWCke057 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0057});
	
	// 100h ~
	qCsrWCke100 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0100});
	qCsrWCke104 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0104});
	qCsrWCke108 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0108});
	qCsrWCke10c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h010c});
	qCsrWCke110 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0110});
	qCsrWCke114 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0114});
	// 200h ~
	qCsrWCke200 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0200});
	qCsrWCke201 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0201});
	qCsrWCke202 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0202});
	qCsrWCke203 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0203});
	qCsrWCke204 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0204});
	qCsrWCke205 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0205});
	qCsrWCke206 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0206});
	qCsrWCke207 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0207});
	qCsrWCke208 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0208});
	qCsrWCke209 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0209});
	qCsrWCke20a <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h020a});
	qCsrWCke20b <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h020b});
	qCsrWCke20c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h020c});
	qCsrWCke20d <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h020d});
	qCsrWCke20e <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h020e});
	qCsrWCke20f <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h020f});
	qCsrWCke210 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0210});
	qCsrWCke211 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0211});
	qCsrWCke212 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0212});
	qCsrWCke213 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0213});
	qCsrWCke214 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0214});
	qCsrWCke215 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0215});
	qCsrWCke216 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0216});
	qCsrWCke217 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0217});
	qCsrWCke218 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0218});
	qCsrWCke219 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0219});
	qCsrWCke21a <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h021a});
	qCsrWCke21b <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h021b});
	qCsrWCke21c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h021c});
	qCsrWCke21d <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h021d});
	qCsrWCke21e <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h021e});
	qCsrWCke21f <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h021f});
	qCsrWCke220 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0220});
	qCsrWCke221 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0221});
	qCsrWCke222 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0222});
	// 300h ~
	qCsrWCke300 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0300});
	qCsrWCke301 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0301});
	qCsrWCke302 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0302});
	qCsrWCke303 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0303});
	qCsrWCke304 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0304});
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
		'h004:		rSUsiRd <= {{(32 - 1			 	){1'b0}}, 	rDmaEnable			};
		'h008:		rSUsiRd <= {{(32 - 1			 	){1'b0}}, 	rDmaCycleEnable		};
		'h00C:		rSUsiRd <= {{(32 - pDmaAdrsWidth	){1'b0}},	rDmaAdrsStart		};
		'h010:		rSUsiRd <= {{(32 - pDmaAdrsWidth	){1'b0}},	rDmaAdrsEnd			};
		'h014:		rSUsiRd <= {{(32 - pDmaAdrsWidth	){1'b0}},	rDmaAdrsAdd			};
		// 020
		'h020:		rSUsiRd <= {{(32 - 31				){1'b0}},	rVsgRst				};
		// 050
		'h050:		rSUsiRd <= {{(32 - 8				){1'b0}},	rTftData			};
		'h051:		rSUsiRd <= {{(32 - 1				){1'b0}},	rTftRST				};
		'h052:		rSUsiRd <= {{(32 - 1				){1'b0}},	rTftWR				};
		'h053:		rSUsiRd <= {{(32 - 1				){1'b0}},	rTftRD				};
		'h054:		rSUsiRd <= {{(32 - 1				){1'b0}},	rTftRS				};
		'h055:		rSUsiRd <= {{(32 - 4				){1'b0}},	rTftIM				};
		'h056:		rSUsiRd <= {{(32 - 1				){1'b0}},	rTftGate			};
		'h057:		rSUsiRd <= {{(32 - 1				){1'b0}},	rTftCS				};
		//
		'h100:		rSUsiRd	<= {{(32 - 16				){1'b0}}, rMapXSize, rMapYSize	};
		//
		'h200:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/ rDotSquareColor1	};
		'h201:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft1		};
		'h202:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight1		};
		'h203:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop1		};
		'h204:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder1		};
		'h205:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/rDotSquareColor2		};
		'h206:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft2		};
		'h207:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight2		};
		'h208:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop2		};
		'h209:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder2		};
		'h20a:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/rDotSquareColor3		};
		'h20b:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft3		};
		'h20c:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight3		};
		'h20d:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop3		};
		'h20e:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder3		};
		'h20f:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/rDotSquareColor4		};
		'h210:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft4		};
		'h211:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight4		};
		'h212:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop4		};
		'h213:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder4		};
		'h214:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/rDotSquareColor5		};
		'h215:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft5		};
		'h216:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight5		};
		'h217:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop5		};
		'h218:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder5		};
		'h219:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/rDotSquareColor6		};
		'h21a:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft6		};
		'h21b:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight6		};
		'h21c:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop6		};
		'h21d:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder6		};
		'h21e:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/rDotSquareColor7		};
		'h21f:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft7		};
		'h220:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight7		};
		'h221:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop7		};
		'h222:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder7		};
		//
		'h300:		rSUsiRd	<= {/*{(32 - pColorDepth	){1'b0}},*/rSceneColor										};
		'h301:		rSUsiRd	<= {{(32 - 7				){1'b0}}, rSceneFrameTiming									};
		'h302:		rSUsiRd	<= {{(32 - 3				){1'b0}}, rSceneFrameRst,rSceneFrameSubEn,rSceneFrameAddEn	};
		'h303:		rSUsiRd	<= {{(32 - 2				){1'b0}}, {iSceneAlphaMax,iSceneAlphaMin}					};
		'h400:		rSUsiRd	<= {{(32 - pVHAW			){1'b0}}, iPdpHpos											};
		'h401:		rSUsiRd	<= {{(32 - pVVAW			){1'b0}}, iPdpVpos											};
		default: 	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule