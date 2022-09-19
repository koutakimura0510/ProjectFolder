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
localparam lpRawFileSave	= "d:/workspace/Xilinx/workspace/CmodA7/BraveFrontierDemo/src/Processor/VideoTxBlock/sim/ImageData.raw";


//----------------------------------------------------------
// Clk Generator
// ・システムクロックはビデオクロックの 2倍以上の周波数でなければならない
// ・メモリクロックはビデオクロックの 2.5倍以上の周波数でなければならない
// ・バスクロックはシステムクロックの 2.5倍以上の周波数でなければならない。
//----------------------------------------------------------
localparam 	lpSysClkCycle 	= 12;
localparam 	lpBusClkCycle 	= 6;
localparam 	lpVideoClkCycle = 40;
localparam 	lpMemClkCycle 	= 18;	// ※ 2022-09-20 やはり外部メモリはバトルネックになる
//
wire 		wSysClk;
wire 		wBusClk;
wire 		wVideoClk;
wire 		wMemClk;
//
reg  		rSysRst;
reg 		rVtbSystemRst;
reg 		rVtbVideoRst;
reg 		rRamSrcRst;
reg 		rRamDstRst;
reg 		rDmaEn;
//
reg 		rRamSrcRst;
reg 		rRamDstRst;
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


//-----------------------------------------------------------------------------
// リセット信号の生成
// rVtbVideoRst リセットは rVtbSystemRst より遅らせることで、
// Dual CLk FIFO にある程度データを溜める目的がある。
//-----------------------------------------------------------------------------
task system_reset();
begin
	rSysRst 		<= 1'b1;
	rVtbSystemRst 	<= 1'b1;
	rVtbVideoRst 	<= 1'b1;
	rRamSrcRst		<= 1'b1;
	rRamDstRst		<= 1'b1;
	rDmaEn  		<= 1'b0;
	#(lpMemClkCycle * 2);
	rSysRst 		<= 1'b0;
	#(lpSysClkCycle * 10);
	rDmaEn  		<= 1'b1;
	rVtbSystemRst 	<= 1'b0;
	rRamSrcRst		<= 1'b0;
	rRamDstRst		<= 1'b0;
	#(lpSysClkCycle * 10);
	rVtbVideoRst 	<= 1'b0;
end
endtask


//-----------------------------------------------------------------------------
// UfiBus パラメータ
//-----------------------------------------------------------------------------
localparam lpBusAdrsBit			= 32;
localparam lpUfiBusWidth		= 12;
localparam lpMemAdrsWidth		= 19;
//
wire [lpUfiBusWidth-1:0] 		wMUfiWdVtb;
wire [lpBusAdrsBit-1:0]			wMUfiAdrsVtb;
wire 							wMUfiWEdVtb;
wire 							wMUfiREdVtb;
wire 							wMUfiVdVtb;		// 転送期間中 Assert
wire 							wMUfiCmdVtb;	// High Read / Lor Write
wire 							wMUfiRdyVtb;	// Vtb に対する Ready 信号
reg 							qMUfiRdy;
//
wire [lpUfiBusWidth-1:0] 		wMUfiRd;		// Master に対する 読み込みデータ
wire 							wMUfiREd;		// Master に対する 読み込み有効信号
wire 							wMUfiRdy;		// Master に対する Ready 信号
// Slave Memory Block Side
wire [lpUfiBusWidth-1:0] 		wSUfiWdRam;		// Slave に対する 書き込みデータ
wire [lpBusAdrsBit-1:0]			wSUfiAdrsRam;	// Slave に対する R/W 共通のアドレス指定バス
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
localparam	lpHdisplay		= 480;
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
localparam lpDualClkFifoDepth	= 16;	// FIFO サイズを可変して、あらゆるサイズで動作可能か検討する
localparam lpDmaFifoDepth		= 16;	// 上記同文
localparam lpFrameSize 			= lpHdisplay * lpVdisplay * 2; // ダブルフレームバッファ構造
localparam lpDmaAdrs1			= 0;
localparam lpDmaAdrs2			= lpHdisplay * lpVdisplay;
localparam lpDmaLen1			= (lpHdisplay * lpVdisplay) - 1;
localparam lpDmaLen2			= (lpHdisplay * lpVdisplay * 2) - 1;
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
	.pBusAdrsBit		(lpBusAdrsBit),
	.pUfiBusWidth		(lpUfiBusWidth),
	.pMemAdrsWidth		(lpMemAdrsWidth),
	.pHdisplayWidth		(lpHdisplayWidth),
	.pVdisplayWidth		(lpVdisplayWidth),
	.pColorDepth		(lpColorDepth),
	.pDualClkFifoDepth	(lpDualClkFifoDepth),
	.pDmaFifoDepth		(lpDmaFifoDepth)
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
	.iMUfiREd			(wMUfiREd),
	.iMUfiRdy			(qMUfiRdy),
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
	.iVtbSystemRst		(rVtbSystemRst),
	.iVtbVideoRst		(rVtbVideoRst),
	.iDisplayRst		(1'b0),
	.iBlDutyRatio		(127),
	.iDmaWAdrs			(lpDmaAdrs1),
	.iDmaRAdrs			(lpDmaAdrs2),
	.iDmaWLen			(lpDmaLen1),
	.iDmaRLen			(lpDmaLen2),
	.iDmaEn				(rDmaEn),
	.iSysClk			(wSysClk),
	.iVideoClk			(wVideoClk),
	.iSysRst			(rSysRst),
	.oFe				(wAFE)
);

always @*
begin
	qMUfiRdy <= wMUfiRdyVtb & wMUfiRdy;
end


//----------------------------------------------------------
// RAM Unit
//----------------------------------------------------------
localparam lpRamFifoDepth	= 16;
localparam lpRamDqWidth		= lpUfiBusWidth;
//
reg  [lpRamDqWidth-1:0] 	rMem	[0:lpFrameSize-1];	// RW フレームバッファ領域
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
	.pBusAdrsBit		(lpBusAdrsBit),
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
	.iRamDualFifoSrcRst	(rRamSrcRst),
	.iRamDualFifoDstRst	(rRamDstRst),
	//
	.iSysRst			(rSysRst),
	.iSysClk			(wSysClk),
	.iMemClk			(wMemClk)
);
//

integer i;

initial
begin
	for (i = 0; i < lpFrameSize; i = i + 1)		// 左右半分で色分けしたデータを初期値とする
	begin
		if (i[4:0] < (lpHdisplay/2))
		begin
			rMem[i] <= 12'h0f0;
		end
		else
		begin
			rMem[i] <= 12'hfff;
		end
	end
end

always @(posedge wMemClk)
begin
	casex ({wMemWE, wMemCE})	// フレームバッファにデータを書き込み
		'b00:		rMem[wMemAdrs] <= wMemDq;
		default:	rMem[wMemAdrs] <= rMem[wMemAdrs];
	endcase
end

always @*
begin
	casex ({wMemWE, wMemCE})	// フレームバッファのデータを読み出し
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
	.pBusAdrsBit		(lpBusAdrsBit)
) UltraFastInterface (
	.iMUfiWdMcs			({lpUfiBusWidth{1'b0}}),
	.iMUfiAdrsMcs		('h0000_0000),
	.iMUfiEdMcs			(1'b0),
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
	.iMUfiAdrsAtb		({lpUfiBusWidth{1'b0}}),
	.iMUfiEdAtb			('h0000_0000),
	.iMUfiVdAtb			(1'b0),
	.oMUfiRdyAtb		(),
	//
	.oMUfiRd			(wMUfiRd),
	.oMUfiREd			(wMUfiREd),
	.oMUfiRdy			(wMUfiRdy),
	.oSUfiWdRam			(wSUfiWdRam),
	.oSUfiAdrsRam		(wSUfiAdrsRam),
	.oSUfiWEdRam		(wSUfiWEdRam),
	.oSUfiREdRam		(owSUfiREdRam),
	.oSUfiCmd			(wSUfiCmdRam),
	.iSUfiRdRam			(wSUfiRdRam),
	.iSUfiREdRam		(iwSUfiREdRam),
	.iSUfiRdyRam		(wSUfiRdyRam),
	.iUfiRst			(rSysRst),
	.iUfiClk			(wBusClk)
);



//-----------------------------------------------------------------------------
// ファイル書き込み
//-----------------------------------------------------------------------------
wire wSaveEnd;

RawFileSaver #(
	.pRawFileSave (lpRawFileSave)
) RAW_FILE_SAVER (
	.iColorR	(wTftColorR),
	.iColorG	(wTftColorG),
	.iColorB	(wTftColorB),
	.iVde		(wTftDe),
	.iAFE		(wAFE),
	.oSaveEnd	(wSaveEnd),
	.iRst		(rVtbVideoRst),
	.iClk		(wVideoClk)
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
localparam lpFrameCnt = 4;
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
