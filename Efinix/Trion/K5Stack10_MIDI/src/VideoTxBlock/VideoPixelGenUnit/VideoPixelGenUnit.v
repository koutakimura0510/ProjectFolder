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
	parameter			pColorDepth 		= 32,
	parameter			pMapChipSize 		= 32,	// マップチップの基本サイズ
	parameter			pMapChipSft 		= f_detect_bitwidth(pMapChipSize),
	parameter			pMapChipIdNum		= 10,	// マップチップの個数
	// non valiable
	parameter	pOutColorDepth 		= pColorDepth - (pColorDepth / 4) // alpha値を除いたbit幅
)(
	// Csr Dot Square Gen
	input		 [pColorDepth-1:0]	iDotSquareColor1,
	input signed [pVHAW:0]			iDotSquareLeft1,
	input signed [pVHAW:0]			iDotSquareRight1,
	input signed [pVVAW:0]			iDotSquareTop1,
	input signed [pVVAW:0]			iDotSquareUnder1,
	input		 [pColorDepth-1:0]	iDotSquareColor2,
	input signed [pVHAW:0]			iDotSquareLeft2,
	input signed [pVHAW:0]			iDotSquareRight2,
	input signed [pVVAW:0]			iDotSquareTop2,
	input signed [pVVAW:0]			iDotSquareUnder2,
	input		 [pColorDepth-1:0]	iDotSquareColor3,
	input signed [pVHAW:0]			iDotSquareLeft3,
	input signed [pVHAW:0]			iDotSquareRight3,
	input signed [pVVAW:0]			iDotSquareTop3,
	input signed [pVVAW:0]			iDotSquareUnder3,
	input		 [pColorDepth-1:0]	iDotSquareColor4,
	input signed [pVHAW:0]			iDotSquareLeft4,
	input signed [pVHAW:0]			iDotSquareRight4,
	input signed [pVVAW:0]			iDotSquareTop4,
	input signed [pVVAW:0]			iDotSquareUnder4,
	input		 [pColorDepth-1:0]	iDotSquareColor5,
	input signed [pVHAW:0]			iDotSquareLeft5,
	input signed [pVHAW:0]			iDotSquareRight5,
	input signed [pVVAW:0]			iDotSquareTop5,
	input signed [pVVAW:0]			iDotSquareUnder5,
	input		 [pColorDepth-1:0]	iDotSquareColor6,
	input signed [pVHAW:0]			iDotSquareLeft6,
	input signed [pVHAW:0]			iDotSquareRight6,
	input signed [pVVAW:0]			iDotSquareTop6,
	input signed [pVVAW:0]			iDotSquareUnder6,
	input		 [pColorDepth-1:0]	iDotSquareColor7,
	input signed [pVHAW:0]			iDotSquareLeft7,
	input signed [pVHAW:0]			iDotSquareRight7,
	input signed [pVVAW:0]			iDotSquareTop7,
	input signed [pVVAW:0]			iDotSquareUnder7,
	// Csr SceneChange
	input	[pColorDepth-1:0]	iSceneColor,
	input	[6:0]				iSceneFrameTiming,
	input 						iSceneFrameAddEn,
	input 						iSceneFrameSubEn,
	input 						iSceneFrameRst,
	output						oSceneAlphaMax,
	output 						oSceneAlphaMin,
	// Fifo I/F
	output	[pColorDepth-1:0] 	oRd,
	input						iRe,
	output						oRvd,
	output  					oEmp,
	// Control Status
	output	[pVHAW-1:0]			oPdpHpos,
	output	[pVVAW-1:0]			oPdpVpos,
	output	oFe,
	// CLK Reset
	input	iRST,
	input	inRST,
	input	iCLK
);


//-----------------------------------------------------------------------------
// 横幅 480 の場合、0 ~ 479 の範囲を使用するため、設定値から -1 する
//-----------------------------------------------------------------------------
localparam [pVHAW-1:0] lpVHA = pVHA - 1;
localparam [pVVAW-1:0] lpVVA = pVVA - 1;


//-----------------------------------------------------------------------------
// Dst Side FIFO
// module の出力部分を FIFO I/F にすることで扱いやすくする目的
//-----------------------------------------------------------------------------
localparam lpPdfDepth 		= 256;
localparam lpPdfBitWidth 	= pColorDepth;

reg  [lpPdfBitWidth-1:0]	qPdfWd;
reg							qPdfWe;
wire						wPdfFull;
wire [lpPdfBitWidth-1:0]	wPdfRd;
wire 						wPdfRvd;
reg  						qPdfRe;
wire 						wPdfEmp;

SyncFifoController #(
	.pFifoDepth(lpPdfDepth),
	.pFifoBitWidth(lpPdfBitWidth)
) PixelDstFifo (
	// write
	.iWd(qPdfWd),		.iWe(qPdfWe),
	.oFull(wPdfFull),
	.oRemaingCntAlert(),
	// read
	.oRd(wPdfRd),		.iRe(qPdfRe),
	.oRvd(wPdfRvd),		.oEmp(wPdfEmp),
	// common
	.inARST(inRST),		.iCLK(iCLK)
);

always @*
begin
	qPdfRe <= iRe;
end

assign oRd  = wPdfRd;
assign oRvd = wPdfRvd;
assign oEmp = wPdfEmp;


//-----------------------------------------------------------------------------
// Map Id
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// PixelDrawPosition(Pdp)
//-----------------------------------------------------------------------------
wire [pVHAW-1:0] 	wPdpHpos;					assign oPdpHpos = wPdpHpos;
wire [pVVAW-1:0] 	wPdpVpos;					assign oPdpVpos = wPdpVpos;
wire [pVHAW-1:4] 	wPdpHposBs;
wire [pVVAW-1:4] 	wPdpVposBs;
wire 				wPdpFe;						assign oFe = wPdpFe;
reg					qPdpCke;

PixelDrawPosition #(
	.pVHAW(pVHAW),
	.pVVAW(pVVAW),
	.pMapChipBasicBs(4)
) PixelDrawPosition (
	// Video Para Input
	.iVha(lpVHA),			.iVva(lpVVA),
	// Video Pos Output
	.oHpos(wPdpHpos),		.oVpos(wPdpVpos),
	.oHposBs(wPdpHposBs),	.oVposBs(wPdpVposBs),
	.oFeFast(wPdpFe),
	// Common
	.iRST(iRST),	.iCKE(qPdpCke),	.iCLK(iCLK)
);

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
// 	qPdfWd  			<= wDcrInfoMapChipWd;
// 	qPdfWe  			<= ~wPdfFull & wDcrInfoMapChipWe;
// 	qPdpCke 			<= wDcrInfoMapChipWe;
// 	qDcrInfoLine		<= wPdpVpos[4:0];
// 	qDcrInfoMapChipId	<= wPdpHposBs;
// end

//-----------------------------------------------------------------------------
// VDMA Tester
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// Dot Square Generator
//-----------------------------------------------------------------------------
wire [pColorDepth-1:0] 	wDsgPd;
wire 					wDsgPv;
reg  [8:0]				rDlx;
reg  [8:0]				rDrx;

DotSquareGen #(
	.pVHAW(pVHAW),				.pVVAW(pVVAW),
	.pColorDepth(pColorDepth)
) DotSquareGen (
	// Pixel Output
	.oPd(wDsgPd),				.oPv(wDsgPv),
	// Control Status
	.iHpos(wPdpHpos),			.iVpos(wPdpVpos),
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

always @(posedge iCLK)
begin
	if (iRST) 			rDrx <= 9'd0;
	else if (wPdpFe)	rDrx <= rDrx + 2'd2;
	else 				rDrx <= rDrx;
end

always @*
begin
	qPdfWd  <=  wDsgPd;
	qPdfWe  <= ~wPdfFull;
	qPdpCke <= ~wPdfFull;
end

/**----------------------------------------------------------------------------
 * 各レイヤのピクセルデータ合成処理
 *---------------------------------------------------------------------------*/




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