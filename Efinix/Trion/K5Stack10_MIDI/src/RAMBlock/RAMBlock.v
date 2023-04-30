/*-----------------------------------------------------------------------------
 * Create  2023/4/28
 * Author  koutakimura
 * -
 * 外部 RAM の制御を行う module
 * V1.0 : new Relaese
 * 
 *-----------------------------------------------------------------------------*/
module RAMBlock #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0]	pAdrsMap = 'h04,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 16,
	parameter pCsrActiveWidth = 8,
	// parameter pUfiBusWidth = 8,
	// parameter pUfiIdNumber = 3,
	parameter pRamAdrsWidth = 16,	// GPIO アドレス幅
	parameter pRamDqWidth = 16		// GPIO データ幅
)(
	// SRAM I/F Port
	output [pRamAdrsWidth-1:0] oSRAMA,
	output [pRamDqWidth-1:0] oSRAMD,
	input  [pRamDqWidth-1:0] iSRAMD,
	output oSRAM_LB,	// N Lower Byte Control
	output oSRAM_UB,	// N Upper Byte Control
	output oSRAM_OE,	// N Output Enable
	output oSRAM_WE,	// N Write Enable
	output oSRAM_CE,	// N Chip Select 
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
	// Ufi Bus Slave Write
	// input	[pUfiBusWidth-1:0]			iSUfiWd,		// Write Data
	// input	[pUsiBusWidth-1:0]			iSUfiAdrs,		// Ufi address
	// input								iSUfiWEd,		// Adrs Enable
	// input								iSUfiREd,		// Adrs Enable
	// input   							iSUfiCmd,		// High Read, Low Write
	// Ufi Bus Slave Read
	// output	[pUfiBusWidth-1:0]			oSUfiRd,		// Read Data
	// output								oSUfiREd,		// Read Data Enable
	// output 								oSUfiRdy,
	// // Ufi ID Lssue
	// input 	[pUfiIdNumber-1:0]			iSUfiIdI,
	// output 	[pUfiIdNumber-1:0]			oSUfiIdO,
	// Status
	output oTestErr,
	output oDone,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);



//-----------------------------------------------------------------------------
// Csr space
//-----------------------------------------------------------------------------
wire wCsrRamRst;
reg  [pRamDqWidth-1:0] qMemRdCsr;

RAMCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),	
	.pUsiBusWidth(pUsiBusWidth),			
	.pCsrAdrsWidth(pCsrAdrsWidth),			.pCsrActiveWidth(pCsrActiveWidth),
	.pRamAdrsWidth(pRamAdrsWidth),			.pRamDqWidth(pRamDqWidth)
) RamCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// CSR
	.oRamRst(wCsrRamRst),
	.iMemRd(qMemRdCsr),
	// CLK Reset
	.iSRST(iSRST),
	.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// System Clk <-> Memory Clk
//-----------------------------------------------------------------------------
// wire 	[pUfiBusWidth-1:0]	wMemWd;
// wire 	[pRamAdrsWidth-1:0]	wMemAdrs;
// wire 						wMemCmd;
// wire 						wRVd;
// wire 						wEmp;
// reg 						qREd;
// wire 						wFull;			assign oSUfiRdy = ~wFull;
// //
// wire 	[pUfiBusWidth-1:0]	wMemRdIf;
// wire 						wMemREdIf;
// wire 						wMemFull;

// RAMDualClkFifo #(
// 	.pUfiIdNumber		(pUfiIdNumber),
// 	.pDualClkFifoDepth 	(pRamFifoDepth),
// 	.pRamDqWidth		(pRamDqWidth),
// 	.pRamAdrsWidth		(pRamAdrsWidth),
// 	.pFullAlMost		(16)
// ) RamDualClkFifo (
// 	.iWd				(iSUfiWd),
// 	.iAdrs				(iSUfiAdrs[pRamAdrsWidth-1:0]),
// 	.iCmd				(iSUfiCmd),
// 	.iWEd				(iSUfiWEd),
// 	.oFull				(wFull),
// 	.oWd				(wMemWd),
// 	.oAdrs				(wMemAdrs),
// 	.oCmd				(wMemCmd),
// 	.iREd				(qREd),
// 	.oEmp 				(wEmp),
// 	.oRVd				(wRVd),
// 	.iMemWd				(wMemRdIf),
// 	.iMemWEd			(wMemREdIf),
// 	.oMemRd				(oSUfiRd),
// 	.oMemREd			(oSUfiREd),
// 	.iMemRe				(iSUfiREd),
// 	.oMemFull 			(wMemFull),
// 	.iSUfiIdI			(iSUfiIdI),
// 	.oSUfiIdO			(oSUfiIdO),
// 	.iSrcRst			(iRamDualFifoSrcRst),
// 	.iDstRst			(iRamDualFifoDstRst),
// 	.iSCLK			(iSCLK),
// 	.iMemClk			(iMemClk)
// );

// always @*
// begin
// 	// Read アクセス時は、読み出し元の Block の速度によっては
// 	// FIFO にデータが蓄積されていくため、両方の状態で Ram にデータを転送するか判断する
// 	qREd <= (~wEmp) & (~wMemFull);
// end


//-----------------------------------------------------------------------------
// Read Write Tester
//-----------------------------------------------------------------------------
wire [pRamAdrsWidth-1:0] wAdrs;
wire [pRamDqWidth-1:0] wWd, wRd;
wire wCmd, wCe;
wire wREd;

MemoryReadWriteTester #(
	.pRamAdrsWidth(pRamAdrsWidth),
	.pRamDqWidth(pRamDqWidth)
) MemoryReadWriteTester (
	// R/W Signal
	.oAdrs(wAdrs),	.oWd(wWd),
	.oCmd(wCmd),	.oCe(wCe),
	.iRd(wRd),		.iREd(wREd),
	// Status
	.oErr(oTestErr),.oDone(oDone),
	// CLK Reset
    .iRST(iSRST),	.iCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// RAM I/F
//-----------------------------------------------------------------------------
reg qRamIfPortUnitCke;

RAMIfPortUnit #(
	.pRamAdrsWidth(pRamAdrsWidth),
	.pRamDqWidth(pRamDqWidth)
) RAMIfPortUnit (
	// SRAM I/F Port
	.oSRAMA(oSRAMA),		.oSRAMD(oSRAMD),
	.iSRAMD(iSRAMD),
	.oSRAM_LB(oSRAM_LB),	.oSRAM_UB(oSRAM_UB),
	.oSRAM_OE(oSRAM_OE),	.oSRAM_WE(oSRAM_WE),
	.oSRAM_CE(oSRAM_CE),
	//
	.iAdrs(wAdrs),	.iWd(wWd),
	.oRd(wRd),		.oREd(wREd),
	.iCmd(wCmd),
	// CLK Reset
	.iRST(iSRST),	.iCKE(qRamIfPortUnitCke),
	.iCLK(iSCLK)
);

always @*
begin
	qRamIfPortUnitCke <= ~wCe;
end

endmodule