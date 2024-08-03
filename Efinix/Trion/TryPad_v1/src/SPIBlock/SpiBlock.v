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
	// Dual Port Audio Stream Data
	output [31:0]				oAtbDQ,
	output [ 1:0]				oAtbVD,
	input  [ 1:0]				iAtbFLL,
	// Bus Master Read
	input  [pUsiBusWidth-1:0] 	iMUsiRd,
	output [pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	output [pUsiBusWidth-1:0] 	oMUsiWd,
	output [pUsiBusWidth-1:0] 	oMUsiAdrs,
	input  [pUsiBusWidth-1:0] 	iSUsiWd,
	input  [pUsiBusWidth-1:0] 	iSUsiAdrs,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);


//---------------------------------------------------------------------------
genvar x;

//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
localparam lpSfmPageWidth = 16;	// 16bit = 65535 page

wire [pSfmNum-1:0] 					wSfmIoHizCsr;				//assign oSfmIoHiz = wSfmIoHizCsr;
wire [pSfmNum-1:0] 					wSfmEnCsr;
wire [pSfmNum-1:0] 					wSfmCycleEnCsr;
wire [pSfmNum*8-1:0] 				wSfmDivCsr;
wire [pSfmNum*8-1:0] 				wSfmCsHoldTimeCsr;
wire [pSfmNum*lpSfmPageWidth-1:0] 	wSfmStartAdrsCsr;
wire [pSfmNum*lpSfmPageWidth-1:0] 	wSfmEndAdrsCsr;
wire [pSfmNum*8-1:0] 				wSfmCpuWdCsr;
wire [pSfmNum-1:0] 					wSfmCpuEnCsr;
wire [pSfmNum-1:0] 					wSfmCpuCsCtrlCsr;
wire [pSfmNum-1:0] 					wSfmCpuValidCsr;
wire [pSfmNum*8-1:0] 				wSfmCpuRdCsr;
wire [pSfmNum-1:0] 					wSfmCpuDoneCsr;
wire [pSfmNum-1:0] 					wSfmDoneCsr;
wire [pSfmNum*lpSfmPageWidth-1:0] 	wSfmAdrsAddCsr;
wire [ 2:0]							wSspDeviceSelCsr;

SpiCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pSfmNum(pSfmNum),
	.pSfmPageWidth(lpSfmPageWidth)
) SpiCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),				.iSUsiAdrs(iSUsiAdrs),
	// Csr Output
	.oSfmEn(wSfmEnCsr),
	.oSfmCycleEn(wSfmCycleEnCsr),
	.oSfmDiv(wSfmDivCsr),
	.oSfmCsHoldTime(wSfmCsHoldTimeCsr),
	.oSfmStartAdrs(wSfmStartAdrsCsr),
	.oSfmEndAdrs(wSfmEndAdrsCsr),
	.oSfmIoHiz(wSfmIoHizCsr),
	.oSfmCpuWd(wSfmCpuWdCsr),
	.oSfmCpuEn(wSfmCpuEnCsr),
	.oSfmCpuCsCtrl(wSfmCpuCsCtrlCsr),
	.oSfmCpuValid(wSfmCpuValidCsr),
	.oSspDeviceSel(wSspDeviceSelCsr),
	// Csr Input
	.iSfmCpuRd(wSfmCpuRdCsr),
	.iSfmCpuDone(wSfmCpuDoneCsr),
	.iSfmDone(wSfmDoneCsr),
	.iSfmAdrsAdd(wSfmAdrsAddCsr),
    // common
	.iSRST(iSRST),		.iSCLK(iSCLK)
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
localparam lpDqBitDepth = 16;

wire [pSfmNum-1:0] wSfuSck;
wire [pSfmNum-1:0] wSfuMosi;
wire [pSfmNum-1:0] wSfuMiso;
wire [pSfmNum-1:0] wSfuCs;
//
wire [lpDqBitDepth-1:0] wAtbRd [0:pSfmNum-1];
wire [pSfmNum-1:0] wAtbRvd;
wire [pSfmNum-1:0] wAtbEmp;
reg  [pSfmNum-1:0] qAtbRe;

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
			.oRd(wAtbRd[x]),			.oRvd(wAtbRvd[x]),
			.oEmp(wAtbEmp[x]),			.iRe(qAtbRe[x]),
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

assign		oAtbDQ = {wAtbRd[1],wAtbRd[0]};
assign		oAtbVD = {wAtbRvd[1],wAtbRvd[0]};
always @*	qAtbRe[1:0] <= iAtbFLL;
always @*	qAtbRe[2] 	<= 1'b0;

/**-----------------------------------------------------------------------------
 * Spi Slave Port
 *-----------------------------------------------------------------------------*/
wire [pUsiBusWidth-1:0]	wSspDecDq;
wire [pUsiBusWidth-1:0]	wSspDecAdrs;
wire					wSspDecREd;
reg  [pUsiBusWidth-1:0]	qSspMUsiRd;

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
	.oDecDq(wSspDecDq),			.oDecAdrs(wSspDecAdrs),		.oDecREd(wSspDecREd),
	// Internal Port for FPGA Master to Flash Rom Slave Side
	.iSfuSck(wSfuSck),			.iSfuMosi(wSfuMosi),		.oSfuMiso(wSfuMiso),	.iSfuCs(wSfuCs),
	// Control / Status
	.iDeviceSel(wSspDeviceSelCsr),
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