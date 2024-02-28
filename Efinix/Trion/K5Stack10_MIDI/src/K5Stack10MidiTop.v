/*-----------------------------------------------------------------------------
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * Device  K5Stack10 Main Board
 * -
 * 23-04-04 v1.00: new release
 * 23-09-02 v1.01: SynthesizerBlock から AudioTxBlock へ変更
 * 23-09-17 v2.00: K5Stack10-v2 に更新のためピンアサイン変更
 * 23-10-15 v2.01: HyperRAMに対応するため、SCLK を 50MHz->100MHz に変更
 * 24-01-17 v3.00: K5Stack10-v3 に更新のためピンアサイン変更,命名規則更新
 * 24-02-27 v3.01: K5Stack10-v3 iPushSw[4:5] 短絡のため I/O 変更、VIDEO_CLK/AUDIO_CLK clkout 属性に変更
 *
 *-----------------------------------------------------------------------------*/  
module K5Stack10MidiTop(
	// Pin Header GPIO
	input   [37:0]	ioGpio_I,
	output  [37:0]	ioGpio_O,
	output  [37:0]	ioGpio_OE,
	// Ext RAM
	input	[15:0]	ioRamDq_I,
	output	[15:0]	ioRamDq_O,
	output	[15:0]	ioRamDq_OE,
	output	[1:0]	oRamClk,
	output	[1:0]	oRamCe,
	// Ext ROM
	input	[7:0]	ioSpiRomDq_I,
	output	[7:0]	ioSpiRomDq_O,
	output	[7:0]	ioSpiRomDq_OE,
	output	[1:0]	oSpiRomClk,
	output	[1:0]	oSpiRomCe,
	// Ext User I/F
	input	[6:0]	iPushSw,
	input	[1:0]	iDipSw,
	output	[3:0]	oLed,
	// USB I/F
	input	iUsbRx,
	output	oUsbTx,
	input	ioI2cScl_I,
	output	ioI2cScl_O,
	output	ioI2cScl_OE,
	input	ioI2cSda_I,
	output	ioI2cSda_O,
	output	ioI2cSda_OE,
	// External OSC
	input	iOSC_IN,
	// PLL BR0
	input	iSCLK,
	output	PLL_BR0_RSTN,
	input	PLL_BR0_LOCKED,
	// PLL TL0
	input	iMCLK,
	output	PLL_TL0_RSTN,
	input	PLL_TL0_LOCKED,
	// PLL TL1
	input	iVCLK,
	output	PLL_TL1_RSTN,
	input	PLL_TL1_LOCKED,
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
	input	jtag_inst1_TCK,
	output	jtag_inst1_TDO,
	input	jtag_inst1_TDI,
	input	jtag_inst1_TMS,
	input	jtag_inst1_RUNTEST,
	input	jtag_inst1_SEL,
	input	jtag_inst1_CAPTURE,
	input	jtag_inst1_SHIFT,
	input	jtag_inst1_UPDATE,
	input	jtag_inst1_RESET
);


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
  qlocked <= &{PLL_BR0_LOCKED, PLL_TL0_LOCKED, PLL_TL1_LOCKED};
  qnARST  <= iPushSw[6] & qlocked;
end

assign wSRST		= rSRST;			assign wnSRST   = rnSRST;
assign wMRST		= rMRST;			assign wnMRST   = rnMRST;
assign wVRST		= rVRST;			assign wnVRST   = rnVRST;
assign PLL_BR0_RSTN = 1'b1;
assign PLL_TL0_RSTN = 1'b1;
assign PLL_TL1_RSTN = 1'b1;


//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth      = 32;		// USIB データ、アドレス共通バス幅
localparam lpBlockConnectNum  = 8;		// 現在接続しているブロックの個数
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
  lpI2cAdrsMap		= 'h7,
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
  lpI2cCsrActiveWidth	= 8,
  lpNullActiveWidth     = 8;  // 使用しない、ソースの追加がやりやすいように

// Bus Master Read
wire [lpUsiBusWidth-1:0]  wMUsiRd, wSUsiRd[lpBlockConnectNum-1:0];
reg  [lpSUsiBusWidth-1:0] qSUsiRd;  // 二次元配列で取得した Slave Readデータを一次元に結合
// Bus Master Write
reg  [lpUsiBusWidth-1:0] qMUsiWd,    qMUsiAdrs;
wire [lpUsiBusWidth-1:0] wSUsiWd,    wSUsiAdrs;
wire [lpUsiBusWidth-1:0] wMUsiWdMcb,  wMUsiAdrsMcb;
wire [lpUsiBusWidth-1:0] wMUsiWdSpi,  wMUsiAdrsSpi;
wire wSpiDir, wnSpiDir;

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
  // qMUsiWd    <= wSpiDir ? wMUsiWdSpi   : wMUsiWdMcb;
  // qMUsiAdrs  <= wSpiDir ? wMUsiAdrsSpi : wMUsiAdrsMcb;
  qMUsiWd    <= wMUsiWdMcb;
  qMUsiAdrs  <= wMUsiAdrsMcb;
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
localparam  lpUfiDqBusWidth   		= 16;		// UFIB データ幅
localparam  lpUfiAdrsBusWidth 		= 32;		// UFIB アドレス幅
localparam  lpUfiBlockConnectNum 	= 6;		// UFIB Connet Block Number
localparam 	lpUfiBlockAdrsWidth		= f_detect_bitwidth(lpUfiBlockConnectNum);
localparam	lpMUfiDqWidth 			= lpUfiDqBusWidth   * lpUfiBlockConnectNum;
localparam	lpMUfiAdrsWidth			= lpUfiAdrsBusWidth * lpUfiBlockConnectNum;
//
localparam lpSynDmaBurstLength		= 16;
localparam lpVtbDmaBurstLength		= 16;

// initial begin
// 	$display("%d", lpUfiBlockAdrsWidth);
// end
//
localparam [lpUfiBlockAdrsWidth-1:0]	// UFI ブロックアドレスマッピング
	lpUfiMcbAdrsMap		= 'h0,
	lpUfiSynAdrsMap		= 'h1,
	lpUfiSynAdrs2Map	= 'h2,
	lpUfiSynAdrs3Map	= 'h3,
	lpUfiSynAdrs4Map	= 'h4,
	lpUfiVtbAdrsMap		= 'h5,
	lpUfiNullAdrsMap	= 	0;
//
wire [lpUfiDqBusWidth-1:0] 		wSUfiRd;
wire [lpUfiAdrsBusWidth-1:0] 	wSUfiAdrs;
wire [lpUfiDqBusWidth-1:0] 		wMUfiRd;
wire [lpUfiAdrsBusWidth-1:0] 	wMUfiAdrs;
//
wire [lpUfiDqBusWidth-1:0] 		wSUfiWd;
wire [lpUfiAdrsBusWidth-1:0] 	wSUfiWAdrs;
wire 							wSUfiRdy;
wire [lpUfiDqBusWidth-1:0] 		wMUfiWd[0:lpUfiBlockConnectNum-1];
wire [lpUfiAdrsBusWidth-1:0] 	wMUfiWAdrs[0:lpUfiBlockConnectNum-1];
wire [lpUfiBlockConnectNum-1:0]	wMUfiRdy;
//
reg [lpMUfiDqWidth-1:0]			qMUfiWd;
reg [lpMUfiAdrsWidth-1:0]		qMUfiWAdrs;

UFIB #(
	.pBlockConnectNum(lpUfiBlockConnectNum),
	.pBlockAdrsWidth(lpUfiBlockAdrsWidth),
	.pUfiDqBusWidth(lpUfiDqBusWidth),
	.pUfiAdrsBusWidth(lpUfiAdrsBusWidth)
) UFIB (
	// Ufi Bus Master Read
	.iSUfiRd(wSUfiRd),  .iSUfiAdrs(wSUfiAdrs),
	.oMUfiRd(wMUfiRd),  .oMUfiAdrs(wMUfiAdrs),
	// Ufi Bus Master Write
	.oSUfiWd(wSUfiWd),  .oSUfiAdrs(wSUfiWAdrs),
	.iSUfiRdy(wSUfiRdy),
	.iMUfiWd(qMUfiWd),  .iMUfiAdrs(qMUfiWAdrs),
	.oMUfiRdy(wMUfiRdy),
	// CLK Reset
	.iRST(wSRST),    	.iCLK(iSCLK)
);


generate
	for (x = 0; x < lpUfiBlockConnectNum; x = x + 1)
	begin
		always @*
		begin
			qMUfiWd[((x+1)*lpUfiDqBusWidth)-1:x*lpUfiDqBusWidth]		<= wMUfiWd[x];
			qMUfiWAdrs[((x+1)*lpUfiAdrsBusWidth)-1:x*lpUfiAdrsBusWidth]	<= wMUfiWAdrs[x];
		end
	end
endgenerate

//-----------------------------------------------------------------------------
// MCB 
//-----------------------------------------------------------------------------
localparam lpOnChipMcu = "yes";		// "yes"=Generate MCU, "no"=not
// localparam lpOnChipMcu = "no";		// "yes"=Generate MCU, "no"=not

wire wSocTxd, wSocRxd;

MicroControllerBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),
	.pAdrsMap(lpMCBAdrsMap),
	.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpMCBCsrActiveWidth),
	.pUsiBusWidth(lpUsiBusWidth),
	.pUfiDqBusWidth(lpUfiDqBusWidth),
	.pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
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
	.iMUfiRd(wMUfiRd),		.iMUfiAdrs(wMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(wMUfiWd[lpUfiMcbAdrsMap]),
	.oMUfiAdrs(wMUfiWAdrs[lpUfiMcbAdrsMap]),
	.iMUfiRdy(wMUfiRdy[lpUfiMcbAdrsMap]),
	// GPIO
	.oTxd(wSocTxd),			.iRxd(wSocRxd),
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
localparam lpGpioWidth	= 4;
localparam lpExtSwNum	= 7;
wire [lpGpioWidth-1:0]	wGpio_O;
wire [lpGpioWidth-1:0]	wGpio_Dir;
wire [lpGpioWidth-1:0]	wGpio_In;
reg  [lpGpioWidth-1:0]	qGpioAltMode;
//
wire [lpExtSwNum-1:0] 	wPushSw;
wire [1:0] 				wDipSw;
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
	.iGpioIn(wGpio_In),
	// User I/F
	.iPushSw(wPushSw),		.iDipSw(wDipSw),
	.oEdgeSw(wEdgeSw),		.oLongSw(wLongSw),
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
wire wSlaveSck, wSlaveMosi, wSlaveMiso, wSlaveCs;
wire wMasterSck, wMasterMosi, wMasterMiso, wMasterCs;
wire wFlashRomSck, wFlashRomMosi, wFlashRomMiso, wFlashRomCs;
wire [1:0] wFlashSpiOe;
wire wIoSpiDir;

SPIBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpSPIAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpSPICsrActiveWidth)
) SPIBlock (
	// SPI Bus Connected External CPU
	.iSpiSck(wSlaveSck),		.iSpiMosi(wSlaveMosi),
	.oSpiMiso(wSlaveMiso),		.iSpiCs(wSlaveCs),
	.oSpiSck(wMasterSck),		.oSpiMosi(wMasterMosi),
	.iSpiMiso(wMasterMiso),		.oSpiCs(wMasterCs),
	.iSpiDir(wIoSpiDir),
	// SPI Bus Connected External Flash Rom
	.oFlashRomSck(wFlashRomSck),
	.oFlashRomMosi(wFlashRomMosi),
	.iFlashRomMiso(wFlashRomMiso),
	.oFlashRomCs(wFlashRomCs),
	// Flash Rom Dir
	.oFlashSpiOe(wFlashSpiOe),
	// Bus Master Read
	.iMUsiRd(wMUsiRd),		.oSUsiRd(wSUsiRd[lpSPIAdrsMap]),
	// Bus Master Write
	.oMUsiWd(wMUsiWdSpi),	.oMUsiAdrs(wMUsiAdrsSpi),
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// MUsi 制御信号
	.oSpiDir(wSpiDir),		.onSpiDir(wnSpiDir),
	// CLK, RST
	.iSRST(wSRST),			.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Sound Generate
//-----------------------------------------------------------------------------
localparam lpSfcNum = 2;		// Serial Flash Memory Number

wire wI2sMclk;
wire wI2sBclk;
wire wI2sLrclk;
wire wI2sSdata;
wire [lpSfcNum-1:0] wSfmSck;
wire [lpSfcNum-1:0] wSfmMosi;
wire [lpSfcNum-1:0] wSfmMiso;
wire [lpSfcNum-1:0] wSfmCs;

AudioTxBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpAtbAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpAtbCsrActiveWidth),
	.pSfmNum(lpSfcNum)
) AudioTxBlock (
	// Audio dac I/F Port
	.oI2S_MCLK(wI2sMclk),	.oI2S_BCLK(wI2sBclk),
	.oI2S_LRCLK(wI2sLrclk),	.oI2S_SDATA(wI2sSdata),
	// Serial Frash Memory I/F Port
	.oSfmSck(wSfmSck),		.oSfmMosi(wSfmMosi),
	.iSfmMiso(wSfmMiso),	.oSfmCs(wSfmCs),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpAtbAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iMRST(wMRST),								.iMCLK(iMCLK),
	.iSRST(wSRST),			.inSRST(wnSRST),	.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Memory Block
//-----------------------------------------------------------------------------
localparam lpRamDevConfIntGen = "yes";

wire [lpRamDqWidth-1:0]  wRamDq_O;
wire [lpRamDqWidth-1:0]  wRamDq_I;
wire [1:0] wRamDq_Oe;
wire [1:0] wRamClk;
wire [1:0] wRamCe;
wire wSRAM_nRST;
wire wTestErr, wDone;

RamBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),	.pAdrsMap(lpRAMAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),
	.pCsrAdrsWidth(lpCsrAdrsWidth),		.pCsrActiveWidth(lpRAMCsrActiveWidth),
	.pUfiDqBusWidth(lpUfiDqBusWidth),	.pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
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
	.oSUfiRd(wSUfiRd),		.oSUfiAdrs(wSUfiAdrs),
	// Ufi Bus Master Write
	.iSUfiWd(wSUfiWd),		.iSUfiAdrs(wSUfiWAdrs),
	.oSUfiRdy(wSUfiRdy),
	// Status
	.oTestErr(wTestErr),	.oDone(wDone),
	// CLK, RST
	.iSRST(wSRST),			.inSRST(wnSRST),		.iSCLK(iSCLK)
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
	.iSUsiWd(wSUsiWd),    .iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(wSRST),		.iSCLK(iSCLK)
);

//---------------------------------------------------------------------------
// Video Tx Block
//---------------------------------------------------------------------------
wire [7:0] 	wVIDEO_R;
wire [7:0] 	wVIDEO_G;
wire [7:0] 	wVIDEO_B;
wire 		wVIDEO_DCK,	wVIDEO_VS, wVIDEO_HS, wVIDEO_DE;
wire 		wVIDEO_RST;

VideoTxBlock #(
	// USI
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpVtbAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpVtbCsrActiveWidth),
	// UFI
	.pUfiDqBusWidth(lpUfiDqBusWidth),		.pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
	.pUfiAdrsMap(lpUfiVtbAdrsMap),
	.pDmaAdrsWidth(lpDmaAdrsWidth),			.pDmaBurstLength(lpVtbDmaBurstLength)
) VideoTxBlock (
	// VIDEO Output Signal Ctrl
	.oVIDEO_R(wVIDEO_R),		.oVIDEO_G(wVIDEO_G),	.oVIDEO_B(wVIDEO_B),
	.oVIDEO_DCK(wVIDEO_DCK),
	.oVIDEO_HS(wVIDEO_HS),		.oVIDEO_VS(wVIDEO_VS),	.oVIDEO_DE(wVIDEO_DE),
	.oVIDEO_RST(wVIDEO_RST),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpVtbAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),    .iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.iMUfiRd(wMUfiRd),    .iMUfiAdrs(wMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(wMUfiWd[lpUfiVtbAdrsMap]),
	.oMUfiAdrs(wMUfiWAdrs[lpUfiVtbAdrsMap]),
	.iMUfiRdy(wMUfiRdy[lpUfiVtbAdrsMap]),
	// CLK, RST
	.iVRST(wVRST),		.inVRST(wnVRST),	.iVCLK(iVCLK),
	.iSRST(wSRST),		.inSRST(wnSRST),	.iSCLK(iSCLK)
);

/**----------------------------------------------------------------------------
 * I2c Block
 *---------------------------------------------------------------------------*/
wire wiI2cScl,	woI2cScl,	woI2cSclOe;
wire wiI2cSda,	woI2cSda,	woI2cSdaOe;

I2cBlock #(
	// USI
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpI2cAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpI2cCsrActiveWidth)
) I2cBlock (
	// I2C Sinal Ctrl
	.iI2cScl(wiI2cScl),		.oI2cScl(woI2cScl),	.oI2cSclOe(woI2cSclOe),
	.iI2cSda(wiI2cSda),		.oI2cSda(woI2cSda),	.oI2cSdaOe(woI2cSdaOe),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpI2cAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(wSRST),			.inSRST(wnSRST),	.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Debug Core Block
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// IO Connect
// Trion,Titanium はユーザーが使用可能な IOプリミティブは無いため、
// 階層を深くせずソースの修正が簡単にすることを目的として Top module に接続する仕様にした
// OE "0"=Input, "1"=Output
//-----------------------------------------------------------------------------
// GPIO Header
wire [37:0] wGpioIn;
assign ioGpio_O[0]	= 1'b0;/*wVIDEO_DCK*/assign  wGpioIn[0] 	= ioGpio_I[0];		assign ioGpio_OE[0]		= 1'b0;
assign ioGpio_O[1]	= wVIDEO_RST;		assign  wGpioIn[1] 	= ioGpio_I[1];		assign ioGpio_OE[1]		= 1'b1;
assign ioGpio_O[2]	= wVIDEO_B[6];		assign  wGpioIn[2]	= ioGpio_I[2];		assign ioGpio_OE[2]		= 1'b1;
assign ioGpio_O[3]	= wVIDEO_B[7];		assign  wGpioIn[3]	= ioGpio_I[3];		assign ioGpio_OE[3]		= 1'b1;
assign ioGpio_O[4]	= wVIDEO_B[4];		assign  wGpioIn[4]	= ioGpio_I[4];		assign ioGpio_OE[4]		= 1'b1;
assign ioGpio_O[5]	= wVIDEO_B[5];		assign  wGpioIn[5]	= ioGpio_I[5];		assign ioGpio_OE[5]		= 1'b1;
assign ioGpio_O[6]	= wVIDEO_B[3];		assign  wGpioIn[6]	= ioGpio_I[6];		assign ioGpio_OE[6]		= 1'b1;
assign ioGpio_O[7]	= wVIDEO_B[2];		assign  wGpioIn[7]	= ioGpio_I[7];		assign ioGpio_OE[7]		= 1'b1;
assign ioGpio_O[8]	= wVIDEO_B[1];		assign  wGpioIn[8]	= ioGpio_I[8];		assign ioGpio_OE[8]		= 1'b1;
assign ioGpio_O[9]	= wVIDEO_B[0];		assign  wGpioIn[9]	= ioGpio_I[9];		assign ioGpio_OE[9]		= 1'b1;
assign ioGpio_O[10]	= wVIDEO_G[7];		assign  wGpioIn[10]	= ioGpio_I[10];		assign ioGpio_OE[10]	= 1'b1;
assign ioGpio_O[11]	= wVIDEO_G[6];		assign  wGpioIn[11]	= ioGpio_I[11];		assign ioGpio_OE[11]	= 1'b1;
assign ioGpio_O[12]	= wVIDEO_G[5];		assign  wGpioIn[12]	= ioGpio_I[12];		assign ioGpio_OE[12]	= 1'b1;
assign ioGpio_O[13]	= wVIDEO_G[4];		assign  wGpioIn[13]	= ioGpio_I[13];		assign ioGpio_OE[13]	= 1'b1;
assign ioGpio_O[14]	= wVIDEO_G[3];		assign  wGpioIn[14]	= ioGpio_I[14];		assign ioGpio_OE[14]	= 1'b1;
assign ioGpio_O[15]	= wVIDEO_G[2];		assign  wGpioIn[15]	= ioGpio_I[15];		assign ioGpio_OE[15]	= 1'b1;
assign ioGpio_O[16]	= wVIDEO_G[1];		assign  wGpioIn[16]	= ioGpio_I[16];		assign ioGpio_OE[16]	= 1'b1;
assign ioGpio_O[17]	= wVIDEO_G[0];		assign  wGpioIn[17]	= ioGpio_I[17];		assign ioGpio_OE[17]	= 1'b1;
assign ioGpio_O[18]	= 1'b0;/*wI2sMclk;*/assign  wGpioIn[18]	= ioGpio_I[18];		assign ioGpio_OE[18]	= 1'b0;
assign ioGpio_O[19]	= wI2sBclk;			assign  wGpioIn[19]	= ioGpio_I[19];		assign ioGpio_OE[19]	= 1'b1;
assign ioGpio_O[20]	= wI2sSdata;		assign  wGpioIn[20]	= ioGpio_I[20];		assign ioGpio_OE[20]	= 1'b1;
assign ioGpio_O[21]	= wI2sLrclk;		assign  wGpioIn[21]	= ioGpio_I[21];		assign ioGpio_OE[21]	= 1'b1;
assign ioGpio_O[22]	= wVIDEO_R[6];		assign  wGpioIn[22]	= ioGpio_I[22];		assign ioGpio_OE[22]	= 1'b1;
assign ioGpio_O[23]	= wVIDEO_R[7];		assign  wGpioIn[23]	= ioGpio_I[23];		assign ioGpio_OE[23]	= 1'b1;
assign ioGpio_O[24]	= wVIDEO_DE;		assign  wGpioIn[24]	= ioGpio_I[24];		assign ioGpio_OE[24]	= 1'b1;
assign ioGpio_O[25]	= wVIDEO_VS;		assign  wGpioIn[25]	= ioGpio_I[25];		assign ioGpio_OE[25]	= 1'b1;
assign ioGpio_O[26]	= wVIDEO_HS;		assign  wGpioIn[26]	= ioGpio_I[26];		assign ioGpio_OE[26]	= 1'b1;
assign ioGpio_O[27]	= 1'b0;				assign  wGpioIn[27]	= ioGpio_I[27];		assign ioGpio_OE[27]	= 1'b0;
assign ioGpio_O[28]	= wVIDEO_R[0];		assign  wGpioIn[28]	= ioGpio_I[28];		assign ioGpio_OE[28]	= 1'b1;
assign ioGpio_O[29]	= wVIDEO_R[2];		assign  wGpioIn[29]	= ioGpio_I[29];		assign ioGpio_OE[29]	= 1'b1;
assign ioGpio_O[30]	= 1'b0;				assign  wGpioIn[30]	= ioGpio_I[30];		assign ioGpio_OE[30]	= 1'b0;
assign ioGpio_O[31]	= 1'b0;				assign  wGpioIn[31]	= ioGpio_I[31];		assign ioGpio_OE[31]	= 1'b0;
assign ioGpio_O[32]	= 1'b0;				assign  wGpioIn[32]	= ioGpio_I[32];		assign ioGpio_OE[32]	= 1'b0;
assign ioGpio_O[33]	= 1'b0;				assign  wGpioIn[33]	= ioGpio_I[33];		assign ioGpio_OE[33]	= 1'b0;
assign ioGpio_O[34]	= wVIDEO_R[3];		assign  wGpioIn[34]	= ioGpio_I[34];		assign ioGpio_OE[34]	= 1'b1;
assign ioGpio_O[35]	= wVIDEO_R[4];		assign  wGpioIn[35]	= ioGpio_I[35];		assign ioGpio_OE[35]	= 1'b1;
assign ioGpio_O[36]	= wVIDEO_R[5];		assign  wGpioIn[36]	= ioGpio_I[36];		assign ioGpio_OE[36]	= 1'b1;
assign ioGpio_O[37]	= wVIDEO_R[1];		assign  wGpioIn[37]	= ioGpio_I[37];		assign ioGpio_OE[37]	= 1'b1;
//
// External ROM / QSPI は後々対応
wire [7:0] wSpiRomDqNot;
assign ioSpiRomDq_O[0]	= wSfmMosi[0];		assign wSpiRomDqNot[0]	= ioSpiRomDq_I[0];	assign ioSpiRomDq_OE[0]	= 1'b1;
assign ioSpiRomDq_O[1]	= 1'b0;				assign wSfmMiso[0]		= ioSpiRomDq_I[1];	assign ioSpiRomDq_OE[1]	= 1'b0;
assign ioSpiRomDq_O[2]	= 1'b0;				assign wSpiRomDqNot[2]	= ioSpiRomDq_I[2];	assign ioSpiRomDq_OE[2]	= 1'b0;
assign ioSpiRomDq_O[3]	= 1'b0;				assign wSpiRomDqNot[3]	= ioSpiRomDq_I[3];	assign ioSpiRomDq_OE[3]	= 1'b0;
assign ioSpiRomDq_O[4]	= wSfmMosi[1];		assign wSpiRomDqNot[4]	= ioSpiRomDq_I[4];	assign ioSpiRomDq_OE[4]	= 1'b1;
assign ioSpiRomDq_O[5]	= 1'b0;				assign wSfmMiso[1]		= ioSpiRomDq_I[5];	assign ioSpiRomDq_OE[5]	= 1'b0;
assign ioSpiRomDq_O[6]	= 1'b0;				assign wSpiRomDqNot[6]	= ioSpiRomDq_I[6];	assign ioSpiRomDq_OE[6]	= 1'b0;
assign ioSpiRomDq_O[7]	= 1'b0;				assign wSpiRomDqNot[7]	= ioSpiRomDq_I[7];	assign ioSpiRomDq_OE[7]	= 1'b0;
assign oSpiRomClk[0]	= wSfmSck[0];
assign oSpiRomClk[1]	= wSfmSck[1];
assign oSpiRomCe[0]		= wSfmCs[0];
assign oSpiRomCe[1]		= wSfmCs[1];
//
// External RAM
assign ioRamDq_O[7:0] 	= wRamDq_O[7:0];	assign wRamDq_I[7:0] 	= ioRamDq_I[7:0];		assign ioRamDq_OE[7:0] 		= {8{wRamDq_Oe[0]}};
assign ioRamDq_O[15:8]	= wRamDq_O[15:8];	assign wRamDq_I[15:8] 	= ioRamDq_I[15:8];		assign ioRamDq_OE[15:8] 	= {8{wRamDq_Oe[1]}};
assign oRamClk[0]		= wRamClk[0];
assign oRamClk[1]		= wRamClk[1];
assign oRamCe[0]		= wRamCe[0];
assign oRamCe[1]		= wRamCe[1];
//
// I2C I/F
assign ioI2cScl_O	= woI2cScl;				assign wiI2cScl	= ioI2cScl_I;		assign ioI2cScl_OE = woI2cSclOe;
assign ioI2cSda_O	= woI2cSda;				assign wiI2cSda	= ioI2cSda_I;		assign ioI2cSda_OE = woI2cSdaOe;
//
// Uart I/F
// assign oUsbTx = wMIDI_In;//iUsbRx;
assign oUsbTx = wSocTxd;
//
// User I/F
assign wPushSw[0]	= iPushSw[0];	// SW-L
assign wPushSw[1]	= iPushSw[1];	// SW-U
assign wPushSw[2]	= iPushSw[2];	// SW-D
assign wPushSw[3]	= iPushSw[3];	// SW-R
assign wPushSw[4]	= iPushSw[4];	// SW-B
assign wPushSw[5]	= iPushSw[5];	// SW-A
assign wPushSw[6]	= iPushSw[6];	// SW-User
assign wDipSw[0]	= iDipSw[0];	// DIP-1
assign wDipSw[1]	= iDipSw[1];	// DIP-2
assign oLed[0]		= wGpio_O[0];
assign oLed[1]		= wGpio_O[1];
assign oLed[2]		= wGpio_O[2];
assign oLed[3]		= wGpio_O[3];

//-----------------------------------------------------------------------------
// LED User Debug Mode (Altenate mode)
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
  qGpioAltMode[0] <= &{iPushSw[5:0]};
  qGpioAltMode[1] <= wPulseVCLK;
  qGpioAltMode[2] <= woI2cSclOe;
  qGpioAltMode[3] <= woI2cSdaOe;
end


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