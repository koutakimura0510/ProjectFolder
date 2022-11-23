//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processer (
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


//----------------------------------------------------------
// Spi Slave動作
//----------------------------------------------------------
wire wMUsiMonopoly;
wire [31:0] wMUsiWdSpi;
wire [15:0] wMUsiAdrsSpi;
wire wMUsiWCkeSpi;
//
reg rMono;
reg [31:0] rSend;
//
SPIBlock SPI_BLOCK (
	.ioSpiSck					(ioSpiSck),
	.ioSpiMiso					(ioSpiMiso),
	.ioSpiMosi					(ioSpiMosi),
	.ioSpiWp					(ioSpiWp),
	.ioSpiHold					(ioSpiHold),
	.oSpiConfigCs				(oSpiConfigCs),
	.ioSpiCs					(ioSpiCs),
	.iMSSel						(iMSSel),
	//
	.iMUsiRd					(32'haaaaaaaa),
	.iMUsiREd					(1'b1),
	//
	.oMUsiWd					(wMUsiWdSpi),
	.oMUsiAdrs					(wMUsiAdrsSpi),
	.oMUsiWEd					(wMUsiWCkeSpi),
	//
	.oSUsiRd					(),
	.oSUsiREd					(),
	//
	.iSUsiWd					(),
	.iSUsiAdrs					(),
	.iSUsiWCke					(),
	//
	.oMUfiWd					(),
	.oMUfiAdrs					(),
	.oMUfiWEd					(),
	.oMUfiWVd					(),
	//
	.oMUsiMonopoly				(wMUsiMonopoly),
	//
	.oMSpiIntr					(),
	//
	.iSysClk					(iSysClk),
	.iSysRst					(iSysRst)
);

always @(posedge iSysClk)
begin
	if (iSysRst)			rSend <= 'd0;
	else if (wMUsiWCkeSpi) 	rSend <= wMUsiWdSpi;
	else					rSend <= rSend;
	rMono <= wMUsiMonopoly;
end

OBUF LED0 (.O(oLed[0]), .I(rMono));
OBUF LED1 (.O(oLed[1]), .I(rSend[3]));
OBUF LED2 (.O(oLedB),   .I(rSend[0]));
OBUF LED3 (.O(oLedG),   .I(rSend[1]));
OBUF LED4 (.O(oLedR),   .I(rSend[2]));

endmodule