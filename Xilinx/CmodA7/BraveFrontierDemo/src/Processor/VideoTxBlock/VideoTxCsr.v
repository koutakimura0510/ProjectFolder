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
reg [pColorDepth-1:0]		rSceneColor;		assign oSceneColor			= rSceneColor;
reg [6:0]					rSceneFrameTiming;	assign oSceneFrameTiming	= rSceneFrameTiming;
reg 						rSceneFrameAddEn;	assign oSceneFrameAddEn		= rSceneFrameAddEn;
reg 						rSceneFrameSubEn;	assign oSceneFrameSubEn		= rSceneFrameSubEn;
reg 						rSceneFrameRst;		assign oSceneFrameRst		= rSceneFrameRst;
reg 						rSceneAlphaMax;
reg 						rSceneAlphaMin;
//
reg 						qCsrWCke00, qCsrWCke04, qCsrWCke08, qCsrWCke0c;
reg 						qCsrWCke10, qCsrWCke14, qCsrWCke18, qCsrWCke1c;
reg 						qCsrWCke20, qCsrWCke24, qCsrWCke28, qCsrWCke2c;
reg 						qCsrWCke30, qCsrWCke34, qCsrWCke38, qCsrWCke3c;
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
		{rVdisplay,rHdisplay}	<= qCsrWCke00 ? {iSUsiWd[pVdisplayWidth-1:0],	iSUsiWd[pHdisplayWidth-1:0]} 	: {rVdisplay,rHdisplay};
		{rVback,rHback		}	<= qCsrWCke04 ? {iSUsiWd[pVbackWidth-1:0],		iSUsiWd[pHbackWidth-1:0]}		: {rVback,rHback};
		{rVfront,rHfront	}	<= qCsrWCke08 ? {iSUsiWd[pVfrontWidth-1:0],		iSUsiWd[pHfrontWidth-1:0]} 		: {rVfront,rHfront};
		{rVpulse,rHpulse	}	<= qCsrWCke0c ? {iSUsiWd[pVpulseWidth-1:0],		iSUsiWd[pHpulseWidth-1:0]}		: {rVpulse,rHpulse};
		//
		rVtbSystemRst			<= qCsrWCke10 ? iSUsiWd[0:0] 					: rVtbSystemRst;
		rVtbVideoRst			<= qCsrWCke10 ? iSUsiWd[1:1] 					: rVtbVideoRst;
		rDisplayRst				<= qCsrWCke10 ? iSUsiWd[2:2] 					: rDisplayRst;
		rDmaEn					<= qCsrWCke10 ? iSUsiWd[3:3] 					: rDmaEn;
		rBlDutyRatio			<= qCsrWCke14 ? iSUsiWd[7:0] 					: rBlDutyRatio;
		rFbufAdrs1				<= qCsrWCke18 ? iSUsiWd[pMemAdrsWidth-1:0] 		: rFbufAdrs1;
		rFbufAdrs2				<= qCsrWCke1c ? iSUsiWd[pMemAdrsWidth-1:0] 		: rFbufAdrs2;
		rFbufLen1				<= qCsrWCke20 ? iSUsiWd[pMemAdrsWidth-1:0] 		: rFbufLen1;
		rFbufLen2				<= qCsrWCke24 ? iSUsiWd[pMemAdrsWidth-1:0] 		: rFbufLen2;
		//
		{rMapXSize, rMapYSize}	<= qCsrWCke28 ? iSUsiWd[15:0] 					: {rMapXSize, rMapYSize};
		//
		rSceneColor				<= qCsrWCke2c ? iSUsiWd[pColorDepth-1:0]		: rSceneColor;
		rSceneFrameTiming		<= qCsrWCke30 ? iSUsiWd[6:0] 					: rSceneFrameTiming;
		rSceneFrameAddEn		<= qCsrWCke34 ? iSUsiWd[0:0]					: rSceneFrameAddEn;
		rSceneFrameSubEn		<= qCsrWCke34 ? iSUsiWd[1:1]					: rSceneFrameSubEn;
		rSceneFrameRst			<= qCsrWCke34 ? iSUsiWd[2:2]					: rSceneFrameRst;
		//
		rHSyncStart 			<= rHdisplay + rHfront;
		rHSyncEnd				<= rHdisplay + rHfront + rHpulse - 1'b1;
		rHSyncMax				<= rHdisplay + rHfront + rHpulse + rHback - 1'b1;
		rVSyncStart 			<= rVdisplay + rVfront;
		rVSyncEnd				<= rVdisplay + rVfront + rVpulse - 1'b1;
		rVSyncMax				<= rVdisplay + rVfront + rVpulse + rVback - 1'b1;
		//
		{rSceneAlphaMax,rSceneAlphaMin}	<= {iSceneAlphaMax, iSceneAlphaMin};
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
	qCsrWCke10 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke14 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke18 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
	qCsrWCke1c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h001c});
	qCsrWCke20 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0020});
	qCsrWCke24 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0024});
	qCsrWCke28 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0028});
	qCsrWCke2c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h002C});
	qCsrWCke30 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0030});
	qCsrWCke34 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0034});
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
			'h0000:		rSUsiRd	<= {{(16 - pVdisplayWidth	){1'b0}}, rVdisplay, 	{(16 - pHdisplayWidth	){1'b0}}, rHdisplay		};
			'h0004:		rSUsiRd	<= {{(16 - pVbackWidth		){1'b0}}, rVback,		{(16 - pHbackWidth		){1'b0}}, rHback		};
			'h0008:		rSUsiRd	<= {{(16 - pVfrontWidth		){1'b0}}, rVfront,		{(16 - pHfrontWidth		){1'b0}}, rHfront		};
			'h000c:		rSUsiRd	<= {{(16 - pVpulseWidth		){1'b0}}, rVpulse,		{(16 - pHpulseWidth		){1'b0}}, rHpulse		};
			'h0010:		rSUsiRd	<= {{(32 - 4				){1'b0}}, rDmaEn,rDisplayRst,rVtbVideoRst,rVtbSystemRst					};
			'h0014:		rSUsiRd	<= {{(32 - 8				){1'b0}}, rBlDutyRatio													};
			'h0018:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufAdrs1													};
			'h001c:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufAdrs2													};
			'h0020:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufLen1														};
			'h0024:		rSUsiRd	<= {{(32 - pMemAdrsWidth	){1'b0}}, rFbufLen2														};
			'h0028:		rSUsiRd	<= {{(32 - 16				){1'b0}}, rMapXSize, rMapYSize											};
			'h002c:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rSceneColor													};
			'h0030:		rSUsiRd	<= {{(32 - 7				){1'b0}}, rSceneFrameTiming												};
			'h0034:		rSUsiRd	<= {{(32 - 3				){1'b0}}, rSceneFrameRst,rSceneFrameSubEn,rSceneFrameAddEn				};
			//
			'h3000:		rSUsiRd	<= {{(16 - (pVdisplayWidth +1)){1'b0}}, rVSyncStart,{(16 - (pHdisplayWidth +1)){1'b0}}, rHSyncStart	};
			'h3004:		rSUsiRd	<= {{(16 - (pVdisplayWidth +1)){1'b0}}, rVSyncEnd,	{(16 - (pHdisplayWidth +1)){1'b0}}, rHSyncEnd	};
			'h3008:		rSUsiRd	<= {{(16 - (pVdisplayWidth +1)){1'b0}}, rVSyncMax,	{(16 - (pHdisplayWidth +1)){1'b0}}, rHSyncMax	};
			'h4000:		rSUsiRd	<= {{(32 - 2)					{1'b0}}, {rSceneAlphaMax,rSceneAlphaMin}							};
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