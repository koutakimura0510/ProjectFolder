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
	parameter	pRegNumver		= 400,		// 設定可能なレジスタの個数
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
	parameter	pDstColorDepth	= 16,
	parameter	pSynColorDepth	= 24,
	//
	parameter	pObjectAnimeNum			= 8,	// アニメーション可能なオブジェクトの個数
	parameter	pObjectAnimeTime		= 8,	// アニメーション指定時間の最大時間 Bit幅で指定する。1フレーム単位で処理するため、8bit幅だったら 最大255フレーム間隔で可能になる。
	parameter	pObjectAnimeXposWidth	= 16,	// [15:11] NC Bit, [10:0] xpos
	parameter	pObjectAnimeYposWidth	= 16	// [15:11] NC Bit, [10:0] ypos
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0]		oSUsiRd,	// Read Data
	// Bus Master Write
	input	[pUsiBusWidth-1:0]		iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0]		iSUsiAdrs,  // R/W Adrs
	// Block RST
	output							oBlockRst,
	// Csr DMA
	output							oDmaEnable,
	output							oDmaCycleEnable,
	output	[pDmaAdrsWidth-1:0] 	oDmaAdrsStart,
	output	[pDmaAdrsWidth-1:0] 	oDmaAdrsEnd,
	output	[pDmaAdrsWidth-1:0] 	oDmaAdrsAdd,
	input							iDmaDone,
	// Csr Vsg
	output							oVsgRst,
	// Csr Vtu
	output	[pDstColorDepth-1:0]	oVtuMcuDq,
	output							oVtuMcuWRX,
	output							oVtuMcuDCX,
	output							oVtuMcuRDX,
	output							oVtuMcuCSX,
	output							oVtuMcuRST,
	output	[3:0]					oVtuMcuIM,
	output							oVtuMcuGate,
	output							oVtuConverterRst,
	output							oVtuMcuBL,
	output	[15:0]					oVtuBlDutyRatio,
	output	[31:0]					oVtuBlIVtimer,
	// Csr Vpg
	output							oVpgUnitRst,
	// Csr Map Info
	output	[7:0] 					oMapXSize,
	output	[7:0] 					oMapYSize,
	// Csr Dot Square Gen
	output		   [pSynColorDepth-1:0]oDotSquareColor1,
	output	signed [pVHAW:0] 		oDotSquareLeft1,
	output	signed [pVHAW:0] 		oDotSquareRight1,
	output	signed [pVVAW:0] 		oDotSquareTop1,
	output	signed [pVVAW:0] 		oDotSquareUnder1,
	output		   [pSynColorDepth-1:0]oDotSquareColor2,
	output	signed [pVHAW:0] 		oDotSquareLeft2,
	output	signed [pVHAW:0] 		oDotSquareRight2,
	output	signed [pVVAW:0] 		oDotSquareTop2,
	output	signed [pVVAW:0] 		oDotSquareUnder2,
	output		   [pSynColorDepth-1:0]oDotSquareColor3,
	output	signed [pVHAW:0] 		oDotSquareLeft3,
	output	signed [pVHAW:0] 		oDotSquareRight3,
	output	signed [pVVAW:0] 		oDotSquareTop3,
	output	signed [pVVAW:0] 		oDotSquareUnder3,
	output		   [pSynColorDepth-1:0]oDotSquareColor4,
	output	signed [pVHAW:0] 		oDotSquareLeft4,
	output	signed [pVHAW:0] 		oDotSquareRight4,
	output	signed [pVVAW:0] 		oDotSquareTop4,
	output	signed [pVVAW:0] 		oDotSquareUnder4,
	output		   [pSynColorDepth-1:0]oDotSquareColor5,
	output	signed [pVHAW:0] 		oDotSquareLeft5,
	output	signed [pVHAW:0] 		oDotSquareRight5,
	output	signed [pVVAW:0] 		oDotSquareTop5,
	output	signed [pVVAW:0] 		oDotSquareUnder5,
	output		   [pSynColorDepth-1:0]oDotSquareColor6,
	output	signed [pVHAW:0] 		oDotSquareLeft6,
	output	signed [pVHAW:0] 		oDotSquareRight6,
	output	signed [pVVAW:0] 		oDotSquareTop6,
	output	signed [pVVAW:0] 		oDotSquareUnder6,
	output		   [pSynColorDepth-1:0]oDotSquareColor7,
	output	signed [pVHAW:0] 		oDotSquareLeft7,
	output	signed [pVHAW:0] 		oDotSquareRight7,
	output	signed [pVVAW:0] 		oDotSquareTop7,
	output	signed [pVVAW:0] 		oDotSquareUnder7,
	// Csr SceneChange
	output	[pSynColorDepth-1:0] 	oSceneColor,
	output 	[6:0] 					oSceneFrameTiming,
	output 							oSceneFrameAddEn,
	output 							oSceneFrameSubEn,
	output 							oSceneFrameRst,
	input							iSceneAlphaMax,
	input 							iSceneAlphaMin,
	// Base Draw Position
	input	[pVHAW-1:0]				iBdpHpos,
	input	[pVVAW-1:0]				iBdpVpos,
	// Player Draw Position
	output	[pVHAW-1:0] 			oPdpXpos,
	output	[pVVAW-1:0] 			oPdpYpos,
	output							oPdpInit,
	// Object Draw
	output	[pObjectAnimeNum-1:0] 								oObdDrawEnable,
	output	[(pObjectAnimeNum * pObjectAnimeTime)-1:0] 			oObdAnimeFrameNum,
	output	[(pObjectAnimeNum * pObjectAnimeXposWidth)-1:0] 	oObdAnimeXpos,
	output	[(pObjectAnimeNum * pObjectAnimeYposWidth)-1:0] 	oObdAnimeYpos,
	// Player Draw
	output	[ 3:0]					oPldDrawPlayerSel,
	// Memory Mapchip Access
	output	[23:0]					oBramWd,
	output	[31:0]					oBramAdrs,
    // CLK Reset
    input	iSRST,
    input	iSCLK
);

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
genvar gen;
//
reg 							rBlockRst;				assign oBlockRst 		= rBlockRst;		// Block RST
reg 							rDmaEnable;				assign oDmaEnable 		= rDmaEnable;		// DMA Function Enable
reg 							rDmaCycleEnable;		assign oDmaCycleEnable	= rDmaCycleEnable;	// Dma Auto Cycle Mode
reg [pDmaAdrsWidth-1:0] 		rDmaAdrsStart;			assign oDmaAdrsStart 	= rDmaAdrsStart;	// 
reg [pDmaAdrsWidth-1:0] 		rDmaAdrsEnd;			assign oDmaAdrsEnd 		= rDmaAdrsEnd;		// 
reg [pDmaAdrsWidth-1:0] 		rDmaAdrsAdd;			assign oDmaAdrsAdd 		= rDmaAdrsAdd;		//
//
reg								rVsgRst;				assign	oVsgRst			= rVsgRst;
//
reg [pDstColorDepth-1:0] 		rVtuMcuDq;				assign  oVtuMcuDq		= rVtuMcuDq;
reg 							rVtuMcuWRX;				assign  oVtuMcuWRX	 	= rVtuMcuWRX;
reg 							rVtuMcuDCX;				assign  oVtuMcuDCX	 	= rVtuMcuDCX;
reg 							rVtuMcuRDX;				assign  oVtuMcuRDX	 	= rVtuMcuRDX;
reg 							rVtuMcuCSX;				assign  oVtuMcuCSX	 	= rVtuMcuCSX;
reg 							rVtuMcuRST;				assign  oVtuMcuRST	 	= rVtuMcuRST;
reg [3:0] 						rVtuMcuIM;				assign  oVtuMcuIM	 	= rVtuMcuIM;
reg 							rVtuMcuGate;			assign  oVtuMcuGate		= rVtuMcuGate;
reg 							rVtuConverterRst;		assign  oVtuConverterRst= rVtuConverterRst;
reg 							rVtuMcuBL;				assign  oVtuMcuBL		= rVtuMcuBL;
reg [15:0]						rVtuBlDutyRatio;		assign  oVtuBlDutyRatio	= rVtuBlDutyRatio;
reg [31:0]						rVtuBlIVtimer;			assign  oVtuBlIVtimer	= rVtuBlIVtimer;
//
reg 							rVpgUnitRst;			assign oVpgUnitRst		= rVpgUnitRst;
reg [ 7:0] 						rMapXSize;				assign oMapXSize		= rMapXSize;		// 現在のマップの最大横幅 / 最大255マス固定
reg [ 7:0] 						rMapYSize;				assign oMapYSize		= rMapYSize;		// 現在のマップの最大縦幅 / 最大255マス固定
//
reg 	   [pSynColorDepth-1:0]	rDotSquareColor1;		assign oDotSquareColor1 = rDotSquareColor1;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft1;		assign oDotSquareLeft1 	= rDotSquareLeft1;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight1;		assign oDotSquareRight1 = rDotSquareRight1;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop1;			assign oDotSquareTop1 	= rDotSquareTop1;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder1;		assign oDotSquareUnder1 = rDotSquareUnder1;	// 四角形描画 下 座標
reg 	   [pSynColorDepth-1:0]	rDotSquareColor2;		assign oDotSquareColor2 = rDotSquareColor2;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft2;		assign oDotSquareLeft2 	= rDotSquareLeft2;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight2;		assign oDotSquareRight2 = rDotSquareRight2;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop2;			assign oDotSquareTop2 	= rDotSquareTop2;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder2;		assign oDotSquareUnder2 = rDotSquareUnder2;	// 四角形描画 下 座標
reg 	   [pSynColorDepth-1:0]	rDotSquareColor3;		assign oDotSquareColor3 = rDotSquareColor3;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft3;		assign oDotSquareLeft3 	= rDotSquareLeft3;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight3;		assign oDotSquareRight3 = rDotSquareRight3;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop3;			assign oDotSquareTop3 	= rDotSquareTop3;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder3;		assign oDotSquareUnder3 = rDotSquareUnder3;	// 四角形描画 下 座標
reg 	   [pSynColorDepth-1:0]	rDotSquareColor4;		assign oDotSquareColor4 = rDotSquareColor4;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft4;		assign oDotSquareLeft4 	= rDotSquareLeft4;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight4;		assign oDotSquareRight4 = rDotSquareRight4;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop4;			assign oDotSquareTop4 	= rDotSquareTop4;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder4;		assign oDotSquareUnder4 = rDotSquareUnder4;	// 四角形描画 下 座標
reg 	   [pSynColorDepth-1:0]	rDotSquareColor5;		assign oDotSquareColor5 = rDotSquareColor5;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft5;		assign oDotSquareLeft5 	= rDotSquareLeft5;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight5;		assign oDotSquareRight5 = rDotSquareRight5;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop5;			assign oDotSquareTop5 	= rDotSquareTop5;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder5;		assign oDotSquareUnder5 = rDotSquareUnder5;	// 四角形描画 下 座標
reg 	   [pSynColorDepth-1:0]	rDotSquareColor6;		assign oDotSquareColor6 = rDotSquareColor6;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft6;		assign oDotSquareLeft6 	= rDotSquareLeft6;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight6;		assign oDotSquareRight6 = rDotSquareRight6;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop6;			assign oDotSquareTop6 	= rDotSquareTop6;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder6;		assign oDotSquareUnder6 = rDotSquareUnder6;	// 四角形描画 下 座標
reg 	   [pSynColorDepth-1:0]	rDotSquareColor7;		assign oDotSquareColor7 = rDotSquareColor7;	// 四角形描画 色
reg signed [pVHAW:0] 			rDotSquareLeft7;		assign oDotSquareLeft7 	= rDotSquareLeft7;	// 四角形描画 左 座標
reg signed [pVHAW:0] 			rDotSquareRight7;		assign oDotSquareRight7 = rDotSquareRight7;	// 四角形描画 右 座標
reg signed [pVVAW:0] 			rDotSquareTop7;			assign oDotSquareTop7 	= rDotSquareTop7;	// 四角形描画 上 座標
reg signed [pVVAW:0] 			rDotSquareUnder7;		assign oDotSquareUnder7 = rDotSquareUnder7;	// 四角形描画 下 座標
//
reg [pSynColorDepth-1:0] 		rSceneColor;			assign oSceneColor			= rSceneColor;			// 描画色
reg [6:0] 						rSceneFrameTiming;		assign oSceneFrameTiming	= rSceneFrameTiming;	// SceneChange の更新速度,fps基準
reg 							rSceneFrameAddEn;		assign oSceneFrameAddEn		= rSceneFrameAddEn;		// SceneChange Add Start
reg 							rSceneFrameSubEn;		assign oSceneFrameSubEn		= rSceneFrameSubEn;		// SceneChange Sub Start
reg 							rSceneFrameRst;			assign oSceneFrameRst		= rSceneFrameRst;		// local module Rst 信号
// Player Draw Position
reg [pVHAW-1:0]					rPdpXpos;				assign oPdpXpos				= rPdpXpos;
reg [pVHAW-1:0]					rPdpYpos;				assign oPdpYpos				= rPdpYpos;
reg 							rPdpInit;				assign oPdpInit				= rPdpInit;
// Object Draw
reg [pObjectAnimeNum-1:0] 								rObdDrawEnable;		assign oObdDrawEnable		= rObdDrawEnable;
reg [(pObjectAnimeNum * pObjectAnimeTime)-1:0] 			rObdAnimeFrameNum;	assign oObdAnimeFrameNum	= rObdAnimeFrameNum;
reg [(pObjectAnimeNum * pObjectAnimeXposWidth)-1:0] 	rObdAnimeXpos;		assign oObdAnimeXpos		= rObdAnimeXpos;
reg [(pObjectAnimeNum * pObjectAnimeYposWidth)-1:0] 	rObdAnimeYpos;		assign oObdAnimeYpos		= rObdAnimeYpos;
// Player Draw
reg [ 3:0] 						rPldDrawPlayerSel;		assign oPldDrawPlayerSel	= rPldDrawPlayerSel;
// Memory Mapchip Access
reg [23:0] 						rBramWd;				assign oBramWd				= rBramWd;				// Block Ram Write Data
reg [31:0] 						rBramAdrs;				assign oBramAdrs			= rBramAdrs;			// Block Raw Adrs [31:24]=Cahce Adrs
//
reg [pRegNumver-1:0] qCsrWCke;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rBlockRst			<= 1'b0;
		rDmaEnable 			<= 1'b0;
		rDmaCycleEnable		<= 1'b0;
		rDmaAdrsStart 		<= {pDmaAdrsWidth{1'b0}};
		rDmaAdrsEnd 		<= {pDmaAdrsWidth{1'b1}};
		rDmaAdrsAdd 		<= {pDmaAdrsWidth{1'b0}};
		rVsgRst				<= 1'b1;
		rVtuMcuDq			<= {pDstColorDepth{1'b0}};
		rVtuMcuWRX			<= 1'b0;
		rVtuMcuDCX			<= 1'b0;
		rVtuMcuRDX			<= 1'b0;
		rVtuMcuCSX			<= 1'b1;
		rVtuMcuRST			<= 1'b0;
		rVtuMcuIM			<= 4'b0000;
		rVtuMcuGate			<= 1'b1;		// Default Mcu Stream
		rVtuConverterRst	<= 1'b1;		// Default Assert
		rVtuMcuBL			<= 1'b0;
		rVtuBlDutyRatio		<= 16'd0;
		rVtuBlIVtimer		<= 32'd0;
		rVpgUnitRst			<= 1'b0;		// Default Negate
		rMapXSize			<= 8'd30;		// DisplayX(480) / MapChipX(16) = 30
		rMapYSize			<= 8'd17;		// DisplayY(272) / MapChipY(16) = 17
		rDotSquareColor1	<= {pSynColorDepth{1'b0}};
		rDotSquareLeft1		<= {(pVHAW+1){1'b0}};
		rDotSquareRight1	<= {(pVHAW+1){1'b0}};
		rDotSquareTop1		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder1	<= {(pVVAW+1){1'b0}};
		rDotSquareColor2	<= {pSynColorDepth{1'b0}};
		rDotSquareLeft2		<= {(pVHAW+1){1'b0}};
		rDotSquareRight2	<= {(pVHAW+1){1'b0}};
		rDotSquareTop2		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder2	<= {(pVVAW+1){1'b0}};
		rDotSquareColor3	<= {pSynColorDepth{1'b0}};
		rDotSquareLeft3		<= {(pVHAW+1){1'b0}};
		rDotSquareRight3	<= {(pVHAW+1){1'b0}};
		rDotSquareTop3		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder3	<= {(pVVAW+1){1'b0}};
		rDotSquareColor4	<= {pSynColorDepth{1'b0}};
		rDotSquareLeft4		<= {(pVHAW+1){1'b0}};
		rDotSquareRight4	<= {(pVHAW+1){1'b0}};
		rDotSquareTop4		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder4	<= {(pVVAW+1){1'b0}};
		rDotSquareColor5	<= {pSynColorDepth{1'b0}};
		rDotSquareLeft5		<= {(pVHAW+1){1'b0}};
		rDotSquareRight5	<= {(pVHAW+1){1'b0}};
		rDotSquareTop5		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder5	<= {(pVVAW+1){1'b0}};
		rDotSquareColor6	<= {pSynColorDepth{1'b0}};
		rDotSquareLeft6		<= {(pVHAW+1){1'b0}};
		rDotSquareRight6	<= {(pVHAW+1){1'b0}};
		rDotSquareTop6		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder6	<= {(pVVAW+1){1'b0}};
		rDotSquareColor7	<= {pSynColorDepth{1'b0}};
		rDotSquareLeft7		<= {(pVHAW+1){1'b0}};
		rDotSquareRight7	<= {(pVHAW+1){1'b0}};
		rDotSquareTop7		<= {(pVVAW+1){1'b0}};
		rDotSquareUnder7	<= {(pVVAW+1){1'b0}};
		rSceneColor			<= {pSynColorDepth{1'b0}};
		rSceneFrameTiming	<= 7'd0;
		rSceneFrameAddEn	<= 1'b0;
		rSceneFrameSubEn	<= 1'b0;
		rSceneFrameRst		<= 1'b1;
		rPdpXpos			<= {(pVHAW){1'b0}};;
		rPdpYpos			<= {(pVVAW){1'b0}};;
		rPdpInit			<= 1'b1;
		rObdDrawEnable		<= {pObjectAnimeNum{1'b0}};
		rObdAnimeFrameNum	<= {(pObjectAnimeNum * pObjectAnimeTime){1'b0}};
		rObdAnimeXpos		<= {(pObjectAnimeNum * pObjectAnimeXposWidth){1'b0}};
		rObdAnimeYpos		<= {(pObjectAnimeNum * pObjectAnimeYposWidth){1'b0}};
		rPldDrawPlayerSel	<= 4'd0;
		rBramWd				<= 24'd0;
		rBramAdrs			<= 32'd0;
	end
	else
	begin
		// DMA Info
		rBlockRst					<= qCsrWCke[0] ? iSUsiWd[0:0] 	: rBlockRst;
		// Video Sync Gen
		rVsgRst						<= qCsrWCke[20] ? iSUsiWd[0:0] : rVsgRst;
		// Video Tft Unit
		rVtuMcuDq					<= qCsrWCke[50] ? iSUsiWd[pDstColorDepth-1:0] : rVtuMcuDq;
		rVtuMcuWRX					<= qCsrWCke[51] ? iSUsiWd[0:0] : rVtuMcuWRX;
		rVtuMcuDCX					<= qCsrWCke[52] ? iSUsiWd[0:0] : rVtuMcuDCX;
		rVtuMcuRDX					<= qCsrWCke[53] ? iSUsiWd[0:0] : rVtuMcuRDX;
		rVtuMcuCSX					<= qCsrWCke[54] ? iSUsiWd[0:0] : rVtuMcuCSX;
		rVtuMcuRST					<= qCsrWCke[55] ? iSUsiWd[0:0] : rVtuMcuRST;
		rVtuMcuIM					<= qCsrWCke[56] ? iSUsiWd[3:0] : rVtuMcuIM;
		rVtuMcuGate					<= qCsrWCke[57] ? iSUsiWd[0:0] : rVtuMcuGate;
		rVtuConverterRst			<= qCsrWCke[58] ? iSUsiWd[0:0] : rVtuConverterRst;
		rVtuMcuBL					<= qCsrWCke[59] ? iSUsiWd[0:0] : rVtuMcuBL;
		rVtuBlDutyRatio				<= qCsrWCke[60] ? iSUsiWd[15:0] : rVtuBlDutyRatio;
		rVtuBlIVtimer				<= qCsrWCke[61] ? iSUsiWd[31:0] : rVtuBlIVtimer;
		// Vpg Memory Mapchip Access 90 ~ 99
		rBramWd						<= qCsrWCke[97] ? iSUsiWd[23:0] : rBramWd;
		rBramAdrs					<= qCsrWCke[98] ? iSUsiWd[31:0] : rBramAdrs;
		rVpgUnitRst					<= qCsrWCke[99] ? iSUsiWd[0:0]  : rVpgUnitRst;
		// Vpg Object 100 ~ 200
		rObdDrawEnable	 [pObjectAnimeNum-1:0]	<= qCsrWCke[100] ? iSUsiWd[pObjectAnimeNum-1:0]	: rObdDrawEnable	[pObjectAnimeNum-1:0];
		rObdAnimeFrameNum[(0*32)+:32]	<= qCsrWCke[101] ? iSUsiWd[31:0]			: rObdAnimeFrameNum [(0*32)+:32];
		rObdAnimeFrameNum[(1*32)+:32]	<= qCsrWCke[102] ? iSUsiWd[31:0]			: rObdAnimeFrameNum [(1*32)+:32];
		rObdAnimeFrameNum[(2*32)+:16]	<= qCsrWCke[103] ? iSUsiWd[15:0]			: rObdAnimeFrameNum [(2*32)+:16];
		rObdAnimeXpos	 [(0*32)+:32]	<= qCsrWCke[120] ? iSUsiWd[31:0]			: rObdAnimeXpos		[(0*32)+:32];
		rObdAnimeXpos	 [(1*32)+:32]	<= qCsrWCke[121] ? iSUsiWd[31:0]			: rObdAnimeXpos		[(1*32)+:32];
		rObdAnimeXpos	 [(2*32)+:32]	<= qCsrWCke[122] ? iSUsiWd[31:0]			: rObdAnimeXpos		[(2*32)+:32];
		rObdAnimeXpos	 [(3*32)+:32]	<= qCsrWCke[123] ? iSUsiWd[31:0]			: rObdAnimeXpos		[(3*32)+:32];
		rObdAnimeXpos	 [(4*32)+:32]	<= qCsrWCke[124] ? iSUsiWd[31:0]			: rObdAnimeXpos		[(4*32)+:32];
		rObdAnimeYpos	 [(0*32)+:32]	<= qCsrWCke[140] ? iSUsiWd[31:0]			: rObdAnimeYpos		[(0*32)+:32];
		rObdAnimeYpos	 [(1*32)+:32]	<= qCsrWCke[141] ? iSUsiWd[31:0]			: rObdAnimeYpos		[(1*32)+:32];
		rObdAnimeYpos	 [(2*32)+:32]	<= qCsrWCke[142] ? iSUsiWd[31:0]			: rObdAnimeYpos		[(2*32)+:32];
		rObdAnimeYpos	 [(3*32)+:32]	<= qCsrWCke[143] ? iSUsiWd[31:0]			: rObdAnimeYpos		[(3*32)+:32];
		rObdAnimeYpos	 [(4*32)+:32]	<= qCsrWCke[144] ? iSUsiWd[31:0]			: rObdAnimeYpos		[(4*32)+:32];
		// Vpg Player
		rPldDrawPlayerSel			<= qCsrWCke[170] ? iSUsiWd[ 3:0]				: rPldDrawPlayerSel;
		// Vpg Dot Square Gen
		rDotSquareColor1			<= qCsrWCke[200] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor1;
		rDotSquareLeft1				<= qCsrWCke[201] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft1;
		rDotSquareRight1			<= qCsrWCke[202] ? iSUsiWd[pVHAW:0]				: rDotSquareRight1;
		rDotSquareTop1				<= qCsrWCke[203] ? iSUsiWd[pVVAW:0]				: rDotSquareTop1;
		rDotSquareUnder1			<= qCsrWCke[204] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder1;
		rDotSquareColor2			<= qCsrWCke[205] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor2;
		rDotSquareLeft2 			<= qCsrWCke[206] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft2;
		rDotSquareRight2			<= qCsrWCke[207] ? iSUsiWd[pVHAW:0]				: rDotSquareRight2;
		rDotSquareTop2 				<= qCsrWCke[208] ? iSUsiWd[pVVAW:0]				: rDotSquareTop2;
		rDotSquareUnder2			<= qCsrWCke[209] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder2;
		rDotSquareColor3			<= qCsrWCke[210] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor3;
		rDotSquareLeft3				<= qCsrWCke[211] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft3;
		rDotSquareRight3			<= qCsrWCke[212] ? iSUsiWd[pVHAW:0]				: rDotSquareRight3;
		rDotSquareTop3				<= qCsrWCke[213] ? iSUsiWd[pVVAW:0]				: rDotSquareTop3;
		rDotSquareUnder3			<= qCsrWCke[214] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder3;
		rDotSquareColor4			<= qCsrWCke[215] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor4;
		rDotSquareLeft4 			<= qCsrWCke[216] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft4;
		rDotSquareRight4			<= qCsrWCke[217] ? iSUsiWd[pVHAW:0]				: rDotSquareRight4;
		rDotSquareTop4  			<= qCsrWCke[218] ? iSUsiWd[pVVAW:0]				: rDotSquareTop4;
		rDotSquareUnder4			<= qCsrWCke[219] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder4;
		rDotSquareColor5			<= qCsrWCke[220] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor5;
		rDotSquareLeft5				<= qCsrWCke[221] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft5;
		rDotSquareRight5			<= qCsrWCke[222] ? iSUsiWd[pVHAW:0]				: rDotSquareRight5;
		rDotSquareTop5				<= qCsrWCke[223] ? iSUsiWd[pVVAW:0]				: rDotSquareTop5;
		rDotSquareUnder5			<= qCsrWCke[224] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder5;
		rDotSquareColor6			<= qCsrWCke[225] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor6;
		rDotSquareLeft6				<= qCsrWCke[226] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft6;
		rDotSquareRight6			<= qCsrWCke[227] ? iSUsiWd[pVHAW:0]				: rDotSquareRight6;
		rDotSquareTop6				<= qCsrWCke[228] ? iSUsiWd[pVVAW:0]				: rDotSquareTop6;
		rDotSquareUnder6			<= qCsrWCke[229] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder6;
		rDotSquareColor7			<= qCsrWCke[230] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor7;
		rDotSquareLeft7				<= qCsrWCke[231] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft7;
		rDotSquareRight7			<= qCsrWCke[232] ? iSUsiWd[pVHAW:0]				: rDotSquareRight7;
		rDotSquareTop7				<= qCsrWCke[233] ? iSUsiWd[pVVAW:0]				: rDotSquareTop7;
		rDotSquareUnder7			<= qCsrWCke[234] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder7;
		// rDotSquareColor[(0 *  0)+:24]	<= qCsrWCke[200] ? iSUsiWd[pSynColorDepth-1:0]	: [(0 *  0)+:24];
		// rDotSquareColor[(1 * 24)+:24]	<= qCsrWCke[201] ? iSUsiWd[pSynColorDepth-1:0]	: [(1 * 24)+:24];
		// rDotSquareColor[(2 * 24)+:24]	<= qCsrWCke[202] ? iSUsiWd[pSynColorDepth-1:0]	: [(2 * 24)+:24];
		// rDotSquareColor[(3 * 24)+:24]	<= qCsrWCke[203] ? iSUsiWd[pSynColorDepth-1:0]	: [(3 * 24)+:24];
		// rDotSquareColor[(4 * 24)+:24]	<= qCsrWCke[204] ? iSUsiWd[pSynColorDepth-1:0]	: [(4 * 24)+:24];
		// rDotSquareColor[(5 * 24)+:24]	<= qCsrWCke[205] ? iSUsiWd[pSynColorDepth-1:0]	: [(5 * 24)+:24];
		// rDotSquareColor[(6 * 24)+:24]	<= qCsrWCke[206] ? iSUsiWd[pSynColorDepth-1:0]	: [(6 * 24)+:24];
		// rDotSquareColor[(7 * 24)+:24]	<= qCsrWCke[207] ? iSUsiWd[pSynColorDepth-1:0]	: [(7 * 24)+:24];
		
		// rDotSquareLeft[(0 * 32)+:32]	<= qCsrWCke[201] ? iSUsiWd[31:0]				: rDotSquareLeft[(0 * 32)+:32];
		// rDotSquareLeft[(1 * 32)+:32]	<= qCsrWCke[201] ? iSUsiWd[31:0]				: rDotSquareLeft[(0 * 32)+:32];
		// rDotSquareLeft[(2 * 32)+:32]	<= qCsrWCke[201] ? iSUsiWd[31:0]				: rDotSquareLeft[(0 * 32)+:32];
		// rDotSquareLeft[(3 * 32)+:32]	<= qCsrWCke[201] ? iSUsiWd[31:0]				: rDotSquareLeft[(0 * 32)+:32];
		
		
		// rDotSquareRight1			<= qCsrWCke[202] ? iSUsiWd[pVHAW:0]				: rDotSquareRight1;
		// rDotSquareTop1				<= qCsrWCke[203] ? iSUsiWd[pVVAW:0]				: rDotSquareTop1;
		// rDotSquareUnder1			<= qCsrWCke[204] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder1;
		// rDotSquareColor2			<= qCsrWCke[205] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor2;
		// rDotSquareLeft2 			<= qCsrWCke[206] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft2;
		// rDotSquareRight2			<= qCsrWCke[207] ? iSUsiWd[pVHAW:0]				: rDotSquareRight2;
		// rDotSquareTop2 				<= qCsrWCke[208] ? iSUsiWd[pVVAW:0]				: rDotSquareTop2;
		// rDotSquareUnder2			<= qCsrWCke[209] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder2;
		// rDotSquareColor3			<= qCsrWCke[210] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor3;
		// rDotSquareLeft3				<= qCsrWCke[211] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft3;
		// rDotSquareRight3			<= qCsrWCke[212] ? iSUsiWd[pVHAW:0]				: rDotSquareRight3;
		// rDotSquareTop3				<= qCsrWCke[213] ? iSUsiWd[pVVAW:0]				: rDotSquareTop3;
		// rDotSquareUnder3			<= qCsrWCke[214] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder3;
		// rDotSquareColor4			<= qCsrWCke[215] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor4;
		// rDotSquareLeft4 			<= qCsrWCke[216] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft4;
		// rDotSquareRight4			<= qCsrWCke[217] ? iSUsiWd[pVHAW:0]				: rDotSquareRight4;
		// rDotSquareTop4  			<= qCsrWCke[218] ? iSUsiWd[pVVAW:0]				: rDotSquareTop4;
		// rDotSquareUnder4			<= qCsrWCke[219] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder4;
		// rDotSquareColor5			<= qCsrWCke[220] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor5;
		// rDotSquareLeft5				<= qCsrWCke[221] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft5;
		// rDotSquareRight5			<= qCsrWCke[222] ? iSUsiWd[pVHAW:0]				: rDotSquareRight5;
		// rDotSquareTop5				<= qCsrWCke[223] ? iSUsiWd[pVVAW:0]				: rDotSquareTop5;
		// rDotSquareUnder5			<= qCsrWCke[224] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder5;
		// rDotSquareColor6			<= qCsrWCke[225] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor6;
		// rDotSquareLeft6				<= qCsrWCke[226] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft6;
		// rDotSquareRight6			<= qCsrWCke[227] ? iSUsiWd[pVHAW:0]				: rDotSquareRight6;
		// rDotSquareTop6				<= qCsrWCke[228] ? iSUsiWd[pVVAW:0]				: rDotSquareTop6;
		// rDotSquareUnder6			<= qCsrWCke[229] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder6;
		// rDotSquareColor7			<= qCsrWCke[230] ? iSUsiWd[pSynColorDepth-1:0]	: rDotSquareColor7;
		// rDotSquareLeft7				<= qCsrWCke[231] ? iSUsiWd[pVHAW:0]				: rDotSquareLeft7;
		// rDotSquareRight7			<= qCsrWCke[232] ? iSUsiWd[pVHAW:0]				: rDotSquareRight7;
		// rDotSquareTop7				<= qCsrWCke[233] ? iSUsiWd[pVVAW:0]				: rDotSquareTop7;
		// rDotSquareUnder7			<= qCsrWCke[234] ? iSUsiWd[pVVAW:0]				: rDotSquareUnder7;
		// Scene Change
		rSceneColor					<= qCsrWCke[300] ? iSUsiWd[pSynColorDepth-1:0]	: rSceneColor;
		rSceneFrameTiming			<= qCsrWCke[301] ? iSUsiWd[6:0] 				: rSceneFrameTiming;
		rSceneFrameAddEn			<= qCsrWCke[302] ? iSUsiWd[0:0]					: rSceneFrameAddEn;
		rSceneFrameSubEn			<= qCsrWCke[303] ? iSUsiWd[1:1]					: rSceneFrameSubEn;
		rSceneFrameRst				<= qCsrWCke[304] ? iSUsiWd[2:2]					: rSceneFrameRst;
		// Draw Position
		rPdpXpos					<= qCsrWCke[390] ? iSUsiWd[pVHAW-1:0]			: rPdpXpos;
		rPdpYpos					<= qCsrWCke[391] ? iSUsiWd[pVVAW-1:0]			: rPdpYpos;
		rPdpInit					<= qCsrWCke[392] ? iSUsiWd[0:0]					: rPdpInit;
	end
end


generate
	for (gen = 0; gen < pRegNumver; gen = gen + 1)
	begin
		wire [15:0] gen_index = gen;
		
		always @*
		begin
			qCsrWCke[gen] <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000 + gen_index});
		end
	end
endgenerate

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth - 1:0])
		'd0:		rSUsiRd <= {{(32 - 1			 	){1'b0}}, 	rBlockRst			};
		'd4:		rSUsiRd <= {{(32 - 1			 	){1'b0}}, 	rDmaEnable			};
		'd8:		rSUsiRd <= {{(32 - 1			 	){1'b0}}, 	rDmaCycleEnable		};
		'd10:		rSUsiRd <= {{(32 - pDmaAdrsWidth	){1'b0}},	rDmaAdrsStart		};
		'd11:		rSUsiRd <= {{(32 - pDmaAdrsWidth	){1'b0}},	rDmaAdrsEnd			};
		'd14:		rSUsiRd <= {{(32 - pDmaAdrsWidth	){1'b0}},	rDmaAdrsAdd			};
		// 020
		'd20:		rSUsiRd <= {{(32 - 31				){1'b0}},	rVsgRst				};
		// 050
		'd50:		rSUsiRd <= {{(32 - pDstColorDepth	){1'b0}},	rVtuMcuDq			};
		'd51:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuMcuWRX			};
		'd52:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuMcuDCX			};
		'd53:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuMcuRDX			};
		'd54:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuMcuCSX			};
		'd55:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuMcuRST			};
		'd56:		rSUsiRd <= {{(32 - 4				){1'b0}},	rVtuMcuIM			};
		'd57:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuMcuGate			};
		'd58:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuConverterRst	};
		'd59:		rSUsiRd <= {{(32 - 1				){1'b0}},	rVtuMcuBL			};
		'd60:		rSUsiRd <= {{(32 - 16				){1'b0}},	rVtuBlDutyRatio		};
		'd61:		rSUsiRd <= {									rVtuBlIVtimer		};
		//
		'd97:		rSUsiRd	<= {{(32 - 24				){1'b0}},	rBramWd				};
		'd98:		rSUsiRd	<= {									rBramAdrs			};
		'd99:		rSUsiRd	<= {{(32 - 1				){1'b0}},	rVpgUnitRst			};
		//
		'd100:		rSUsiRd	<= {{(32 - pObjectAnimeNum	){1'b0}},	rObdDrawEnable		};
		'd101:		rSUsiRd	<= {									rObdAnimeFrameNum[(0*32)+:32]};
		'd102:		rSUsiRd	<= {									rObdAnimeFrameNum[(1*32)+:32]};
		'd103:		rSUsiRd	<= {									rObdAnimeFrameNum[(2*32)+:16]};
		'd120:		rSUsiRd	<= {									rObdAnimeXpos	 [(0*32)+:32]};
		'd121:		rSUsiRd	<= {									rObdAnimeXpos	 [(1*32)+:32]};
		'd122:		rSUsiRd	<= {									rObdAnimeXpos	 [(2*32)+:32]};
		'd123:		rSUsiRd	<= {									rObdAnimeXpos	 [(3*32)+:32]};
		'd124:		rSUsiRd	<= {									rObdAnimeXpos	 [(4*32)+:32]};
		'd140:		rSUsiRd	<= {									rObdAnimeYpos	 [(0*32)+:32]};
		'd141:		rSUsiRd	<= {									rObdAnimeYpos	 [(1*32)+:32]};
		'd142:		rSUsiRd	<= {									rObdAnimeYpos	 [(2*32)+:32]};
		'd143:		rSUsiRd	<= {									rObdAnimeYpos	 [(3*32)+:32]};
		'd144:		rSUsiRd	<= {									rObdAnimeYpos	 [(4*32)+:32]};
		'd170:		rSUsiRd	<= {{(32 - 28				){1'b0}}, rPldDrawPlayerSel		};
		//
		'd200:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rDotSquareColor1		};
		'd201:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft1		};
		'd202:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight1		};
		'd203:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop1		};
		'd204:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder1		};
		'd205:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rDotSquareColor2		};
		'd206:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft2		};
		'd207:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight2		};
		'd208:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop2		};
		'd209:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder2		};
		'd210:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rDotSquareColor3		};
		'd211:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft3		};
		'd212:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight3		};
		'd213:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop3		};
		'd214:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder3		};
		'd215:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rDotSquareColor4		};
		'd216:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft4		};
		'd217:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight4		};
		'd218:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop4		};
		'd219:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder4		};
		'd220:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rDotSquareColor5		};
		'd221:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft5		};
		'd222:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight5		};
		'd223:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop5		};
		'd224:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder5		};
		'd225:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rDotSquareColor6		};
		'd226:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft6		};
		'd227:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight6		};
		'd228:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop6		};
		'd229:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder6		};
		'd230:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rDotSquareColor7		};
		'd231:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareLeft7		};
		'd232:		rSUsiRd	<= {{(32 - (pVHAW+1)		){1'b0}}, rDotSquareRight7		};
		'd233:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareTop7		};
		'd234:		rSUsiRd	<= {{(32 - (pVVAW+1)		){1'b0}}, rDotSquareUnder7		};
		//
		'd300:		rSUsiRd	<= {{(32 - pSynColorDepth	){1'b0}}, rSceneColor										};
		'd301:		rSUsiRd	<= {{(32 - 7				){1'b0}}, rSceneFrameTiming									};
		'd302:		rSUsiRd	<= {{(32 - 3				){1'b0}}, rSceneFrameRst,rSceneFrameSubEn,rSceneFrameAddEn	};
		'd303:		rSUsiRd	<= {{(32 - 2				){1'b0}}, {iSceneAlphaMax,iSceneAlphaMin}					};
		'd390:		rSUsiRd	<= {{(32 - pVHAW			){1'b0}}, rPdpXpos											};
		'd391:		rSUsiRd	<= {{(32 - pVVAW			){1'b0}}, rPdpYpos											};
		'd392:		rSUsiRd	<= {{(32 - 31				){1'b0}}, rPdpInit											};
		'd400:		rSUsiRd	<= {{(32 - pVHAW			){1'b0}}, iBdpHpos											};
		'd401:		rSUsiRd	<= {{(32 - pVVAW			){1'b0}}, iBdpVpos											};
		default: 	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule