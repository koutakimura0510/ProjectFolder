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
    output          oSpiSck,
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
    output          oPixelData,
    output          oBackLightControl,
    // Audio
    input           iAudioLRch,
    output          oAudioData,
    // CLK Reset
    input           iSysClk,
    input           iPixelClk,
    input           iMemClk,
    input           iAudioClk,
    input           iSysRst,
    input           iAudioRst
);

//
assign oSpiSck      = 0;
assign ioSpiMiso    = 0;
assign ioSpiMosi    = 0;
assign ioSpiWp      = 0;
assign ioSpiHold    = 0;
assign oSpiConfigCs = 0;
assign oSpiCs1      = 0;
assign oSpiCs2      = 0;
assign ioSrampDq	= 1'bz;
assign ioSrampDqs	= 1'bz;
assign oSrampClk	= 1'b0;
assign oSrampCs		= 1'b0;
assign ioSramsDq	= 1'bz;
assign ioSramsDqs	= 1'bz;
assign oSramsClk	= 1'b0;
assign oSramsCs		= 1'b0;
assign oSwScl		= 1'b0;
assign ioSwSda		= 1'bz;
assign oUartTx		= 1'b0;
assign oLedEdge		= 1'b0;
assign oLedClk		= 1'b0;
assign oPixelData		= 1'b0;
assign oBackLightControl= 1'b0;
assign oAudioData		= 1'b0;

//----------------------------------------------------------
// 外部ユーザーインターフェースを操作しシステムと協調動作させる
// SPI-ROM / LED / SW
//----------------------------------------------------------
// MicroControllerUnit MCU


//----------------------------------------------------------
// 外部 RAM を操作しシステムと協調動作させる
//----------------------------------------------------------
// MemoryInterfaceBlock MEMORY_INTERFACE_BLOCK


endmodule