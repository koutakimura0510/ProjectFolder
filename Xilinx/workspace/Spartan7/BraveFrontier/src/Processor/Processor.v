//----------------------------------------------------------
// Create 2022/4/21
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processer #(
    parameter       pHdisplay     = 640,
    parameter       pVdisplay     = 480,
    parameter       pPixelDebug   = "yes",
    parameter       pBuffDepth    = 1024,
    parameter       pDebug        = "off"
)(
    // External port
    // SPI
    output          ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    output          oSpiCs1,
    output          oSpiCs2,
    // PSRAM
    inout  [15:0]   ioSrampDq,
    inout  [1:0]    ioSrampDqs,
    output          oSrampClk,
    output          oSrampCs,
    inout  [15:0]   ioSramsDq,
    inout  [1:0]    ioSramsDqs,
    output          oSramsClk,
    output          oSramsCs,
    // I2C
    output          oSwScl,
    inout           ioSwSda,
    // UART
    output          oUartTx,
    input           iUartRx,
    // LED
    output [1:0]    oLedEdge,
    output          oLedClk,
    // Internal Port
    // Video
    input           iPFvde,
    output [15:0]   oPixelData,
    output          oBackLightControl,
    // Audio
    input           iAudioLRch,
    output [31:0]   oAudioData,
    // CLK Reset
    input           iSysClk,
    input           iPixelClk,
    input           iMemClk,
    input           iAudioClk,
    input           iSysRst,
    input           iAudioRst
);

// 
assign ioSpiSck      	= 1'bz;
assign ioSpiMiso    	= 1'bz;
assign ioSpiMosi    	= 1'bz;
assign ioSpiWp      	= 1'bz;
assign ioSpiHold    	= 1'bz;
assign oSpiConfigCs 	= 0;
assign oSpiCs1      	= 0;
assign oSpiCs2      	= 0;
assign ioSrampDq		= 16'bz;
assign ioSrampDqs		= 2'bz;
assign oSrampClk		= 1'b0;
assign oSrampCs			= 1'b0;
assign ioSramsDq		= 16'bz;
assign ioSramsDqs		= 2'bz;
assign oSramsClk		= 1'b0;
assign oSramsCs			= 1'b0;
assign oSwScl			= 1'b0;
assign ioSwSda			= 1'bz;
assign oUartTx			= 1'b0;
assign oLedEdge			= 1'b0;
assign oLedClk			= 1'b0;
assign oPixelData		= 1'b0;
assign oBackLightControl= 1'b0;
assign oAudioData		= 1'b0;

//----------------------------------------------------------
// MCB
//----------------------------------------------------------
// MicroControllerBlock MCB

//----------------------------------------------------------
// LED Block
//----------------------------------------------------------
// GPIOBlock GPIO_LED_BLOCK

//----------------------------------------------------------
// PWM BackLight
//----------------------------------------------------------
// PWMBlock PWM_BLOCK

//----------------------------------------------------------
// Flash Memory Block
//----------------------------------------------------------
// SPIBlock SPI_BLOCK

//----------------------------------------------------------
// SW
//----------------------------------------------------------
// I2CBlock I2C1_BLOCK()

//----------------------------------------------------------
// PGB
//----------------------------------------------------------
// PixelGenBlock PGB

//----------------------------------------------------------
// AGB
//----------------------------------------------------------
// AudioGenBlock AGB

//----------------------------------------------------------
// VDMA
//----------------------------------------------------------
// VDMABlock VDMA ()

//----------------------------------------------------------
// ADMA
//----------------------------------------------------------
// ADMABlock ADMA ()

//----------------------------------------------------------
// 外部 RAM を操作しシステムと協調動作させる
//----------------------------------------------------------
// PSRAMBlock PSRAM_BLOCK

//----------------------------------------------------------
// USI/F BUS
//----------------------------------------------------------
// UltraSimpleInterface USI_BUS

//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// UltraFastInterface UFI_BUS


endmodule