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
	parameter					pUsiBusWidth		= 32,
	parameter					pUfiIdNumber	= 3,
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
	input	[pUsiBusWidth-1:0]	iSUfiAdrs,		// Ufi address
	input						iSUfiWEd,		// Adrs Enable
	input						iSUfiREd,		// Adrs Enable
	input   					iSUfiCmd,		// High Read, Low Write
	output 						oSUfiRdy,		// Active Assert
	// Ufi Bus Slave Read
	output	[pUfiBusWidth-1:0]	oSUfiRd,		// Read Data
	output						oSUfiREd,		// Read Data Enable
	// Ufi ID Lssue
	input 	[pUfiIdNumber-1:0]	iSUfiIdI,
	output 	[pUfiIdNumber-1:0]	oSUfiIdO,
	//
	input 						iRamDualFifoSrcRst,
	input 						iRamDualFifoDstRst,
	//
    input						iSRST,
    input						iSCLK,
    input						iMemClk
);


//-----------------------------------------------------------------------------
// System Clk <-> Memory Clk
//-----------------------------------------------------------------------------
wire 	[pUfiBusWidth-1:0]	wMemWd;
wire 	[pRamAdrsWidth-1:0]	wMemAdrs;
wire 						wMemCmd;
wire 						wRVd;
wire 						wEmp;
reg 						qREd;
wire 						wFull;			assign oSUfiRdy = ~wFull;
//
wire 	[pUfiBusWidth-1:0]	wMemRdIf;
wire 						wMemREdIf;
wire 						wMemFull;

RAMDualClkFifo #(
	.pUfiIdNumber		(pUfiIdNumber),
	.pDualClkFifoDepth 	(pRamFifoDepth),
	.pRamDqWidth		(pRamDqWidth),
	.pRamAdrsWidth		(pRamAdrsWidth),
	.pFullAlMost		(16)
) RamDualClkFifo (
	.iWd				(iSUfiWd),
	.iAdrs				(iSUfiAdrs[pRamAdrsWidth-1:0]),
	.iCmd				(iSUfiCmd),
	.iWEd				(iSUfiWEd),
	.oFull				(wFull),
	.oWd				(wMemWd),
	.oAdrs				(wMemAdrs),
	.oCmd				(wMemCmd),
	.iREd				(qREd),
	.oEmp 				(wEmp),
	.oRVd				(wRVd),
	.iMemWd				(wMemRdIf),
	.iMemWEd			(wMemREdIf),
	.oMemRd				(oSUfiRd),
	.oMemREd			(oSUfiREd),
	.iMemRe				(iSUfiREd),
	.oMemFull 			(wMemFull),
	.iSUfiIdI			(iSUfiIdI),
	.oSUfiIdO			(oSUfiIdO),
	.iSrcRst			(iRamDualFifoSrcRst),
	.iDstRst			(iRamDualFifoDstRst),
	.iSCLK			(iSCLK),
	.iMemClk			(iMemClk)
);

always @*
begin
	// Read アクセス時は、読み出し元の Block の速度によっては
	// FIFO にデータが蓄積されていくため、両方の状態で Ram にデータを転送するか判断する
	qREd <= (~wEmp) & (~wMemFull);
end


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
	.oRd			(wMemRdIf),
	.oREd			(wMemREdIf),
	//
	.iRST			(iSRST),
	.iMemClk		(iMemClk)
);


endmodule