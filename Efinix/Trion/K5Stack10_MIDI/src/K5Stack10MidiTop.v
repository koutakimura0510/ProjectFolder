/*-----------------------------------------------------------------------------
 * Create  2023/4/4
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * Device  K5Stack10 Main Board
 * -
 * V1.0：new release
 * 
 *-----------------------------------------------------------------------------*/  
module K5Stack10MidiTop(
  // GPIOL
  input   [ 5:0] ioGPIOL_I,
  output  [ 5:0] ioGPIOL_O,
  output  [ 5:0] ioGPIOL_OE,
  // GPIOR
  input   [17:0] ioGPIOR_I,
  output  [17:0] ioGPIOR_O,
  output  [17:0] ioGPIOR_OE,
  // GPIOB
  input   [23:0] ioGPIOB_I,
  output  [23:0] ioGPIOB_O,
  output  [23:0] ioGPIOB_OE,
  //
  // External IO
  input   ioCSI_I,
  output  ioCSI_O,
  output  ioCSI_OE,
  //
  // SRAM
  input   [15:0] ioSRAMD_I,
  output  [15:0] ioSRAMD_O,
  output  [15:0] ioSRAMD_OE,
  output  [17:0] oSRAMA,
  output   oSRAM_CE,
  output   oSRAM_LB,
  output   oSRAM_OE,
  output   oSRAM_UB,
  output   oSRAM_WE,
  //
  // USB UART
  input   iUSB_RX,
  output  oUSB_TX,
  //
  // Flash ROM SPI
  input   ioMOSI_I,
  output  ioMOSI_O,
  output  ioMOSI_OE,
  input   ioMISO_I,
  output  ioMISO_O,
  output  ioMISO_OE,
  input   ioCCK_I,
  output  ioCCK_O,
  output  ioCCK_OE,
  input   ioSSN_I,
  output  ioSSN_O,
  output  ioSSN_OE,
  //
  // External OSC
  input   iOSC_IN,
  //
  // PLL BR0
  input   iMCLK,
  output  PLL_BR0_RSTN,
  input   PLL_BR0_LOCKED,
  //
  // PLL TL0
  input   iSCLK,
  output  PLL_TL0_RSTN,
  input   PLL_TL0_LOCKED,
  // JTAG Soc
  input   jtag_inst1_TCK,
  output  jtag_inst1_TDO,
  input   jtag_inst1_TDI,
  input   jtag_inst1_TMS,
  input   jtag_inst1_RUNTEST,
  input   jtag_inst1_SEL,
  input   jtag_inst1_CAPTURE,
  input   jtag_inst1_SHIFT,
  input   jtag_inst1_UPDATE,
  input   jtag_inst1_RESET
);


//-----------------------------------------------------------------------------
// System Reset Gen
//-----------------------------------------------------------------------------
genvar x;  // Top内で共通変数として使用する
reg rSRST, rnSRST;
reg rMRST, rnMRST;
wire wSRST, wnSRST;
wire wMRST, wnMRST;
wire wnARST;
reg  qnARST;
reg  qlocked;

always @(posedge iMCLK, negedge qnARST)
begin
  if (!qnARST)  rnMRST <= 1'b0;
  else          rnMRST <= 1'b1;

  if (!qnARST)  rMRST <= 1'b1;
  else          rMRST <= 1'b0;
end

always @(posedge iSCLK, negedge qnARST)
begin
  if (!qnARST)  rnSRST <= 1'b0;
  else          rnSRST <= 1'b1;
  
  if (!qnARST)  rSRST <= 1'b1;
  else          rSRST <= 1'b0;
end

always @*
begin
  qlocked <= &{PLL_BR0_LOCKED, PLL_TL0_LOCKED};
  qnARST  <= wnARST & qlocked;
end

assign wSRST    = rSRST;
assign wnSRST   = rnSRST;
assign wMRST    = rMRST;
assign wnMRST   = rnMRST;
assign PLL_BR0_RSTN = 1'b1;
assign PLL_TL0_RSTN = 1'b1;


//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth      = 32;		// USIB Width
localparam lpBlockConnectNum  = 6;		// 現在接続しているブロックの個数
localparam lpBlockAdrsWidth   = f_detect_bitwidth(lpBlockConnectNum);
localparam lpCsrAdrsWidth     = 16;		// 各ブロック共通の基本CSR幅
localparam lpSUsiBusWidth     = (lpUsiBusWidth * lpBlockConnectNum);
localparam [lpBlockAdrsWidth-1:0]		// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
  lpGpioAdrsMap         = 'h0,
  lpSPIAdrsMap          = 'h1,
  lpSynthesizerAdrsMap  = 'h2,
  lpRAMAdrsMap          = 'h3,
  lpSysTimerAdrsMap     = 'h4,
  lpMCBAdrsMap		    = 'h5,
  lpNullAdrsMap         = 0;

// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが難しいと感じたため用意した。
localparam 
  lpGpioCsrActiveWidth  = 8,
  lpSPICsrActiveWidth   = 8,
  lpSynCsrActiveWidth   = 8,
  lpRAMCsrActiveWidth   = 8,
  lpTimerCsrActiveWidth = 8,
  lpMCBCsrActiveWidth	= 8,
  lpNullActiveWidth     = 8;  // 使用しない、ソースの追加がやりやすいように
  // lpI2CCsrActiveWidth  = 8,
  // lpVTBCsrActiveWidth  = 16,
  // lpATBCsrActiveWidth  = 8,
  // lpRAMCsrActiveWidth  = 8;

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
localparam  lpUfiBlockConnectNum 	= 1;
localparam 	lpUfiBlockAdrsWidth		= f_detect_bitwidth(lpUfiBlockConnectNum);
localparam	lpMUfiDqWidth 			= lpUfiDqBusWidth   * lpUfiBlockConnectNum;
localparam	lpMUfiAdrsWidth			= lpUfiAdrsBusWidth * lpUfiBlockConnectNum;

// initial begin
// 	$display("%d", lpUfiBlockAdrsWidth);
// end
//
localparam [lpUfiBlockAdrsWidth-1:0]	// UFI ブロックアドレスマッピング
	lpUfiMcbAdrsMap		= 'h0,
	lpUfiVtbAdrsMap		= 'h1,
	lpUfiSynAdrsMap		= 'h2,
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
// MCB ここRISC-V に変更。別プロジェクトでデバッグ中
//-----------------------------------------------------------------------------
wire wSocTxd, wSocRxd;

MicroControllerBlock #(
  .pBlockAdrsWidth(lpBlockAdrsWidth),
  .pAdrsMap(lpMCBAdrsMap),
  .pCsrAdrsWidth(lpCsrAdrsWidth),
  .pCsrActiveWidth(lpMCBCsrActiveWidth),
  .pUsiBusWidth(lpUsiBusWidth),
  .pUfiDqBusWidth(lpUfiDqBusWidth),
  .pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
  .pUfiAdrsMap(lpUfiMcbAdrsMap)
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
localparam lpGpioWidth = 3;
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
  // External Port
  // SPI Bus Connected External CPU
  .iSpiSck(wSlaveSck),		.iSpiMosi(wSlaveMosi),
  .oSpiMiso(wSlaveMiso),	.iSpiCs(wSlaveCs),
  .oSpiSck(wMasterSck),  	.oSpiMosi(wMasterMosi),
  .iSpiMiso(wMasterMiso),  	.oSpiCs(wMasterCs),
  .iSpiDir(wIoSpiDir),
  // SPI Bus Connected External Flash Rom
  .oFlashRomSck(wFlashRomSck),
  .oFlashRomMosi(wFlashRomMosi),
  .iFlashRomMiso(wFlashRomMiso),
  .oFlashRomCs(wFlashRomCs),
  // Flash Rom Dir
  .oFlashSpiOe(wFlashSpiOe),
  // Bus Master Read
  .iMUsiRd(wMUsiRd),    .oSUsiRd(wSUsiRd[lpSPIAdrsMap]),
  // Bus Master Write
  .oMUsiWd(wMUsiWdSpi),  .oMUsiAdrs(wMUsiAdrsSpi),
  .iSUsiWd(wSUsiWd),    .iSUsiAdrs(wSUsiAdrs),
  // MUsi 制御信号
  .oSpiDir(wSpiDir),    .onSpiDir(wnSpiDir),
  // CLK, RST
  .iSRST(wSRST),      .iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Sound Generate
//-----------------------------------------------------------------------------
wire wMIDI_In;  // Input Only
wire wI2S_MCLK, wI2S_BCLK, wI2S_LRCLK, wI2S_SDATA;
wire [7:0] wMidiRd;
wire wMidiVd;

SynthesizerBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpSynthesizerAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpSynCsrActiveWidth),
	.pUfiDqBusWidth(lpUfiDqBusWidth),
	.pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
	.pUfiAdrsMap(lpUfiSynAdrsMap),
	.pDmaAdrsWidth(lpRamAdrsWidth),
	.pDmaBurstLength(256)
) SynthesizerBlock (
	// External Port
	// Connected External PCM5102A and MIPI Host
	.iMIDI(wMIDI_In),
	.oI2S_MCLK(wI2S_MCLK),    .oI2S_BCLK(wI2S_BCLK),
	.oI2S_LRCLK(wI2S_LRCLK),  .oI2S_SDATA(wI2S_SDATA),
	// Control Status data
	.oMidiRd(wMidiRd),    .oMidiVd(wMidiVd),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpSynthesizerAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),    .iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.iMUfiRd(wMUfiRd),    .iMUfiAdrs(wMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(wMUfiWd[lpUfiSynAdrsMap]),
	.oMUfiAdrs(wMUfiWAdrs[lpUfiSynAdrsMap]),
	.iMUfiRdy(wMUfiRdy[lpUfiSynAdrsMap]),
	// CLK, RST
	.iMRST(wMRST),      .iMCLK(iMCLK),
	.iSRST(wSRST),      .inSRST(wnSRST),
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
wire [5:0] wIunsedL;
wire [17:0] wIunsedR;
assign ioGPIOL_O[0]     = wFlashRomSck;		assign  wIunsedL[0]  	= ioGPIOL_I[0];  assign ioGPIOL_OE[0] = wFlashSpiOe[0];
assign ioGPIOL_O[1]     = wFlashRomMosi;	assign  wIunsedL[1]  	= ioGPIOL_I[1];  assign ioGPIOL_OE[1] = wFlashSpiOe[0];
assign ioGPIOL_O[2]     = 1'b0;				assign  wFlashRomMiso	= ioGPIOL_I[2];  assign ioGPIOL_OE[2] = wFlashSpiOe[1];
assign ioGPIOL_O[3]     = wFlashRomCs;		assign  wIunsedL[3]  	= ioGPIOL_I[3];  assign ioGPIOL_OE[3] = wFlashSpiOe[0];
assign ioGPIOL_O[4]     = 1'b0;				assign  wnARST		 	= ioGPIOL_I[4];  assign ioGPIOL_OE[4] = 1'b0;
assign ioGPIOL_O[5]     = 1'b1;				assign  wIunsedL[5]  	= ioGPIOL_I[5];  assign ioGPIOL_OE[5] = 1'b1;
// GPIOR
assign ioGPIOR_O[0]     = 1'b0;        assign  wIunsedR[0]  = ioGPIOR_I[0];  assign ioGPIOR_OE[0]  = 1'b0;
assign ioGPIOR_O[1]     = 1'b0;        assign  wIunsedR[1]  = ioGPIOR_I[1];  assign ioGPIOR_OE[1]  = 1'b0;
assign ioGPIOR_O[2]     = 1'b0;        assign  wIunsedR[2]  = ioGPIOR_I[2];  assign ioGPIOR_OE[2]  = 1'b0;
assign ioGPIOR_O[3]     = 1'b0;        assign  wIunsedR[3]  = ioGPIOR_I[3];  assign ioGPIOR_OE[3]  = 1'b0;
assign ioGPIOR_O[4]     = 1'b0;        assign  wIunsedR[4]  = ioGPIOR_I[4];  assign ioGPIOR_OE[4]  = 1'b0;
assign ioGPIOR_O[5]     = 1'b0;        assign  wIunsedR[5]  = ioGPIOR_I[5];  assign ioGPIOR_OE[5]  = 1'b0;
assign ioGPIOR_O[6]     = 1'b0;        assign  wIunsedR[6]  = ioGPIOR_I[6];  assign ioGPIOR_OE[6]  = 1'b0;
assign ioGPIOR_O[7]     = 1'b0;        assign  wMIDI_In     = ioGPIOR_I[7];  assign ioGPIOR_OE[7]  = 1'b0;
assign ioGPIOR_O[8]     = 1'b0;        assign  wIunsedR[8]  = ioGPIOR_I[8];  assign ioGPIOR_OE[8]  = 1'b0;
assign ioGPIOR_O[9]     = 1'b0;        assign  wIunsedR[9]  = ioGPIOR_I[9];  assign ioGPIOR_OE[9]  = 1'b0;
assign ioGPIOR_O[10]    = 1'b0;        assign  wIunsedR[10] = ioGPIOR_I[10];  assign ioGPIOR_OE[10] = 1'b0;
assign ioGPIOR_O[11]    = 1'b0;        assign  wIunsedR[11] = ioGPIOR_I[11];  assign ioGPIOR_OE[11] = 1'b0;
assign ioGPIOR_O[12]    = 1'b0;        assign  wIunsedR[12] = ioGPIOR_I[12];  assign ioGPIOR_OE[12] = 1'b0;
assign ioGPIOR_O[13]    = 1'b0;        assign  wIunsedR[13] = ioGPIOR_I[13];  assign ioGPIOR_OE[13] = 1'b0;
assign ioGPIOR_O[14]   = wGPIOR_O[0];  assign  wGPIOR_In[0] = ioGPIOR_I[14];  assign ioGPIOR_OE[14] = wGPIOR_Dir[0];
assign ioGPIOR_O[15]   = wGPIOR_O[1];  assign  wGPIOR_In[1] = ioGPIOR_I[15];  assign ioGPIOR_OE[15] = wGPIOR_Dir[1];
assign ioGPIOR_O[16]   = wGPIOR_O[2];  assign  wGPIOR_In[2] = ioGPIOR_I[16];  assign ioGPIOR_OE[16] = wGPIOR_Dir[2];
assign ioGPIOR_O[17]    = 1'b0;        assign  wIunsedR[17] = ioGPIOR_I[17];  assign ioGPIOR_OE[17] = 1'b0;
// GPIOB
wire [23:0] wIunsedB;
assign ioGPIOB_O[0]  = 1'b0;          assign wIunsedB[0]   = ioGPIOB_I[0];   assign ioGPIOB_OE[0]  = 1'b1;
assign ioGPIOB_O[1]  = 1'b0;          assign wIunsedB[1]   = ioGPIOB_I[1];   assign ioGPIOB_OE[1]  = 1'b1;
assign ioGPIOB_O[2]  = 1'b0;          assign wIunsedB[2]   = ioGPIOB_I[2];   assign ioGPIOB_OE[2]  = 1'b1;
assign ioGPIOB_O[3]  = 1'b0;          assign wIunsedB[3]   = ioGPIOB_I[3];   assign ioGPIOB_OE[3]  = 1'b1;
assign ioGPIOB_O[4]  = 1'b0;          assign wIunsedB[4]   = ioGPIOB_I[4];   assign ioGPIOB_OE[4]  = 1'b1;
assign ioGPIOB_O[5]  = 1'b0;          assign wIunsedB[5]   = ioGPIOB_I[5];   assign ioGPIOB_OE[5]  = 1'b1;
assign ioGPIOB_O[6]  = 1'b0;          assign wIunsedB[6]   = ioGPIOB_I[6];   assign ioGPIOB_OE[6]  = 1'b1;
assign ioGPIOB_O[7]  = 1'b0;          assign wIunsedB[7]   = ioGPIOB_I[7];   assign ioGPIOB_OE[7]  = 1'b1;
assign ioGPIOB_O[8]  = 1'b0;          assign wIunsedB[8]   = ioGPIOB_I[8];   assign ioGPIOB_OE[8]  = 1'b1;
assign ioGPIOB_O[9]  = 1'b0;          assign wIunsedB[9]   = ioGPIOB_I[9];   assign ioGPIOB_OE[9]  = 1'b1;
assign ioGPIOB_O[10] = 1'b0;          assign wIunsedB[10]  = ioGPIOB_I[10];  assign ioGPIOB_OE[10] = 1'b1;
assign ioGPIOB_O[11] = 1'b0;          assign wIunsedB[11]  = ioGPIOB_I[11];  assign ioGPIOB_OE[11] = 1'b1;
assign ioGPIOB_O[12] = 1'b0;          assign wIunsedB[12]  = ioGPIOB_I[12];  assign ioGPIOB_OE[12] = 1'b1;
assign ioGPIOB_O[13] = wSlaveMiso;    assign wMasterMiso   = ioGPIOB_I[13];  assign ioGPIOB_OE[13] = wnSpiDir;
assign ioGPIOB_O[14] = wMasterSck;    assign wSlaveSck     = ioGPIOB_I[14];  assign ioGPIOB_OE[14] = wSpiDir;
assign ioGPIOB_O[15] = wMasterMosi;   assign wSlaveMosi    = ioGPIOB_I[15];  assign ioGPIOB_OE[15] = wSpiDir;
assign ioGPIOB_O[16] = wMasterCs;     assign wSlaveCs      = ioGPIOB_I[16];  assign ioGPIOB_OE[16] = wSpiDir;
assign ioGPIOB_O[17] = 1'b0;          assign wIoSpiDir     = ioGPIOB_I[17];  assign ioGPIOB_OE[17] = 1'b0; // "1" で SPI Block が Bus Master として動作, "0" では MCB操作
assign ioGPIOB_O[18] = wI2S_MCLK;     assign wIunsedB[18]  = ioGPIOB_I[18];  assign ioGPIOB_OE[18] = 1'b1; // Out Only
assign ioGPIOB_O[19] = wI2S_BCLK;     assign wIunsedB[19]  = ioGPIOB_I[19];  assign ioGPIOB_OE[19] = 1'b1; // Out Only
assign ioGPIOB_O[20] = wI2S_SDATA;    assign wIunsedB[20]  = ioGPIOB_I[20];  assign ioGPIOB_OE[20] = 1'b1; // Out Only
assign ioGPIOB_O[21] = wI2S_LRCLK;    assign wIunsedB[21]  = ioGPIOB_I[21];  assign ioGPIOB_OE[21] = 1'b1; // Out Only
assign ioGPIOB_O[22] = 1'b0;          assign wIunsedB[22]  = ioGPIOB_I[22];  assign ioGPIOB_OE[22] = 1'b1;
assign ioGPIOB_O[23] = 1'b0;          assign wIunsedB[23]  = ioGPIOB_I[23];  assign ioGPIOB_OE[23] = 1'b1;
// External IO
assign ioCSI_O = ioCSI_I;
assign ioCSI_OE = 1'b0;
// SRAM
assign ioSRAMD_O = wSRAMD_O;      assign wSRAMD_I = ioSRAMD_I;    assign ioSRAMD_OE = {lpRamDqWidth{wSRAM_OE}};
assign oSRAMA = wSRAMA;
assign oSRAM_LB = wSRAM_LB;
assign oSRAM_UB = wSRAM_UB;
assign oSRAM_OE = wSRAM_OE;
assign oSRAM_WE = wSRAM_WE;
assign oSRAM_CE = wSRAM_CE;
// USB UART
// assign oUSB_TX = wMIDI_In;//iUSB_RX;
assign oUSB_TX = wSocTxd;
// Configration ROM SPI
wire [3:0] wIunusedConfig;
assign ioMOSI_O = 1'b0;     assign wIunusedConfig[0] = ioMOSI_I;  assign ioMOSI_OE = 1'b0;
assign ioMISO_O = 1'b0;     assign wIunusedConfig[1] = ioMISO_I;  assign ioMISO_OE = 1'b0;
assign ioCCK_O = 1'b0;      assign wIunusedConfig[2] = ioCCK_I;   assign ioCCK_OE  = 1'b0;
assign ioSSN_O = 1'b0;      assign wIunusedConfig[3] = ioSSN_I;   assign ioSSN_OE  = 1'b0;
//

//-----------------------------------------------------------------------------
// LED Toggle
//-----------------------------------------------------------------------------
localparam lpCntMax = 25000000-1;

reg [27:0] rCnt;
reg rLed;

always @(posedge iSCLK)
begin
  if (rSRST)                rCnt <= 0;
  else if (lpCntMax==rCnt)  rCnt <= 0;
  else                      rCnt <= rCnt + 1'b1;

  if (rSRST)                rLed <= 0;
  else if (lpCntMax==rCnt)  rLed <= ~rLed;
  else                      rLed <= rLed;
end

always @*
begin
  qGpioAltMode[0] <= qlocked;
  qGpioAltMode[1] <= wTestErr;
  qGpioAltMode[2] <= rLed;
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