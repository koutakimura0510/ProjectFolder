//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processor #(
    parameter       pHdisplay     = 480,
    parameter       pHfront       =   8,
    parameter       pHback        =  43,
    parameter       pHpulse       =  30,
    parameter       pVdisplay     = 272,
    parameter       pVfront       =  12,
    parameter       pVback        =   4,
    parameter       pVpulse       =  10,
    parameter       pPixelDebug   = "yes",
    parameter       pBuffDepth    = 1024,
    parameter       pDebug        = "off"
)(
    // External port
	// SPI
    inout           ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    inout           ioSpiCs,
    input           iMSSel,
	// RAM
	output 	[18:0]	oMemAdrs,
	inout	[7:0]	ioMemDq,
	output 			oMemOE,
	output 			oMemWE,
	output 			oMemCE,
	// Display
    output	[7:4]   oTftColorR,
    output	[7:4]   oTftColorG,
    output	[7:4]   oTftColorB,
    output          oTftDclk,
    output          oTftHSync,
    output          oTftVSync,
    output          oTftDe,
    output          oTftBackLight,
    output          oTftRst,
	// I2C Controller
    output          oI2CScl,
    inout           ioI2CSda,
	// PWM Audio
    output          oAudioMclk,
	// LED
	output	[1:0]	oLed,
	output 			oLedB,
	output 			oLedG,
	output 			oLedR,
	// TestPort
	output	[3:0]	oTestPort,
    // Internal Port
    // CLK Reset
    input           iSysClk,
    input           iVideoClk,
    input           iMemClk,
    input           iAudioClk,
	input 			iUfibClk,
    input           iSysRst,
    input           iAudioRst
);


//-----------------------------------------------------------------------------
// TestPort の使用・不使用
//-----------------------------------------------------------------------------
localparam lpTestPortNum	= 4;
localparam lpTestPortSpi 	= "no";
localparam lpTestPortVideo 	= "no";
localparam lpTestPortAudio 	= "yes";

wire [lpTestPortNum-1:0] wTestPortGpio;
wire [lpTestPortNum-1:0] wTestPortI2c;
wire [lpTestPortNum-1:0] wTestPortSpi;
wire [lpTestPortNum-1:0] wTestPortVideo;
wire [lpTestPortNum-1:0] wTestPortAudio;
wire [lpTestPortNum-1:0] wTestPortRam;


//-----------------------------------------------------------------------------
// 現在接続している ブロックの個数
//-----------------------------------------------------------------------------
localparam lpBusBlockConnect = 6;


//-----------------------------------------------------------------------------
// ブロックアドレスの Bit幅、接続中のブロック数に応じて切り替える
//-----------------------------------------------------------------------------
localparam lpBlockAdrsMap = 4;	// 2022-09-03 4bit だと 最大16個のブロック接続


//-----------------------------------------------------------------------------
// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
//-----------------------------------------------------------------------------
localparam [lpBlockAdrsMap-1:0] 
	lpGpioAdrsMap	= 'h01,
	lpSPIAdrsMap	= 'h02,
	lpI2CAdrsMap	= 'h03,
	lpVTBAdrsMap	= 'h04,
	lpATBAdrsMap	= 'h05,
	lpRAMAdrsMap 	= 'h06;


//-----------------------------------------------------------------------------
// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが
// 難しいと感じたため用意した。
// 
//-----------------------------------------------------------------------------
localparam lpCsrAdrsWidth	= 16;
localparam 
	lpGpioCsrActiveWidth = 8,
	lpSPICsrActiveWidth  = 8,
	lpI2CCsrActiveWidth  = 8,
	lpVTBCsrActiveWidth  = 16,		// 2022-09-03 現在 VTB だけ 16bit幅で使用している
	lpATBCsrActiveWidth  = 8,
	lpRAMCsrActiveWidth  = 8;


//----------------------------------------------------------
// バス幅を定義
//----------------------------------------------------------
localparam 	lpRamAdrsWidth		= 19;
localparam 	lpRamDqWidth		= 8;
localparam	lpUsiBusWidth  		= 32;			// Usi バスデータ幅
localparam	lpBusAdrsBit		= 32;			// バスアドレス幅, Usi/Ufi 共通
localparam  lpUfiBusWidth		= lpRamDqWidth;	// メモリのバス幅と同義
localparam	lpUfiIdNumber		= 3;



//----------------------------------------------------------
// MCB
//----------------------------------------------------------
// Slave -> Master
reg  [31:0] 					qMUsiRdMcb;
reg  [lpBusBlockConnect-1:0]	qMUsiVdMcb;
// Master -> Slave
wire [31:0] 					wMUsiWdMcb;
wire [lpBusAdrsBit-1:0]			wMUsiAdrsMcb;
wire 							wMUsiWCkeMcb;
//
wire [lpUfiBusWidth-1:0]		wMUfiWdMcs;
wire [lpBusAdrsBit-1:0]			wMUfiAdrsMcs;
wire 							wMUfiEdMcs;
wire 							wMUfiVdMcs;

MicroControllerBlock #(
	.pBusBlockConnect			(lpBusBlockConnect),
	.pBusAdrsBit				(lpBusAdrsBit),
	.pUfiBusWidth				(lpUfiBusWidth)
) MicroControllerBlock (
	.iMUsiRd					(qMUsiRdMcb),
	.iMUsiREd					(qMUsiVdMcb),
	.oMUsiWd					(wMUsiWdMcb),
	.oMUsiAdrs					(wMUsiAdrsMcb),
	.oMUsiWEd					(wMUsiWCkeMcb),
	.oMUfiWd					(wMUfiWdMcs),
	.oMUfiAdrs					(wMUfiAdrsMcs),
	.oMUfiEd					(wMUfiEdMcs),
	.oMUfiVd					(wMUfiVdMcs),
	.iSysRst					(iSysRst),
	.iSysClk					(iSysClk)
);


//----------------------------------------------------------
// GPIO Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdGpio;
wire 					wSUsiREdGpio;
// Master -> Slave
reg  [31:0] 			qSUsiWdGpio;
reg  [lpBusAdrsBit-1:0] qSUsiAdrsGpio;
reg  					qSUsiWCkeGpio;

GpioBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpGpioAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpGpioCsrActiveWidth)
) GpioBlock (
	// External Port
	.oLed				(oLed),
	.oLedB				(oLedB),
	.oLedG				(oLedG),
	.oLedR				(oLedR),
	// Internal Port
	.oSUsiRd			(wSUsiRdGpio),
	.oSUsiREd			(wSUsiREdGpio),
	.iSUsiWd			(qSUsiWdGpio),
	.iSUsiAdrs			(qSUsiAdrsGpio),
	.iSUsiWCke			(qSUsiWCkeGpio),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);


//----------------------------------------------------------
// External CPU Master SPI Block or Slave SPI Block
//----------------------------------------------------------
// Slave -> Master
reg  [31:0] 					qMUsiRdSpi;
reg  [lpBusBlockConnect-1:0]	qMUsiREdSpi;
wire [31:0] 					wSUsiRdSpi;
wire 							wSUsiREdSpi;
// Master -> Slave
wire [31:0] 					wMUsiWdSpi;
wire [lpBusAdrsBit-1:0]			wMUsiAdrsSpi;
wire 							wMUsiWCkeSpi;
reg  [31:0] 					qSUsiWdSpi;
reg  [lpBusAdrsBit-1:0]			qSUsiAdrsSpi;
reg  							qSUsiWCkeSpi;
// 
wire [lpUfiBusWidth-1:0]		wMUfiWdSpi;
wire [lpBusAdrsBit-1:0]			wMUfiAdrsSpi;
wire 							wMUfiEdSpi;
wire 							wMUfiVdSpi;
wire 							wMUfiCmdSpi;
// Master Select
wire 							wMUsiSel;
// Interrupt
wire 							wMSpiIntr;

SPIBlock #(
	.pBlockAdrsMap				(lpBlockAdrsMap),
	.pAdrsMap	 				(lpSPIAdrsMap),
	.pBusAdrsBit				(lpBusAdrsBit),
	.pCsrAdrsWidth				(lpCsrAdrsWidth),
	.pCsrActiveWidth			(lpSPICsrActiveWidth),
	.pBusBlockConnect			(lpBusBlockConnect),
	.pUfiBusWidth				(lpUfiBusWidth),
	.pTestPortUsed 				(lpTestPortSpi),
	.pTestPortNum				(lpTestPortNum)
) SPIBlock (
	// External Port
	.ioSpiSck					(ioSpiSck),
	.ioSpiMiso					(ioSpiMiso),
	.ioSpiMosi					(ioSpiMosi),
	.ioSpiWp					(ioSpiWp),
	.ioSpiHold					(ioSpiHold),
	.oSpiConfigCs				(oSpiConfigCs),
	.ioSpiCs					(ioSpiCs),
	.iMSSel						(iMSSel),
	// Slave -> Master
	.iMUsiRd					(qMUsiRdSpi),
	.iMUsiREd					(qMUsiREdSpi),
	// Master -> Slave
	.oMUsiWd					(wMUsiWdSpi),
	.oMUsiAdrs					(wMUsiAdrsSpi),
	.oMUsiWEd					(wMUsiWCkeSpi),
	// Slave -> Master
	.oSUsiRd					(wSUsiRdSpi),
	.oSUsiREd					(wSUsiREdSpi),
	// Master -> Slave
	.iSUsiWd					(qSUsiWdSpi),
	.iSUsiAdrs					(qSUsiAdrsSpi),
	.iSUsiWCke					(qSUsiWCkeSpi),
	// Master -> Slave
	.oMUfiWd					(wMUfiWdSpi),
	.oMUfiAdrs					(wMUfiAdrsSpi),
	.oMUfiEd					(wMUfiEdSpi),
	.oMUfiVd					(wMUfiVdSpi),
	.oMUfiCmd					(wMUfiCmdSpi),
	// MUsi 制御信号
	.oMUsiSel					(wMUsiSel),
	.oMSpiIntr					(wMSpiIntr),
	//
	.iSysClk					(iSysClk),
	.iSysRst					(iSysRst),
	//
	.oTestPort					(wTestPortSpi)
);


//----------------------------------------------------------
// 外部コントローラ接続
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdI2c;
wire 					wSUsiREdI2c;
// Master -> Slave
reg  [31:0] 			qSUsiWdI2c;
reg  [lpBusAdrsBit-1:0]	qSUsiAdrsI2c;
reg  					qSUsiWCkeI2c;

I2CBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpGpioAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpI2CCsrActiveWidth)
) I2CBlock (
	// External Port
	.oI2CScl			(oI2CScl),
	.ioI2CSda			(ioI2CSda),
	// Internal Port
	.oSUsiRd			(wSUsiRdI2c),
	.oSUsiREd			(wSUsiREdI2c),
	.iSUsiWd			(qSUsiWdI2c),
	.iSUsiAdrs			(qSUsiAdrsI2c),
	.iSUsiWCke			(qSUsiWCkeI2c),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

//----------------------------------------------------------
// Video Tx Block
//----------------------------------------------------------
// ディスプレイ制御レジスタの Bit幅
localparam lpHdisplayWidth	= 11;
localparam lpHfrontWidth	= 7;
localparam lpHbackWidth		= 7;
localparam lpHpulseWidth	= 7;
localparam lpVdisplayWidth	= 11;
localparam lpVfrontWidth	= 5;
localparam lpVbackWidth		= 5;
localparam lpVpulseWidth	= 5;
// Slave -> Master
wire [31:0] 			wSUsiRdVtb;
wire 					wSUsiREdVtb;
// Master -> Slave
reg  [31:0] 			qSUsiWdVtb;
reg  [lpBusAdrsBit-1:0] qSUsiAdrsVtb;
reg  					qSUsiWCkeVtb;
//
reg  [lpUfiBusWidth-1:0]qMUfiRdVtb;
reg  					qMUfiREdVtb;
//
wire [lpUfiBusWidth-1:0]wMUfiWdVtb;
wire [lpBusAdrsBit-1:0]	wMUfiAdrsVtb;
wire 					wMUfiWEdVtb;
wire 					wMUfiREdVtb;
wire 					wMUfiVdVtb;
wire 					wMUfiCmdVtb;
reg  					qMUfiRdyVtb;
//
VideoTxBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap			(lpVTBAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pUfiBusWidth		(lpUfiBusWidth),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpVTBCsrActiveWidth),
	.pMemAdrsWidth		(lpRamAdrsWidth),
	//
	.pHdisplay			(pHdisplay),
	.pHfront			(pHfront),
	.pHback				(pHback),
	.pHpulse			(pHpulse),
	.pVdisplay			(pVdisplay),
	.pVfront			(pVfront),
	.pVback				(pVback),
	.pVpulse			(pVpulse),
	.pHdisplayWidth		(lpHdisplayWidth),
	.pHfrontWidth		(lpHfrontWidth),
	.pHbackWidth		(lpHbackWidth),
	.pHpulseWidth		(lpHpulseWidth),
	.pVdisplayWidth		(lpVdisplayWidth),
	.pVfrontWidth		(lpVfrontWidth),
	.pVbackWidth		(lpVbackWidth),
	.pVpulseWidth		(lpVpulseWidth),
	//
	.pColorDepth		(16),
	//
	.pTestPortUsed		(lpTestPortVideo),
	.pTestPortNum		(lpTestPortNum)
) VideoTxBlock (
	// External port
	.oTftColorR			(oTftColorR),
	.oTftColorG			(oTftColorG),
	.oTftColorB			(oTftColorB),
	.oTftDclk			(oTftDclk),
	.oTftHSync			(oTftHSync),
	.oTftVSync			(oTftVSync),
	.oTftDe				(oTftDe),
	.oTftBackLight		(oTftBackLight),
	.oTftRst			(oTftRst),
	// Intenal port
	.oSUsiRd			(wSUsiRdVtb),
	.oSUsiREd			(wSUsiREdVtb),
	.iSUsiWd			(qSUsiWdVtb),
	.iSUsiAdrs			(qSUsiAdrsVtb),
	.iSUsiWCke			(qSUsiWCkeVtb),
	//
	.iMUfiRd			(qMUfiRdVtb),
	.iMUfiREd			(qMUfiREdVtb),
	//
	.oMUfiWd			(wMUfiWdVtb),
	.oMUfiAdrs			(wMUfiAdrsVtb),
	.oMUfiWEd			(wMUfiWEdVtb),
	.oMUfiREd			(wMUfiREdVtb),
	.oMUfiVd			(wMUfiVdVtb),
	.oMUfiCmd			(wMUfiCmdVtb),
	//
	.iMUfiRdy			(qMUfiRdyVtb),
	// CLK Rst
	.iSysRst			(iSysRst),
	.iVideoClk 			(iVideoClk),
	.iSysClk			(iSysClk),
	//
	.oTestPort			(wTestPortVideo)
);


//----------------------------------------------------------
// Audio Tx Block
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdAudio;
wire 					wSUsiREdAudio;
// Master -> Slave
reg  [31:0] 			qSUsiWdAudio;
reg  [lpBusAdrsBit-1:0]	qSUsiAdrsAudio;
reg  					qSUsiWCkeAudio;
//
reg  [lpUfiBusWidth-1:0]qMUfiRdAtb;
reg  					qMUfiREdAtb;
//
wire [lpBusAdrsBit-1:0]	wMUfiAdrsAtb;
wire 					wMUfiWEdAtb;
wire 					wMUfiREdAtb;
wire 					wMUfiVdAtb;
//
reg 					qMUfiRdyAtb;

AudioTxBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpATBAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pUfiBusWidth		(lpUfiBusWidth),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpATBCsrActiveWidth),
	.pMemAdrsWidth		(lpRamAdrsWidth),
	//
	.pSamplingBitWidth	(8),
	//
	.pTestPortUsed		(lpTestPortAudio),
	.pTestPortNum		(lpTestPortNum)
) AudioTxBlock (
	// External Port
	.oAudioMclk			(oAudioMclk),
	// Internal Port
	.oSUsiRd			(wSUsiRdAudio),
	.oSUsiREd			(wSUsiREdAudio),
	.iSUsiWd			(qSUsiWdAudio),
	.iSUsiAdrs			(qSUsiAdrsAudio),
	.iSUsiWCke			(qSUsiWCkeAudio),
	//
	.iMUfiRd			(qMUfiRdAtb),
	.iMUfiREd			(qMUfiREdAtb),
	//
	.oMUfiAdrs			(wMUfiAdrsAtb),
	.oMUfiWEd			(wMUfiWEdAtb),
	.oMUfiREd			(wMUfiREdAtb),
	.oMUfiVd			(wMUfiVdAtb),
	//
	.iMUfiRdy			(qMUfiRdyAtb),
	//
	.iSysRst			(iSysRst),
	.iSysClk			(iSysClk),
	.iAudioRst			(iAudioRst),
	.iAudioClk			(iAudioClk),
	//
	.oTestPort			(wTestPortAudio)
);


//----------------------------------------------------------
// RAMBlock
//----------------------------------------------------------
// USI Bus
wire [31:0] 			wSUsiRdRam;
wire 					wSUsiREdRam;
reg  [31:0] 			qSUsiWdRam;
reg  [lpBusAdrsBit-1:0]	qSUsiAdrsRam;
reg  					qSUsiWCkeRam;
// UFI Bus
reg  [lpUfiBusWidth-1:0]qSUfiWdRam;
reg 					qSUfiWEdRam;
reg 					qSUfiREdRam;
reg  [lpBusAdrsBit-1:0]	qSUfiAdrsRam;
reg  					qSUfiCmd;
wire 					wSUfiRdy;
wire [lpUfiBusWidth-1:0]wSUfiRdRam;
wire 					wSUfiREdRamI;
wire [lpUfiIdNumber-1:0]wMUfiIdI;
wire [lpUfiIdNumber-1:0]wMUfiIdO;

RAMBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpRAMAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pCsrAdrsWidth		(lpCsrAdrsWidth),
	.pCsrActiveWidth	(lpRAMCsrActiveWidth),
	.pUfiBusWidth		(lpUfiBusWidth),
	.pUfiIdNumber		(lpUfiIdNumber),
	.pRamAdrsWidth		(lpRamAdrsWidth),
	.pRamDqWidth		(lpRamDqWidth)
) RamBlock (
	// External Port
	.oMemAdrs			(oMemAdrs),
	.ioMemDq			(ioMemDq),
	.oMemOE				(oMemOE),
	.oMemWE				(oMemWE),
	.oMemCE				(oMemCE),
	// Internal Port
	// Slave -> Master
	.oSUsiRd			(wSUsiRdRam),
	.oSUsiREd			(wSUsiREdRam),
	// Master -> Slave
	.iSUsiWd			(qSUsiWdRam),
	.iSUsiAdrs			(qSUsiAdrsRam),
	.iSUsiWCke			(qSUsiWCkeRam),
	// Master -> Slave
	.iSUfiWd			(qSUfiWdRam),
	.iSUfiAdrs			(qSUfiAdrsRam),
	.iSUfiWEd			(qSUfiWEdRam),
	.iSUfiREd			(qSUfiREdRam),
	.iSUfiCmd			(qSUfiCmd),
	.oSUfiRdy			(wSUfiRdy),
	// Slave -> Master
	.oSUfiRd			(wSUfiRdRam),
	.oSUfiREd			(wSUfiREdRamI),
	// Ufi ID Lssue
	.iSUfiIdI			(wMUfiIdI),
	.oSUfiIdO			(wMUfiIdO),
	//
	.iSysRst			(iSysRst),
	.iSysClk			(iSysClk),
	.iMemClk			(iMemClk)
);


//----------------------------------------------------------
// USI/F BUS
//----------------------------------------------------------
// not variable parameter
localparam	lpBusLen = (lpUsiBusWidth * lpBusBlockConnect) - 1'b1;

// Slave -> Master
wire [31:0] 					wMUsiRd;
wire [lpBusBlockConnect-1:0]	wMUsiREd;
reg  [lpBusLen:0]				qSUsiRd;
reg  [lpBusBlockConnect-1:0]	qSUsiREd;
// Master -> Slave
reg  [31:0]						qMUsiWd;
reg  [lpBusAdrsBit-1:0] 		qMUsiAdrs;
reg  							qMUsiWEd;
wire [31:0] 					wSUsiWd;
wire [lpBusAdrsBit-1:0] 		wSUsiAdrs;
wire 							wSUsiWCke;

UltraSimpleInterface #(
	.pBusBlockConnect			(lpBusBlockConnect),
	.pUsiBusWidth				(lpUsiBusWidth),
	.pBusAdrsBit				(lpBusAdrsBit),
	.pBlockAdrsMap				(lpBlockAdrsMap),
	.pGpioAdrsMap				(lpGpioAdrsMap),
	.pSPIAdrsMap				(lpSPIAdrsMap),
	.pI2CAdrsMap				(lpI2CAdrsMap),
	.pVTBAdrsMap				(lpVTBAdrsMap),
	.pATBAdrsMap				(lpATBAdrsMap),
	.pRAMAdrsMap				(lpRAMAdrsMap),
	.pCsrAdrsWidth				(lpCsrAdrsWidth)
) UsiBus (
	// Slave to Master
	.oMUsiRd					(wMUsiRd),
	.oMUsiREd					(wMUsiREd),
	.iSUsiRd					(qSUsiRd),
	.iSUsiREd					(qSUsiREd),
	// Master to Slave
	.iMUsiWd					(qMUsiWd),
	.iMUsiAdrs					(qMUsiAdrs),
	.iMUsiWEd					(qMUsiWEd),
	.oSUsiWd					(wSUsiWd),
	.oSUsiAdrs					(wSUsiAdrs),
	.oSUsiWCke					(wSUsiWCke),
	// Clk Rst
	.iUsiRst					(iSysRst),
	.iUsiClk 					(iSysClk)
);

always @*
begin
	qMUsiRdMcb		<= wMUsiRd;
	qMUsiVdMcb		<= wMUsiREd;
	qMUsiRdSpi		<= wMUsiRd;
	qMUsiREdSpi		<= wMUsiREd;
	//
	qMUsiWd			<= wMUsiSel ? wMUsiWdSpi   : wMUsiWdMcb;
	qMUsiAdrs		<= wMUsiSel ? wMUsiAdrsSpi : wMUsiAdrsMcb;
	qMUsiWEd		<= wMUsiSel ? wMUsiWCkeSpi : wMUsiWCkeMcb;
	//
	qSUsiWdGpio		<= wSUsiWd;
	qSUsiAdrsGpio 	<= wSUsiAdrs;
	qSUsiWCkeGpio	<= wSUsiWCke;
	//
	qSUsiWdSpi		<= wSUsiWd;
	qSUsiAdrsSpi	<= wSUsiAdrs;
	qSUsiWCkeSpi	<= wSUsiWCke;
	//
	qSUsiWdI2c		<= wSUsiWd;
	qSUsiAdrsI2c	<= wSUsiAdrs;
	qSUsiWCkeI2c	<= wSUsiWCke;
	//
	qSUsiWdVtb		<= wSUsiWd;
	qSUsiAdrsVtb	<= wSUsiAdrs;
	qSUsiWCkeVtb	<= wSUsiWCke;
	//
	qSUsiWdAudio	<= wSUsiWd;
	qSUsiAdrsAudio	<= wSUsiAdrs;
	qSUsiWCkeAudio	<= wSUsiWCke;
	//
	qSUsiWdRam		<= wSUsiWd;
	qSUsiAdrsRam	<= wSUsiAdrs;
	qSUsiWCkeRam	<= wSUsiWCke;
	//
	qSUsiRd			<= {wSUsiRdRam,  wSUsiRdAudio,  wSUsiRdVtb,  wSUsiRdI2c,  wSUsiRdSpi,  wSUsiRdGpio	};
	qSUsiREd		<= {wSUsiREdRam, wSUsiREdAudio, wSUsiREdVtb, wSUsiREdI2c, wSUsiREdSpi, wSUsiREdGpio	};
end


//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
wire [lpUfiBusWidth-1:0]wMUfiRd;
wire 					wMUfiEddVtb;
wire 					wMUfiEddAtb;
wire					wMUfiRdy;
//
wire [lpUfiBusWidth-1:0]wSUfiWdRam;
wire [lpBusAdrsBit-1:0]	wSUfiAdrsRam;
wire 					wSUfiWEdRam;
wire 					wSUfiREdRamO;
wire 					wSUfiCmd;
wire 					wMUfiRdyVtb;
wire 					wMUfiRdyAtb;

UltraFastInterface #(
	.pUfiBusWidth	(lpUfiBusWidth),
	.pBusAdrsBit	(lpBusAdrsBit),
	.pUfiIdNumber	(lpUfiIdNumber)
) UfiBus (
	.iMUfiWdMcs		(wMUfiWdMcs),
	.iMUfiAdrsMcs	(wMUfiAdrsMcs),
	.iMUfiEdMcs		(wMUfiEdMcs),
	.iMUfiVdMcs		(wMUfiVdMcs),
	//
	.iMUfiWdSpi		(wMUfiWdSpi),
	.iMUfiAdrsSpi	(wMUfiAdrsSpi),
	.iMUfiEdSpi		(wMUfiEdSpi),
	.iMUfiVdSpi		(wMUfiVdSpi),
	.iMUfiCmdSpi	(wMUfiCmdSpi),
	//
	.iMUfiWdVtb		(wMUfiWdVtb),
	.iMUfiAdrsVtb	(wMUfiAdrsVtb),
	.iMUfiWEdVtb	(wMUfiWEdVtb),
	.iMUfiREdVtb	(wMUfiREdVtb),
	.iMUfiVdVtb		(wMUfiVdVtb),
	.iMUfiCmdVtb	(wMUfiCmdVtb),
	.oMUfiRdyVtb	(wMUfiRdyVtb),
	//
	.iMUfiAdrsAtb	(wMUfiAdrsAtb),
	.iMUfiWEdAtb	(wMUfiWEdAtb),
	.iMUfiREdAtb	(wMUfiREdAtb),
	.iMUfiVdAtb		(wMUfiVdAtb),
	.oMUfiRdyAtb	(wMUfiRdyAtb),
	//
	.oMUfiRd		(wMUfiRd),
	.oMUfiEddVtb	(wMUfiEddVtb),
	.oMUfiEddAtb	(wMUfiEddAtb),
	.oMUfiRdy		(wMUfiRdy),
	//
	.iMUfiIdI		(wMUfiIdO),
	.oMUfiIdO		(wMUfiIdI),
	//
	.oSUfiWdRam		(wSUfiWdRam),
	.oSUfiAdrsRam	(wSUfiAdrsRam),
	.oSUfiWEdRam	(wSUfiWEdRam),
	.oSUfiREdRam	(wSUfiREdRamO),
	.oSUfiCmd		(wSUfiCmd),
	//
	.iSUfiRdRam		(wSUfiRdRam),
	.iSUfiREdRam	(wSUfiREdRamI),
	.iSUfiRdyRam	(wSUfiRdy),
	//
	.iUfiRst		(iSysRst),
	.iUfiClk		(iUfibClk)
);

always @*
begin
	qSUfiWdRam	<= wSUfiWdRam;
	qSUfiAdrsRam<= wSUfiAdrsRam;
	qSUfiWEdRam	<= wSUfiWEdRam;
	qSUfiREdRam	<= wSUfiREdRamO;
	qSUfiCmd	<= wSUfiCmd;
	//
	qMUfiRdVtb 	<= wMUfiRd;
	qMUfiREdVtb <= wMUfiEddVtb;
	qMUfiRdyVtb <= &{wMUfiRdyVtb,wMUfiRdy};
	//
	qMUfiRdAtb	<= wMUfiRd;
	qMUfiREdAtb	<= wMUfiEddAtb;
	qMUfiRdyAtb <= &{wMUfiRdyAtb,wMUfiRdy};
end

endmodule