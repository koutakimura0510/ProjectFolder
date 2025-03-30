/*-----------------------------------------------------------------------------
 * 1pixel毎の描画データ生成
 *
 * 23-08-23 v1.00 : new release
 * 
 * -
 * レイヤーの並び順は下記の通りである。
 * Field		:ワールドマップ・フィールドマップ
 * NPC			:プレイヤー以外のキャラクター
 * Player		:操作キャラクター
 * Object		:宝箱などのオブジェクトと、滝の裏側など通過できるフィールドのこと
 * Field2		:ドラクエ5 のエルヘブンのような立体感のあるマップを生成するのに必要
 * Effect		:戦闘エフェクト描画、フィールドエフェクトはない予定
 * Foreground	:前景、霧や光源など
 * Menu			:ウィンドウメニュー
 * Scene		:シーンチェンジ
 * 
 * 上記 Block ごとにパイプラインで接続する。
 * Valid / Ready 信号による パイプライン制御参考 https://qiita.com/ikwzm/items/21c60d827c0e1744c621
 *-----------------------------------------------------------------------------*/
module VideoPixelGenUnit #(
	// Display Size
	parameter			pVHA				= 480,
	parameter			pVVA				= 272,
	parameter			pVHAW				= 11,
	parameter			pVVAW				= 11,
	// UFI
	parameter 			pUfiDqBusWidth 		= 32,
	parameter	[3:0] 	pUfiAdrsMap			= 'h2,
	parameter 			pDmaAdrsWidth 		= 18,
	parameter 			pDmaBurstLength 	= 256,
	// Pixel
	parameter			pDstColorDepth 		= 16,
	parameter			pSynColorDepth 		= 24,
	parameter			pMapChipSize 		= 32,	// マップチップの基本サイズ
	parameter			pMapChipSft 		= f_detect_bitwidth(pMapChipSize),
	parameter			pMapChipIdNum		= 10,	// マップチップの個数
	// Object
	parameter		pObjectAnimeNum			= 8,	// アニメーション可能なオブジェクトの個数
	parameter		pObjectAnimeTime		= 8,	// アニメーション指定時間の最大時間 Bit幅で指定する。1フレーム単位で処理するため、8bit幅だったら 最大255フレーム間隔で可能になる。
	parameter		pObjectAnimeXposWidth	= 16,	// [15:11] NC Bit, [10:0] xpos
	parameter		pObjectAnimeYposWidth	= 16	// [15:11] NC Bit, [10:0] ypos
)(
	// Csr Dot Square Gen
	input		 [pSynColorDepth-1:0]	iDotSquareColor1,
	input signed [pVHAW:0]				iDotSquareLeft1,
	input signed [pVHAW:0]				iDotSquareRight1,
	input signed [pVVAW:0]				iDotSquareTop1,
	input signed [pVVAW:0]				iDotSquareUnder1,
	input		 [pSynColorDepth-1:0]	iDotSquareColor2,
	input signed [pVHAW:0]				iDotSquareLeft2,
	input signed [pVHAW:0]				iDotSquareRight2,
	input signed [pVVAW:0]				iDotSquareTop2,
	input signed [pVVAW:0]				iDotSquareUnder2,
	input		 [pSynColorDepth-1:0]	iDotSquareColor3,
	input signed [pVHAW:0]				iDotSquareLeft3,
	input signed [pVHAW:0]				iDotSquareRight3,
	input signed [pVVAW:0]				iDotSquareTop3,
	input signed [pVVAW:0]				iDotSquareUnder3,
	input		 [pSynColorDepth-1:0]	iDotSquareColor4,
	input signed [pVHAW:0]				iDotSquareLeft4,
	input signed [pVHAW:0]				iDotSquareRight4,
	input signed [pVVAW:0]				iDotSquareTop4,
	input signed [pVVAW:0]				iDotSquareUnder4,
	input		 [pSynColorDepth-1:0]	iDotSquareColor5,
	input signed [pVHAW:0]				iDotSquareLeft5,
	input signed [pVHAW:0]				iDotSquareRight5,
	input signed [pVVAW:0]				iDotSquareTop5,
	input signed [pVVAW:0]				iDotSquareUnder5,
	input		 [pSynColorDepth-1:0]	iDotSquareColor6,
	input signed [pVHAW:0]				iDotSquareLeft6,
	input signed [pVHAW:0]				iDotSquareRight6,
	input signed [pVVAW:0]				iDotSquareTop6,
	input signed [pVVAW:0]				iDotSquareUnder6,
	input		 [pSynColorDepth-1:0]	iDotSquareColor7,
	input signed [pVHAW:0]				iDotSquareLeft7,
	input signed [pVHAW:0]				iDotSquareRight7,
	input signed [pVVAW:0]				iDotSquareTop7,
	input signed [pVVAW:0]				iDotSquareUnder7,
	// Csr SceneChange
	input	[pSynColorDepth-1:0]	iSceneColor,
	input	[6:0]					iSceneFrameTiming,
	input 							iSceneFrameAddEn,
	input 							iSceneFrameSubEn,
	input 							iSceneFrameRst,
	output							oSceneAlphaMax,
	output 							oSceneAlphaMin,
	// Object
	input	[(pObjectAnimeNum * pObjectAnimeTime)-1:0]		iObdAnimeFrameNum,
	input	[(pObjectAnimeNum * pObjectAnimeXposWidth)-1:0] iObdAnimeXpos,
	input	[(pObjectAnimeNum * pObjectAnimeYposWidth)-1:0] iObdAnimeYpos,
	// Draw Position
	output	[pVHAW-1:0]				oBdpHpos,
	output	[pVVAW-1:0]				oBdpVpos,
	output							oBdpFe,
	input	[pVHAW-1:0]				iPdpXpos,
	input	[pVVAW-1:0]				iPdpYpos,
	input							iPdpInit,
	//
	input	[23:0]					iBramWd,
	input	[31:0]					iBramAdrs,
	// Fifo I/F
	output	[pDstColorDepth-1:0] 	oPD,
	input							iRS,
	output							oVD,
	output							oFD,
	output							oLD,
	// Unit RST
	input	iUnitRst,
	// CLK Reset
	input	iRST,
	input	inRST,
	input	iCLK
);


//-----------------------------------------------------------------------------
// 横幅 480 の場合、0 ~ 479 の範囲を使用するため、設定値から -1 する
//-----------------------------------------------------------------------------
localparam [pVHAW-1:0] 	lpVHA = pVHA - 1;
localparam [pVVAW-1:0] 	lpVVA = pVVA - 1;
localparam 				lpDstColorDepth	= pDstColorDepth;	// RGB 色深度
localparam 				lpSynColorDepth = pSynColorDepth;	// 合成を行うピクセルデータの色深度
//
localparam [7:0] lpPlayerDrawCacheBaseAdrs	= 8'h01;
localparam [7:0] lpFiledDrawCacheBaseAdrs	= 8'h08;
localparam [7:0] lpObjectDrawCacheBaseAdrs	= 8'h10;


/**-----------------------------------------------------------------------------
 * Dst Side FIFO
 * module の出力部分を FIFO I/F にすることで扱いやすくする目的
 * almost full に出力タイミングを、全ての Draw Unit のパイプライン処理にかかるレイテンシの合計値以上に設定することで、
 * Draw Unit に Valid 以外の制御信号が必要なくなる想定で Ready によるタイミングの調停が不要になる。
 *-----------------------------------------------------------------------------*/
localparam lpPdfDepth 		= 256;
localparam lpPdfBitWidth 	= lpDstColorDepth * 2;	// 出力の時は、Alpha 値を除いた色深度のみでよい

reg  [lpPdfBitWidth-1:0]	qPdfPS;
reg							qPdfVS;
wire						wPdfFLL;
wire [lpPdfBitWidth-1:0]	wPdfPD;
wire 						wPdfVD;
reg  						qPdfRS;

SyncFifoController #(
	.pFifoDepth(lpPdfDepth),
	.pFifoBitWidth(lpPdfBitWidth),
	.pFifoRemaingCntBorder(lpPdfDepth-32),
	.pFifoRemaingCntUsed("yes")
) PixelDstFifo (
	// write
	.iWd(qPdfPS),		.iWe(qPdfVS),
	.oFull(),			.oRemaingCntAlert(wPdfFLL),
	// read
	.oRd(wPdfPD),		.iRe(qPdfRS),
	.oRvd(wPdfVD),		.oEmp(),
	// common
	.inARST(inRST),		.iCLK(iCLK)
);

always @*
begin
	qPdfRS <= iRS;
end

assign oPD = wPdfPD[15:0];
assign oVD = wPdfVD;
assign oFD = wPdfPD[16];
assign oLD = wPdfPD[17];


//-----------------------------------------------------------------------------
// Map Id
//-----------------------------------------------------------------------------


/**-----------------------------------------------------------------------------
 * Base Draw Position(Pdp)
 *-----------------------------------------------------------------------------*/
wire [pVHAW-1:0] 	wBdpBHPD;					assign oBdpHpos = wBdpBHPD;
wire [pVVAW-1:0] 	wBdpBVPD;					assign oBdpVpos = wBdpBVPD;
wire 				wBdpFD;						assign oBdpFe	= wBdpFD;
wire				wBdpLD;
wire [pVHAW-1:4] 	wBdpBHPDBs;
wire [pVVAW-1:4] 	wBdpBVPDBs;
wire				wBdpVD;
reg					qBdpCke;

PixelDrawPosition #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pMapChipBasicBs(4)
) BaseDrawPosition (
	// Video Para Input
	.iVha(lpVHA),			.iVva(lpVVA),
	// Video Pos Output
	.oHpos(wBdpBHPD),		.oVpos(wBdpBVPD),
	.oHposBs(wBdpBHPDBs),	.oVposBs(wBdpBVPDBs),
	.oFD(wBdpFD),			.oLD(wBdpLD),		.oVD(wBdpVD),
	// Common
	.iRST(iRST),			.iCKE(qBdpCke),		.iCLK(iCLK)
);

always @*
begin
	qBdpCke <= ~wPdfFLL;
end

/**-----------------------------------------------------------------------------
 * Player Draw Position
 *-----------------------------------------------------------------------------*/
wire [pVHAW-1:0] 	wPdpPHPD;
wire [pVVAW-1:0] 	wPdpPVPD;
wire [pVHAW-1:4] 	wPdpPHPDBs;
wire [pVVAW-1:4] 	wPdpPVPDBs;

PlayerDrawPosition #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pMapChipBasicBs(4)
) PlayerDrawPosition (
	// Player Pos Output
	.oXpos(wPdpPHPD),		.oYpos(wPdpPVPD),
	.oXposAdd(),			.oYposAdd(),
	.oXposBs(wPdpPHPDBs),	.oYposBs(wPdpPVPDBs),
	// Base Draw Position
	.iFS(wBdpFD),			.iLS(wBdpVD),		.iVS(wBdpVD),
	// Control Status
	.iXpos(iPdpXpos),		.iYpos(iPdpYpos),
	.iXposAdd(0),			.iYposAdd(0),
	.iInit(iPdpInit),
	// Common
	.iRST(iRST),			.iCLK(iCLK)
);


/**-----------------------------------------------------------------------------
 * Filed Draw
 *-----------------------------------------------------------------------------*/
reg  [lpDstColorDepth-1:0]	qFidPS;		wire [lpDstColorDepth-1:0]	wFidPD;
reg  						qFidVS;		wire 						wFidVD;
reg  						qFidFS;		wire 						wFidFD;
reg  						qFidLS;		wire 						wFidLD;
reg  [pVHAW-1:0] 			qFidBHPS;	wire [pVHAW-1:0] 			wFidBHPD;
reg  [pVVAW-1:0] 			qFidBVPS;	wire [pVVAW-1:0] 			wFidBVPD;
reg  [pVHAW-1:0] 			qFidPHPS;	wire [pVHAW-1:0] 			wFidPHPD;
reg  [pVVAW-1:0] 			qFidPVPS;	wire [pVVAW-1:0] 			wFidPVPD;

FieldDraw #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth),
	.pCacheBaseAdrs(lpFiledDrawCacheBaseAdrs)
	// .pRamDepth(),
) FieldDraw (
	// Dst Pixel Stream I/F
	.oPD(wFidPD),		.oVD(wFidVD),		.oFD(wFidFD),	.oLD(wFidLD),
	.oBHPD(wFidBHPD),	.oBVPD(wFidBVPD),
	.oPHPD(wFidPHPD),	.oPVPD(wFidPVPD),
	// Src Pixel Stream I/F
	.iPS(qFidPS),		.iVS(qFidVS),		.iFS(qFidFS),	.iLS(qFidLS),
	.iBHPS(qFidBHPS),	.iBVPS(qFidBVPS),
	.iPHPS(qFidPHPS),	.iPVPS(qFidPVPS),
	// Memory Mapchip Access
	.iBramWd(iBramWd),	.iBramAdrs(iBramAdrs),
	// common
	.iRST(iRST),		.iCLK(iCLK)
);

always @*
begin
	qFidPS		<= 16'h0000;
	qFidVS		<= wBdpVD;
	qFidFS		<= wBdpFD;
	qFidLS		<= wBdpLD;
	qFidBHPS	<= wBdpBHPD;
	qFidBVPS	<= wBdpBVPD;
	qFidPHPS	<= wPdpPHPD;
	qFidPVPS	<= wPdpPVPD;
end

/**-----------------------------------------------------------------------------
 * Player Draw
 *-----------------------------------------------------------------------------*/
reg  [lpDstColorDepth-1:0]	qPldPS;		wire [lpDstColorDepth-1:0]	wPldPD;
reg  						qPldVS;		wire 						wPldVD;
reg  						qPldFS;		wire 						wPldFD;
reg  						qPldLS;		wire 						wPldLD;
reg  [pVHAW-1:0] 			qPldBHPS;	wire [pVHAW-1:0] 			wPldBHPD;
reg  [pVVAW-1:0] 			qPldBVPS;	wire [pVVAW-1:0] 			wPldBVPD;
reg  [pVHAW-1:0] 			qPldPHPS;	wire [pVHAW-1:0] 			wPldPHPD;
reg  [pVVAW-1:0] 			qPldPVPS;	wire [pVVAW-1:0] 			wPldPVPD;

PlayerDraw #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth),
	.pCacheBaseAdrs(lpPlayerDrawCacheBaseAdrs)
	// .pRamDepth(),
) PlayerDraw (
	// Dst Pixel Stream I/F
	.oPD(wPldPD),		.oVD(wPldVD),		.oFD(wPldFD),	.oLD(wPldLD),
	.oBHPD(wPldBHPD),	.oBVPD(wPldBVPD),
	.oPHPD(wPldPHPD),	.oPVPD(wPldPVPD),
	// Src Pixel Stream I/F
	.iPS(qPldPS),		.iVS(qPldVS),		.iFS(qPldFS),	.iLS(qPldLS),
	.iBHPS(qPldBHPS),	.iBVPS(qPldBVPS),
	.iPHPS(qPldPHPS),	.iPVPS(qPldPVPS),
	// Memory Mapchip Access
	.iBramWd(iBramWd),	.iBramAdrs(iBramAdrs),
	// common
	.iRST(iRST),		.iCLK(iCLK)
);

always @*
begin
	qPldPS		<= wFidPD;
	qPldVS		<= wFidVD;
	qPldFS		<= wFidFD;
	qPldLS		<= wFidLD;
	qPldBHPS	<= wFidBHPD;
	qPldBVPS	<= wFidBVPD;
	qPldPHPS	<= wFidPHPD;
	qPldPVPS	<= wFidPVPD;
end

/**-----------------------------------------------------------------------------
 * Object Draw
 *-----------------------------------------------------------------------------*/
reg  [lpDstColorDepth-1:0]	qObdPS;		wire [lpDstColorDepth-1:0]	wObdPD;
reg  						qObdVS;		wire 						wObdVD;
reg  						qObdFS;		wire 						wObdFD;
reg  						qObdLS;		wire 						wObdLD;
reg  [pVHAW-1:0] 			qObdBHPS;	wire [pVHAW-1:0] 			wObdBHPD;
reg  [pVVAW-1:0] 			qObdBVPS;	wire [pVVAW-1:0] 			wObdBVPD;
reg  [pVHAW-1:0] 			qObdPHPS;	wire [pVHAW-1:0] 			wObdPHPD;
reg  [pVVAW-1:0] 			qObdPVPS;	wire [pVVAW-1:0] 			wObdPVPD;

ObjectDraw #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth),
	.pCacheBaseAdrs(lpObjectDrawCacheBaseAdrs),
	.pObjectAnimeNum(pObjectAnimeNum),
	.pObjectAnimeTime(pObjectAnimeTime),
	.pObjectAnimeXposWidth(pObjectAnimeXposWidth),
	.pObjectAnimeYposWidth(pObjectAnimeYposWidth)
) ObjectDraw (
	// Dst Pixel Stream I/F
	.oPD(wObdPD),		.oVD(wObdVD),		.oFD(wObdFD),	.oLD(wObdLD),
	.oBHPD(wObdBHPD),	.oBVPD(wObdBVPD),
	.oPHPD(wObdPHPD),	.oPVPD(wObdPVPD),
	// Src Pixel Stream I/F
	.iPS(qObdPS),		.iVS(qObdVS),		.iFS(qObdFS),	.iLS(qObdLS),
	.iBHPS(qObdBHPS),	.iBVPS(qObdBVPS),
	.iPHPS(qObdPHPS),	.iPVPS(qObdPVPS),
	// Memory Mapchip Access
	.iBramWd(iBramWd),	.iBramAdrs(iBramAdrs),
	// Draw & Animation Parameter
	.iAnimeFrameNum(iObdAnimeFrameNum),
	.iAnimeXpos(iObdAnimeXpos),
	.iAnimeYpos(iObdAnimeYpos),
	// common
	.iRST(iRST),		.iCLK(iCLK)
);

always @*
begin
	qObdPS		<= wPldPD;
	qObdVS		<= wPldVD;
	qObdFS		<= wPldFD;
	qObdLS		<= wPldLD;
	qObdBHPS	<= wPldBHPD;
	qObdBVPS	<= wPldBVPD;
	qObdPHPS	<= wPldPHPD;
	qObdPVPS	<= wPldPVPD;
end

/**-----------------------------------------------------------------------------
 * Dot Square Generator
 *-----------------------------------------------------------------------------*/
reg  [lpDstColorDepth-1:0]	qDsgPS;		wire [lpDstColorDepth-1:0]	wDsgPD;
reg  						qDsgVS;		wire 						wDsgVD;
reg  						qDsgFS;		wire 						wDsgFD;
reg  						qDsgLS;		wire 						wDsgLD;
reg  [pVHAW-1:0] 			qDsgBHPS;	wire [pVHAW-1:0] 			wDsgBHPD;
reg  [pVVAW-1:0] 			qDsgBVPS;	wire [pVVAW-1:0] 			wDsgBVPD;
reg  [pVHAW-1:0] 			qDsgPHPS;	wire [pVHAW-1:0] 			wDsgPHPD;
reg  [pVVAW-1:0] 			qDsgPVPS;	wire [pVVAW-1:0] 			wDsgPVPD;

DotSquareGen #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pDstColorDepth(lpDstColorDepth),
	.pSynColorDepth(lpSynColorDepth)
) DotSquareGen (
	// Dst Pixel Stream I/F
	.oPD(wDsgPD),		.oVD(wDsgVD),		.oFD(wDsgFD),		.oLD(wDsgLD),
	.oBHPD(wDsgBHPD),	.oBVPD(wDsgBVPD),
	.oPHPD(wDsgPHPD),	.oPVPD(wDsgPVPD),
	// Src Pixel Stream I/F
	.iPS(qDsgPS),		.iVS(qDsgVS),		.iFS(qDsgFS),		.iLS(qDsgLS),
	.iBHPS(qDsgBHPS),	.iBVPS(qDsgBVPS),
	.iPHPS(qDsgPHPS),	.iPVPS(qDsgPVPS),
	// Control Status
	.iColor1(iDotSquareColor1),	.iLeft1(iDotSquareLeft1),	.iRight1(iDotSquareRight1),	.iTop1(iDotSquareTop1),	.iUnder1(iDotSquareUnder1),
	.iColor2(iDotSquareColor2),	.iLeft2(iDotSquareLeft2),	.iRight2(iDotSquareRight2),	.iTop2(iDotSquareTop2),	.iUnder2(iDotSquareUnder2),
	.iColor3(iDotSquareColor3),	.iLeft3(iDotSquareLeft3),	.iRight3(iDotSquareRight3),	.iTop3(iDotSquareTop3),	.iUnder3(iDotSquareUnder3),
	.iColor4(iDotSquareColor4),	.iLeft4(iDotSquareLeft4),	.iRight4(iDotSquareRight4),	.iTop4(iDotSquareTop4),	.iUnder4(iDotSquareUnder4),
	.iColor5(iDotSquareColor5),	.iLeft5(iDotSquareLeft5),	.iRight5(iDotSquareRight5),	.iTop5(iDotSquareTop5),	.iUnder5(iDotSquareUnder5),
	.iColor6(iDotSquareColor6),	.iLeft6(iDotSquareLeft6),	.iRight6(iDotSquareRight6),	.iTop6(iDotSquareTop6),	.iUnder6(iDotSquareUnder6),
	.iColor7(iDotSquareColor7),	.iLeft7(iDotSquareLeft7),	.iRight7(iDotSquareRight7),	.iTop7(iDotSquareTop7),	.iUnder7(iDotSquareUnder7),
	// common
	.iRST(iRST),				.iCLK(iCLK)
);

always @*
begin
	qDsgPS		<= wObdPD;
	qDsgVS		<= wObdVD;
	qDsgFS		<= wObdFD;
	qDsgLS		<= wObdLD;
	qDsgBHPS	<= wObdBHPD;
	qDsgBVPS	<= wObdBVPD;
	qDsgPHPS	<= wObdPHPD;
	qDsgPVPS	<= wObdPVPD;
	//
	qPdfPS[15:0]<= wDsgPD;
	qPdfPS[16]  <= wDsgFD;
	qPdfPS[17]  <= wDsgLD;
	qPdfVS		<= wDsgVD;
end

//-----------------------------------------------------------------------------
// VideoDmaChipRead
//-----------------------------------------------------------------------------
// wire [pUfiDqBusWidth-1:0]	wDcrInfoMapChipWd;
// wire [pDmaAdrsWidth-1:0] 	wDcrInfoMapChipWa;
// wire 						wDcrInfoMapChipWe;
// wire [pVHAW-1:0]			qDcrInfoLine;
// wire [9:0] 					qDcrInfoMapChipId;
// wire 	 					qDcrInfoMapChipIdRe;

// VideoDmaChipRead #(
// 	.pUfiDqBusWidth(pUfiDqBusWidth),
// 	.pUfiAdrsBusWidth(pUfiAdrsBusWidth),
// 	.pUfiAdrsMap(pUfiAdrsMap),
// 	.pDmaAdrsWidth(pDmaAdrsWidth),
// 	.pDmaBurstLength(pDmaBurstLength),
// 	.pColorDepth(pColorDepth),
// 	.pMapChipSize(pMapChipSize),
// 	.pMapChipIdNum(pMapChipIdNum)
// ) VideoDmaChipRead (
// 	// Ufi Bus Master Read
// 	.iMUfiRd(iMUfiRd),		.iMUfiAdrs(iMUfiAdrs),
// 	// Ufi Bus Master Write
// 	.oMUfiWd(oMUfiWd),		.oMUfiAdrs(oMUfiAdrs),
// 	.iMUfiRdy(iMUfiRdy),
// 	// Info
// 	.oInfoMapChipWd(wDcrInfoMapChipWd),
// 	.oInfoMapChipWa(wDcrInfoMapChipWa),
// 	.oInfoMapChipWe(wDcrInfoMapChipWe),
// 	.iInfoLine(qDcrInfoLine),
// 	.iInfoMapChipId(qDcrInfoMapChipId),
// 	.iInfoMapChipIdRe(),
// 	// Common
// 	.iRST(iRST),	.inRST(inRST),
// 	.iCLK(iCLK)
// );

// always @*
// begin
// 	qPdfPS  			<= wDcrInfoMapChipWd;
// 	qPdfVS  			<= ~wPdfFLL & wDcrInfoMapChipWe;
// 	qPdpCke 			<= wDcrInfoMapChipWe;
// 	qDcrInfoLine		<= wPdpVpos[4:0];
// 	qDcrInfoMapChipId	<= wPdpHposBs;
// end

//-----------------------------------------------------------------------------
// VDMA Tester
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// キャラクター(Player,NPC)の座標データ算出
//-----------------------------------------------------------------------------
// DrawUnitPosInfo (

// ) DrawUnitPosInfo (

// );


//-----------------------------------------------------------------------------
// MapIdInfo の取得・更新
// TODO MCB に移動する
//-----------------------------------------------------------------------------
// wire [7:0] wInfoFieldId;
// wire [7:0] wInfoObjectId;
// wire [7:0] wInfoField2Id;
// wire [7:0] wInfoForegroundId;

// DrawMapIdInfo #(
// 	.pMapSizeWidth			(pMapXSizeMax),
// 	.pMapIdWidth			(pMapIdWidth),
// 	.pMapInfoNumber			(4)
// ) DrawMapIdInfo (
// 	.iMapInfoWd				(wSUfiWd),
// 	.iMapInfoWAdrs			(wSUfiAdrs),
// 	.iMapInfoCke			(wSUfiWEd[lpBramMap]),
// 	.oInfoFieldId			(wInfoFieldId),
// 	.oInfoObjectId			(wInfoObjectId),
// 	.oInfoField2Id			(wInfoField2Id),
// 	.oInfoForegroundId		(wInfoForegroundId),
// 	.iRST					(iRST),
// 	.iCLK					(iCLK)
// );


//-----------------------------------------------------------------------------
// 制約が必要そうではある。
// BRAM を cache 扱いとしないと、RAM へのアクセス時間が足りなさそう。
// 16 x 16 x 16 = 4096
// 4096 * 8 = 32768 , 36kB に収まる
// ドラクエ方式として、上下左右の右足左足で 合計 8マップチップのため収まりそう。
// 
// 格納可能なマップチップ数が 8 個ならば、1マップ(または 1画面)で、
// 各レイヤーの使用できるマップチップ最大個数を決める必要がある。
// 
// ※ 上記タイル方式はボツとする。MCB 内でマップIDを取得し、IDによって RAM
// に格納されている マップチップのアドレスを計算・取得する。
// 1 Line の描画データを各 BRAM に割り振りを行う。
// BRAM は 4Line 格納可能である。
// 
// ※ 更に上記方法をやめて、やっぱりマップチップ読み込み方式で行うことにした。
// 16Byte 小刻みに読み込むのは レイテンシが悪すぎる。
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Field Draw
//-----------------------------------------------------------------------------
// DrawFieldMapchip (

// ) DrawFieldMapchip (

// );


//-----------------------------------------------------------------------------
// NPC Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Player Draw (以降 PD)
// 気づいたが、Dot データは BRAM に格納されているので、
// Enable を Assert すればタイミング制御は容易なのではと思う。
//-----------------------------------------------------------------------------
// wire [pColorDepth-1:0] 	wPlayerDrawDd;

// PlayerDraw #(
// 	.pInitFileName			(pInitFileName),
// 	.pColorDepth			(pColorDepth),
// 	.pRamDepth				(pMapChipRamDepth)
// ) PlayerDraw (
// 	.oPixel					(wPlayerDrawDd),
// 	.iPlayerPixelWd			({pColorDepth{1'b0}}),
// 	.iPlayerPixelWe			(1'b0),
// 	.iFe					(wAFe),
// 	.iPlayerDrawVd			(),
// 	.iSrcEn					(),
// 	.iPDFeUpdateCnt			(iPDFeUpdateCnt),
// 	.iPDRadrsNext			(iPDRadrsNext),
// 	.iPDRst					(iPDRst),
// 	.oPDFeCntCke			(oPDFeCntCke),
// 	.iRST					(iRST),
// 	.iCLK					(iCLK)
// );


//-----------------------------------------------------------------------------
// Object Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Effect Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Foreground Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Menu Draw
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Scene Draw
//-----------------------------------------------------------------------------
// wire [pColorDepth-1:0] 	wSceneChangeDd;

// SceneChange #(
// 	.pColorDepth		(pColorDepth)
// ) SceneChange (
// 	.iFe				(wAFe),
// 	//
// 	.oPixel				(wSceneChangeDd),
// 	//
// 	.iSceneColor		(iSceneColor),
// 	.iSceneFrameTiming	(iSceneFrameTiming),
// 	.iSceneFrameAddEn	(iSceneFrameAddEn),
// 	.iSceneFrameSubEn	(iSceneFrameSubEn),
// 	.iSceneFrameRst		(iSceneFrameRst),
// 	.oSceneAlphaMax		(oSceneAlphaMax),
// 	.oSceneAlphaMin		(oSceneAlphaMin),
// 	//
// 	.iRST				(iRST),
// 	.iCLK				(iCLK)
// );

//-----------------------------------------------------------------------------
// デモンストレーション
//-----------------------------------------------------------------------------
// localparam 				lpVpgDemoGenFifoDepth = 512;
// //
// reg 					qVpgDemoEds;
// wire 					wVpgDemoFull;
// wire [pColorDepth-1:0] 	wVpgDemoDd;
// wire 					wVpgDemoVdd;
// reg  					qVpgDemoEdd;
// wire 					wVpgDemoEmp;

// VpgDemo #(
// 	.pHdisplayWidth		(pHdisplayWidth),
// 	.pVdisplayWidth		(pVdisplayWidth),
// 	.pColorDepth		(pColorDepth),
// 	.pFifoDepth			(lpVpgDemoGenFifoDepth),
// 	.pFifoBitWidth		(pColorDepth)
// ) VpgDemo (
// 	.iHdisplay			(wHdisplay),
// 	.iVdisplay			(wVdisplay),
// 	.iHpos				(wPdpHpos),
// 	.iVpos				(wPdpVpos),
// 	.iFe				(wAFe),
// 	//
// 	.iColor				(16'hf0f0),
// 	.iEds 				(qVpgDemoEds),
// 	.oFull				(wVpgDemoFull),
// 	.oDd				(wVpgDemoDd),
// 	.oVdd				(wVpgDemoVdd),
// 	.iEdd				(qVpgDemoEdd),
// 	.oEmp				(wVpgDemoEmp),
// 	.iRST				(iRST),
// 	.iCLK				(iCLK)
// );

// always @*
// begin
// 	qVpgDemoEds				<= (~wVpgDemoFull);	// 自身の FIFO が満杯でなければデータ保存
// 	qPdpCke 	<= (~wVpgDemoFull);
// end


// //-----------------------------------------------------------------------------
// // Final Stage ドットデータを結合し一つのピクセルデータに変換する
// // 前段と後段から要求される制御信号は、異なる CLK ドメインによるレイテンシの違いが発生するため、
// // pFifoFastOutValue パラメータで調整を行う。
// // このとき、FIFO Depth のパラメータ設定には十分余裕を持つこととする。
// //-----------------------------------------------------------------------------
// localparam lpDotMargeToPixelConverterFifoDepth = 512;

// wire [pOutColorDepth-1:0] wPixelMargeDd;		assign oPixel 	= wPixelMargeDd;
// wire  wPixelMargeVdd;							assign oWEd 	= wPixelMargeVdd;
// wire  wPixelMargeFull;
// wire  wPixelMargeEmp;
// reg   qPixelMargeEds;
// reg   qPixelMargeEdd;

// DotMargeToPixelConverter #(
// 	.pColorDepth		(pColorDepth),
// 	.pFifoDepth			(lpDotMargeToPixelConverterFifoDepth),
// 	.pFifoBitWidth		(pOutColorDepth),
// 	.pFifoFastOutValue	(10)
// ) DotMargeToPixelConverter (
// 	.iField				({pColorDepth{1'b0}}),
// 	.iNpc				({pColorDepth{1'b0}}),
// 	.iPlayer			({pColorDepth{1'b0}}),
// 	.iObject			({pColorDepth{1'b0}}),
// 	.iEffect1			({pColorDepth{1'b0}}),
// 	.iEffect2			({pColorDepth{1'b0}}),
// 	.iForeground		({pColorDepth{1'b0}}),
// 	.iMenuWindow		({pColorDepth{1'b0}}),
// 	.iVpgDemo 			(wVpgDemoDd),
// 	.iSceneChange		(wSceneChangeDd),
// 	//
// 	.iEds				(qPixelMargeEds),
// 	.oFull				(wPixelMargeFull),
// 	.oDd				(wPixelMargeDd),
// 	.oVdd				(wPixelMargeVdd),
// 	.iEdd				(qPixelMargeEdd),
// 	.oEmp				(wPixelMargeEmp),
// 	.iRST				(iRST),
// 	.iCLK				(iCLK)
// );

// always @*
// begin
// 	// 前段から Write Enable
// 	// 前段全ステージで データ転送が可能になった時のみ受け付ける
// 	qPixelMargeEds	<= wVpgDemoVdd;

// 	// 後段からの データ転送要求受付
// 	qPixelMargeEdd 	<= (~wPixelMargeEmp) & iEdd;

// 	// 前段 にデータ受付許可発行
// 	qVpgDemoEdd		<= (~wPixelMargeFull);
// end

//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------
function integer f_detect_bitwidth;
	input integer number;
	integer bitwidth;
	integer bitcnt;
	integer	i;
	begin
		bitcnt = 0;
		for (i = 0; i < 32; i = i+1 )
		begin
			if (number[i]) 
			begin
				bitcnt++;
			end
		end

		if (bitcnt == 1)
		begin
			for (i = 0; i < 32; i = i+1 )
			begin
				if (number[i]) 
				begin
					f_detect_bitwidth = i+1;
				end
			end

			if (f_detect_bitwidth != 1)
			begin
				f_detect_bitwidth = f_detect_bitwidth - 1;
			end
		end
		else
		begin
			bitwidth = 0;
			if (number == 0)
			begin
				f_detect_bitwidth = 1;
			end
			else
			begin
				while (number != 0)
				begin
					bitwidth++;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction


endmodule

//-----------------------------------------------------------------------------
// endmodule
//-----------------------------------------------------------------------------