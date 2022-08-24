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
assign oMemAdr			= 19'd0;
assign ioMemDq			= 8'dz;
assign oRamOE			= 1'b1;
assign oRamWE			= 1'b1;
assign oRamCE			= 1'b1;
//
assign oTftColorR		= 4'd0;
assign oTftColorG		= 4'd0;
assign oTftColorB		= 4'd0;
assign oTftDclk			= 1'd0;
assign oTftHsync		= 1'd0;
assign oTftVsync		= 1'd0;
assign oTftDe			= 1'd0;
assign oTftBackLight	= 1'd0;
assign oTftRst			= 1'd0;
// 
assign oTestPort 		= 4'd0;


//----------------------------------------------------------
// バス接続の周辺機能アドレスマップ
//----------------------------------------------------------
localparam lpBusSlaveConnect  	= 6;		// 接続Slave数、最大16
localparam lpBlockAdrsMap 		= 8;

localparam [lpBlockAdrsMap-1'b1:0] 
	lpGpioAdrsMap	= 8'h01,
	lpSPIAdrsMap	= 8'h02,
	lpI2CAdrsMap	= 8'h03,
	lpPGBAdrsMap	= 8'h04,
	lpAGBAdrsMap	= 8'h05,
	lpRAMAdrsMap 	= 8'h06;


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
	.oLed				(oLed),
	.oLedB				(oLedB),
	.oLedG				(oLedG),
	.oLedR				(oLedR),
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
wire [lpUfiBusWidth-1:0]		wMUfiWdSpi;
wire [31:0]						wMUfiAdrsSpi;
wire 							wMUfiWEdSpi;
wire 							wMUfiWVdSpi;
// Master Select
wire 							wMUsiMonopoly;
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
	.oMUsiMonopoly				(wMUsiMonopoly),
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
// PixelGenBlock #(
// 	.pHdisplay			(pHdisplay),
// 	.pHback				(pHback),
// 	.pHfront			(pHfront),
// 	.pHsync				(pHsync),
// 	.pVdisplay			(pVdisplay),
// 	.pVtop				(pVtop),
// 	.pVbottom			(pVbottom),
// 	.pVsync				(pVsync)
// ) PGB (
// 	// External port
// 	.oTftColorR			(oTftColorR),
// 	.oTftColorG			(oTftColorG),
// 	.oTftColorB			(oTftColorB),
// 	.oTftDclk			(oTftDclk),
// 	.oTftHsync			(oTftHsync),
// 	.oTftVsync			(oTftVsync),
// 	.oTftDe				(oTftDe),
// 	.oTftBackLight		(oTftBackLight),
// 	.oTftRst			(oTftRst),
// 	// Intenal port
// 	// CLK Rst
// 	.iPixelClk 			(iPixelClk),
// 	.iSysRst			(iSysRst),
// );


//----------------------------------------------------------
// Audio Gen
//----------------------------------------------------------
// Slave -> Master
wire [31:0] 			wSUsiRdAudio;
wire 					wSUsiREdAudio;
// Master -> Slave
reg  [31:0] 			qSUsiWdAudio;
reg  [lpBusAdrsBit-1:0]	qSUsiAdrsAudio;
reg  					qSUsiWCkeAudio;

AudioGenBlock #(
	.pBlockAdrsMap		(lpBlockAdrsMap),
	.pAdrsMap	 		(lpAGBAdrsMap),
	.pBusAdrsBit		(lpBusAdrsBit)
) AUDIO_GEN_BLOCK (
	.oAudioMclk			(oAudioMclk),
	.oSUsiRd			(wSUsiRdAudio),
	.oSUsiREd			(wSUsiREdAudio),
	.iSUsiWd			(qSUsiWdAudio),
	.iSUsiAdrs			(qSUsiAdrsAudio),
	.iSUsiWCke			(qSUsiWCkeAudio),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);


//----------------------------------------------------------
// 外部 RAM を操作しシステムと協調動作させる
//----------------------------------------------------------
// RAMBlock RAM_BLOCK


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
	.pGpioAdrsMap		(lpGpioAdrsMap),
	.pSPIAdrsMap		(lpSPIAdrsMap),
	.pI2CAdrsMap		(lpI2CAdrsMap),
	.pPGBAdrsMap		(lpPGBAdrsMap),
	.pAGBAdrsMap		(lpAGBAdrsMap),
	.pRAMAdrsMap		(lpRAMAdrsMap)
) USI_BUS (
	// Slave to Master
	.oMUsiRd			(wMUsiRd),
	.oMUsiREd			(wMUsiREd),
	.iSUsiRd			(qSUsiRd),
	.iSUsiREd			(qSUsiREd),
	// Master to Slave
	.iMUsiWd			(qMUsiWd),
	.iMUsiAdrs			(qMUsiAdrs),
	.iMUsiWEd			(qMUsiWEd),
	.oSUsiWd			(wSUsiWd),
	.oSUsiAdrs			(wSUsiAdrs),
	.oSUsiWCke			(wSUsiWCke),
	// Clk Rst
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
	qMUsiWd			<= wMUsiMonopoly ? wMUsiWdMcb	: wMUsiWdSpi;
	qMUsiAdrs		<= wMUsiMonopoly ? wMUsiAdrsMcb	: wMUsiAdrsSpi;
	qMUsiWEd		<= wMUsiMonopoly ? wMUsiWCkeMcb	: wMUsiWCkeSpi;
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
	qSUsiWdAudio	<= wSUsiWd;
	qSUsiAdrsAudio	<= wSUsiAdrs;
	qSUsiWCkeAudio	<= wSUsiWCke;
	//
	qSUsiRd			<= {32'd0, wSUsiRdAudio,  32'd0, wSUsiRdI2c,  wSUsiRdSpi,  wSUsiRdGpio	};
	qSUsiREd		<= { 1'h0, wSUsiREdAudio,  1'd0, wSUsiREdI2c, wSUsiREdSpi, wSUsiREdGpio	};
end

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// UltraFastInterface UFI_BUS


endmodule