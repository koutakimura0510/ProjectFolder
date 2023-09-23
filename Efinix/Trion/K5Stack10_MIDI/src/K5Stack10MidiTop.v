/*-----------------------------------------------------------------------------
 * Create  2023/4/4
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * Device  K5Stack10 Main Board
 * -
 * 23-04-04 V1.00: new release
 * 23-09-02 V1.01: SynthesizerBlock から AudioTxBlock へ変更
 * 23-09-17 V2.00: K5Stack10-v2 に更新のためピンアサイン変更
 *-----------------------------------------------------------------------------*/  
module K5Stack10MidiTop(
	// GPIOL
	input   [16:0] ioGPIOL_I,
	output  [16:0] ioGPIOL_O,
	output  [16:0] ioGPIOL_OE,
	// GPIOR
	input   [20:0] ioGPIOR_I,
	output  [20:0] ioGPIOR_O,
	output  [20:0] ioGPIOR_OE,
	// GPIOB
	input   [23:0] ioGPIOB_I,
	output  [23:0] ioGPIOB_O,
	output  [23:0] ioGPIOB_OE,
	// SRAM
	input	[7:0] ioSRAMD_I,
	output	[7:0] ioSRAMD_O,
	output	[7:0] ioSRAMD_OE,
	output	oSRAM_RWDS,
	output	oSRAM_pCLK,
	output	oSRAM_nCLK,
	output	oSRAM_nCE,
	output	oSRAM_nRST,
	// USB UART
	input	iUSB_RX,
	output	oUSB_TX,
	// External OSC
	input	iOSC_IN,
	// PLL BR0
	input	iMCLK,
	output	PLL_BR0_RSTN,
	input	PLL_BR0_LOCKED,
	// PLL TL0
	input	iSCLK,
	input	iVCLK,
	output	PLL_TL0_RSTN,
	input	PLL_TL0_LOCKED,
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
  qlocked <= &{PLL_BR0_LOCKED, PLL_TL0_LOCKED};
  qnARST  <= wnARST & qlocked;
end

assign wSRST    = rSRST;			assign wnSRST   = rnSRST;
assign wMRST    = rMRST;			assign wnMRST   = rnMRST;
assign wVRST    = rVRST;			assign wnVRST   = rnVRST;
assign PLL_BR0_RSTN = 1'b1;
assign PLL_TL0_RSTN = 1'b1;

//-----------------------------------------------------------------------------
// Game Mode / Update Mode 
//-----------------------------------------------------------------------------
localparam lpSmsTime = 100000000;

reg  qSmsRst;
reg  rSmsMode = 1'b0;		// Init Game Mode
wire wSmsCke;

CkeGenerator #(
	.pSysClk(lpSmsTime)
) SystemModeSelect (
	.iDiv(),	.iCke(),	.oCke(wSmsCke),
	// coommon
	.iRST(qSmsRst),			.iCLK(iSCLK)
);

always @(posedge iSCLK)
begin
	if (wSmsCke)		rSmsMode <= ~rSmsMode;
	else 				rSmsMode <=  rSmsMode;
end

always @*
begin
	qSmsRst <= wnSRST;	// SW Push 時に mode 遷移を行う
end


//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth      = 32;		// USIB Width
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
  lpVtbCsrActiveWidth	= 16,
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
localparam  lpRamAdrsWidth    		= 18;
localparam  lpRamDqWidth      		= 16;
localparam  lpUfiDqBusWidth   		= lpRamDqWidth;
localparam  lpUfiAdrsBusWidth 		= 32;
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
localparam lpOnChipMcu = "no";

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
	.oMUsiWd(wMUsiWdMcb),  .oMUsiAdrs(wMUsiAdrsMcb),
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.iMUfiRd(wMUfiRd),    .iMUfiAdrs(wMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(wMUfiWd[lpUfiMcbAdrsMap]),
	.oMUfiAdrs(wMUfiWAdrs[lpUfiMcbAdrsMap]),
	.iMUfiRdy(wMUfiRdy[lpUfiMcbAdrsMap]),
	// GPIO
	.oTxd(wSocTxd),       .iRxd(wSocRxd),
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
	.iSRST(wSRST),      .inSRST(rnSRST),
	.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// GPIO Block
//-----------------------------------------------------------------------------
localparam lpGpioWidth = 6;
wire [lpGpioWidth-1:0] wGPIOR_O;
wire [lpGpioWidth-1:0] wGPIOR_Dir;
wire [lpGpioWidth-1:0] wGPIOR_In;
reg  [lpGpioWidth-1:0] qGpioAltMode;

GpioBlock #(
  .pBlockAdrsWidth(lpBlockAdrsWidth),
  .pAdrsMap(lpGpioAdrsMap),
  .pUsiBusWidth(lpUsiBusWidth),
  .pCsrAdrsWidth(lpCsrAdrsWidth),
  .pCsrActiveWidth(lpGpioCsrActiveWidth),
  .pGpioWidth(lpGpioWidth)
) GpioBlock (
  // GPIO Output Ctrl
  .oGpioR(wGPIOR_O),
  .oGpioDir(wGPIOR_Dir),
  // GPIO Alt Mode
  .iGpioAltMode(qGpioAltMode),
  // GPIO Input
  .iGpioIn(wGPIOR_In),
  // Control
  .iSmsMode(rSmsMode),
  // Bus Master Read
  .oSUsiRd(wSUsiRd[lpGpioAdrsMap]),
  // Bus Master Write
  .iSUsiWd(wSUsiWd),  .iSUsiAdrs(wSUsiAdrs),
  // CLK, RST
  .iSRST(wSRST),    .iSCLK(iSCLK)
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
  .pBlockAdrsWidth(lpBlockAdrsWidth),	.pAdrsMap(lpSPIAdrsMap),
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
localparam lpSfcNum = 3;

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
	.oI2sMclk(wI2sMclk),	.oI2sBclk(wI2sBclk),
	.oI2sLrclk(wI2sLrclk),	.oI2sSdata(wI2sSdata),
	// Serial Frash Memory I/F Port
	.oSfmSck(wSfmSck),		.oSfmMosi(wSfmMosi),
	.iSfmMiso(wSfmMiso),	.oSfmCs(wSfmCs),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpAtbAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iMRST(wMRST),			.iMCLK(iMCLK),
	.iSRST(wSRST),			.inSRST(wnSRST),
	.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Memory Block
//-----------------------------------------------------------------------------
wire [lpRamAdrsWidth-1:0] wSRAMA;
wire [lpRamDqWidth-1:0]  wSRAMD_O;
wire [lpRamDqWidth-1:0]  wSRAMD_I;
wire wSRAM_LB;
wire wSRAM_UB;
wire wSRAM_OE;
wire wSRAM_WE;
wire wSRAM_CE;
wire wTestErr, wDone;

RAMBlock #(
  .pBlockAdrsWidth(lpBlockAdrsWidth),    .pAdrsMap(lpRAMAdrsMap),
  .pUsiBusWidth(lpUsiBusWidth),
  .pCsrAdrsWidth(lpCsrAdrsWidth),      .pCsrActiveWidth(lpRAMCsrActiveWidth),
  .pUfiDqBusWidth(lpUfiDqBusWidth),    .pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
  .pRamAdrsWidth(lpRamAdrsWidth),      .pRamDqWidth(lpRamDqWidth)
) RAMBlock (
  // SRAM I/F Port
  .oSRAMA(wSRAMA),		.oSRAMD(wSRAMD_O),
  .iSRAMD(wSRAMD_I),
  .oSRAM_LB(wSRAM_LB),  .oSRAM_UB(wSRAM_UB),
  .oSRAM_OE(wSRAM_OE),  .oSRAM_WE(wSRAM_WE),
  .oSRAM_CE(wSRAM_CE),
  // Usi Bus Master Read
  .oSUsiRd(wSUsiRd[lpRAMAdrsMap]),
  // Usi Bus Master Write
  .iSUsiWd(wSUsiWd),    .iSUsiAdrs(wSUsiAdrs),
  // Ufi Bus Master Read
  .oSUfiRd(wSUfiRd),    .oSUfiAdrs(wSUfiAdrs),
  // Ufi Bus Master Write
  .iSUfiWd(wSUfiWd),    .iSUfiAdrs(wSUfiWAdrs),
  .oSUfiRdy(wSUfiRdy),
  // Status
  .oTestErr(wTestErr),  .oDone(wDone),
  // CLK, RST
  .iSRST(wSRST),      .inSRST(wnSRST),
  .iSCLK(iSCLK)
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
wire [7:3] 	wVIDEO_R;
wire [7:2] 	wVIDEO_G;
wire [7:3] 	wVIDEO_B;
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
	.pDmaAdrsWidth(lpRamAdrsWidth),			.pDmaBurstLength(lpVtbDmaBurstLength)
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
	.iVRST(wVRST),		.inVRST(wnVRST),
	.iVCLK(iVCLK),
	.iSRST(wSRST),		.inSRST(wnSRST),
	.iSCLK(iSCLK)
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
// GPIOL
wire [16:0] wIunsedL;
wire [20:0] wIunsedR;
assign ioGPIOL_O[0]		= wFlashRomSck;		assign  wIunsedL[0]  	= ioGPIOL_I[0];		assign ioGPIOL_OE[0]  = wFlashSpiOe[0];		// No1.Flash Rom SCK
assign ioGPIOL_O[1]		= wFlashRomMosi;	assign  wIunsedL[1]  	= ioGPIOL_I[1];		assign ioGPIOL_OE[1]  = wFlashSpiOe[0];		// No1.Flash Rom DO / IO0
assign ioGPIOL_O[2]		= 1'b0;				assign  wFlashRomMiso	= ioGPIOL_I[2];		assign ioGPIOL_OE[2]  = wFlashSpiOe[1];		// No1.Flash Rom DI / IO1
assign ioGPIOL_O[3]		= wFlashRomCs;		assign  wIunsedL[3]		= ioGPIOL_I[3];		assign ioGPIOL_OE[3]  = wFlashSpiOe[0];		// No1.Flash Rom CS
assign ioGPIOL_O[4]		= 1'b0;				assign  wIunsedL[4]		= ioGPIOL_I[4];		assign ioGPIOL_OE[4]  = 1'b0;				// No1.Flash Rom HOLD / IO2
assign ioGPIOL_O[5]		= 1'b0;				assign  wIunsedL[5]		= ioGPIOL_I[5];		assign ioGPIOL_OE[5]  = 1'b0;				// No1.Flash Rom WP / IO3
assign ioGPIOL_O[6]		= 1'b0;				assign  wIunsedL[6]		= ioGPIOL_I[6];		assign ioGPIOL_OE[6]  = 1'b0;				// No2.Flash Rom HOLD / IO2
assign ioGPIOL_O[7]		= wSfmMosi[0];		assign  wIunsedL[7]		= ioGPIOL_I[7];		assign ioGPIOL_OE[7]  = 1'b0;				// No2.Flash Rom DO / IO0
assign ioGPIOL_O[8]		= 1'b0;				assign  wIunsedL[8]		= ioGPIOL_I[8];		assign ioGPIOL_OE[8]  = 1'b0;				// No2.Flash Rom WP / IO3
assign ioGPIOL_O[9]		= wSfmSck[0];		assign  wIunsedL[9]		= ioGPIOL_I[9];		assign ioGPIOL_OE[9]  = 1'b1;				// No2.Flash Rom SCK
assign ioGPIOL_O[10]	= 1'b0;				assign  wSfmMiso[0]		= ioGPIOL_I[10];	assign ioGPIOL_OE[10] = 1'b1;				// No2.Flash Rom DI / IO1
assign ioGPIOL_O[11]	= wSfmCs[0];		assign  wIunsedL[11]	= ioGPIOL_I[11];	assign ioGPIOL_OE[11] = 1'b1;				// No2.Flash Rom CS
assign ioGPIOL_O[12]	= wSfmMosi[1];		assign  wIunsedL[12]	= ioGPIOL_I[12];	assign ioGPIOL_OE[12] = 1'b0;				// No3.Flash Rom DO / IO0
assign ioGPIOL_O[13]	= wSfmSck[1];		assign  wIunsedL[13]	= ioGPIOL_I[13];	assign ioGPIOL_OE[13] = 1'b0;				// No3.Flash Rom SCK
assign ioGPIOL_O[14]	= 1'b0;				assign  wSfmMiso[1]		= ioGPIOL_I[14];	assign ioGPIOL_OE[14] = 1'b0;				// No3.Flash Rom DI / IO1
assign ioGPIOL_O[15]	= wSfmCs[1];		assign  wIunsedL[15]	= ioGPIOL_I[15];	assign ioGPIOL_OE[15] = 1'b0;				// No3.Flash Rom CS
assign ioGPIOL_O[16]	= wSfmMosi[2];		assign  wIunsedL[16]	= ioGPIOL_I[16];	assign ioGPIOL_OE[16] = 1'b0;				// No4.Flash Rom DO / IO0
// GPIOR
assign ioGPIOR_O[0]		= wGPIOR_O[2];		assign  wGPIOR_In[2]	= ioGPIOR_I[0];		assign ioGPIOR_OE[0]  = |{rSmsMode,wGPIOR_Dir[2]};	// LED3
assign ioGPIOR_O[1]		= wGPIOR_O[1];		assign  wGPIOR_In[1]	= ioGPIOR_I[1];		assign ioGPIOR_OE[1]  = |{rSmsMode,wGPIOR_Dir[1]};	// LED2
assign ioGPIOR_O[2]		= wGPIOR_O[0];		assign  wGPIOR_In[0]	= ioGPIOR_I[2];		assign ioGPIOR_OE[2]  = |{rSmsMode,wGPIOR_Dir[0]};	// LED1
assign ioGPIOR_O[3]		= 1'b0;				assign  wnARST			= ioGPIOR_I[3];		assign ioGPIOR_OE[3]  = 1'b0;			// User SW
assign ioGPIOR_O[4]		= wGPIOR_O[3];		assign  wGPIOR_In[3]	= ioGPIOR_I[4];		assign ioGPIOR_OE[4]  = |{rSmsMode,wGPIOR_Dir[3]};	// LED4
assign ioGPIOR_O[5]		= 1'b0;				assign  wIunsedR[4]		= ioGPIOR_I[5];		assign ioGPIOR_OE[5]  = 1'b0;			// MIDI IN
assign ioGPIOR_O[6]		= 1'b0;				assign  wIunsedR[6]		= ioGPIOR_I[6];		assign ioGPIOR_OE[6]  = 1'b0;			// Unused
assign ioGPIOR_O[7]		= 1'b0;				assign  wIunsedR[7]		= ioGPIOR_I[7];		assign ioGPIOR_OE[7]  = 1'b0;			// Unused
assign ioGPIOR_O[8]		= 1'b0;				assign  wIunsedR[8]		= ioGPIOR_I[8];		assign ioGPIOR_OE[8]  = 1'b0;			// Unused
assign ioGPIOR_O[9]		= wVIDEO_R[3];		assign  wIunsedR[9]		= ioGPIOR_I[9];		assign ioGPIOR_OE[9]  = 1'b1;			// Video R3
assign ioGPIOR_O[10]	= 1'b0;				assign  wIunsedR[10]	= ioGPIOR_I[10];	assign ioGPIOR_OE[10] = 1'b0;			// MCP2221A SCL
assign ioGPIOR_O[11]	= wVIDEO_R[4];		assign  wIunsedR[11]	= ioGPIOR_I[11];	assign ioGPIOR_OE[11] = 1'b1;			// Video R4
assign ioGPIOR_O[12]	= 1'b0;				assign  wIunsedR[12]	= ioGPIOR_I[12];	assign ioGPIOR_OE[12] = 1'b0;			// MCP2221A SDA
assign ioGPIOR_O[13]	= wVIDEO_R[5];		assign  wIunsedR[13]	= ioGPIOR_I[13];	assign ioGPIOR_OE[13] = 1'b1;			// Video R5
assign ioGPIOR_O[14]	= 1'b0;				assign  wIunsedR[14]	= ioGPIOR_I[14];	assign ioGPIOR_OE[14] = 1'b0;			// No4.Flash Rom HOLD / IO2
assign ioGPIOR_O[15]	= wSfmCs[2];		assign  wIunsedR[15]	= ioGPIOR_I[15];	assign ioGPIOR_OE[15] = 1'b0;			// No4.Flash Rom CS
assign ioGPIOR_O[16]	= wSfmSck[2];		assign  wIunsedR[16]	= ioGPIOR_I[16];	assign ioGPIOR_OE[16] = 1'b0;			// No4.Flash Rom SCK
assign ioGPIOR_O[17]	= wGPIOR_O[4];		assign  wGPIOR_In[4]	= ioGPIOR_I[17];	assign ioGPIOR_OE[17] = |{rSmsMode,wGPIOR_Dir[4]};	// LED5
assign ioGPIOR_O[18]	= 1'b0;				assign  wSfmMiso[2]		= ioGPIOR_I[18];	assign ioGPIOR_OE[18] = 1'b0;			// No4.Flash Rom DI / IO1
assign ioGPIOR_O[19]	= wGPIOR_O[5];		assign  wGPIOR_In[5]	= ioGPIOR_I[19];	assign ioGPIOR_OE[19] = |{rSmsMode,wGPIOR_Dir[5]};	// LED6
assign ioGPIOR_O[20]	= 1'b0;				assign  wIunsedR[20]	= ioGPIOR_I[20];	assign ioGPIOR_OE[20] = 1'b0;			// No4.Flash Rom WP / IO3
// GPIOB
wire [23:0] wIunsedB;
assign ioGPIOB_O[0]		= wVIDEO_VS;		assign wIunsedB[0]	= ioGPIOB_I[0];   assign ioGPIOB_OE[0]  = 1'b1;		// Video VS
assign ioGPIOB_O[1]		= wVIDEO_DE;		assign wIunsedB[1]	= ioGPIOB_I[1];   assign ioGPIOB_OE[1]  = 1'b1;		// Video DE
assign ioGPIOB_O[2]		= wVIDEO_RST;		assign wIunsedB[2]	= ioGPIOB_I[2];   assign ioGPIOB_OE[2]  = 1'b1;		// Video RST
assign ioGPIOB_O[3]		= wVIDEO_HS;		assign wIunsedB[3]	= ioGPIOB_I[3];   assign ioGPIOB_OE[3]  = 1'b1;		// Video HS
assign ioGPIOB_O[4]		= wVIDEO_B[7];		assign wIunsedB[4]	= ioGPIOB_I[4];   assign ioGPIOB_OE[4]  = 1'b1;		// Video B7
assign ioGPIOB_O[5]		= wVIDEO_DCK;		assign wIunsedB[5]	= ioGPIOB_I[5];   assign ioGPIOB_OE[5]  = 1'b1;		// Video DCK
assign ioGPIOB_O[6]		= wVIDEO_B[6];		assign wIunsedB[6]	= ioGPIOB_I[6];   assign ioGPIOB_OE[6]  = 1'b1;		// Video B6
assign ioGPIOB_O[7]		= wVIDEO_B[5];		assign wIunsedB[7]	= ioGPIOB_I[7];   assign ioGPIOB_OE[7]  = 1'b1;		// Video B5
assign ioGPIOB_O[8]		= wVIDEO_B[4];		assign wIunsedB[8]	= ioGPIOB_I[8];   assign ioGPIOB_OE[8]  = 1'b1;		// Video B4
assign ioGPIOB_O[9]		= wVIDEO_B[3];		assign wIunsedB[9]	= ioGPIOB_I[9];   assign ioGPIOB_OE[9]  = 1'b1;		// Video B3
assign ioGPIOB_O[10]	= wVIDEO_G[7];		assign wIunsedB[10]	= ioGPIOB_I[10];  assign ioGPIOB_OE[10] = 1'b1;		// Video G7
assign ioGPIOB_O[11]	= wVIDEO_G[6];		assign wIunsedB[11]	= ioGPIOB_I[11];  assign ioGPIOB_OE[11] = 1'b1;		// Video G6
assign ioGPIOB_O[12]	= wVIDEO_G[5];		assign wIunsedB[12]	= ioGPIOB_I[12];  assign ioGPIOB_OE[12] = 1'b1;		// Video G5
// assign ioGPIOB_O[13] = wSlaveMiso;    assign wMasterMiso   = ioGPIOB_I[13];  assign ioGPIOB_OE[13] = wnSpiDir;
// assign ioGPIOB_O[14] = wMasterSck;    assign wSlaveSck     = ioGPIOB_I[14];  assign ioGPIOB_OE[14] = wSpiDir;
// assign ioGPIOB_O[15] = wMasterMosi;   assign wSlaveMosi    = ioGPIOB_I[15];  assign ioGPIOB_OE[15] = wSpiDir;
// assign ioGPIOB_O[16] = wMasterCs;     assign wSlaveCs      = ioGPIOB_I[16];  assign ioGPIOB_OE[16] = wSpiDir;
assign ioGPIOB_O[13]	= wVIDEO_G[4];		assign wIunsedB[13]	= ioGPIOB_I[13];  assign ioGPIOB_OE[13] = 1'b1;		// Video G4
assign ioGPIOB_O[14]	= wVIDEO_G[3];		assign wIunsedB[14]	= ioGPIOB_I[14];  assign ioGPIOB_OE[14] = 1'b1;		// Video G3
assign ioGPIOB_O[15]	= wVIDEO_G[2];		assign wIunsedB[15]	= ioGPIOB_I[15];  assign ioGPIOB_OE[15] = 1'b1;		// Video G2
assign ioGPIOB_O[16]	= wVIDEO_R[7];		assign wIunsedB[16]	= ioGPIOB_I[16];  assign ioGPIOB_OE[16] = 1'b1;		// Video R7
assign ioGPIOB_O[17]	= wVIDEO_R[6];		assign wIunsedB[17]	= ioGPIOB_I[17];  assign ioGPIOB_OE[17] = 1'b1;		// Video R6
assign ioGPIOB_O[18]	= wI2sMclk;			assign wIunsedB[18]	= ioGPIOB_I[18];  assign ioGPIOB_OE[18] = 1'b1; 	// I2S MCLK
assign ioGPIOB_O[19]	= wI2sBclk;			assign wIunsedB[19]	= ioGPIOB_I[19];  assign ioGPIOB_OE[19] = 1'b1; 	// I2S BCLK
assign ioGPIOB_O[20]	= wI2sSdata;		assign wIunsedB[20]	= ioGPIOB_I[20];  assign ioGPIOB_OE[20] = 1'b1; 	// I2S SDATA
assign ioGPIOB_O[21]	= wI2sLrclk;		assign wIunsedB[21]	= ioGPIOB_I[21];  assign ioGPIOB_OE[21] = 1'b1; 	// I2S LRCLK
assign ioGPIOB_O[22]	= 1'b0;				assign wIunsedB[22]	= ioGPIOB_I[22];  assign ioGPIOB_OE[22] = 1'b0;		// I2C Controller
assign ioGPIOB_O[23]	= 1'b0;				assign wIunsedB[23]	= ioGPIOB_I[23];  assign ioGPIOB_OE[23] = 1'b0;		// I2C Controller
// SRAM
assign ioSRAMD_O 	= wSRAMD_O;				assign wSRAMD_I = ioSRAMD_I;    assign ioSRAMD_OE = {lpRamDqWidth{wSRAM_OE}};
assign oSRAMA		= wSRAMA;
assign oSRAM_LB		= wSRAM_LB;
assign oSRAM_UB		= wSRAM_UB;
assign oSRAM_OE		= wSRAM_OE;
assign oSRAM_WE		= wSRAM_WE;
assign oSRAM_CE		= wSRAM_CE;
// USB UART
// assign oUSB_TX = wMIDI_In;//iUSB_RX;
assign oUSB_TX = wSocTxd;

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
  qGpioAltMode[0] <= rSmsMode ? wPulseSCLK 	: qlocked;
  qGpioAltMode[1] <= &{~rSmsMode,wTestErr};
  qGpioAltMode[2] <= 1'b0;
  qGpioAltMode[3] <= &{~rSmsMode,wPulseSCLK};
  qGpioAltMode[4] <= &{~rSmsMode,wPulseMCLK};
  qGpioAltMode[5] <= &{~rSmsMode,wPulseVCLK};
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