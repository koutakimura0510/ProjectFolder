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
	//
	// GPIOL
	input 	[ 5:0] ioGPIOL_I,
	output 	[ 5:0] ioGPIOL_O,
	output 	[ 5:0] ioGPIOL_OE,
	// GPIOR
	input 	[17:0] ioGPIOR_I,
	output 	[17:0] ioGPIOR_O,
	output 	[17:0] ioGPIOR_OE,
	// GPIOB
	input	[23:0] ioGPIOB_I,
	output 	[23:0] ioGPIOB_O,
	output 	[23:0] ioGPIOB_OE,
	//
	// External IO
	input 	ioCSI_I,
	output 	ioCSI_O,
	output 	ioCSI_OE,
	//
	// SRAM
	input 	[15:0] ioSRAMD_I,
	output 	[15:0] ioSRAMD_O,
	output 	[15:0] ioSRAMD_OE,
	output 	[14:0] oSRAMA,
	output 	oSRAM_CE,
	output 	oSRAM_LB,
	output 	oSRAM_OE,
	output 	oSRAM_UB,
	output 	oSRAM_WE,
	//
	// USB UART
	input 	iUSB_RX,
	output 	oUSB_TX,
	//
	// Flash ROM SPI
	input 	ioMOSI_I,
	output 	ioMOSI_O,
	output 	ioMOSI_OE,
	input 	ioMISO_I,
	output 	ioMISO_O,
	output 	ioMISO_OE,
	input 	ioCCK_I,
	output 	ioCCK_O,
	output 	ioCCK_OE,
	input 	ioSSN_I,
	output 	ioSSN_O,
	output 	ioSSN_OE,
	//
	// External OSC
	input 	iOSC_IN,
	//
	// PLL BR0
	input 	iMCLK,
	output 	PLL_BR0_RSTN,
	input 	PLL_BR0_LOCKED,
	//
	// PLL TL0
	input 	iSCLK,
	output 	PLL_TL0_RSTN,
	input 	PLL_TL0_LOCKED
);


//-----------------------------------------------------------------------------
// System Reset Gen
//-----------------------------------------------------------------------------
genvar x;	// Top内で共通変数として使用する
reg rSRST, rnSRST;
reg rMRST, rnMRST;
wire wSRST, wnSRST;
wire wMRST, wnMRST;
reg  qlocked;

always @(posedge iMCLK, negedge qlocked)
begin
	if (!qlocked) 	rnMRST <= 1'b0;
	else 			rnMRST <= 1'b1;

	if (!qlocked) 	rMRST <= 1'b1;
	else 			rMRST <= 1'b0;
end

always @(posedge iSCLK, negedge qlocked)
begin
	if (!qlocked) 	rnSRST <= 1'b0;
	else 			rnSRST <= 1'b1;
	
	if (!qlocked) 	rSRST <= 1'b1;
	else 			rSRST <= 1'b0;
end

always @*
begin
	qlocked = &{PLL_BR0_LOCKED, PLL_TL0_LOCKED};
end

assign wSRST	= rSRST;
assign wnSRST	= rnSRST;
assign wMRST	= rMRST;
assign wnMRST	= rnMRST;
assign PLL_BR0_RSTN = 1'b1;
assign PLL_TL0_RSTN = 1'b1;


//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth = 32;		// USIB Width
localparam lpBlockConnectNum = 2;	// 現在接続している ブロックの個数
localparam lpBlockAdrsWidth = func_getwidth(lpBlockConnectNum);
localparam lpCsrAdrsWidth = 16;		// 各ブロック共通の基本CSR幅
localparam lpSUsiBusWidth = (lpUsiBusWidth * lpBlockConnectNum);
localparam [lpBlockAdrsWidth-1:0] 	// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
	lpGpioAdrsMap	= 'h0,
	lpSPIAdrsMap	= 'h1,
	lpNullAdrsMap	= 0;

// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが難しいと感じたため用意した。
localparam 
	lpGpioCsrActiveWidth = 8,
	lpSPICsrActiveWidth  = 8,
	lpNullActiveWidth	 = 8;	// 使用しない、ソースの追加がやりやすいように
	// lpI2CCsrActiveWidth  = 8,
	// lpVTBCsrActiveWidth  = 16,
	// lpATBCsrActiveWidth  = 8,
	// lpRAMCsrActiveWidth  = 8;

// Bus Master Read
wire [lpUsiBusWidth-1:0] wMUsiRd, wSUsiRd[lpBlockConnectNum-1:0];
reg  [lpSUsiBusWidth-1:0] qSUsiRd;	// 二次元配列で取得した Slave Readデータを一次元に結合
// Bus Master Write
reg  [lpUsiBusWidth-1:0] qMUsiWd,		qMUsiAdrs;
wire [lpUsiBusWidth-1:0] wSUsiWd,		wSUsiAdrs;
wire [lpUsiBusWidth-1:0] wMUsiWdSpi,	wMUsiAdrsSpi;
wire wSpiDir, wnSpiDir;
wire wMSpiIntr;

USIB #(
	.pBlockConnectNum(lpBlockConnectNum),	.pBlockAdrsWidth(lpBlockAdrsWidth),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
) USIB (
	// Bus Master Read
	.oMUsiRd(wMUsiRd),	.iSUsiRd(qSUsiRd),
	// Bus Master Write
	.iMUsiWd(qMUsiWd),	.iMUsiAdrs(qMUsiAdrs),
	.oSUsiWd(wSUsiWd),	.oSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(wSRST),		.iSCLK(iSCLK)
);

always @*
begin
	qMUsiWd		<= wMUsiWdSpi;
	qMUsiAdrs	<= wMUsiAdrsSpi;
	// qMUsiWd		<= wSpiDir ? wMUsiWdSpi   : wMUsiWdMcb;
	// qMUsiAdrs	<= wSpiDir ? wMUsiAdrsSpi : wMUsiAdrsMcb;
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
// USIF 
//----------------------------------------------------------
localparam 	lpRamAdrsWidth		= 19;
localparam 	lpRamDqWidth		= 8;
localparam  lpUfiBusWidth		= 8;
localparam	lpUfiIdNumber		= 3;


//-----------------------------------------------------------------------------
// GPIO Block
//-----------------------------------------------------------------------------
localparam lpGpioWidth = 18;
wire [lpGpioWidth-1:0] wGPIOR_O;
wire [lpGpioWidth-1:0] wGPIOR_Dir;
wire [lpGpioWidth-1:0] wGPIOR_In;

GpioBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpGpioAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpGpioCsrActiveWidth),
	.pGpioWidth(lpGpioWidth)
) GpioBlock (
	// GPIO Output Ctrl
	.oGpioR(wGPIOR_O),
	.oGpioDir(wGPIOR_Dir),
	// GPIO Alt Mode
	.iLocked(qlocked),
	// GPIO Input
	.iGpioIn(wGPIOR_In),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpGpioAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),	.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(wSRST),		.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// External CPU Master SPI Block or Slave SPI Block
//-----------------------------------------------------------------------------
wire wSlaveSck, wSlaveMosi, wSlaveMiso, wSlaveCs;
wire wMasterSck, wMasterMosi, wMasterMiso, wMasterCs;
wire wIoSpiDir;

SPIBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpSPIAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpSPICsrActiveWidth)
) SPIBlock (
	// External Port
	.iSpiSck(wSlaveSck),	.iSpiMosi(wSlaveMosi),
	.oSpiMiso(wSlaveMiso),	.iSpiCs(wSlaveCs),
	.oSpiSck(wMasterSck),	.oSpiMosi(wMasterMosi),
	.iSpiMiso(wMasterMiso),	.oSpiCs(wMasterCs),
	.iSpiDir(wIoSpiDir),
	// Bus Master Read
	.iMUsiRd(wMUsiRd),		.oSUsiRd(wSUsiRd[lpSPIAdrsMap]),
	// Bus Master Write
	.oMUsiWd(wMUsiWdSpi),	.oMUsiAdrs(wMUsiAdrsSpi),
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// MUsi 制御信号
	.oMSpiIntr(wMSpiIntr),
	.oSpiDir(wSpiDir),		.onSpiDir(wnSpiDir),
	// CLK, RST
	.iSRST(wSRST),			.iSCLK(iSCLK)
);



//-----------------------------------------------------------------------------
// IO Connect
// Trion,Titanium はユーザーが使用可能な IOプリミティブは無いため、
// 階層を深くせずソースの修正が簡単にすることを目的として Top module に接続する仕様にした
// 
// 使用していない IO は Input 設定にしておく。
//-----------------------------------------------------------------------------
// GPIOL
wire [5:0] wIunsedL;
assign ioGPIOL_O[0]     = 1'b0;			assign  wIunsedL[0]  = ioGPIOL_I[0];	assign ioGPIOL_OE[0] = 1'b1;
assign ioGPIOL_O[1]     = 1'b0;			assign  wIunsedL[1]  = ioGPIOL_I[1];	assign ioGPIOL_OE[1] = 1'b1;
assign ioGPIOL_O[2]     = 1'b0;			assign  wIunsedL[2]  = ioGPIOL_I[2];	assign ioGPIOL_OE[2] = 1'b1;
assign ioGPIOL_O[3]     = 1'b0;			assign  wIunsedL[3]  = ioGPIOL_I[3];	assign ioGPIOL_OE[3] = 1'b1;
assign ioGPIOL_O[4]     = 1'b0;			assign  wIunsedL[4]  = ioGPIOL_I[4];	assign ioGPIOL_OE[4] = 1'b1;
assign ioGPIOL_O[5]     = 1'b0;			assign  wIunsedL[5]  = ioGPIOL_I[5];	assign ioGPIOL_OE[5] = 1'b1;
// GPIOR
assign ioGPIOR_O[0]     = wGPIOR_O[0];	assign  wGPIOR_In[0]  = ioGPIOR_I[0];	assign ioGPIOR_OE[0]  = wGPIOR_Dir[0];
assign ioGPIOR_O[1]     = wGPIOR_O[1];	assign  wGPIOR_In[1]  = ioGPIOR_I[1];	assign ioGPIOR_OE[1]  = wGPIOR_Dir[1];
assign ioGPIOR_O[2]     = wGPIOR_O[2];	assign  wGPIOR_In[2]  = ioGPIOR_I[2];	assign ioGPIOR_OE[2]  = wGPIOR_Dir[2];
assign ioGPIOR_O[3]     = wGPIOR_O[3];	assign  wGPIOR_In[3]  = ioGPIOR_I[3];	assign ioGPIOR_OE[3]  = wGPIOR_Dir[3];
assign ioGPIOR_O[4]     = wGPIOR_O[4];	assign  wGPIOR_In[4]  = ioGPIOR_I[4];	assign ioGPIOR_OE[4]  = wGPIOR_Dir[4];
assign ioGPIOR_O[5]     = wGPIOR_O[5];	assign  wGPIOR_In[5]  = ioGPIOR_I[5];	assign ioGPIOR_OE[5]  = wGPIOR_Dir[5];
assign ioGPIOR_O[6]     = wGPIOR_O[6];	assign  wGPIOR_In[6]  = ioGPIOR_I[6];	assign ioGPIOR_OE[6]  = wGPIOR_Dir[6];
assign ioGPIOR_O[7]     = wGPIOR_O[7];	assign  wGPIOR_In[7]  = ioGPIOR_I[7];	assign ioGPIOR_OE[7]  = wGPIOR_Dir[7];
assign ioGPIOR_O[8]     = wGPIOR_O[8];	assign  wGPIOR_In[8]  = ioGPIOR_I[8];	assign ioGPIOR_OE[8]  = wGPIOR_Dir[8];
assign ioGPIOR_O[9]     = wGPIOR_O[9];	assign  wGPIOR_In[9]  = ioGPIOR_I[9];	assign ioGPIOR_OE[9]  = wGPIOR_Dir[9];
assign ioGPIOR_O[10]    = wGPIOR_O[10];	assign  wGPIOR_In[10] = ioGPIOR_I[10];	assign ioGPIOR_OE[10] = wGPIOR_Dir[10];
assign ioGPIOR_O[11]    = wGPIOR_O[11];	assign  wGPIOR_In[11] = ioGPIOR_I[11];	assign ioGPIOR_OE[11] = wGPIOR_Dir[11];
assign ioGPIOR_O[12]    = wGPIOR_O[12];	assign  wGPIOR_In[12] = ioGPIOR_I[12];	assign ioGPIOR_OE[12] = wGPIOR_Dir[12];
assign ioGPIOR_O[13]    = wGPIOR_O[13];	assign  wGPIOR_In[13] = ioGPIOR_I[13];	assign ioGPIOR_OE[13] = wGPIOR_Dir[13];
assign ioGPIOR_O[14] 	= wGPIOR_O[14];	assign  wGPIOR_In[14] = ioGPIOR_I[14];	assign ioGPIOR_OE[14] = wGPIOR_Dir[14];
assign ioGPIOR_O[15] 	= wGPIOR_O[15];	assign  wGPIOR_In[15] = ioGPIOR_I[15];	assign ioGPIOR_OE[15] = wGPIOR_Dir[15];
assign ioGPIOR_O[16] 	= wGPIOR_O[16];	assign  wGPIOR_In[16] = ioGPIOR_I[16];	assign ioGPIOR_OE[16] = wGPIOR_Dir[16];
assign ioGPIOR_O[17]    = wGPIOR_O[17];	assign  wGPIOR_In[17] = ioGPIOR_I[17];	assign ioGPIOR_OE[17] = wGPIOR_Dir[17];
// GPIOB
wire [23:0] wIunsedB;
assign ioGPIOB_O[0]  = 1'b0;			assign wIunsedB[0]	= ioGPIOB_I[0];		assign ioGPIOB_OE[0]  = 1'b1;
assign ioGPIOB_O[1]  = 1'b0;			assign wIunsedB[1]	= ioGPIOB_I[1];		assign ioGPIOB_OE[1]  = 1'b1;
assign ioGPIOB_O[2]  = 1'b0;			assign wIunsedB[2]	= ioGPIOB_I[2];		assign ioGPIOB_OE[2]  = 1'b1;
assign ioGPIOB_O[3]  = 1'b0;			assign wIunsedB[3]	= ioGPIOB_I[3];		assign ioGPIOB_OE[3]  = 1'b1;
assign ioGPIOB_O[4]  = 1'b0;			assign wIunsedB[4]	= ioGPIOB_I[4];		assign ioGPIOB_OE[4]  = 1'b1;
assign ioGPIOB_O[5]  = 1'b0;			assign wIunsedB[5]	= ioGPIOB_I[5];		assign ioGPIOB_OE[5]  = 1'b1;
assign ioGPIOB_O[6]  = 1'b0;			assign wIunsedB[6]	= ioGPIOB_I[6];		assign ioGPIOB_OE[6]  = 1'b1;
assign ioGPIOB_O[7]  = 1'b0;			assign wIunsedB[7]	= ioGPIOB_I[7];		assign ioGPIOB_OE[7]  = 1'b1;
assign ioGPIOB_O[8]  = 1'b0;			assign wIunsedB[8]	= ioGPIOB_I[8];		assign ioGPIOB_OE[8]  = 1'b1;
assign ioGPIOB_O[9]  = 1'b0;			assign wIunsedB[9]	= ioGPIOB_I[9];		assign ioGPIOB_OE[9]  = 1'b1;
assign ioGPIOB_O[10] = 1'b0;			assign wIunsedB[10]	= ioGPIOB_I[10];	assign ioGPIOB_OE[10] = 1'b1;
assign ioGPIOB_O[11] = 1'b0;			assign wIunsedB[11]	= ioGPIOB_I[11];	assign ioGPIOB_OE[11] = 1'b1;
assign ioGPIOB_O[12] = 1'b0;			assign wIunsedB[12]	= ioGPIOB_I[12];	assign ioGPIOB_OE[12] = 1'b1;
assign ioGPIOB_O[13] = wSlaveMiso;		assign wMasterMiso	= ioGPIOB_I[13];	assign ioGPIOB_OE[13] = wnSpiDir;
assign ioGPIOB_O[14] = wMasterSck;		assign wSlaveSck	= ioGPIOB_I[14];	assign ioGPIOB_OE[14] = wSpiDir;
assign ioGPIOB_O[15] = wMasterMosi;		assign wSlaveMosi	= ioGPIOB_I[15];	assign ioGPIOB_OE[15] = wSpiDir;
assign ioGPIOB_O[16] = wMasterCs;		assign wSlaveCs		= ioGPIOB_I[16];	assign ioGPIOB_OE[16] = wSpiDir;
assign ioGPIOB_O[17] = 1'b0;			assign wIoSpiDir	= ioGPIOB_I[17];	assign ioGPIOB_OE[17] = 1'b1;
assign ioGPIOB_O[18] = 1'b0;			assign wIunsedB[18]	= ioGPIOB_I[18];	assign ioGPIOB_OE[18] = 1'b1;
assign ioGPIOB_O[19] = 1'b0;			assign wIunsedB[19]	= ioGPIOB_I[19];	assign ioGPIOB_OE[19] = 1'b1;
assign ioGPIOB_O[20] = 1'b0;			assign wIunsedB[20]	= ioGPIOB_I[20];	assign ioGPIOB_OE[20] = 1'b1;
assign ioGPIOB_O[21] = 1'b0;			assign wIunsedB[21]	= ioGPIOB_I[21];	assign ioGPIOB_OE[21] = 1'b1;
assign ioGPIOB_O[22] = 1'b0;			assign wIunsedB[22]	= ioGPIOB_I[22];	assign ioGPIOB_OE[22] = 1'b1;
assign ioGPIOB_O[23] = 1'b0;			assign wIunsedB[23]	= ioGPIOB_I[23];	assign ioGPIOB_OE[23] = 1'b1;
// External IO
assign ioCSI_O = ioCSI_I;
assign ioCSI_OE = 1'b0;
// SRAM
wire [15:0] wIoSrandd;
assign ioSRAMD_O[0]  = 1'b0;	assign wIoSrandd[0]  = ioSRAMD_I[0];		assign ioSRAMD_OE[0]  = 1'b1;
assign ioSRAMD_O[1]  = 1'b0;	assign wIoSrandd[1]  = ioSRAMD_I[1];		assign ioSRAMD_OE[1]  = 1'b1;
assign ioSRAMD_O[2]  = 1'b0;	assign wIoSrandd[2]  = ioSRAMD_I[2];		assign ioSRAMD_OE[2]  = 1'b1;
assign ioSRAMD_O[3]  = 1'b0;	assign wIoSrandd[3]  = ioSRAMD_I[3];		assign ioSRAMD_OE[3]  = 1'b1;
assign ioSRAMD_O[4]  = 1'b0;	assign wIoSrandd[4]  = ioSRAMD_I[4];		assign ioSRAMD_OE[4]  = 1'b1;
assign ioSRAMD_O[5]  = 1'b0;	assign wIoSrandd[5]  = ioSRAMD_I[5];		assign ioSRAMD_OE[5]  = 1'b1;
assign ioSRAMD_O[6]  = 1'b0;	assign wIoSrandd[6]  = ioSRAMD_I[6];		assign ioSRAMD_OE[6]  = 1'b1;
assign ioSRAMD_O[7]  = 1'b0;	assign wIoSrandd[7]  = ioSRAMD_I[7];		assign ioSRAMD_OE[7]  = 1'b1;
assign ioSRAMD_O[8]  = 1'b0;	assign wIoSrandd[8]  = ioSRAMD_I[8];		assign ioSRAMD_OE[8]  = 1'b1;
assign ioSRAMD_O[9]  = 1'b0;	assign wIoSrandd[9]  = ioSRAMD_I[9];		assign ioSRAMD_OE[9]  = 1'b1;
assign ioSRAMD_O[10] = 1'b0;	assign wIoSrandd[10] = ioSRAMD_I[10];		assign ioSRAMD_OE[10] = 1'b1;
assign ioSRAMD_O[11] = 1'b0;	assign wIoSrandd[11] = ioSRAMD_I[11];		assign ioSRAMD_OE[11] = 1'b1;
assign ioSRAMD_O[12] = 1'b0;	assign wIoSrandd[12] = ioSRAMD_I[12];		assign ioSRAMD_OE[12] = 1'b1;
assign ioSRAMD_O[13] = 1'b0;	assign wIoSrandd[13] = ioSRAMD_I[13];		assign ioSRAMD_OE[13] = 1'b1;
assign ioSRAMD_O[14] = 1'b0;	assign wIoSrandd[14] = ioSRAMD_I[14];		assign ioSRAMD_OE[14] = 1'b1;
assign ioSRAMD_O[15] = 1'b0;	assign wIoSrandd[15] = ioSRAMD_I[15];		assign ioSRAMD_OE[15] = 1'b1;
assign oSRAMA = 15'd0;
assign oSRAM_CE = 1'b1;
assign oSRAM_LB = 1'b1;
assign oSRAM_OE = 1'b1;
assign oSRAM_UB = 1'b1;
assign oSRAM_WE = 1'b1;
// USB UART
assign oUSB_TX = iUSB_RX;
// Flash ROM SPI
wire [3:0] wIunusedConfig;
assign ioMOSI_O = 1'b0;		assign wIunusedConfig[0] = ioMOSI_I;	assign ioMOSI_OE = 1'b1;
assign ioMISO_O = 1'b0;		assign wIunusedConfig[1] = ioMISO_I;	assign ioMISO_OE = 1'b1;
assign ioCCK_O = 1'b0;		assign wIunusedConfig[2] = ioCCK_I;		assign ioCCK_OE  = 1'b1;
assign ioSSN_O = 1'b0;		assign wIunusedConfig[3] = ioSSN_I;		assign ioSSN_OE  = 1'b1;
//

//---------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//---------------------------------------------------------------------------
function[  7:0]	func_getwidth;
    input [31:0] iVAL;
    integer			i;

    begin
    func_getwidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            func_getwidth = i+1;
        end
    end
endfunction

endmodule