//----------------------------------------------------------
// Create 2022/8/21
// Author koutakimura
// -
// CPU システムの管理を司るモジュール
//----------------------------------------------------------
module Processer (
    // External port
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
reg rLed;
wire wCke;

always @(posedge iSysClk)
begin
	if (iSysRst) 	rLed <= 1'b0;
	else if (wCke)	rLed <= ~rLed;
	else 			rLed <= rLed;
end

CkeGenerator #(
	.pDivReg	("yes"),
	.pDivWidth	(32)
) CKEGEN (
	.iDiv		('d12000000),
	.iCke		(1'b1),
	.oCke		(wCke),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);

OBUF TEST1 (.O(oTestPort[0]), .I(rLed));
OBUF TEST2 (.O(oTestPort[1]), .I(rLed));
// OBUF TEST3 (.O(oTestPort[2]), .I(ioSpiMosi));
// OBUF TEST4 (.O(oTestPort[3]), .I(ioSpiCs));

OBUF LED0 (.O(oLed[0]), .I(rLed));
OBUF LED1 (.O(oLed[1]), .I(rLed));
OBUF LED2 (.O(oLedB),   .I(rLed));
OBUF LED3 (.O(oLedG),   .I(rLed));
OBUF LED4 (.O(oLedR),   .I(rLed));

endmodule