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
	parameter	pColorDepth		= 16
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input	[pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr DMA
	output	oDmaEnable,
	output	oDmaCycleEnable,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsStart,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsEnd,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsAdd,
	input	iDmaDone,
	// Csr Map Info
	output	[7:0] oMapXSize,
	output	[7:0] oMapYSize,
	// Csr SceneChange
    output	[pColorDepth-1:0] oSceneColor,
	output 	[6:0] oSceneFrameTiming,
	output 	oSceneFrameAddEn,
	output 	oSceneFrameSubEn,
    output 	oSceneFrameRst,
	input	iSceneAlphaMax,
	input 	iSceneAlphaMin,
    // CLK Reset
    input	iSRST,
    input	iSCLK
);

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg rDmaEnable;								assign oDmaEnable 		= rDmaEnable;		// DMA Function Enable
reg rDmaCycleEnable;						assign oDmaCycleEnable	= rDmaCycleEnable;	// Dma Auto Cycle Mode
reg [pDmaAdrsWidth-1:0] rDmaAdrsStart;		assign oDmaAdrsStart 	= rDmaAdrsStart;	// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsEnd;		assign oDmaAdrsEnd 		= rDmaAdrsEnd;		// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsAdd;		assign oDmaAdrsAdd 		= rDmaAdrsAdd;		// 
//
reg [ 7:0] rMapXSize;						assign oMapXSize		= rMapXSize;		// 現在のマップの最大横幅 / 最大255マス固定
reg [ 7:0] rMapYSize;						assign oMapYSize		= rMapYSize;		// 現在のマップの最大縦幅 / 最大255マス固定
//
reg [pColorDepth-1:0] rSceneColor;			assign oSceneColor			= rSceneColor;			// 描画色
reg [6:0] rSceneFrameTiming;				assign oSceneFrameTiming	= rSceneFrameTiming;	// SceneChange の更新速度,fps基準
reg rSceneFrameAddEn;						assign oSceneFrameAddEn		= rSceneFrameAddEn;		// SceneChange Add Start
reg rSceneFrameSubEn;						assign oSceneFrameSubEn		= rSceneFrameSubEn;		// SceneChange Sub Start
reg rSceneFrameRst;							assign oSceneFrameRst		= rSceneFrameRst;		// local module Rst 信号
//
reg qCsrWCke0000, qCsrWCke0004, qCsrWCke0008, qCsrWCke000c;
reg qCsrWCke0010, qCsrWCke0014, qCsrWCke0018, qCsrWCke001c;
//
reg qCsrWCke0100, qCsrWCke0104, qCsrWCke0108, qCsrWCke010c;
reg qCsrWCke0110, qCsrWCke0114, qCsrWCke0118, qCsrWCke011c;
reg qCsrWCke0120, qCsrWCke0124, qCsrWCke0128, qCsrWCke012c;
reg qCsrWCke0130, qCsrWCke0134, qCsrWCke0138, qCsrWCke013c;
//
reg qCsrWCke0200, qCsrWCke0204, qCsrWCke0208, qCsrWCke020c;
reg qCsrWCke0210, qCsrWCke0214, qCsrWCke0218, qCsrWCke021c;
reg qCsrWCke0220, qCsrWCke0224, qCsrWCke0228, qCsrWCke022c;
reg qCsrWCke0230, qCsrWCke0234, qCsrWCke0238, qCsrWCke023c;
//
reg qCsrWCke0300, qCsrWCke0304, qCsrWCke0308, qCsrWCke030c;
reg qCsrWCke0310, qCsrWCke0314, qCsrWCke0318, qCsrWCke031c;
reg qCsrWCke0320, qCsrWCke0324, qCsrWCke0328, qCsrWCke032c;
reg qCsrWCke0330, qCsrWCke0334, qCsrWCke0338, qCsrWCke033c;
//
reg qCsrWCke0400, qCsrWCke0404, qCsrWCke0408, qCsrWCke040c;
reg qCsrWCke0410, qCsrWCke0414, qCsrWCke0418, qCsrWCke041c;
reg qCsrWCke0420, qCsrWCke0424, qCsrWCke0428, qCsrWCke042c;
reg qCsrWCke0430, qCsrWCke0434, qCsrWCke0438, qCsrWCke043c;
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
		rSceneColor			<= {pColorDepth{1'b0}};
		rSceneFrameTiming	<= 7'd0;
		rSceneFrameAddEn	<= 1'b0;
		rSceneFrameSubEn	<= 1'b0;
		rSceneFrameRst		<= 1'b1;
	end
	else
	begin
		//
		rDmaEnable				<= iDmaDone	  ? rDmaCycleEnable : qCsrWCke0004 ? iSUsiWd[0:0] : rDmaEnable;
		rDmaCycleEnable			<= qCsrWCke0008 ? iSUsiWd[0:0] : rDmaCycleEnable;
		rDmaAdrsStart			<= qCsrWCke000c ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsStart;
		rDmaAdrsEnd				<= qCsrWCke0010 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsEnd;
		rDmaAdrsAdd				<= qCsrWCke0014 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsAdd;
		// Map Info		0x0200 ~ 0x02fc
		{rMapXSize, rMapYSize}	<= qCsrWCke0200 ? iSUsiWd[15:0]					: {rMapXSize, rMapYSize};
		// Scene Change	0x0300 ~ 0x03fc
		rSceneColor				<= qCsrWCke0300 ? iSUsiWd[pColorDepth-1:0]		: rSceneColor;
		rSceneFrameTiming		<= qCsrWCke0304 ? iSUsiWd[6:0] 					: rSceneFrameTiming;
		rSceneFrameAddEn		<= qCsrWCke0308 ? iSUsiWd[0:0]					: rSceneFrameAddEn;
		rSceneFrameSubEn		<= qCsrWCke0308 ? iSUsiWd[1:1]					: rSceneFrameSubEn;
		rSceneFrameRst			<= qCsrWCke0308 ? iSUsiWd[2:2]					: rSceneFrameRst;
	end
end

always @*
begin
	qCsrWCke0000 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke0004 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke0008 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke000c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	//
	qCsrWCke0010 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke0014 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke0018 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
	qCsrWCke001c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h001c});
	qCsrWCke0100 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0100});
	qCsrWCke0104 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0104});
	qCsrWCke0108 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0108});
	qCsrWCke010c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h010c});
	qCsrWCke0110 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0110});
	qCsrWCke0114 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0114});
	qCsrWCke0200 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0200});
	qCsrWCke0300 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0300});
	qCsrWCke0304 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0304});
	qCsrWCke0308 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0308});
	qCsrWCke0400 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0400});
	qCsrWCke0404 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0404});
	qCsrWCke0408 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0408});
	qCsrWCke040c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h040C});
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
		'h0004:		rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaEnable};
		'h0008:		rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaCycleEnable};
		'h000C:		rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsStart};
		'h0010:		rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsEnd};
		'h0014:		rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsAdd};
		//
		'h0200:		rSUsiRd	<= {{(32 - 16				){1'b0}}, rMapXSize, rMapYSize											};
		'h0300:		rSUsiRd	<= {{(32 - pColorDepth		){1'b0}}, rSceneColor													};
		'h0304:		rSUsiRd	<= {{(32 - 7				){1'b0}}, rSceneFrameTiming												};
		'h0308:		rSUsiRd	<= {{(32 - 3				){1'b0}}, rSceneFrameRst,rSceneFrameSubEn,rSceneFrameAddEn				};
		'h030c:		rSUsiRd	<= {{(32 - 2				){1'b0}}, {iSceneAlphaMax,iSceneAlphaMin}								};
		default: 	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule