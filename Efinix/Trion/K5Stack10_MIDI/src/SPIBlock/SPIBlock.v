//----------------------------------------------------------
// Create 2022/8/2
// Author koutakimura
// -
// バスシステムの Masterと SPI I/F の管理を司るブロック
// iSpiDir FPGA SPI の Master / Slave を切り替える役割も持つ
// I/O の状態を確認し、High Master / Low Slave とする
// 通常はフラッシュメモリと接続されるが、デバッグ時は 外部CPU と接続するためこの機能を設けた。
// 
// また、本ブロックは フラッシュメモリの操作を司る扱いではなく、SPI I/F を通じて外部ターゲットと通信を行う目的がある。
// そのため、外部ターゲット操作時にページ消去コマンドなどのシーケンス制御が必要ならば、
// 本ブロックを使用する Upper Module 内のブロックで制御を行うようにする。
// 汎用性を持たせるためこのような仕様とした。
// 
// V1.1 USIB 更新版に対応
//----------------------------------------------------------
module SPIBlock #(
	// variable parameter
	parameter pBlockAdrsWidth = 8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8
)(
	// External Port
	input  iSpiSck,
	input  iSpiMosi,
	output oSpiMiso,
	input  iSpiCs,
	output oSpiSck,
	output oSpiMosi,
	input  iSpiMiso,
	output oSpiCs,
	input  iSpiDir,
	// Flash Rom Only
	output oFlashRomSck,
	output oFlashRomMosi,
	input  iFlashRomMiso,
	output oFlashRomCs,
	// Flash Rom Dir
	output [1:0] oFlashSpiOe,
	// Bus Master Read
	input  [pUsiBusWidth-1:0] iMUsiRd,
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	output [pUsiBusWidth-1:0] oMUsiWd,
	output [pUsiBusWidth-1:0] oMUsiAdrs,
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
	// Interrupt
	output oSpiDir,		// 0. Slave として機能 / 1. Master バスを独占
	output onSpiDir,	// 0. Slave として機能 / 1. Master バスを独占
    // CLK Reset
    input  iSRST,
    input  iSCLK
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpDivClk = 16;	// SCL生成の分周値レジスタBit幅

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 				wSPIEnCsr;
wire [lpDivClk-1:0]	wSPIDivCsr;
wire [7:0] 			wMWdCsr;
wire 				wMSpiCsCsr;
wire [7:0]			wMRdCsr;
wire 				wMSpiIntrCsr;
// Flash Rom
wire 				wFlashSpiEnCsr;
wire [lpDivClk-1:0]	wFlashSpiDivCsr;
wire [7:0] 			wFlashWdCsr;
wire 				wFlashCsOutCtrlCsr;
wire 				wFlashSpiIoHiz;
wire [7:0]			wFlashRdCsr;
wire 				wFlashSpiIntrCsr;

SPICsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),			.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),		
	.pDivClk(lpDivClk)
) SPI_CSR (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// Csr Output
	.oSPIEn(wSPIEnCsr),				.oSPIDiv(wSPIDivCsr),
	.oMWd(wMWdCsr),					.oMSpiCs(wMSpiCsCsr),
	.oFlashSpiEn(wFlashSpiEnCsr),	.oFlashSpiDiv(wFlashSpiDivCsr),
	.oFlashWd(wFlashWdCsr),			.oFlashCsOutCtrl(wFlashCsOutCtrlCsr),
	.oFlashSpiIoHiz(wFlashSpiIoHiz),
	// Csr Input
	.iMRd(wMRdCsr),					.iMSpiIntr(wMSpiIntrCsr),
	.iFlashRd(wFlashRdCsr),			.iFlashSpiIntr(wFlashSpiIntrCsr),
	// CLK Reset
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


//---------------------------------------------------------------------------
// SPI OE
//---------------------------------------------------------------------------
reg [1:0] rFlashSpiOe;		assign oFlashSpiOe = rFlashSpiOe;	// [1] MISO / [0] SCK,MOSI,CS

always @(posedge iSCLK)
begin
	if (wFlashSpiIoHiz)	rFlashSpiOe <= 2'b01;	// FPGA が Flash Mem にアクセス
	else 				rFlashSpiOe <= 2'b00;	// 外部 Master が Flash Mem にアクセス
end


//----------------------------------------------------------
// 指定分周値 の CKE 信号生成
//----------------------------------------------------------
wire wDivCke;

CkeGenerator #(
	.pDivReg("yes"),	.pDivWidth(lpDivClk)
) SpiCkeGen (
	.iCke(wSPIEnCsr),	.iDiv(wSPIDivCsr),	.oCke(wDivCke),
	.iRST(iSRST),		  .iCLK(iSCLK)
);


//----------------------------------------------------------
// FPGA Slave の際のデータ操作
//----------------------------------------------------------
wire [pUsiBusWidth-1:0]	wMUsiRd;
wire [pUsiBusWidth-1:0]	wSpiRd;
wire [pUsiBusWidth-1:0]	wSpiAdrs;
wire wSpiREd;

SPISignalMux # (
	.pUsiBusWidth(pUsiBusWidth)
	// .pUfiBusWidth(pUfiBusWidth)
) SPISignalMux (
	// SPI USIB Bridge
	.iSpiRd(wSpiRd),	.iSpiAdrs(wSpiAdrs),
	.iSpiREd(wSpiREd),
	// Bus Master Write/Read
	.oMUsiRd(wMUsiRd), .iMUsiRd(iMUsiRd),
	.oMUsiWd(oMUsiWd),	.oMUsiAdrs(oMUsiAdrs),
	// Ufi Bus Master Write
	// .oMUfiWd		(oMUfiWd),
	// .oMUfiAdrs		(oMUfiAdrs),
	// .oMUfiEd		(oMUfiEd),
	// .oMUfiVd		(oMUfiVd),
	// .oMUfiCmd		(oMUfiCmd),
	// CLK Reset
	.iSRST(iSRST),	.iSCLK(iSCLK)
);


//----------------------------------------------------------
// 外部 CPU との SPI 通信信号生成
//----------------------------------------------------------
SPISignal SPISignal (
	// External Port
	// FPGA Slave
	.iSlaveSck(iSpiSck),	    .oSlaveMiso(oSpiMiso),
	.iSlaveMosi(iSpiMosi),	  .iSlaveCs(iSpiCs),
	// FPGA Master
	.oMasterSck(oSpiSck),	    .iMasterMiso(iSpiMiso),
	.oMasterMosi(oSpiMosi),	  .oMasterCs(oSpiCs),
	.iSpiDir(iSpiDir),
	// Internal Port FPGA Slave Side
	.iMUsiRd(wMUsiRd),		    .oSpiRd(wSpiRd),
	.oSpiAdrs(wSpiAdrs),	    .oSpiREd(wSpiREd),
	// Internal Port FPGA Master Side
	.iSPIEn(wSPIEnCsr),		    .iDivCke(wDivCke),
	.iMWd(wMWdCsr),			      .oMRd(wMRdCsr),
	.oMSpiIntr(wMSpiIntrCsr),	.iMSPICs(wMSpiCsCsr),
	// Control
	.oSpiDir(oSpiDir),	      .onSpiDir(onSpiDir),
	//
	.iSRST(iSRST), .iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Flash Rom との SPI 通信
//-----------------------------------------------------------------------------
wire wFlashDivCke;

SpiFlashRom SpiFlashRom (
	// External Port
	.oFlashRomSck(oFlashRomSck),
	.oFlashRomMosi(oFlashRomMosi),
	.iFlashRomMiso(iFlashRomMiso),
	.oFlashRomCs(oFlashRomCs),
	// Internal Port FPGA Master Side
	.iWd(wFlashWdCsr),					.oRd(wFlashRdCsr),
	.iDivCke(wFlashDivCke),				.iSpiEn(wFlashSpiEnCsr),
	.iCsOutCtrl(wFlashCsOutCtrlCsr),  	.oSpiIntr(wFlashSpiIntrCsr),
	// common
	.iSRST(iSRST), 		.iSCLK(iSCLK)
);

CkeGenerator #(
	.pDivReg("yes"),	.pDivWidth(lpDivClk)
) FlashSpiCkeGen (
	.iCke(wFlashSpiEnCsr),	.iDiv(wFlashSpiDivCsr),	.oCke(wFlashDivCke),
	.iRST(iSRST),			.iCLK(iSCLK)
);

endmodule