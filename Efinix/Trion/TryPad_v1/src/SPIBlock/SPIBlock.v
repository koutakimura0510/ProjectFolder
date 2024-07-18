/*------------------------------------------------------------------------------
 * Create 2022/8/2
 * Author koutakimura
 * -
 * バスシステムの Masterと SPI I/F の管理を司るブロック
 * iSpiDir FPGA SPI の Master / Slave を切り替える役割も持つ
 * I/O の状態を確認し、High Master / Low Slave とする
 * 通常はフラッシュメモリと接続されるが、デバッグ時は 外部CPU と接続するためこの機能を設けた。
 * 
 * また、本ブロックは フラッシュメモリの操作を司る扱いではなく、SPI I/F を通じて外部ターゲットと通信を行う目的がある。
 * そのため、外部ターゲット操作時にページ消去コマンドなどのシーケンス制御が必要ならば、
 * 本ブロックを使用する Upper Module 内のブロックで制御を行うようにする。
 * 汎用性を持たせるためこのような仕様とした。
 * 
 * V1.1 USIB 更新版に対応
 * V1.2 2024-07-15 : Master となる CPU が SPI 信号をスルーでデバイスにアクセスできるように更新
 *                   その他、module 構成を大幅に更新
 *-----------------------------------------------------------------------------*/
module SpiBlock #(
	// variable parameter
	parameter 						pBlockAdrsWidth 	= 8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsWidth-1:0] pAdrsMap	 		= 'h03,
	parameter 						pUsiBusWidth	 	= 32,
	parameter 						pCsrAdrsWidth	 	= 8,
	parameter 						pCsrActiveWidth	 	= 8,
	parameter 						pSfmNum 			= 3
)(
	// External Port for CPU Master
	input						iSpiSck,
	input						iSpiMosi,
	output						oSpiMiso,
	input						iSpiCs,
	input						iSpiThru,
	// External Port for Flash Memory
	output [pSfmNum-1:0] 		oSfmSck,
	output [pSfmNum-1:0] 		oSfmMosi,
	input  [pSfmNum-1:0] 		iSfmMiso,
	output [pSfmNum-1:0] 		oSfmCs,
	// Bus Master Read
	input  [pUsiBusWidth-1:0] 	iMUsiRd,
	output [pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	output [pUsiBusWidth-1:0] 	oMUsiWd,
	output [pUsiBusWidth-1:0] 	oMUsiAdrs,
	input  [pUsiBusWidth-1:0] 	iSUsiWd,
	input  [pUsiBusWidth-1:0] 	iSUsiAdrs,
	// Interrupt
	output oSpiDir,		// 0. Slave として機能 / 1. Master バスを独占
	output onSpiDir,	// 0. Slave として機能 / 1. Master バスを独占
    // CLK Reset
    input  iSRST,
    input  iSCLK
);


//---------------------------------------------------------------------------
localparam lpDqBitDepth = 16;
genvar x;

//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
localparam lpSfmPageWidth = 16;	// 16bit = 65535 page
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
	.iSUsiWd(iSUsiWd),				.iSUsiAdrs(iSUsiAdrs),
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
	.iSRST(iSRST),					.iSCLK(iSCLK)
);


/**-----------------------------------------------------------------------------
 * Spi Decord USIB Bridge
 *-----------------------------------------------------------------------------*/
reg [pUsiBusWidth-1:0]	qSsmSpiRd;
reg [pUsiBusWidth-1:0]	qSsmSpiAdrs;
reg 					qSsmSpiREd;
wire [pUsiBusWidth-1:0]	wSsmMUsiRd;

SpiUsibBridge #(
	.pUsiBusWidth(pUsiBusWidth)
) SpiUsibBridge (
	// SPI USIB Bridge
	.iSpiRd(qSsmSpiRd),		.iSpiAdrs(qSsmSpiAdrs),		.iSpiREd(qSsmSpiREd),
	// Bus Master Write/Read
	.oMUsiRd(wSsmMUsiRd), 	.iMUsiRd(iMUsiRd),
	.oMUsiWd(oMUsiWd),		.oMUsiAdrs(oMUsiAdrs),
	// Ufi Bus Master Write
	// .oMUfiWd		(oMUfiWd),
	// .oMUfiAdrs		(oMUfiAdrs),
	// .oMUfiEd		(oMUfiEd),
	// .oMUfiVd		(oMUfiVd),
	// .oMUfiCmd		(oMUfiCmd),
	// CLK Reset
	.iSRST(iSRST),	.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Sfc Part
//-----------------------------------------------------------------------------
wire [pSfmNum-1:0] wSfuSck;
wire [pSfmNum-1:0] wSfuMosi;
wire [pSfmNum-1:0] wSfuMiso;
wire [pSfmNum-1:0] wSfuCs;
//
wire [lpDqBitDepth-1:0] wArrRd [0:pSfmNum-1];
reg  [lpDqBitDepth-1:0] qArrRd [0:pSfmNum-1];
wire [pSfmNum-1:0] wArrRvd;
wire [pSfmNum-1:0] wArrEmp;
reg  [pSfmNum-1:0] qArrRe;

generate
	for (x = 0; x < pSfmNum; x = x + 1)
	begin : SpiFlashUnitX
		SpiFlashUnit #(
			.pSfmNum(pSfmNum),
			.pSfmPageWidth(lpSfmPageWidth)
		) SpiFlashUnit (
			// Serial Flash Memory
			.oSfuSck(wSfuSck[x]),		.oSfuMosi(wSfuMosi[x]),
			.iSfuMiso(wSfuMiso[x]),		.oSfuCs(wSfuCs[x]),
			// Audio Data
			.oRd(wArrRd[x]),			.oRvd(wArrRvd[x]),
			.oEmp(wArrEmp[x]),			.iRe(qArrRe[x]),
			// Logic Sfm Control
			.iSfmEn(wSfmEnCsr[x]),
			.iSfmCycleEn(wSfmCycleEnCsr[x]),
			.iSfmDiv(wSfmDivCsr[(x+1)*8-1:(x*8)]),
			.iSfmCsHoldTime(wSfmCsHoldTimeCsr[(x+1)*8-1:(x*8)]),
			.iSfmStartAdrs(wSfmStartAdrsCsr[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			.iSfmEndAdrs(wSfmEndAdrsCsr[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			.oSfmDone(wSfmDoneCsr[x]),
			.oSfmAdrsAdd(wSfmAdrsAddCsr[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			// Cpu Sfm Control
			.iSfmCpuWd(wSfmCpuWdCsr[(x+1)*8-1:(x*8)]),
			.iSfmCpuEn(wSfmCpuEnCsr[x]),
			.iSfmCpuCsCtrl(wSfmCpuCsCtrlCsr[x]),
			.iSfmCpuValid(wSfmCpuValidCsr[x]),
			.oSfmCpuRd(wSfmCpuRdCsr[(x+1)*8-1:(x*8)]),
			.oSfmCpuDone(wSfmCpuDoneCsr[x]),
			// common
			.iSRST(iSRST),	.inSRST(inSRST),	.iSCLK(iSCLK)
		);
	end
endgenerate


/**-----------------------------------------------------------------------------
 * Spi Slave Port
 *-----------------------------------------------------------------------------*/
wire [pUsiBusWidth-1:0]	wSspDecDq;
wire [pUsiBusWidth-1:0]	wSspDecAdrs;
wire					wSspDecREd;
wire [pUsiBusWidth-1:0]	qSspMUsiRd;

SpiSlavePort #(
	.pSfmNum(pSfmNum)
) SpiSlavePort (
	// External Port for CPU Master
	.iSpiSck(iSpiSck),			.iSpiMosi(iSpiMosi),		.oSpiMiso(oSpiMiso),	.iSpiCs(iSpiCs),
	.iSpiThru(iSpiThru),
	// External Port for Flash Memory
	.oSfmSck(oSfmSck),			.oSfmMosi(oSfmMosi),		.iSfmMiso(iSfmMiso),	.oSfmCs(oSfmCs),
	// Internal Port for CPU Master to FPGA Slave Side
	.iMUsiRd(qSspMUsiRd),
	.oDecRd(wSspDecDq),			.oDecAdrs(wSspDecAdrs),		.oDecREd(wSspDecREd),
	// Internal Port for FPGA Master to Flash Rom Slave Side
	.iSfuSck(wSfuSck),			.iSfuMosi(wSfuMosi),		.oSfuMiso(wSfuMiso),	.iSfuCs(wSfuCs),
	// Control / Status
	.iDeviceSel(),
	// common
	.iSRST(iSRST),				.iSCLK(iSCLK)
);

always @*
begin
	qSsmSpiRd	<= wSspDecDq;
	qSsmSpiAdrs	<= wSspDecAdrs;
	qSsmSpiREd	<= wSspDecREd;
	qSspMUsiRd	<= wSsmMUsiRd;
end

endmodule