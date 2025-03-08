/*-----------------------------------------------------------------------------
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2023.1.754
 * Device  TRYPAD V1
 * -
 * 24-06-01 v1.00: new release
 *
 *-----------------------------------------------------------------------------*/  
module TryPadV1Top #(
parameter [15:0] pSystemVersion	= 16'h0001,
parameter [15:0] pDeviceCode	= "TRPD"
)(
// Video I/F
output[15:0] 	oVideoDq,
output			oVideoIm0,
output			oVideoDc,
output			oVideoRd,
output			oVideoWr,
output			oVideoCs,
output			oVideoRst,
output			oVideoBl,
// SDIO I/F
output[ 3:0]	ioSdioDq_O,
output[ 3:0]	ioSdioDq_OE,
input [ 3:0]	ioSdioDq_I,
output			ioSdioCmd_O,
output			ioSdioCmd_OE,
input			ioSdioCmd_I,
output			oSdioClk,
input			iSdioDetA,
input			iSdioDetB,
// Config Flash Rom I/F
input			iSpiMosi,
output			oSpiMiso,
input			iSpiSck,
input			iSpiCs,
// PSRAM I/F
output[15:0]	ioRamDq_O,
output[15:0]	ioRamDq_OE,
input [15:0]	ioRamDq_I,
output[ 3:0]	oRamCs,
output[ 3:0]	oRamClk,
// I2S I/F
output 			oI2cSdo,
output 			oI2sLrc,
output 			oI2cBck,
// Push Sw
input [11:0] 	iPushSw,
// Led
output[ 7:0]	oLed,
// CLK, RST
input			iOscSys,
input			iMCLK,
input			iVCLK,
input			iSCLK,
input			iPllBr0Lock,
input			iPllTl0Lock,
input			iPllTl1Lock,
output			onPllBr0Rst,
output			onPllTl0Rst,
output			onPllTl1Rst,
// JTAG Debug
// input	jtag_inst1_TCK,
// output	jtag_inst1_TDO,
// input	jtag_inst1_TDI,
// input	jtag_inst1_TMS,
// input	jtag_inst1_RUNTEST,
// input	jtag_inst1_SEL,
// input	jtag_inst1_CAPTURE,
// input	jtag_inst1_SHIFT,
// input	jtag_inst1_UPDATE,
// input	jtag_inst1_RESET,
// JTAG Soc
input			jtag_inst1_TCK,
output			jtag_inst1_TDO,
input			jtag_inst1_TDI,
input			jtag_inst1_TMS,
input			jtag_inst1_RUNTEST,
input			jtag_inst1_SEL,
input			jtag_inst1_CAPTURE,
input			jtag_inst1_SHIFT,
input			jtag_inst1_UPDATE,
input			jtag_inst1_RESET
);

/**----------------------------------------------------------------------------
 * Pkg Version
 *---------------------------------------------------------------------------*/
localparam lpPkgVer	= "v1";


//-----------------------------------------------------------------------------
// System Reset Gen
//-----------------------------------------------------------------------------
genvar x;  // Top内で共通変数として使用する
//
reg 	rSRST, rnSRST;
reg 	rMRST, rnMRST;
reg 	rVRST, rnVRST;
wire 	wSRST, wnSRST;
wire 	wMRST, wnMRST;
wire 	wVRST, wnVRST;
//
wire 	wnARST;
reg  	qnARST;
reg  	qlocked;

always @(posedge iMCLK, negedge qnARST)
begin
	if (!qnARST)	rnMRST <= 1'b0;
	else			rnMRST <= 1'b1;

	if (!qnARST)	rMRST <= 1'b1;
	else			rMRST <= 1'b0;
end

always @(posedge iSCLK, negedge qnARST)
begin
	if (!qnARST)	rnSRST <= 1'b0;
	else			rnSRST <= 1'b1;
  
	if (!qnARST)	rSRST <= 1'b1;
	else			rSRST <= 1'b0;
end

always @(posedge iVCLK, negedge qnARST)
begin
	if (!qnARST)	rnVRST <= 1'b0;
	else			rnVRST <= 1'b1;
  
	if (!qnARST)	rVRST <= 1'b1;
	else			rVRST <= 1'b0;
end

always @*
begin
  qlocked <= &{iPllBr0Lock, iPllTl0Lock, iPllTl1Lock};
  qnARST  <= &{~wnARST,qlocked};
end

assign wSRST		= rSRST;			assign wnSRST   = rnSRST;
assign wMRST		= rMRST;			assign wnMRST   = rnMRST;
assign wVRST		= rVRST;			assign wnVRST   = rnVRST;
assign onPllBr0Rst	= 1'b1;
assign onPllTl0Rst	= 1'b1;
assign onPllTl1Rst	= 1'b1;


//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth      = 32;		// USIB データ、アドレス共通バス幅
localparam lpBlockConnectNum  = 7;		// 現在接続しているブロックの個数
localparam lpBlockAdrsWidth   = f_detect_bitwidth(lpBlockConnectNum);
localparam lpCsrAdrsWidth     = 16;		// 各ブロック共通の基本CSR幅
localparam lpSUsiBusWidth     = (lpUsiBusWidth * lpBlockConnectNum);
localparam [lpBlockAdrsWidth-1:0]		// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
  lpGpioAdrsMap		= 'h0,
  lpSPIAdrsMap		= 'h1,
  lpAtbAdrsMap  	= 'h2,
  lpRAMAdrsMap		= 'h3,
  lpSysTimerAdrsMap	= 'h4,
  lpMCBAdrsMap		= 'h5,
  lpVtbAdrsMap		= 'h6,
  lpNullAdrsMap		= 0;

// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが難しいと感じたため用意した。
localparam 
  lpGpioCsrActiveWidth  = 8,
  lpSPICsrActiveWidth   = 8,
  lpAtbCsrActiveWidth   = 8,
  lpRAMCsrActiveWidth   = 8,
  lpTimerCsrActiveWidth = 8,
  lpMCBCsrActiveWidth	= 8,
  lpVtbCsrActiveWidth	= 12,
  lpNullActiveWidth     = 8;  // 使用しない、ソースの追加がやりやすいように

// Bus Master Read
wire [lpUsiBusWidth-1:0]  wMUsiRd, wSUsiRd[lpBlockConnectNum-1:0];
reg  [lpSUsiBusWidth-1:0] qSUsiRd;  // 二次元配列で取得した Slave Readデータを一次元に結合
// Bus Master Write
reg  [lpUsiBusWidth-1:0] qMUsiWd,    qMUsiAdrs;
wire [lpUsiBusWidth-1:0] wSUsiWd,    wSUsiAdrs;
wire [lpUsiBusWidth-1:0] wMUsiWdMcb,  wMUsiAdrsMcb;
wire [lpUsiBusWidth-1:0] wMUsiWdSpi,  wMUsiAdrsSpi;

USIB #(
  .pBlockConnectNum(lpBlockConnectNum),  .pBlockAdrsWidth(lpBlockAdrsWidth),
  .pUsiBusWidth(lpUsiBusWidth),      .pCsrAdrsWidth(lpCsrAdrsWidth)
) USIB (
  // Bus Master Read
  .oMUsiRd(wMUsiRd),  .iSUsiRd(qSUsiRd),
  // Bus Master Write
  .iMUsiWd(qMUsiWd),  .iMUsiAdrs(qMUsiAdrs),
  .oSUsiWd(wSUsiWd),  .oSUsiAdrs(wSUsiAdrs),
  // CLK, RST
  .iSRST(wSRST),    .iSCLK(iSCLK)
);

always @*
begin
  // qMUsiWd    <= wMUsiWdSpi;
  // qMUsiAdrs  <= wMUsiAdrsSpi;
  qMUsiWd    <= wMUsiWdSpi;
  qMUsiAdrs  <= wMUsiAdrsSpi;
//   qMUsiWd    <= wMUsiWdMcb;
//   qMUsiAdrs  <= wMUsiAdrsMcb;
end

generate
  for (x = 0; x < lpBlockConnectNum; x = x + 1)
  begin
    always @*
    begin
      qSUsiRd[((x+1)*lpUsiBusWidth)-1:x*lpUsiBusWidth] <= wSUsiRd[x];
    end
  end
endgenerate

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
localparam  lpRamAdrsWidth    		= 24;		// 外部 RAM の Adrs 領域
localparam  lpRamDqWidth      		= 16;		// 外部 RAM の Dq 端子数
localparam  lpDmaAdrsWidth    		= lpRamAdrsWidth;
localparam  lpUfiBusWidth   		= 48;		// UFIB データ幅
localparam  lpUfiBlockConnectNum 	= 2;		// UFIB Connet Block Number
localparam 	lpUfiBlockAdrsWidth		= f_detect_bitwidth(lpUfiBlockConnectNum);
localparam	lpMUfiBusWidth 			= lpUfiBusWidth   * lpUfiBlockConnectNum;
//
localparam lpSynDmaBurstLength		= 16;
localparam lpVtbDmaBurstLength		= 16;

// initial begin
// 	$display("%d", lpUfiBlockAdrsWidth);
// end
localparam [lpUfiBlockAdrsWidth-1:0]	// UFI ブロックアドレスマッピング
	lpUfiMcbAdrsMap		= 'h0,
	lpUfiVtbAdrsMap		= 'h1,
	lpUfiNullAdrsMap	= 	0;
	
// Ufi Slave to Master
wire [lpUfiBusWidth-1:0] 		wSUfiRd;
wire [lpUfiBusWidth-1:0] 		wMUfiRd;
wire 							wSUfiVd;
wire [lpUfiBlockConnectNum-1:0]	wMUfiVd;
// Usi Master to Slave
wire [lpUfiBusWidth-1:0] 		wSUfiWd;
wire [lpUfiBusWidth-1:0] 		wMUfiWd[0:lpUfiBlockConnectNum-1];
wire 							wSUfiRdy;
wire [lpUfiBlockConnectNum-1:0]	wMUfiRdy;
//
reg [lpMUfiBusWidth-1:0]		qMUfiWd;

UFIBv2 #(
	.pBlockConnectNum(lpUfiBlockConnectNum),
	.pBlockAdrsWidth(lpUfiBlockAdrsWidth),
	.pUfiBusWidth(lpUfiBusWidth)
) UFIBv2 (
	// Ufi Bus Master Read
	.iSUfiRd(wSUfiRd),	.oMUfiRd(wMUfiRd),
	.iSUfiVd(wSUfiVd),	.oMUfiVd(wMUfiVd),
	// Ufi Bus Master Write
	.oSUfiWd(wSUfiWd),	.iSUfiRdy(wSUfiRdy),
	.iMUfiWd(qMUfiWd),	.oMUfiRdy(wMUfiRdy),
	// CLK Reset
	.iRST(wSRST),    	.iCLK(iSCLK)
);


generate
	for (x = 0; x < lpUfiBlockConnectNum; x = x + 1)
	begin
		always @*
		begin
			qMUfiWd[((x+1)*lpUfiBusWidth)-1:x*lpUfiBusWidth] <= wMUfiWd[x];
		end
	end
endgenerate

//-----------------------------------------------------------------------------
// MCB 
//-----------------------------------------------------------------------------
// localparam lpOnChipMcu = "yes";		// "yes"=Generate MCU, "no"=not
localparam lpOnChipMcu = "no";		// "yes"=Generate MCU, "no"=not

wire wSocTxd, wSocRxd;

MicroControllerBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),
	.pAdrsMap(lpMCBAdrsMap),
	.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpMCBCsrActiveWidth),
	.pUsiBusWidth(lpUsiBusWidth),
	.pUfiBusWidth(lpUfiBusWidth),
	.pUfiAdrsMap(lpUfiMcbAdrsMap),
	.pOnChipMcu(lpOnChipMcu)
) MicroControllerBlock (
	// Usi Bus Master Read
	.iMUsiRd(wMUsiRd),
	.oSUsiRd(wSUsiRd[lpMCBAdrsMap]),
	// Usi Bus Master Write
	.oMUsiWd(wMUsiWdMcb),	.oMUsiAdrs(wMUsiAdrsMcb),
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.iMUfiRd(wMUfiRd),
	.iMUfiVd(wMUfiVd[lpUfiMcbAdrsMap]),
	// Ufi Bus Master Write
	.oMUfiWd(wMUfiWd[lpUfiMcbAdrsMap]),
	.iMUfiRdy(wMUfiRdy[lpUfiMcbAdrsMap]),
	// GPIO
	.oTxd(wSocTxd),			.iRxd(wSocRxd),
	// Control / Status
	.iSystemVersion(pSystemVersion),
	.iCustomCode(pDeviceCode),
	// JTAG
	.jtag_inst1_TCK(jtag_inst1_TCK),
	.jtag_inst1_TDI(jtag_inst1_TDI),
	.jtag_inst1_TDO(jtag_inst1_TDO),
	.jtag_inst1_SEL(jtag_inst1_SEL),
	.jtag_inst1_CAPTURE(jtag_inst1_CAPTURE),
	.jtag_inst1_SHIFT(jtag_inst1_SHIFT),
	.jtag_inst1_UPDATE(jtag_inst1_UPDATE),
	.jtag_inst1_RESET(jtag_inst1_RESET),
	// common
	.iSRST(wSRST),			.inSRST(rnSRST),		.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// GPIO Block
//-----------------------------------------------------------------------------
localparam lpGpioWidth	= 8;
localparam lpExtSwNum	= 12;
wire [lpGpioWidth-1:0]	wGpio_O;
wire [lpGpioWidth-1:0]	wGpio_Dir;
wire [lpGpioWidth-1:0]	wGpio_In;
reg  [lpGpioWidth-1:0]	qGpioAltMode;
//
wire [23:0] 			wVideoGpioOe;
wire [2:0]				wAudioGpioOe;
wire [7:0]				wRomGpioOe;
wire [6:0]				wCfgRomGpioOe;
//
wire [lpExtSwNum-1:0] 	wPushSw;
wire [lpExtSwNum-1:0] 	wEdgeSw;
wire [lpExtSwNum-1:0] 	wLongSw;

GpioBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),
	.pAdrsMap(lpGpioAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),
	.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpGpioCsrActiveWidth),
	.pGpioWidth(lpGpioWidth),
	.pExtSwNum(lpExtSwNum)
) GpioBlock (
	// GPIO Output Ctrl
	.oGpio(wGpio_O),		.oGpioDir(wGpio_Dir),
	// GPIO Alt Mode
	.iGpioAltMode(qGpioAltMode),
	// GPIO Input
	.iGpioIn(8'h00),
	// User I/F
	.iPushSw(wPushSw),		.oEdgeSw(wEdgeSw),		.oLongSw(wLongSw),
	// Status
	.iPllLock(qlocked),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpGpioAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(wSRST),			.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// External CPU Master SPI Block or Slave SPI Block
//-----------------------------------------------------------------------------
localparam lpSfmNum = 1;		// Serial Flash Memory Number

wire wSlaveSck,		wSlaveMosi,		wSlaveMiso,		wSlaveCs;		// Ext  SPI Master -> FPGA SPI Slave
wire wSpiThru;
wire wSdioDetA, wSdioDetB;
//
wire [lpSfmNum-1:0] wSfmSck;
wire [lpSfmNum-1:0] wSfmMosi;
wire [lpSfmNum-1:0] wSfmMiso;
wire [lpSfmNum-1:0] wSfmCs;
//
wire [31:0]			wAtbDQ;
wire				wAtbVD;
wire				wAtbFLL;

SpiBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpSPIAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpSPICsrActiveWidth),
	.pSfmNum(lpSfmNum)
) SpiBlock (
	// External Port for CPU Master
	.iSpiSck(wSlaveSck),	.iSpiMosi(wSlaveMosi),	.oSpiMiso(wSlaveMiso),	.iSpiCs(wSlaveCs),
	.iSpiThru(1'b0),
	// External Port for Flash Memory
	.oSfmSck(wSfmSck),		.oSfmMosi(wSfmMosi),	.iSfmMiso(wSfmMiso),	.oSfmCs(wSfmCs),
	.iSdioDetA(wSdioDetA),	.iSdioDetB(wSdioDetB),
	// Dual Port Audio Stream Data
	// .oAtbDQ(wAtbDQ),		.oAtbVD(wAtbVD),		.iAtbFLL(wAtbFLL),
	// Bus Master Read
	.iMUsiRd(wMUsiRd),		.oSUsiRd(wSUsiRd[lpSPIAdrsMap]),
	// Bus Master Write
	.oMUsiWd(wMUsiWdSpi),	.oMUsiAdrs(wMUsiAdrsSpi),
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(wSRST),			.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Sound Generate
//-----------------------------------------------------------------------------
wire wI2S_MCLK, wI2S_BCLK, wI2S_LRCLK, wI2S_SDATA;

AudioTxBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpAtbAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpAtbCsrActiveWidth)
) AudioTxBlock (
	// Audio dac I/F Port
	.oI2S_MCLK(wI2S_MCLK),		.oI2S_BCLK(wI2S_BCLK),
	.oI2S_LRCLK(wI2S_LRCLK),	.oI2S_SDATA(wI2S_SDATA),
	// Dual Port Stream Data
	.iDQ(wAtbDQ),				.iVD(wAtbVD),		.oFLL(wAtbFLL),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpAtbAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),			.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iMRST(wMRST),									.iMCLK(iMCLK),
	.iSRST(wSRST),				.inSRST(wnSRST),	.iSCLK(iSCLK)
);

//---------------------------------------------------------------------------
// Systick Timer Block
//---------------------------------------------------------------------------
SysTimerBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),	.pAdrsMap(lpSysTimerAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),
	.pCsrAdrsWidth(lpCsrAdrsWidth),		.pCsrActiveWidth(lpTimerCsrActiveWidth)
) SysTimerBlock (
	// Usi Bus Master Read
	.oSUsiRd(wSUsiRd[lpSysTimerAdrsMap]),
	// Usi Bus Master Write
	.iSUsiWd(wSUsiWd),	.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(wSRST),		.iSCLK(iSCLK)
);

//---------------------------------------------------------------------------
// Video Tx Block
//---------------------------------------------------------------------------
wire [23:0]	wVIDEO_DQ;
wire		wVIDEO_WRX,	wVIDEO_DCX, wVIDEO_RDX,	wVIDEO_CSX;
wire 		wVIDEO_RST;
wire [3:0]	wVIDEO_IM;
wire 		wVIDEO_BL;
wire 		wVIDEO_DCK,	wVIDEO_VS, 	wVIDEO_HS, wVIDEO_DE;

VideoTxBlock #(
	// USI
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpVtbAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpVtbCsrActiveWidth),
	// UFI
	.pUfiBusWidth(lpUfiBusWidth),			.pUfiAdrsMap(lpUfiVtbAdrsMap)
) VideoTxBlock (
	// VIDEO Output Signal Ctrl
	.oVIDEO_DQ(wVIDEO_DQ),		.oVIDEO_WRX(wVIDEO_WRX),
	.oVIDEO_DCX(wVIDEO_DCX),	.oVIDEO_RDX(wVIDEO_RDX),
	.oVIDEO_CSX(wVIDEO_CSX),	.oVIDEO_RST(wVIDEO_RST),
	.oVIDEO_IM(wVIDEO_IM),		.oVIDEO_BL(wVIDEO_BL),
	.oVIDEO_HS(wVIDEO_HS),		.oVIDEO_VS(wVIDEO_VS),	.oVIDEO_DE(wVIDEO_DE),
	.oVIDEO_DCK(wVIDEO_DCK),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpVtbAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),			.iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.iMUfiRd(wMUfiRd),
	.iMUfiVd(wMUfiVd[lpUfiVtbAdrsMap]),
	// Ufi Bus Master Write
	.oMUfiWd(wMUfiWd[lpUfiVtbAdrsMap]),
	.iMUfiRdy(wMUfiRdy[lpUfiVtbAdrsMap]),
	// CLK, RST
	.iVRST(wVRST),		.inVRST(wnVRST),	.iVCLK(iVCLK),
	.iSRST(wSRST),		.inSRST(wnSRST),	.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Memory Block
//-----------------------------------------------------------------------------
localparam lpRamDevConfIntGen = "yes";

wire [lpRamDqWidth-1:0]  wRamDq_O;
wire [lpRamDqWidth-1:0]  wRamDq_I;
wire [1:0] wRamDq_Oe;
wire [3:0] wRamClk;
wire [3:0] wRamCe;
wire wSRAM_nRST;
wire wTestErr, wDone;

RamBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),	.pAdrsMap(lpRAMAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),
	.pCsrAdrsWidth(lpCsrAdrsWidth),		.pCsrActiveWidth(lpRAMCsrActiveWidth),
	.pUfiBusWidth(lpUfiBusWidth),
	// Ram I/F
	.pRamAdrsWidth(lpRamAdrsWidth),		.pRamDqWidth(lpRamDqWidth),
	// test
	.pDevConfIntGen(lpRamDevConfIntGen)
) RamBlock (
  // SRAM I/F Port
	.oRamDq(wRamDq_O),		.iRamDq(wRamDq_I),		.oRamDq_Oe(wRamDq_Oe),
	.oRamClk(wRamClk),		.oRamCe(wRamCe),
	// Usi Bus Master Read
	.oSUsiRd(wSUsiRd[lpRAMAdrsMap]),
	// Usi Bus Master Write
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.oSUfiRd(wSUfiRd),		.oSUfiVd(wSUfiVd),
	// Ufi Bus Master Write
	.iSUfiWd(wSUfiWd),		.oSUfiRdy(wSUfiRdy),
	// Status
	.oTestErr(wTestErr),	.oDone(wDone),
	// CLK, RST
	.iSRST(wSRST),			.inSRST(wnSRST),		.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Debug Core Block
//-----------------------------------------------------------------------------
localparam lpSclkCntMax = 25000000;
localparam lpMclkCntMax = 22600000;
localparam lpVclkCntMax = 9000000;

wire wPulseSCLK,wPulseMCLK,wPulseVCLK;

PulseGenerator #(.pDivClk(lpSclkCntMax)) SclkPulseGenerator (.oPulse(wPulseSCLK), .iRST(wSRST), .iCLK(iSCLK));
PulseGenerator #(.pDivClk(lpMclkCntMax)) MclkPulseGenerator (.oPulse(wPulseMCLK), .iRST(wMRST), .iCLK(iMCLK));
PulseGenerator #(.pDivClk(lpVclkCntMax)) VclkPulseGenerator (.oPulse(wPulseVCLK), .iRST(wVRST), .iCLK(iVCLK));

always @*
begin
	qGpioAltMode[0] <= qlocked;	// 内部ロジックの状態を LED に結線する。
	qGpioAltMode[1] <= wPulseSCLK;
	qGpioAltMode[2] <= wPulseMCLK;
	qGpioAltMode[3] <= wPulseVCLK;
	qGpioAltMode[4] <= 1'b0;
	qGpioAltMode[5] <= 1'b0;
	qGpioAltMode[6] <= 1'b0;
	qGpioAltMode[7] <= 1'b0;
end

//-----------------------------------------------------------------------------
// IO Connect
// Trion,Titanium はユーザーが使用可能な IOプリミティブは無いため、
// 階層を深くせずソースの修正が簡単にすることを目的として Top module に接続する仕様にした
// OE "0"=Input, "1"=Output
//-----------------------------------------------------------------------------
//
// Video I/F
assign 	oVideoDq		= wVIDEO_DQ[15:0];
assign	oVideoDc		= wVIDEO_DCX;
assign	oVideoRd		= wVIDEO_RDX;
assign	oVideoWr		= wVIDEO_WRX;
assign	oVideoCs		= wVIDEO_CSX;
assign	oVideoRst		= wVIDEO_RST;
assign	oVideoIm0		= wVIDEO_IM[0];
assign	oVideoBl		= wVIDEO_BL;
//
// I2S I/F
assign	oI2cSdo			= wI2S_SDATA;
assign	oI2sLrc			= wI2S_LRCLK;
assign	oI2cBck			= wI2S_BCLK;
//
// User Sdio I/F
wire wNotUsed[4:1];

assign ioSdioDq_O[0]	= 1'b1;				assign wSfmMiso			= ioSdioDq_I[0];	assign ioSdioDq_OE[0]	= 1'b0;		// SPI Mode = MISO
assign ioSdioDq_O[1]	= 1'b1;				assign wNotUsed[1]		= ioSdioDq_I[1];	assign ioSdioDq_OE[1]	= 1'b0;		// SPI Mode = IRQ
assign ioSdioDq_O[2]	= 1'b1;				assign wNotUsed[2]		= ioSdioDq_I[2];	assign ioSdioDq_OE[2]	= 1'b0;
assign ioSdioDq_O[3]	= wSfmCs;			assign wNotUsed[3]		= ioSdioDq_I[3];	assign ioSdioDq_OE[3]	= 1'b1;		// SPI Mode = CS_B
assign ioSdioCmd_O		= wSfmMosi;			assign wNotUsed[4]		= ioSdioCmd_I;		assign ioSdioCmd_OE		= 1'b1;		// SPI Mode = MOSI
assign oSdioClk			= wSfmSck;			//wSdioClk;			// SPI Mode = SCK
assign wSdioDetA		= iSdioDetA;
assign wSdioDetB		= iSdioDetB;
//
// User PSRAM I/F
assign ioRamDq_O[7:0] 	= wRamDq_O[7:0];	assign wRamDq_I[7:0] 	= ioRamDq_I[7:0];		assign ioRamDq_OE[7:0] 		= {8{wRamDq_Oe[0]}};
assign ioRamDq_O[15:8]	= wRamDq_O[15:8];	assign wRamDq_I[15:8] 	= ioRamDq_I[15:8];		assign ioRamDq_OE[15:8] 	= {8{wRamDq_Oe[1]}};
assign oRamClk[0]		= wRamClk[0];
assign oRamClk[1]		= wRamClk[1];
assign oRamClk[2]		= wRamClk[2];
assign oRamClk[3]		= wRamClk[3];
assign oRamCs[0]		= wRamCe[0];
assign oRamCs[1]		= wRamCe[1];
assign oRamCs[2]		= wRamCe[2];
assign oRamCs[3]		= wRamCe[3];
//
// CPU Master SPI I/F
assign wSlaveMosi		= iSpiMosi;
assign oSpiMiso			= wSlaveMiso;
assign wSlaveSck		= iSpiSck;
assign wSlaveCs			= iSpiCs;
//
// User I/F
assign wPushSw[0]	= iPushSw[0];	// SW-B
assign wPushSw[1]	= iPushSw[1];	// SW-A
assign wPushSw[2]	= iPushSw[2];	// SW-X
assign wPushSw[3]	= iPushSw[3];	// SW-Y
assign wPushSw[4]	= iPushSw[4];	// SW-UR
assign wPushSw[5]	= iPushSw[5];	// SW-START
assign wPushSw[6]	= iPushSw[6];	// SW-SELECT
assign wPushSw[7]	= iPushSw[7];	// SW-L
assign wPushSw[8]	= iPushSw[8];	// SW-UL
assign wPushSw[9]	= iPushSw[9];	// SW-U
assign wPushSw[10]	= iPushSw[10];	// SW-D
assign wPushSw[11]	= iPushSw[11];	// SW-R
//
assign oLed[0]		= wGpio_O[0];
assign oLed[1]		= wGpio_O[1];
assign oLed[2]		= wGpio_O[2];
assign oLed[3]		= wGpio_O[3];
assign oLed[4]		= wGpio_O[4];
assign oLed[5]		= wGpio_O[5];
assign oLed[6]		= wGpio_O[6];
assign oLed[7]		= wGpio_O[7];


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------
function integer f_detect_bitwidth;
	input integer number;
	integer bitwidth;
	integer bitcnt;
	integer	i;
	begin
		bitcnt = 0;
		for (i = 0; i < 32; i = i+1 )
		begin
			if (number[i]) 
			begin
				bitcnt++;
			end
		end

		if (bitcnt == 1)
		begin
			for (i = 0; i < 32; i = i+1 )
			begin
				if (number[i]) 
				begin
					f_detect_bitwidth = i+1;
				end
			end

			if (f_detect_bitwidth != 1)
			begin
				f_detect_bitwidth = f_detect_bitwidth - 1;
			end
		end
		else
		begin
			bitwidth = 0;
			if (number == 0)
			begin
				f_detect_bitwidth = 1;
			end
			else
			begin
				while (number != 0)
				begin
					bitwidth++;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction

endmodule