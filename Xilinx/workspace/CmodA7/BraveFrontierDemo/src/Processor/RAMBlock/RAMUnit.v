//----------------------------------------------------------
// Create 2022/9/11
// Author koutakimura
// -
// RAMの制御を司るユニット
// 
//----------------------------------------------------------
module RAMUnit #(
	// variable parameter
	parameter		pRamFifoDepth	= 16,
	parameter		pRamAdrsWidth	= 19,
	parameter		pRamDqWidth		= 8
)(
	// External Port
	output 	[pRamAdrsWidth-1:0]	oMemAdrs,
	inout	[pRamDqWidth-1:0]	ioMemDq,
	output 						oMemOE,			// Output Enable
	output 						oMemWE,			// Write Enable
	output 						oMemCE,			// Chip Select
	//
	input	[pRamAdrsWidth-1:0]	iMemAdrs,
	input	[pRamDqWidth-1:0]	iMemWd,
	input						iMemCE,
	input						iMemCmd,
	output 	[pRamDqWidth-1:0]	oMemRd,
    // Internal Port
    input						iSysRst,
    input						iSysClk,
    input						iMemClk
);




//-----------------------------------------------------------------------------
// RAM I/F
//-----------------------------------------------------------------------------
RAMIf #(
	.pRamAdrsWidth	(pRamAdrsWidth),
	.pRamDqWidth	(pRamDqWidth)
) RamIf (
	.oMemAdrs		(oMemAdrs),
	.ioMemDq		(ioMemDq),
	.oMemOE			(oMemOE),
	.oMemWE			(oMemWE),
	.oMemCE			(oMemCE),
	//
	.iAdrs			(iMemAdrs),
	.iWd			(iMemWd),
	.oRd			(oMemRd),
	.oRVd			(oMemRVd),
	.iCE			(iMemCE),
	.iCmd			(iMemCmd),
	//
	.iRst			(iSysRst),
	.iClk			(iMemClk)
);


endmodule