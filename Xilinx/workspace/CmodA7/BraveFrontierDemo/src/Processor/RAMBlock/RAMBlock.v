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
	parameter							pBusAdrsBit			= 32,
	parameter 							pCsrAdrsWidth	 	= 16,
	parameter							pCsrActiveWidth 	= 8,
	parameter							pUfiBusWidth		= 8,
	parameter							pUfiIdNumber		= 3,
	//
	parameter							pRamAdrsWidth		= 19,	// GPIO アドレス幅
	parameter							pRamDqWidth			= 8		// GPIO データ幅
)(
	// External Port
	output 	[pRamAdrsWidth-1:0]			oMemAdrs,
	inout	[pRamDqWidth-1:0]			ioMemDq,
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
	input	[pBusAdrsBit-1:0]			iSUfiAdrs,		// Ufi address
	input								iSUfiWEd,		// Adrs Enable
	input								iSUfiREd,		// Adrs Enable
	input   							iSUfiCmd,		// High Read, Low Write
	// Ufi Bus Slave Read
	output	[pUfiBusWidth-1:0]			oSUfiRd,		// Read Data
	output								oSUfiREd,		// Read Data Enable
	output 								oSUfiRdy,
	// Ufi ID Lssue
	input 	[pUfiIdNumber-1:0]			iSUfiIdI,
	output 	[pUfiIdNumber-1:0]			oSUfiIdO,
    // CLK Reset
    input           					iSysRst,
    input           					iSysClk,
	input 								iMemClk
);


//----------------------------------------------------------
// RAM Unit
//----------------------------------------------------------
localparam lpFifoDepath = 1024;

wire wRamDualFifoSrcRstCsr;
wire wRamDualFifoDstRstCsr;
reg [pUfiBusWidth-1:0]	qMemRdCsr;

RAMUnit #(
	.pUfiBusWidth		(pUfiBusWidth),
	.pBusAdrsBit		(pBusAdrsBit),
	.pUfiIdNumber		(pUfiIdNumber),
	.pRamFifoDepth		(lpFifoDepath),
	.pRamAdrsWidth		(pRamAdrsWidth),
	.pRamDqWidth		(pRamDqWidth)
) RamUnit (
	.oMemAdrs			(oMemAdrs),
	.ioMemDq			(ioMemDq),
	.oMemOE				(oMemOE),
	.oMemWE				(oMemWE),
	.oMemCE				(oMemCE),
	//
	.iSUfiWd			(iSUfiWd),
	.iSUfiAdrs			(iSUfiAdrs),
	.iSUfiWEd			(iSUfiWEd),
	.iSUfiREd			(iSUfiREd),
	.iSUfiCmd			(iSUfiCmd),
	.oSUfiRd			(oSUfiRd),
	.oSUfiREd			(oSUfiREd),
	.oSUfiRdy			(oSUfiRdy),
	//
	.iSUfiIdI			(iSUfiIdI),
	.oSUfiIdO			(oSUfiIdO),
	//
	.iRamDualFifoSrcRst	(wRamDualFifoSrcRstCsr),
	.iRamDualFifoDstRst	(wRamDualFifoDstRstCsr),
	//
	.iSysRst			(iSysRst),
	.iSysClk			(iSysClk),
	.iMemClk			(iMemClk)
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
	//
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	//
	.oRamDualFifoSrcRst	(wRamDualFifoSrcRstCsr),
	.oRamDualFifoDstRst	(wRamDualFifoDstRstCsr),
	//
	.iMemRd				(qMemRdCsr),
	//
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

always @*
begin
	qMemRdCsr <= oSUfiRd;
end

endmodule