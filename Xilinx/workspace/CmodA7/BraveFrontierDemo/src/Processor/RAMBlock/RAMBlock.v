//----------------------------------------------------------
// Create 2022/9/11
// Author koutakimura
// -
// 外部 RAM の管理を司るブロック
//----------------------------------------------------------
module RAMBlock #(
	// variable parameter
	parameter 							pBlockAdrsMap 		= 8,
	parameter [pBlockAdrsMap-1:0] 		pAdrsMap	  		= 'h06,
	parameter							pBusAdrsBit			= 16,
	parameter 							pCsrAdrsWidth	 	= 8,
	parameter							pCsrActiveWidth 	= 8,
	parameter							pUfiBusWidth		= 16,
	//
	parameter							pRamFifoDepth		= 16,
	parameter							pRamAdrsWidth		= 19,
	parameter							pRamDqWidth			= 8
)(
	// External Port
	output 	[18:0]						oMemAdrs,
	inout	[7:0]						ioMemDq,
	output 								oMemOE,			// Output Enable
	output 								oMemWE,			// Write Enable
	output 								oMemCE,			// Chip Select
    // Internal Port
	// Usi Bus Slave Read
	output	[31:0]						oSUsiRd,		// Read Data
	output								oSUsiREd,		// Read Data Enable
	// Usi Bus Slave Write
	input	[31:0]						iSUsiWd,		// Master Write Data
	input	[pBusAdrsBit-1:0]			iSUsiAdrs,		// Csr Access Adrs
	input								iSUsiWCke,		// Data Enable
	// Ufi Bus Slave Write
	input	[pUfiBusWidth-1:0]			iSUfiWd,		// Write Data
	input								iSUfiWEd,		// Write Data Enable
	// Ufi Bus Slave Read
	output	[pUfiBusWidth-1:0]			oSUfiRd,		// Read Data
	output								oSUfiREd,		// Read Data Enable
	//Ufi Bus Slave Common
	input	[pBusAdrsBit-1:0]			iSUfiAdrs,		// Ufi address
	input   							iSUfiCmd,		// High Read, Low Write
    // CLK Reset
    input           					iSysRst,
    input           					iSysClk,
	input 								iMemClk
);


//----------------------------------------------------------
// RAM Unit
//----------------------------------------------------------
wire [pRamAdrsWidth-1:0]	wMemAdrsCsr;
wire [pRamDqWidth-1:0]		wMemWdCsr;
wire 						wMemCECsr;
wire 						wMemCmdCsr;
wire [pRamDqWidth-1:0]		wMemRdCsr;

RAMUnit #(
	.pRamFifoDepth	(pRamFifoDepth),
	.pRamAdrsWidth	(pRamAdrsWidth),
	.pRamDqWidth	(pRamDqWidth)
) RamUnit (
	.oMemAdrs		(oMemAdrs),
	.ioMemDq		(ioMemDq),
	.oMemOE			(oMemOE),
	.oMemWE			(oMemWE),
	.oMemCE			(oMemCE),
	.iMemAdrs		(wMemAdrsCsr),
	.iMemWd			(wMemWdCsr),
	.iMemCE			(wMemCECsr),
	.iMemCmd		(wMemCmdCsr),
	.oMemRd			(wMemRdCsr),
	.iSysRst		(iSysRst),
	.iSysClk		(iSysClk),
	.iMemClk		(iMemClk)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
RAMCsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),	
	.pBusAdrsBit		(pBusAdrsBit),
	.pCsrAdrsWidth		(pCsrAdrsWidth),
	.pCsrActiveWidth	(pCsrActiveWidth),
	.pRamAdrsWidth		(pRamAdrsWidth),
	.pRamDqWidth		(pRamDqWidth)
) RamCsr (
	.oSUsiRd			(oSUsiRd),
	.oSUsiREd			(oSUsiREd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	.oMemAdrs			(wMemAdrsCsr),
	.oMemWd				(wMemWdCsr),
	.oMemCE				(wMemCECsr),
	.oMemCmd			(wMemCmdCsr),
	.iMemRd				(wMemRdCsr),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

endmodule