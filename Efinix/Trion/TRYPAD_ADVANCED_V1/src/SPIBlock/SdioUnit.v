/*-----------------------------------------------------------------------------
 * SDCard 制御
 *
 * 25-04-08 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module SdioUnit #(
	parameter 	pSfmNum = 3,
	parameter	pSfmPageWidth = 16
)(
	// Serial Flash Memory
	output						oSpiSck,
	output						oSpiMosi,
	input						iSpiMiso,
	output						oSpiCs,
	// Read Fifo I/F (Hard Side)
	output[15:0] 				oRd,
	output 						oRvd,
	output						oEmp,
	input 						iRe,
	// Control Status (CPU Side)
	input						iSfmEn,
	input						iSfmCycleEn,
	input [7:0]					iSfmDiv,		// ※2
	input [7:0]					iSfmCsHoldTime,
	input [pSfmPageWidth-1:0] 	iSfmStartAdrs,
	input [pSfmPageWidth-1:0] 	iSfmEndAdrs,
	input [7:0]					iSfmCpuWd,		// ※1
	input 						iSfmCpuEn,		// 1byte 毎に Auto Clear
	input 						iSfmCpuCsCtrl,	// CPU CS制御信号
	input 						iSfmCpuValid,	// CPU 制御時に有効
	output[7:0]					oSfmCpuRd,		// 
	output 						oSfmCpuDone,	// 1byte 送信完了時の割り込み信号
	output 						oSfmDone,
	output [pSfmPageWidth-1:0]	oSfmAdrsAdd,
	// CLK Reset
	input						iSRST,
	input						inSRST,
	input						iSCLK
);

// ※1 SfmCpu = 起動時の Flash Memory Protecition 解除などを CPU側から行うために使用する
// ※1 FPGA ステート・マシン で上記処理を行うとリソースを結構消費するため Fix
// ※2 ハード・ソフト操作で共通使用とする

//-----------------------------------------------------------------------------
// Rrs(Rom Read Sequence) Part
//-----------------------------------------------------------------------------
// reg  [7:0]	qRrsRd;
// reg 		qRrsDone;
// wire [7:0] 	wRrsWd;
// wire 		wRrsEn;
// wire 		wRrsCsCtrl;

// SpiFlashReadSequence #(
// 	.pSfmPageWidth(pSfmPageWidth)
// ) SpiFlashReadSequence (
// 	// Read Fifo I/F
// 	.oRd(oRd),						.oRvd(oRvd),
// 	.oEmp(oEmp),					.iRe(iRe),
// 	// Sfm Part
// 	.iSfmRd(qRrsRd),				.iSfmDone(qRrsDone),
// 	.oSfmWd(wRrsWd),				.oSfmEn(wRrsEn),
// 	.oSfmCsCtrl(wRrsCsCtrl),
// 	// control status
// 	.iSfmEn(iSfmEn),				.iSfmCycleEn(iSfmCycleEn),
// 	.iSfmCsHoldTime(iSfmCsHoldTime),
// 	.iSfmStartAdrs(iSfmStartAdrs),	.iSfmEndAdrs(iSfmEndAdrs),
// 	.oSfmDone(oSfmDone),			.oSfmAdrsAdd(oSfmAdrsAdd),
// 	// common
// 	.iRST(iSRST),	.inRST(inSRST),	.iCLK(iSCLK)
// );


//-----------------------------------------------------------------------------
// Spi Master Part
//-----------------------------------------------------------------------------
reg  [7:0] qSfrWd;
wire [7:0] wSfrRd;					assign oSfmCpuRd 	= wSfrRd;
wire wSfrDone;						assign oSfmCpuDone 	= wSfrDone;
wire wSfrDivCke;
reg	 qSfrCsCtrl;
reg  qSfrSpiEn;

SpiMaster SpiMaster (
	// Spi Master Signal
	.oSpiSck(oSpiSck),
	.oSpiMosi(oSpiMosi),
	.iSpiMiso(iSpiMiso),
	.oSpiCs(oSpiCs),
	// Sfr W/R Side
	.iWd(qSfrWd),
	.oRd(wSfrRd),
	// Control Status
	.oSpiIntr(wSfrDone),
	.iDivCke(wSfrDivCke),
	.iCsOutCtrl(qSfrCsCtrl),
	.iSpiEn(qSfrSpiEn),
	// common
	.iRST(iSRST), 	.iCLK(iSCLK)
);

CkeGenerator #(
	.pDivReg("yes"),	.pDivWidth(8)
) FlashSpiCkeGen (
	.iCke(qSfrSpiEn),	.iDiv(iSfmDiv),	.oCke(wSfrDivCke),
	.iRST(iSRST),		.iCLK(iSCLK)
);

// always @*
// begin
// 	qRrsRd		<= wSfrRd;
// 	qRrsDone	<= wSfrDone;
// end

always @*
begin
	// qSfrWd 		<= iSfmCpuValid ? iSfmCpuWd : wRrsWd;
	qSfrWd 		<= iSfmCpuWd;
	// qSfrSpiEn 	<= |{iSfmCpuEn,wRrsEn};
	qSfrSpiEn 	<= |{iSfmCpuEn};
	// qSfrCsCtrl	<= &{iSfmCpuCsCtrl,wRrsCsCtrl};
	qSfrCsCtrl	<= &{iSfmCpuCsCtrl};
end

//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------


endmodule