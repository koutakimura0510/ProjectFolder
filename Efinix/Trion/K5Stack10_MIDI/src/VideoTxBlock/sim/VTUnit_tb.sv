`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/09/03
// Author  KoutaKimura
// -
// 参考文献
// https://qiita.com/takeru0x5569/items/b054cdcf9e014f332edd
//----------------------------------------------------------
module VTUnit_tb;


//-----------------------------------------------------------------------------
// ファイル名
//-----------------------------------------------------------------------------
// localparam lpRawFileSave	= "/home/kimura/workspace/ProjectFolder/Xilinx/CmodA7/BraveFrontierDemo/src/Processor/VideoTxBlock/sim/ImageData.raw";
localparam lpRawFileSave	= "/home/kimura/workspace/ProjectFolder/Xilinx/CmodA7/BraveFrontierDemo/src/Processor/VideoTxBlock/sim/ImageData.bmp";

//----------------------------------------------------------
// Clk Generator
// ・システムクロックはビデオクロックの 2倍以上の周波数でなければならない
// ・メモリクロックはビデオクロックの 2.5倍以上の周波数でなければならない
// ・バスクロックはシステムクロックの 2.5倍以上の周波数でなければならない。
//----------------------------------------------------------
localparam 	lpSysClkCycle 	= 4;
localparam 	lpBusClkCycle 	= 2;
localparam 	lpVideoClkCycle = 40;
localparam 	lpMemClkCycle 	= 4;		// SysClk より遅い場合、タイミングエラー
localparam 	lpAudioClkCycle	= 16;
//
wire 		wSysClk;
wire 		wBusClk;
wire 		wVideoClk;
wire 		wMemClk;
wire 		wAudioClk;
//
SimSystemClk #(
	.pSystemClkCycle	(lpSysClkCycle)
) SimSystemClk (
	.oSysClk			(wSysClk)
);

SimSystemClk #(
	.pSystemClkCycle	(lpBusClkCycle)
) SimBusClk (
	.oSysClk			(wBusClk)
);

SimSystemClk #(
	.pSystemClkCycle	(lpVideoClkCycle)
) SimVideoClk (
	.oSysClk			(wVideoClk)
);

SimSystemClk #(
	.pSystemClkCycle	(lpMemClkCycle)
) SimMemClk (
	.oSysClk			(wMemClk)
);

SimSystemClk #(
	.pSystemClkCycle	(lpAudioClkCycle)
) SimAudioClk (
	.oSysClk			(wAudioClk)
);


//-----------------------------------------------------------------------------
// リセット信号の生成
// rVtbVideoRst リセットは rVtbSystemRst より遅らせることで、
// Dual CLk FIFO にある程度データを溜める目的がある。
//-----------------------------------------------------------------------------
reg  		rSysRst;
reg  		rAudioRst;
//
reg 		rVtbSystemRst;
reg 		rVtbVideoRst;
reg 		rVtbSceneFrameRst;
//
reg 		rRamSrcRst;
reg 		rRamDstRst;
reg 		rDmaEn;
//
task system_reset();
begin
	rSysRst 			<= 1'b1;
	rAudioRst 			<= 1'b1;
	rVtbSystemRst 		<= 1'b1;
	rVtbVideoRst 		<= 1'b1;
	rVtbSceneFrameRst 	<= 1'b1;
	rRamSrcRst			<= 1'b1;
	rRamDstRst			<= 1'b1;
	rDmaEn  			<= 1'b0;
	#(lpAudioClkCycle * 4);
	rAudioRst 			<= 1'b0;
	rSysRst 			<= 1'b0;
	#(lpSysClkCycle * 10);
	rDmaEn  			<= 1'b1;
	rVtbSystemRst 		<= 1'b0;
	rRamSrcRst			<= 1'b0;
	rRamDstRst			<= 1'b0;
	rVtbSceneFrameRst	<= 1'b0;
	#(lpSysClkCycle * 50);
	rVtbVideoRst 		<= 1'b0;
end
endtask


//-----------------------------------------------------------------------------
// UfiBus パラメータ
//-----------------------------------------------------------------------------
localparam lpUsiBusWidth			= 32;
localparam lpUfiBusWidth		= 12;
localparam lpMemAdrsWidth		= 19;
localparam lpUfiIdNumber		=  3;
//
wire [lpUfiBusWidth-1:0] 		wMUfiWdVtb;
wire [lpUsiBusWidth-1:0]			wMUfiAdrsVtb;
wire 							wMUfiWEdVtb;
wire 							wMUfiREdVtb;
wire 							wMUfiVdVtb;		// 転送期間中 Assert
wire 							wMUfiCmdVtb;	// High Read / Lor Write
wire 							wMUfiRdyVtb;	// Vtb に対する Ready 信号
reg 							qMUfiRdyVtb;
//
wire [lpUsiBusWidth-1:0]			wMUfiAdrsAtb;
wire 							wMUfiWEdAtb;
wire 							wMUfiREdAtb;
wire 							wMUfiVdAtb;		// 転送期間中 Assert
wire 							wMUfiRdyAtb;	// Vtb に対する Ready 信号
reg 							qMUfiRdyAtb;
//
wire [lpUfiBusWidth-1:0] 		wMUfiRd;		// Master に対する 読み込みデータ
wire 							wMUfiEddVtb;	// Master に対する 読み込み有効信号
wire 							wMUfiEddAtb;	// Master に対する 読み込み有効信号
wire 							wMUfiRdy;		// Master に対する Ready 信号
//
wire [lpUfiIdNumber-1:0]		wMUfiIdI;
wire [lpUfiIdNumber-1:0]		wMUfiIdO;
// Slave Memory Block Side
wire [lpUfiBusWidth-1:0] 		wSUfiWdRam;		// Slave に対する 書き込みデータ
wire [lpUsiBusWidth-1:0]			wSUfiAdrsRam;	// Slave に対する R/W 共通のアドレス指定バス
wire 							wSUfiWEdRam;	// Slave に対する 書き込み有効信号
wire 							iwSUfiREdRam;	// Slave に対する 書き込み有効信号
wire 							wSUfiCmdRam;	// Slave に対する High Read, Low Write
wire  [lpUfiBusWidth-1:0] 		wSUfiRdRam;		// Master に対する 読み込みデータ 
wire  							owSUfiREdRam;	// Master に対する 読み込み有効信号
wire 							wSUfiRdyRam;	// Master に対する Ready 信号



//----------------------------------------------------------
// VideoTxUnit
//----------------------------------------------------------
localparam  lpHdisplayWidth	= 11;
localparam	lpVdisplayWidth	= 11;
localparam	lpHdisplay		= 100;
localparam	lpHfront		= 8;
localparam	lpHback			= 43;
localparam	lpHpulse		= 30;
localparam	lpVdisplay		= 272;
localparam	lpVfront		= 12;
localparam	lpVback			= 4;
localparam	lpVpulse		= 10;
localparam [lpHdisplayWidth:0] lpHSyncStart	= lpHdisplay + lpHfront;
localparam [lpHdisplayWidth:0] lpHSyncEnd	= lpHdisplay + lpHfront + lpHpulse - 1'b1;
localparam [lpHdisplayWidth:0] lpHSyncMax	= lpHdisplay + lpHfront + lpHpulse + lpHback - 1'b1;
localparam [lpVdisplayWidth:0] lpVSyncStart	= lpVdisplay + lpVfront;
localparam [lpVdisplayWidth:0] lpVSyncEnd	= lpVdisplay + lpVfront + lpVpulse - 1'b1;
localparam [lpVdisplayWidth:0] lpVSyncMax	= lpVdisplay + lpVfront + lpVpulse + lpVback - 1'b1;
//
localparam lpColorDepth 		= 16;
localparam lpDualClkFifoDepth	= 1024;	// FIFO サイズを可変して、あらゆるサイズで動作可能か検討する
localparam lpDmaFifoDepth		= 1024;	// 上記同文
localparam lpFrameSize 			= lpHdisplay * lpVdisplay * 2; // ダブルフレームバッファ構造
localparam lpDmaAdrs1			= 0;
localparam lpDmaAdrs2			= lpHdisplay * lpVdisplay;
localparam lpDmaLen1			= (lpHdisplay * lpVdisplay);
localparam lpDmaLen2			= (lpHdisplay * lpVdisplay * 2);
//
wire [7:0]	wTftColorR;
wire [7:0]	wTftColorG;
wire [7:0]	wTftColorB;
wire 		wTftDclk;
wire 		wTftHSync;
wire 		wTftVSync;
wire 		wTftDe;
wire 		wTftBackLight;
wire 		wTftRst;
wire 		wAFE;
//
assign wTftColorR[3:0] = 4'b0000;	// GPIO 下位 4bit は GND 接続
assign wTftColorG[3:0] = 4'b0000;	// GPIO 下位 4bit は GND 接続
assign wTftColorB[3:0] = 4'b0000;	// GPIO 下位 4bit は GND 接続
//
VideoTxUnit #(
	.pUsiBusWidth		(lpUsiBusWidth),
	.pUfiBusWidth		(lpUfiBusWidth),
	.pMemAdrsWidth		(lpMemAdrsWidth),
	.pHdisplayWidth		(lpHdisplayWidth),
	.pVdisplayWidth		(lpVdisplayWidth),
	.pColorDepth		(lpColorDepth),
	.pDualClkFifoDepth	(lpDualClkFifoDepth),
	.pDmaFifoDepth		(lpDmaFifoDepth),
	.pFifoDepthOverride	("yes"),
	.pTestBencth 		("yes")
) VIDEO_TX_UNIt (
	.oTftColorR			(wTftColorR[7:4]),
	.oTftColorG			(wTftColorG[7:4]),
	.oTftColorB			(wTftColorB[7:4]),
	.oTftDclk			(wTftDclk),
	.oTftHSync			(wTftHSync),
	.oTftVSync			(wTftVSync),
	.oTftDe				(wTftDe),
	.oTftBackLight		(wTftBackLight),
	.oTftRst			(wTftRst),
	//
	.iMUfiRd			(wMUfiRd),
	.iMUfiREd			(wMUfiEddVtb),
	.iMUfiRdy			(qMUfiRdyVtb),
	//
	.iSUfiWd			(0),
	.iSUfiAdrs			(0),
	.iSUfiWEd			(0),
	//
	.oMUfiWd			(wMUfiWdVtb),
	.oMUfiAdrs			(wMUfiAdrsVtb),
	.oMUfiWEd			(wMUfiWEdVtb),
	.oMUfiREd			(wMUfiREdVtb),
	.oMUfiVd			(wMUfiVdVtb),
	.oMUfiCmd			(wMUfiCmdVtb),
	//
	.iHdisplay			(lpHdisplay),
	.iVdisplay			(lpVdisplay),
	.iHSyncStart		(lpHSyncStart),
	.iHSyncEnd			(lpHSyncEnd),
	.iHSyncMax			(lpHSyncMax),
	.iVSyncStart		(lpVSyncStart),
	.iVSyncEnd			(lpVSyncEnd),
	.iVSyncMax			(lpVSyncMax),
	//
	.iVtbSystemRst		(rVtbSystemRst),
	.iVtbVideoRst		(rVtbVideoRst),
	.iDisplayRst		(1'b0),
	.iBlDutyRatio		(127),
	//
	.iFbufAdrs1			(lpDmaAdrs1),
	.iFbufAdrs2			(lpDmaAdrs2),
	.iFbufLen1			(lpDmaLen1),
	.iFbufLen2			(lpDmaLen2),
	.iDmaEn				(rDmaEn),
	//
	.iMapXSize			(0),
	.iMapYSize			(0),
	.iMapInfoWd			(0),
	.iMapInfoCke		(0),
	.iMapInfoVd			(0),
	//
	.iSceneColor		(16'h0fff),
	.iSceneFrameTiming	(7'd0),
	.iSceneFrameAddEn	(1),
	.iSceneFrameSubEn	(0),
	.iSceneFrameRst		(rVtbSceneFrameRst),
	.oSceneAlphaMax		(),
	.oSceneAlphaMin		(),
	//
	.iSCLK			(wSysClk),
	.iVideoClk			(wVideoClk),
	.iSRST			(rSysRst),
	.oFe				(wAFE)
);

always @*
begin
	qMUfiRdyVtb <= wMUfiRdyVtb & wMUfiRdy;
end


//-----------------------------------------------------------------------------
// AudioTxUnit
//-----------------------------------------------------------------------------
localparam [lpMemAdrsWidth-1:0] lpDmaAdrs					= 'h40000;
localparam [lpMemAdrsWidth-1:0] lpDmaLen					= 'h30000;
localparam 						lpDualClkFifoDepthAudio		= 1024;
localparam 						lpDmaFifoDepthAudio			= 1024;
localparam 						lpFifoDepthOverrideAudio	= "yes";

wire wAudioMClk;

AudioTxUnit #(
	.pUsiBusWidth		(lpUsiBusWidth),
	.pUfiBusWidth		(lpUfiBusWidth),
	.pMemAdrsWidth		(lpMemAdrsWidth),
	.pSamplingBitWidth	(8),
	//
	.pDualClkFifoDepth	(lpDualClkFifoDepthAudio),
	.pDmaFifoDepth		(lpDmaFifoDepthAudio),
	.pFifoDepthOverride	(lpFifoDepthOverrideAudio),
	//
	.pTestPortUsed		("no"),
	.pTestPortNum		(4)
) AudioTxUnit (
	.iMUfiRd			(wMUfiRd),
	.iMUfiREd			(wMUfiEddAtb),
	.iMUfiRdy			(qMUfiRdyAtb),
	.oMUfiAdrs			(wMUfiAdrsAtb),
	.oMUfiWEd			(wMUfiWEdAtb),
	.oMUfiREd			(wMUfiREdAtb),
	.oMUfiVd			(wMUfiVdAtb),
	.oAudioMclk			(wAudioMClk),
	.iDmaAdrs			(lpDmaAdrs),
	.iDmaLen			(lpDmaLen),
	.iDmaEn				(rDmaEn),
	.iSRST			(rSysRst),
	.iSCLK			(wSysClk),
	.iAudioRst			(rAudioRst),
	.iAudioClk			(wAudioClk),
	.oTestPort			()
);

always @*
begin
	qMUfiRdyAtb <= wMUfiRdyAtb & wMUfiRdy;
end


//----------------------------------------------------------
// RAM Unit
//----------------------------------------------------------
localparam lpRamSize		= 'h7d000; // 512KB
localparam lpRamFifoDepth	= 32;
localparam lpRamDqWidth		= lpUfiBusWidth;
//
reg  [lpRamDqWidth-1:0] 	rMem	[0:lpRamSize-1];
reg  [lpRamDqWidth-1:0]		qMemDq;
wire [lpMemAdrsWidth-1:0]	wMemAdrs;
wire [lpRamDqWidth-1:0]		wMemDq;
wire 						wMemOE;
wire 						wMemWE;
wire 						wMemCE;
//
assign wMemDq = qMemDq;

RAMUnit #(
	.pUfiBusWidth		(lpUfiBusWidth),
	.pUsiBusWidth		(lpUsiBusWidth),
	.pUfiIdNumber		(lpUfiIdNumber),
	.pRamFifoDepth		(lpRamFifoDepth),
	.pRamAdrsWidth		(lpMemAdrsWidth),
	.pRamDqWidth		(lpRamDqWidth)
) RamUnit (
	.oMemAdrs			(wMemAdrs),
	.ioMemDq			(wMemDq),
	.oMemOE				(wMemOE),
	.oMemWE				(wMemWE),
	.oMemCE				(wMemCE),
	//
	.iSUfiWd			(wSUfiWdRam),
	.iSUfiAdrs			(wSUfiAdrsRam),
	.iSUfiWEd			(wSUfiWEdRam),
	.iSUfiREd			(owSUfiREdRam),
	.iSUfiCmd			(wSUfiCmdRam),
	.oSUfiRd			(wSUfiRdRam),
	.oSUfiREd			(iwSUfiREdRam),
	.oSUfiRdy			(wSUfiRdyRam),
	//
	.iSUfiIdI			(wMUfiIdO),
	.oSUfiIdO			(wMUfiIdI),
	//
	.iRamDualFifoSrcRst	(rRamSrcRst),
	.iRamDualFifoDstRst	(rRamDstRst),
	//
	.iSRST			(rSysRst),
	.iSCLK			(wSysClk),
	.iMemClk			(wMemClk)
);
//

integer i;

initial
begin
	for (i = 0; i < lpRamSize; i = i + 1)
	begin
		rMem[i] <= i; 	// 適当な初期値
	end
end

always @(posedge wMemClk)
begin
	casex ({wMemWE, wMemCE})	// データを書き込み
		'b00:		rMem[wMemAdrs] <= wMemDq;
		default:	rMem[wMemAdrs] <= rMem[wMemAdrs];
	endcase
end

always @*
begin
	casex ({wMemWE, wMemCE})	// データを読み出し
		'b00:		qMemDq <= {lpRamDqWidth{1'bz}};
		'b10:		qMemDq <= rMem[wMemAdrs];
		default:	qMemDq <= {lpRamDqWidth{1'bz}};
	endcase
end


//-----------------------------------------------------------------------------
// UfiBus
//-----------------------------------------------------------------------------
UltraFastInterface #(
	.pUfiBusWidth		(lpUfiBusWidth),
	.pUsiBusWidth		(lpUsiBusWidth)
) UltraFastInterface (
	.iMUfiWdMcs			({lpUfiBusWidth{1'b0}}),
	.iMUfiAdrsMcs		('h0000_0000),
	.iMUfiWEdMcs		(1'b0),
	.iMUfiREdMcs		(1'b0),
	.iMUfiCmdMcs		(1'b0),
	.iMUfiVdMcs			(1'b0),
	//
	.iMUfiWdSpi			({lpUfiBusWidth{1'b0}}),
	.iMUfiAdrsSpi		('h0000_0000),
	.iMUfiEdSpi			(1'b0),
	.iMUfiVdSpi			(1'b0),
	.iMUfiCmdSpi		(1'b0),
	//
	.iMUfiWdVtb			(wMUfiWdVtb),
	.iMUfiAdrsVtb		(wMUfiAdrsVtb),
	.iMUfiWEdVtb		(wMUfiWEdVtb),
	.iMUfiREdVtb		(wMUfiREdVtb),
	.iMUfiVdVtb			(wMUfiVdVtb),
	.iMUfiCmdVtb		(wMUfiCmdVtb),
	.oMUfiRdyVtb		(wMUfiRdyVtb),
	//
	.oSUfiWdVtb			(),
	.oSUfiAdrsVtb		(),
	.oSUfiWEdVtb		(),
	//
	.iMUfiAdrsAtb		(wMUfiAdrsAtb),
	.iMUfiWEdAtb		(wMUfiWEdAtb),
	.iMUfiREdAtb		(wMUfiREdAtb),
	.iMUfiVdAtb			(wMUfiVdAtb),
	.oMUfiRdyAtb		(wMUfiRdyAtb),
	//
	.oMUfiRd			(wMUfiRd),
	.oMUfiEddMcs		(),
	.oMUfiEddVtb		(wMUfiEddVtb),
	.oMUfiEddAtb		(wMUfiEddAtb),
	.oMUfiRdy			(wMUfiRdy),
	//
	.iMUfiIdI			(wMUfiIdI),
	.oMUfiIdO			(wMUfiIdO),
	//
	.oSUfiWdRam			(wSUfiWdRam),
	.oSUfiAdrsRam		(wSUfiAdrsRam),
	.oSUfiWEdRam		(wSUfiWEdRam),
	.oSUfiREdRam		(owSUfiREdRam),
	.oSUfiCmd			(wSUfiCmdRam),
	.iSUfiRdRam			(wSUfiRdRam),
	.iSUfiREdRam		(iwSUfiREdRam),
	.iSUfiRdyRam		(wSUfiRdyRam),
	//
	.iUfiRST			(rSysRst),
	.iUfiCLK			(wBusClk)
);



//-----------------------------------------------------------------------------
// BMP ファイル書き込み
//-----------------------------------------------------------------------------
wire wSaveEnd;

// RawFileSaver #(
// 	.pRawFileSave 	(lpRawFileSave)
// ) RAW_FILE_SAVER (
// 	.iColorR	(wTftColorR),
// 	.iColorG	(wTftColorG),
// 	.iColorB	(wTftColorB),
// 	.iVde		(wTftDe),
// 	.iAFE		(wAFE),
// 	.oSaveEnd	(wSaveEnd),
// 	.iRST		(rVtbVideoRst),
// 	.iCLK		(wVideoClk)
// );
BmpFileSaver #(
	.pRawFileSave 	(lpRawFileSave),
	.pHdisplay		(lpHdisplay),
	.pVdisplay		(lpVdisplay)
) BmpFileSaver (
	.iColorR		(wTftColorR),
	.iColorG		(wTftColorG),
	.iColorB		(wTftColorB),
	.iVde			(wTftDe),
	.iAFE			(wAFE),
	.oSaveEnd		(wSaveEnd),
	.iRST			(rVtbVideoRst),
	.iCLK			(wVideoClk)
);


//
task RawWriteWait(
	input integer flag
);
begin
	while (wSaveEnd == flag)
	begin
		#(lpVideoClkCycle);
	end
end
endtask


//-----------------------------------------------------------------------------
// TestBench 動作
// lpFrameCnt 画像出力の回数を指定可能、複数回ループさせて正しく raw 画像が出れば OK
//-----------------------------------------------------------------------------
localparam lpFrameCnt = 16;
integer n;

initial
begin
	system_reset();

	for (n = 0; n < lpFrameCnt; n = n + 1)
	begin
		RawWriteWait(0);
		RawWriteWait(1);
	end
    $finish;
end


endmodule
