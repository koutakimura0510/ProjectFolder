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
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h04,
	parameter						pBusAdrsBit		= 16,
	parameter 						pCsrAdrsWidth   = 16,
	parameter						pCsrActiveWidth = 16,
	parameter						pMemAdrsWidth	= 19,
	//
    parameter       				pHdisplay		= 480,
    parameter       				pHfront			= 8,
    parameter       				pHback			= 43,
    parameter       				pHpulse			= 30,
    parameter       				pVdisplay		= 272,
    parameter       				pVfront			= 12,
    parameter       				pVback			= 4,
    parameter       				pVpulse			= 10,
	//
    parameter       				pHdisplayWidth	= 11,
    parameter       				pHbackWidth		= 7,
    parameter       				pHfrontWidth	= 7,
    parameter       				pHpulseWidth	= 7,
    parameter       				pVdisplayWidth	= 11,
    parameter       				pVfrontWidth	= 5,
    parameter       				pVbackWidth		= 5,
    parameter       				pVpulseWidth	= 5,
	//
	parameter						pColorDepth		= 16,
	// MapChip BRAM Depth
	parameter						pMapChipRamWidth= 10,
	//
	parameter						pMapInfoBitWidth = 8
)(
    // Internal Port
	// Csr Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// Csr Display
	output 	[pHdisplayWidth-1:0]	oHdisplay,
	output 	[pVdisplayWidth-1:0]	oVdisplay,
	output	[pHdisplayWidth:0]		oHSyncStart,
	output	[pHdisplayWidth:0]		oHSyncEnd,
	output	[pHdisplayWidth:0]		oHSyncMax,
	output	[pVdisplayWidth:0]		oVSyncStart,
	output	[pVdisplayWidth:0]		oVSyncEnd,
	output	[pVdisplayWidth:0]		oVSyncMax,
	// Csr Video System Rst
	output							oVtbSystemRst,
	output							oVtbVideoRst,
	output  						oDisplayRst,
	output	[7:0]					oBlDutyRatio,
	// Csr DMA
	output 	[pMemAdrsWidth-1:0]		oFbufAdrs1,
	output 	[pMemAdrsWidth-1:0]		oFbufAdrs2,
	output 	[pMemAdrsWidth-1:0]		oFbufLen1,
	output 	[pMemAdrsWidth-1:0]		oFbufLen2,
	output 							oDmaEn,
	// Csr Map Info
	output	[7:0]					oMapXSize,
	output	[7:0]					oMapYSize,
	// Csr SceneChange
    output	[pColorDepth-1:0]		oSceneColor,
	output 	[6:0]					oSceneFrameTiming,
	output 							oSceneFrameAddEn,
	output 							oSceneFrameSubEn,
    output                     		oSceneFrameRst,
	input							iSceneAlphaMax,
	input 							iSceneAlphaMin,
	// Csr Player Draw
	output 	[6:0]					oPDFeUpdateCnt,
	output 	[pMapChipRamWidth-1:0]	oPDRadrsNext,
	output 							oPDRst,
	input 							iPDFeCntCke,
    // CLK Reset
    input           				iSysRst,
    input           				iSysClk
);


//-----------------------------------------------------------------------------
// パラメータ計算結果
//-----------------------------------------------------------------------------
localparam [pHdisplayWidth:0] lpHSyncStart	= pHdisplay + pHfront;
localparam [pHdisplayWidth:0] lpHSyncEnd	= pHdisplay + pHfront + pHpulse - 1'b1;
localparam [pHdisplayWidth:0] lpHSyncMax	= pHdisplay + pHfront + pHpulse + pHback - 1'b1;
localparam [pVdisplayWidth:0] lpVSyncStart	= pVdisplay + pVfront;
localparam [pVdisplayWidth:0] lpVSyncEnd	= pVdisplay + pVfront + pVpulse - 1'b1;
localparam [pVdisplayWidth:0] lpVSyncMax	= pVdisplay + pVfront + pVpulse + pVback - 1'b1;
// Frame Buffer Size
localparam [pMemAdrsWidth-1:0] lpFbufAdrs1	= 0;
localparam [pMemAdrsWidth-1:0] lpFbufAdrs2	= (pHdisplay * pVdisplay);
localparam [pMemAdrsWidth-1:0] lpFbufLen1	= (pHdisplay * pVdisplay);
localparam [pMemAdrsWidth-1:0] lpFbufLen2	= (pHdisplay * pVdisplay * 2);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pHdisplayWidth-1:0] 	rHdisplay;			assign oHdisplay 	= rHdisplay;		// 水平モニタ横幅
reg [pHfrontWidth-1:0] 		rHfront;													// 水平フロントポーチ
reg [pHbackWidth-1:0] 		rHback;														// 水平バックポーチ
reg [pHpulseWidth-1:0] 		rHpulse;													// 水平同期信号幅
reg [pVdisplayWidth-1:0] 	rVdisplay;			assign oVdisplay 	= rVdisplay;		// 垂直モニタ縦幅
reg [pVfrontWidth-1:0] 		rVfront;													// 垂直フロントポーチ
reg [pVbackWidth-1:0] 		rVback;														// 垂直バックポーチ
reg [pVpulseWidth-1:0] 		rVpulse;													// 垂直同期信号幅
reg 						rVtbSystemRst;		assign oVtbSystemRst= rVtbSystemRst;	// システムクロックロジック側のリセット信号
reg 						rVtbVideoRst;		assign oVtbVideoRst = rVtbVideoRst;		// ビデオクロックロジック側のリセット信号
reg 						rDisplayRst;		assign oDisplayRst	= rDisplayRst;		// ディスプレイのリセット信号
reg 						rDmaEn;				assign oDmaEn		= rDmaEn;			// DMA Enable
reg [7:0]					rBlDutyRatio;		assign oBlDutyRatio = rBlDutyRatio;		// ディスプレイバックライトの調光
reg [pMemAdrsWidth-1:0]		rFbufAdrs1;			assign oFbufAdrs1	= rFbufAdrs1;		// FrameBuffer領域 Wriet DMA の開始アドレス
reg [pMemAdrsWidth-1:0]		rFbufAdrs2;			assign oFbufAdrs2	= rFbufAdrs2;		// FrameBuffer領域 Read DMA の開始アドレス
reg [pMemAdrsWidth-1:0]		rFbufLen1;			assign oFbufLen1	= rFbufLen1;		// Wriet DMA のアクセスサイズ
reg [pMemAdrsWidth-1:0]		rFbufLen2;			assign oFbufLen2	= rFbufLen2;		// Read DMA のアクセスサイズ
//
reg [pHdisplayWidth:0]		rHSyncStart;		assign oHSyncStart 	= rHSyncStart;		// アクティブエリア から 同期信号まで
reg [pHdisplayWidth:0]		rHSyncEnd;			assign oHSyncEnd 	= rHSyncEnd;		// 同期信号 から バックポーチまで
reg [pHdisplayWidth:0]		rHSyncMax;			assign oHSyncMax 	= rHSyncMax;		// アクティブエリア + 非表示エリア
reg [pVdisplayWidth:0]		rVSyncStart;		assign oVSyncStart 	= rVSyncStart;		// アクティブエリア から 同期信号まで
reg [pVdisplayWidth:0]		rVSyncEnd;			assign oVSyncEnd 	= rVSyncEnd;		// 同期信号 から バックポーチまで
reg [pVdisplayWidth:0]		rVSyncMax;			assign oVSyncMax 	= rVSyncMax;		// アクティブエリア + 非表示エリア
reg [ 7:0]					rMapXSize;			assign oMapXSize	= rMapXSize;		// 現在のマップの最大横幅 / 最大255マス固定
reg [ 7:0]					rMapYSize;			assign oMapYSize	= rMapYSize;		// 現在のマップの最大縦幅 / 最大255マス固定
//
reg [pColorDepth-1:0]		rSceneColor;		assign oSceneColor			= rSceneColor;			// 描画色
reg [6:0]					rSceneFrameTiming;	assign oSceneFrameTiming	= rSceneFrameTiming;	// SceneChange の更新速度,fps基準
reg 						rSceneFrameAddEn;	assign oSceneFrameAddEn		= rSceneFrameAddEn;		// SceneChange Add Start
reg 						rSceneFrameSubEn;	assign oSceneFrameSubEn		= rSceneFrameSubEn;		// SceneChange Sub Start
reg 						rSceneFrameRst;		assign oSceneFrameRst		= rSceneFrameRst;		// local module Rst 信号
reg 						rSceneAlphaMax;
reg 						rSceneAlphaMin;
//
reg [6:0]					rPDFeUpdateCnt;		assign oPDFeUpdateCnt		= rPDFeUpdateCnt;		// プレイヤー描画アニメーション更新速度. fps基準
reg [pRamAdrsWidth-1:0]		rPDRadrsNext;		assign oPDRadrsNext			= rPDRadrsNext;			// プレイヤー描画アドレス
reg 						rPDRst;				assign oPDRst				= rPDRst;				// local module rst 信号
reg 						rPDFeCntCke;
//
reg 						qCsrWCke0000, qCsrWCke0004, qCsrWCke0008, qCsrWCke000c;
reg 						qCsrWCke0010, qCsrWCke0014, qCsrWCke0018, qCsrWCke001c;
//
reg 						qCsrWCke0100, qCsrWCke0104, qCsrWCke0108, qCsrWCke010c;
reg 						qCsrWCke0110, qCsrWCke0114, qCsrWCke0118, qCsrWCke011c;
reg 						qCsrWCke0120, qCsrWCke0124, qCsrWCke0128, qCsrWCke012c;
reg 						qCsrWCke0130, qCsrWCke0134, qCsrWCke0138, qCsrWCke013c;
//
reg 						qCsrWCke0200, qCsrWCke0204, qCsrWCke0208, qCsrWCke020c;
reg 						qCsrWCke0210, qCsrWCke0214, qCsrWCke0218, qCsrWCke021c;
reg 						qCsrWCke0220, qCsrWCke0224, qCsrWCke0228, qCsrWCke022c;
reg 						qCsrWCke0230, qCsrWCke0234, qCsrWCke0238, qCsrWCke023c;
//
reg 						qCsrWCke0300, qCsrWCke0304, qCsrWCke0308, qCsrWCke030c;
reg 						qCsrWCke0310, qCsrWCke0314, qCsrWCke0318, qCsrWCke031c;
reg 						qCsrWCke0320, qCsrWCke0324, qCsrWCke0328, qCsrWCke032c;
reg 						qCsrWCke0330, qCsrWCke0334, qCsrWCke0338, qCsrWCke033c;
//
reg 						qCsrWCke0400, qCsrWCke0404, qCsrWCke0408, qCsrWCke040c;
reg 						qCsrWCke0410, qCsrWCke0414, qCsrWCke0418, qCsrWCke041c;
reg 						qCsrWCke0420, qCsrWCke0424, qCsrWCke0428, qCsrWCke042c;
reg 						qCsrWCke0430, qCsrWCke0434, qCsrWCke0438, qCsrWCke043c;
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rHdisplay				<= pHdisplay;
		rHfront					<= pHfront;
		rHback					<= pHback;
		rHpulse					<= pHpulse;
		rVdisplay				<= pVdisplay;
		rVfront					<= pVfront;
		rVback					<= pVback;
		rVpulse					<= pVpulse;
		rHSyncStart				<= lpHSyncStart;
		rHSyncEnd				<= lpHSyncEnd;
		rHSyncMax				<= lpHSyncMax;
		rVSyncStart				<= lpVSyncStart;
		rVSyncEnd				<= lpVSyncEnd;
		rVSyncMax				<= lpVSyncMax;
		rVtbSystemRst			<= 1'b1;		// Active High
		rVtbVideoRst			<= 1'b1;		// Active High
		rDisplayRst				<= 1'b1;		// Active Low
		rDmaEn					<= 1'b0;
		rBlDutyRatio			<= 8'h00;		// 0xff Max Flash
		rFbufAdrs1				<= lpFbufAdrs1;
		rFbufAdrs2				<= lpFbufAdrs2;
		rFbufLen1				<= lpFbufLen1;
		rFbufLen2				<= lpFbufLen2;
		rMapXSize				<= 8'd30;		// DisplayX(480) / MapChipX(16) = 30
		rMapYSize				<= 8'd17;		// DisplayY(272) / MapChipY(16) = 17
		rSceneColor				<= {pColorDepth{1'b0}};
		rSceneFrameTiming		<= 7'd0;
		rSceneFrameAddEn		<= 1'b0;
		rSceneFrameSubEn		<= 1'b0;
		rSceneFrameRst			<= 1'b1;
		rSceneAlphaMax			<= 1'b0;
		rSceneAlphaMin			<= 1'b0;
	end
	else
	begin
		// System Rst	0x0000 ~ 0x000c
		rVtbSystemRst			<= qCsrWCke0000 ? iSUsiWd[0:0] 					: rVtbSystemRst;
		rVtbVideoRst			<= qCsrWCke0000 ? iSUsiWd[1:1] 					: rVtbVideoRst;
		rDisplayRst				<= qCsrWCke0000 ? iSUsiWd[2:2] 					: rDisplayRst;
		// Display		0x0010 ~ 0x00fc
		{rVdisplay,rHdisplay}	<= qCsrWCke0010 ? {iSUsiWd[pVdisplayWidth-1:0],	iSUsiWd[pHdisplayWidth-1:0]} 	: {rVdisplay,rHdisplay};
		{rVback,rHback		}	<= qCsrWCke0014 ? {iSUsiWd[pVbackWidth-1:0],	iSUsiWd[pHbackWidth-1:0]}		: {rVback,rHback};
		{rVfront,rHfront	}	<= qCsrWCke0018 ? {iSUsiWd[pVfrontWidth-1:0],	iSUsiWd[pHfrontWidth-1:0]} 		: {rVfront,rHfront};
		{rVpulse,rHpulse	}	<= qCsrWCke001c ? {iSUsiWd[pVpulseWidth-1:0],	iSUsiWd[pHpulseWidth-1:0]}		: {rVpulse,rHpulse};
		rHSyncStart 			<= rHdisplay + rHfront;								//20
		rVSyncStart 			<= rVdisplay + rVfront;								//20
		rHSyncEnd				<= rHdisplay + rHfront + rHpulse - 1'b1;			//24
		rVSyncEnd				<= rVdisplay + rVfront + rVpulse - 1'b1;			//24
		rHSyncMax				<= rHdisplay + rHfront + rHpulse + rHback - 1'b1;	//2c
		rVSyncMax				<= rVdisplay + rVfront + rVpulse + rVback - 1'b1;	//2c
		// DMA			0x0100 ~ 0x01fc
		rDmaEn					<= qCsrWCke0100 ? iSUsiWd[0:0] 					: rDmaEn;
		rBlDutyRatio			<= qCsrWCke0104 ? iSUsiWd[7:0] 					: rBlDutyRatio;
		rFbufAdrs1				<= qCsrWCke0108 ? iSUsiWd[pMemAdrsWidth-1:0] 	: rFbufAdrs1;
		rFbufAdrs2				<= qCsrWCke010c ? iSUsiWd[pMemAdrsWidth-1:0] 	: rFbufAdrs2;
		rFbufLen1				<= qCsrWCke0110 ? iSUsiWd[pMemAdrsWidth-1:0] 	: rFbufLen1;
		rFbufLen2				<= qCsrWCke0114 ? iSUsiWd[pMemAdrsWidth-1:0] 	: rFbufLen2;
		// Map Info		0x0200 ~ 0x02fc
		{rMapXSize, rMapYSize}	<= qCsrWCke0200 ? iSUsiWd[15:0]					: {rMapXSize, rMapYSize};
		// Scene Change	0x0300 ~ 0x03fc
		rSceneColor				<= qCsrWCke0300 ? iSUsiWd[pColorDepth-1:0]		: rSceneColor;
		rSceneFrameTiming		<= qCsrWCke0304 ? iSUsiWd[6:0] 					: rSceneFrameTiming;
		rSceneFrameAddEn		<= qCsrWCke0308 ? iSUsiWd[0:0]					: rSceneFrameAddEn;
		rSceneFrameSubEn		<= qCsrWCke0308 ? iSUsiWd[1:1]					: rSceneFrameSubEn;
		rSceneFrameRst			<= qCsrWCke0308 ? iSUsiWd[2:2]					: rSceneFrameRst;
		{rSceneAlphaMax,rSceneAlphaMin}	<= {iSceneAlphaMax, iSceneAlphaMin};	// 030c
		// Player Draw	0x0400 ~ 0x4fc
		rPDRst					<= qCsrWCke0400 ? iSUsiWd[0:0]					: rPDRst;
		rPDFeUpdateCnt			<= qCsrWCke0404 ? iSUsiWd[6:0]					: rPDFeUpdateCnt;
		rPDRadrsNext			<= qCsrWCke0408 ? iSUsiWd[pMapChipRamWidth-1:0]	: rPDRadrsNext;
		rPDFeCntCke				<= &{rSUsiREd,qCsrWCke040c} ? 1'b0 :  iPDFeCntCke;
	end
end

always @*
begin
	qCsrWCke0000 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	//
	qCsrWCke0010 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke0014 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke0018 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
	qCsrWCke001c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h001c});
	qCsrWCke0100 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0100});
	qCsrWCke0104 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0104});
	qCsrWCke0108 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0108});
	qCsrWCke010c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h010c});
	qCsrWCke0110 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0110});
	qCsrWCke0114 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0114});
	qCsrWCke0200 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0200});
	qCsrWCke0300 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0300});
	qCsrWCke0304 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0304});
	qCsrWCke0308 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0308});
	qCsrWCke0400 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0400});
	qCsrWCke0404 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0404});
	qCsrWCke0408 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0408});
	qCsrWCke040c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h040C});
end


//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd  = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd  <= 'h0;
		rSUsiREd <= 1'b0;
	end
	else
	begin
		// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
		case (iSUsiAdrs[pCsrActiveWidth - 1:0])
			'h0000:		rSUsiRd	<= {{(32 - 3				){1'b0}}, rDisplayRst,rVtbVideoRst,rVtbSystemRst						};
			'h0010:		rSUsiRd	<= {{(16 - pVdisplayWidth	){1'b0}}, rVdisplay, 	{(16 - pHdisplayWidth	){1'b0}}, rHdisplay		};
			'h0014:		rSUsiRd	<= {{(16 - pVbackWidth		){1'b0}}, rVback,		{(16 - pHbackWidth		){1'b0}}, rHback		};
			'h0018:		rSUsiRd	<= {{(16 - pVfrontWidth		){1'b0}}, rVfront,		{(16 - pHfrontWidth		){1'b0}}, rHfront		};
			'h001c:		rSUsiRd	<= {{(16 - pVpulseWidth		){1'b0}}, rVpulse,		{(16 - pHpulseWidth		){1'b0}}, rHpulse		};
			'h0020:		rSUsiRd	<= {{(16 - (pVdisplayWidth +1)){1'b0}}, rVSyncStart,{(16 - (pHdisplayWidth +1)){1'b0}}, rHSyncStart	};
			'h0024:		rSUsiRd	<= {{(16 - (pVdisplayWidth +1)){1'b0}}, rVSyncEnd,	{(16 - (pHdisplayWidth +1)){1'b0}}, rHSyncEnd	};
			'h0028:		rSUsiRd	<= {{(16 - (pVdisplayWidth +1)){1'b0}}, rVSyncMax,	{(16 - (pHdisplayWidth +1)){1'b0}}, rHSyncMax	};
			'h0100:		rSUsiRd	<= {{(32 - 1				){1'b0}}, rDmaEn														};
			'h0104:		rSUsiRd	<= {{(32 - 8				){1'b0}}, rBlDutyRatio													};
			'h0108:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufAdrs1													};
			'h010c:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufAdrs2													};
			'h0110:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufLen1														};
			'h0114:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufLen2														};
			'h0200:		rSUsiRd	<= {{(32 - 16				){1'b0}}, rMapXSize, rMapYSize											};
			'h0300:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rSceneColor													};
			'h0304:		rSUsiRd	<= {{(32 - 7				){1'b0}}, rSceneFrameTiming												};
			'h0308:		rSUsiRd	<= {{(32 - 3				){1'b0}}, rSceneFrameRst,rSceneFrameSubEn,rSceneFrameAddEn				};
			'h030c:		rSUsiRd	<= {{(32 - 2				){1'b0}}, {rSceneAlphaMax,rSceneAlphaMin}								};
			'h0400:		rSUsiRd	<= {{(32 - 1				){1'b0}}, rPDRst														};
			'h0404:		rSUsiRd	<= {{(32 - 6				){1'b0}}, rPDFeUpdateCnt												};
			'h0408:		rSUsiRd	<= {{(32 - pMapChipRamWidth	){1'b0}}, rPDRadrsNext													};
			'h040c:		rSUsiRd	<= {{(32 - 1				){1'b0}}, rPDFeCntCke													};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:pCsrAdrsWidth] == pAdrsMap};
end

endmodule