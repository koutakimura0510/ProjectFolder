//----------------------------------------------------------
// Create 2022/9/11
// Author koutakimura
// -
// RAMの制御を司るユニット
// 
//----------------------------------------------------------
module RAMUnit #(
	// variable parameter
	parameter					pUfiBusWidth	= 16,
	parameter					pBusAdrsBit		= 32,
	parameter					pRamFifoDepth	= 16,
	parameter					pRamDqWidth		= 8,
	parameter					pRamAdrsWidth	= 19
)(
	// External Port
	inout	[pRamDqWidth-1:0]	ioMemDq,
	output 	[pRamAdrsWidth-1:0]	oMemAdrs,
	output 						oMemOE,			// Output Enable
	output 						oMemWE,			// Write Enable
	output 						oMemCE,			// Chip Select
	// Ufi Bus Slave Write
	input	[pUfiBusWidth-1:0]	iSUfiWd,		// Write Data
	input	[pBusAdrsBit-1:0]	iSUfiAdrs,		// Ufi address
	input   					iSUfiCmd,		// High Read, Low Write
	input						iSUfiEd,		// Adrs Enable
	output 						oSUfiRdy,		// Active Assert
	// Ufi Bus Slave Read
	output	[pUfiBusWidth-1:0]	oSUfiRd,		// Read Data
	output						oSUfiREd,		// Read Data Enable
	//
    input						iSysRst,
    input						iSysClk,
    input						iMemClk
);


//-----------------------------------------------------------------------------
// System Clk <-> Memory Clk
//-----------------------------------------------------------------------------
wire [pUfiBusWidth-1:0]	wMemWd;
wire [pRamAdrsWidth-1:0]wMemAdrs;
wire 					wMemCmd;
wire 					wRVd;
wire 					wEmp;
wire 					wFull;					assign oSUfiRdy = ~wFull;

RAMDualClkFifo #(
	.pDualClkFifoDepth 	(pRamFifoDepth),
	.pRamDqWidth		(pRamDqWidth),
	.pRamAdrsWidth		(pRamAdrsWidth)
) RamDualClkFifo (
	.iWd				(iSUfiWd),
	.iAdrs				(iSUfiAdrs[pRamAdrsWidth-1:0]),
	.iCmd				(iSUfiCmd),
	.iWEd				(iSUfiEd),
	.oFull				(wFull),
	.oWd				(wMemWd),
	.oAdrs				(wMemAdrs),
	.oCmd				(wMemCmd),
	.iREd				(~wEmp),
	.oEmp 				(wEmp),
	.oRVd				(wRVd),
	.iRst				(iSysRst),
	.iSysClk			(iSysClk),
	.iMemClk			(iMemClk)
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
	.iWd			(wMemWd),
	.iAdrs			(wMemAdrs),
	.iCE			(~wRVd),
	.iCmd			(wMemCmd),
	.oRd			(oSUfiRd),
	.oREd			(oSUfiREd),
	//
	.iRst			(iSysRst),
	.iMemClk		(iMemClk)
);


endmodule