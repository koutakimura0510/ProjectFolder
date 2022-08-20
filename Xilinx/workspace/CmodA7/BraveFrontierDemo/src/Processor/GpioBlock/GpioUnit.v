//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// GPIO ポートの制御を司るユニット
// 
//----------------------------------------------------------
module GpioUnit (
	// Internal Port
	output [1:0] 			oSftEdge,
	output 					oSftClk,
	input  [7:0]			iGpioLed,
	input  [7:0]			iGpioDiv,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// 外部シフトレジスタ操作
//----------------------------------------------------------
LedSftReg LedSftReg (
	.oSftEdge	(oSftEdge),
	.oSftClk	(oSftClk),
	.iGpioLed	(iGpioLed),
	.iGpioDiv	(iGpioDiv),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);

endmodule