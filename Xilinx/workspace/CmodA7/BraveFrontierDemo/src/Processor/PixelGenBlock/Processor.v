//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processer #(
    parameter       pHdisplay     = 480,
    parameter       pHback        =  43,
    parameter       pHfront       =   8,
    parameter       pHsync        =  30,
    parameter       pVdisplay     = 272,
    parameter       pVtop         =  12,
    parameter       pVbottom      =   4,
    parameter       pVsync        =  10,
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
	output 	[18:0]	oMemAdr,
	inout	[7:0]	ioMemDq,
	output 			oRamOE,
	output 			oRamWE,
	output 			oRamCE,
	// Display
    output	[7:4]   oTftColorR,
    output	[7:4]   oTftColorG,
    output	[7:4]   oTftColorB,
    output          oTftDclk,
    output          oTftHsync,
    output          oTftVsync,
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
    input           iPixelClk,
    input           iMemClk,
    input           iAudioClk,
    input           iSysRst,
    input           iAudioRst
);

// 
assign ioSramDq			= 16'bz;
assign ioSramDqs		= 2'bz;
assign oSramClk			= 1'b0;
assign oSramCs			= 1'b0;
//
assign oPixelData		= 1'b0;
assign oAudioData		= 1'b0;


//----------------------------------------------------------
// バス接続の周辺機能アドレスマップ
//----------------------------------------------------------
localparam lpBusSlaveConnect  	= 6;		// 接続Slave数、最大16
localparam lpBlockAdrsMap 		= 8;

localparam [lpBlockAdrsMap-1'b1:0] 
	lpGpioAdrsMap	= 8'h01,
	lpPWMAdrsMap 	= 8'h02,
	lpSPIAdrsMap	= 8'h03,
	lpI2CAdrsMap	= 8'h04,
	lpPGBAdrsMap	= 8'h05,
	lpAGBAdrsMap	= 8'h06,
	lpRAMAdrsMap 	= 8'h07,
	lpTFTAdrsMap 	= 8'h08;


//----------------------------------------------------------
// バス幅を定義
//----------------------------------------------------------
// variable parameter
localparam	lpUsiBusWidth  		= 32;		// バスデータ幅
localparam	lpBusAdrsBit		= 16;		// バスアドレス幅
localparam  lpUfiBusWidth		= 16;


//----------------------------------------------------------
// MCB
//----------------------------------------------------------
// Slave -> Master
reg  [31:0] 					qMUsiRdMcb;
reg  [lpBusSlaveConnect-1:0]	qMUsiVdMcb;
// Master -> Slave
wire [31:0] 					wMUsiWdMcb;
wire [lpBusAdrsBit-1:0]			wMUsiAdrsMcb;
wire 							wMUsiWCkeMcb;

MicroControllerBlock #(
	.pBusSlaveConnect	(lpBusSlaveConnect),
	.pBusAdrsBit		(lpBusAdrsBit)
) MICRO_CONTROLLER_BLOCK (
	.iMUsiRd			(qMUsiRdMcb),
	.iMUsiREd			(qMUsiVdMcb),
	.oMUsiWd			(wMUsiWdMcb),
	.oMUsiAdrs			(wMUsiAdrsMcb),
	.oMUsiWEd			(wMUsiWCkeMcb),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
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
	.pBusAdrsBit		(lpBusAdrsBit)
) GPIO_BLOCK (
	.oLedEdge			(oLedEdge),
	.oLedClk			(oLedClk),
	.oSUsiRd			(wSUsiRdGpio),
	.oSUsiREd			(wSUsiREdGpio),
	.iSUsiWd			(qSUsiWdGpio),
	.iSUsiAdrs			(qSUsiAdrsGpio),
	.iSUsiWCke			(qSUsiWCkeGpio),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

//----------------------------------------------------------
// PWM BackLight
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdPwm;
wire 					wSUsiREdPwm;
// Master -> Slave
reg  [31:0] 			qSUsiWdPwm;
reg  [lpBusAdrsBit-1:0]	qSUsiAdrsPwm;
reg  					qSUsiWCkePwm;

PWMBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpPWMAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit)
) PWM_BLOCK (
	.oPwm				(oBackLightControl),
	.oSUsiRd			(wSUsiRdPwm),
	.oSUsiREd			(wSUsiREdPwm),
	.iSUsiWd			(qSUsiWdPwm),
	.iSUsiAdrs			(qSUsiAdrsPwm),
	.iSUsiWCke			(qSUsiWCkePwm),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

//----------------------------------------------------------
// External CPU Master SPI Block or Slave SPI Block
//----------------------------------------------------------
// Slave -> Master
reg  [31:0] 					qMUsiRdSpi;
reg  [lpBusSlaveConnect-1:0]	qMUsiREdSpi;
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
wire [31:0]						wMUfiWdSpi;
wire [31:0]						wMUfiAdrsSpi;
wire 							wMUfiWEdSpi;
wire 							wMUfiWVdSpi;
// Master Select
wire 							wMUsiSel;
// Interrupt
wire 							wMSpiIntr;

SPIBlock #(
	.pBlockAdrsMap				(lpBlockAdrsMap),
	.pAdrsMap	 				(lpSPIAdrsMap),
	.pBusAdrsBit				(lpBusAdrsBit),
	.pBusSlaveConnect			(lpBusSlaveConnect),
	.pUfiBusWidth				(lpUfiBusWidth)
) SPI_BLOCK (
	.ioSpiSck					(ioSpiSck),
	.ioSpiMiso					(ioSpiMiso),
	.ioSpiMosi					(ioSpiMosi),
	.ioSpiWp					(ioSpiWp),
	.ioSpiHold					(ioSpiHold),
	.oSpiConfigCs				(oSpiConfigCs),
	.ioSpiCs					(ioSpiCs),
	.iMSSel						(iMSSel),
	//
	.iMUsiRd					(qMUsiRdSpi),
	.iMUsiREd					(qMUsiREdSpi),
	//
	.oMUsiWd					(wMUsiWdSpi),
	.oMUsiAdrs					(wMUsiAdrsSpi),
	.oMUsiWEd					(wMUsiWCkeSpi),
	//
	.oSUsiRd					(wSUsiRdSpi),
	.oSUsiREd					(wSUsiREdSpi),
	//
	.iSUsiWd					(qSUsiWdSpi),
	.iSUsiAdrs					(qSUsiAdrsSpi),
	.iSUsiWCke					(qSUsiWCkeSpi),
	//
	.oMUfiWd					(wMUfiWdSpi),
	.oMUfiAdrs					(wMUfiAdrsSpi),
	.oMUfiWEd					(wMUfiWEdSpi),
	.oMUfiWVd					(wMUfiWVdSpi),
	//
	.oMUsiSel				(wMUsiSel),
	//
	.oMSpiIntr					(wMSpiIntr),
	//
	.iSysClk					(iSysClk),
	.iSysRst					(iSysRst)
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
	.pBusAdrsBit		(lpBusAdrsBit)
) I2C_BLOCK (
	.oI2CScl			(oI2CScl),
	.ioI2CSda			(ioI2CSda),
	.oSUsiRd			(wSUsiRdI2c),
	.oSUsiREd			(wSUsiREdI2c),
	.iSUsiWd			(qSUsiWdI2c),
	.iSUsiAdrs			(qSUsiAdrsI2c),
	.iSUsiWCke			(qSUsiWCkeI2c),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

//----------------------------------------------------------
// PGB
//----------------------------------------------------------
// PixelGenBlock PGB

//----------------------------------------------------------
// AGB
//----------------------------------------------------------
// AudioGenBlock AGB


//----------------------------------------------------------
// 外部 RAM を操作しシステムと協調動作させる
//----------------------------------------------------------
// RAMBlock RAM_BLOCK


//---------------------------------------------------------------------------
// TFT Display 送信
//---------------------------------------------------------------------------
tftWrapper TFT_WRAPPER (
	.oTftColorR			(oTftColorR),
	.oTftColorG			(oTftColorG),
	.oTftColorB			(oTftColorB),
	.oTftDclk			(oTftDclk),
	.oTftHsync			(oTftHsync),
	.oTftVsync			(oTftVsync),
	.oTftDe				(oTftDe),
	.oTftBackLight		(oTftBackLight),
	.oTftRst			(oTftRst),
	.iPixelClk 			(iPixelClk),
	.iSysRst			(iSysRst),
	.iPixelData			(iPixelData),
	.iVde				(iVde),
	.iHsync				(iHsync),
	.iVsync				(iVsync),
	.iBackLightControl 	(iBackLightControl)
);



//----------------------------------------------------------
// USI/F BUS
//----------------------------------------------------------
// not variable parameter
localparam	lpBusLen = (lpUsiBusWidth * lpBusSlaveConnect) - 1'b1;

// Slave -> Master
wire [31:0] 					wMUsiRd;
wire [lpBusSlaveConnect-1:0]	wMUsiREd;
reg  [lpBusLen:0]				qSUsiRd;
reg  [lpBusSlaveConnect-1:0]	qSUsiREd;
// Master -> Slave
reg  [31:0]						qMUsiWd;
reg  [lpBusAdrsBit-1:0] 		qMUsiAdrs;
reg  							qMUsiWEd;
wire [31:0] 					wSUsiWd;
wire [lpBusAdrsBit-1:0] 		wSUsiAdrs;
wire 							wSUsiWCke;

UltraSimpleInterface #(
	.pBusSlaveConnect	(lpBusSlaveConnect),
	.pUsiBusWidth		(lpUsiBusWidth),
	.pBusAdrsBit		(lpBusAdrsBit),
	.pBlockAdrsMap		(lpBlockAdrsMap),
	// .pGpioAdrsMap		(lpGpioAdrsMap),
	.pPWMAdrsMap		(lpPWMAdrsMap),
	.pSPIAdrsMap		(lpSPIAdrsMap),
	.pI2CAdrsMap		(lpI2CAdrsMap),
	.pPGBAdrsMap		(lpPGBAdrsMap),
	.pAGBAdrsMap		(lpAGBAdrsMap),
	.pRAMAdrsMap		(lpRAMAdrsMap),
	.pTFTAdrsMap		(lpTFTAdrsMap),
) USI_BUS (
	.oMUsiRd			(wMUsiRd),
	.oMUsiREd			(wMUsiREd),
	.iMUsiWd			(qMUsiWd),
	.iMUsiAdrs			(qMUsiAdrs),
	.iMUsiWEd			(qMUsiWEd),
	.oSUsiWd			(wSUsiWd),
	.oSUsiAdrs			(wSUsiAdrs),
	.oSUsiWCke			(wSUsiWCke),
	.iSUsiRd			(qSUsiRd),
	.iSUsiREd			(qSUsiREd),
	.iUsiClk 			(iSysClk),
	.iUsiRst			(iSysRst)
);

always @*
begin
	qMUsiRdMcb		<= wMUsiRd;
	qMUsiVdMcb		<= wMUsiREd;
	qMUsiRdSpi		<= wMUsiRd;
	qMUsiREdSpi		<= wMUsiREd;
	//
	qMUsiWd			<= wMUsiSel ? wMUsiWdMcb	: wMUsiWdSpi;
	qMUsiAdrs		<= wMUsiSel ? wMUsiAdrsMcb	: wMUsiAdrsSpi;
	qMUsiWEd		<= wMUsiSel ? wMUsiWCkeMcb	: wMUsiWCkeSpi;
	//
	// qSUsiWdGpio		<= wSUsiWd;
	// qSUsiAdrsGpio 	<= wSUsiAdrs;
	// qSUsiWCkeGpio	<= wSUsiWCke;
	//
	qSUsiWdPwm		<= wSUsiWd;
	qSUsiAdrsPwm	<= wSUsiAdrs;
	qSUsiWCkePwm	<= wSUsiWCke;
	//
	qSUsiWdSpi		<= wSUsiWd;
	qSUsiAdrsSpi	<= wSUsiAdrs;
	qSUsiWCkeSpi	<= wSUsiWCke;
	//
	qSUsiWdI2c		<= wSUsiWd;
	qSUsiAdrsI2c	<= wSUsiAdrs;
	qSUsiWCkeI2c	<= wSUsiWCke;
	//
	qSUsiRd			<= {{4{32'd0}}, wSUsiRdI2c,  wSUsiRdSpi,  wSUsiRdPwm,  wSUsiRdGpio	};
	qSUsiREd		<= {{4{1'h0}},  wSUsiREdI2c, wSUsiREdSpi, wSUsiREdPwm, wSUsiREdGpio	};
end

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// UltraFastInterface UFI_BUS


endmodule