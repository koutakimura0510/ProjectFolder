///----------------------------------------------------------
// Create  2022/11/26
// Author  kimura
// -
// Bram module を基本的な使用方法で Instanceする module
// 
//----------------------------------------------------------
module BramBasicInst #(
	parameter 	pInitFile 		= "NONE",	// BRAM 初期化ファイル指定
	parameter	pRamMode		= "SDP",	// "SDP" Single port, "TDP" Dual Port
	parameter	pRWFarst		= "r",		// "r" READ FARST, "w" WRITE FARST
	parameter	pBramWidthA 	= 36,		// 0, 1, 2, 4, 9, 18, 36, 72 から選択
	parameter	pBramWidthB 	= 36,		// SDP は最大 72bit、TDP は最大 36bit
	parameter	pDataWidth		= 32,
	parameter	pParityWidth	= pBramWidthA - pDataWidth
)(
	// Aside
	input 	[pBramWidthA-1:0]	iWDA,
	output 	[pBramWidthA-1:0]	oRDA,
	input	[15:0]				iAdrsA,
	input 						iCkeA,
	input	[3:0]				iWCkeA,
	// Bside
	input 	[pBramWidthB-1:0]	iWDB,
	output 	[pBramWidthB-1:0]	oRDB,
	input	[15:0]				iAdrsB,
	input						iCkeB,
	input	[7:0]				iWCkeB,
	//
	input 						iRstA,
	input 						iRstB,
	input 						iClkA,
	input 						iClkB
	// copy and paste
	// .iWDA			(iWDA),
	// .oRDA			(oRDA),
	// .iAdrsA			(iAdrsA),
	// .iCkeA			(iCkeA),
	// .iWCkeA			(iWCkeA),
	// .iWDB			(iWDB),
	// .oRDB			(oRDB),
	// .iAdrsB			(iAdrsB),
	// .iCkeB			(iCkeB),
	// .iWCkeB			(iWCkeB),
	// .iRstA			(iRstA),
	// .iRstB			(iRstB),
	// .iClkA			(iClkA),
	// .iClkB			(iClkB)
);

// BRAM プリミティブの配線長に増減
wire [31:0] 	wWDA  = iWDA[pDataWidth-1:0];
wire [3:0]		wWDPA = iWDA[pDataWidth + pParityWidth - 1:pDataWidth];
//
wire [31:0] 	wWDB  = iWDB[pDataWidth-1:0];
wire [3:0]		wWDPB = iWDB[pDataWidth + pParityWidth - 1:pDataWidth];
//
wire [3:0]		wRDPA;
wire [3:0]		wRDPB;
wire [31:0]		wRDA;				assign oRDA = {wRDPA[pParityWidth-1:0], wRDA[pDataWidth-1:0]};
wire [31:0]		wRDB;				assign oRDB = {wRDPB[pParityWidth-1:0], wRDB[pDataWidth-1:0]};
//

BramPrimitive #(
	.pParityWidth	(pParityWidth),
	.pInitFile		(pInitFile),
	.pRamMode		(pRamMode),
	.pRWFarst		(pRWFarst),
	.pDataWidth		(pDataWidth),
	.pBramWidthA	(pBramWidthA),
	.pBramWidthB	(pBramWidthB)
) BramPrimitive (
	.iWDA			(wWDA),
	.iWAPA			(wWDPA),
	.oRDA			(wRDA),
	.oRDPA			(wRDPA),
	.iAdrsA			(iAdrsA),
	.iCkeA			(iCkeA),
	.iWCkeA			(iWCkeA),
	.iWDB			(wWDB),
	.iWDPB			(wWDPB),
	.oRDB			(wRDB),
	.oRDPB			(wRDPB),
	.iAdrsB			(iAdrsB),
	.iCkeB			(iCkeB),
	.iWCkeB			(iWCkeB),
	.iCascadeA		(1'b0),
	.iCascadeCkeA	(1'b0),
	.oCascadeA		(),
	.iCascadeB		(1'b0),
	.iCascadeCkeB	(1'b0),
	.oCascadeB		(),
	.oDBitErr		(),
	.oParity		(),
	.oEcc			(),
	.oSBitErr		(),
	.iRstA			(iRstA),
	.iRstB			(iRstB),
	.iClkA			(iClkA),
	.iClkB			(iClkB)
);

endmodule