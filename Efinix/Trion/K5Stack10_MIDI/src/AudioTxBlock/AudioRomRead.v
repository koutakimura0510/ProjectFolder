/*-----------------------------------------------------------------------------
 * SPI ROM から音源データを読み出し
 *
 * 23-09-02 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module AudioRomRead #(
	parameter 	pSfmNum = 3,
	parameter	pSfmPageWidth = 16
)(
	// Serial Flash Memory
	output	oSfmSck,
	output	oSfmMosi,
	input	iSfmMiso,
	output	oSfmCs,
	// Audio Data
	output [15:0] 				oAudioData,
	output 						oAudioVd,
	// Control Status
	input						iSfmEn,
	input						iSfmCycleEn,
	input [7:0]					iSfmDiv,		// ※2
	input [7:0]					iSfmCsHoldTime,
	input [pSfmPageWidth-1:0] 	iSfmStartAdrs,
	input [pSfmPageWidth-1:0] 	iSfmEndAdrs,
	input [7:0]					iSfmCpuWd,		// ※1
	input 						iSfmCpuEn,
	input 						iSfmCpuCsCtrl,
	input 						iSfmCpuValid,
	output[7:0]					oSfmCpuRd,
	output 						oSfmCpuDone,
	output 						oSfmDone,
	// CLK Reset
	input	iSRST,
	input	inSRST,
	input	iSCLK
);

// ※1 SfmCpu = 起動時の Flash Memory Protecition 解除などを CPU側から行うために使用する
// ※1 FPGA ステート・マシン で上記処理を行うとリソースを結構消費するため Fix
// ※2 ハード・ソフト操作で共通使用とする

//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------



//-----------------------------------------------------------------------------
// Flash Rom Access
//-----------------------------------------------------------------------------
reg  [7:0] qSfrWd;
wire [7:0] wSfrRd;					assign oSfmCpuRd 	= wSfrRd;
wire wSfrDone;						assign oSfmCpuDone 	= wSfrDone;
wire wSfrDivCke;
reg	 qSfrCsCtrl;
reg  qSfrSpiEn;

SpiFlashRom SpiFlashRom (
	// Serial Flash Memory
	.oFlashRomSck(oSfmSck),
	.oFlashRomMosi(oSfmMosi),
	.iFlashRomMiso(iSfmMiso),
	.oFlashRomCs(oSfmCs),
	// Sfr W/R Side
	.iWd(qSfrWd),
	.oRd(wSfrRd),
	// Control Status
	.oSpiIntr(wSfrDone),
	.iDivCke(wSfrDivCke),
	.iCsOutCtrl(qSfrCsCtrl),
	.iSpiEn(qSfrSpiEn),
	// common
	.iSRST(iSRST), 	.iSCLK(iSCLK)
);

CkeGenerator #(
	.pDivReg("yes"),	.pDivWidth(8)
) FlashSpiCkeGen (
	.iCke(qSfrSpiEn),	.iDiv(iSfmDiv),	.oCke(wSfrDivCke),
	.iRST(iSRST),		.iCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Flash Rom Read Sequence
//-----------------------------------------------------------------------------
always @*
begin
	qSfrWd 		<= iSfmCpuValid ? iSfmCpuWd : 8'h00;
	qSfrSpiEn 	<= |{iSfmCpuEn,iSfmEn};
	qSfrCsCtrl	<= iSfmCpuValid ? iSfmCpuCsCtrl : 1'b1;
end

//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------


endmodule