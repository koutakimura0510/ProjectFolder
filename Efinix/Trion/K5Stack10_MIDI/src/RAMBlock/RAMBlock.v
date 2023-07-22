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
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth 	= 16,
	parameter pCsrActiveWidth 	= 8,
	parameter pUfiDqBusWidth 	= 16,
	parameter pUfiAdrsBusWidth 	= 32,
	parameter pUfiEnableBit 	= 32,
	parameter pRamAdrsWidth 	= 18,	// GPIO アドレス幅
	parameter pRamDqWidth 		= 16	// GPIO データ幅
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
	// Ufi Bus Master Read
	output [pUfiDqBusWidth-1:0] 	oSUfiRd,
	output [pUfiAdrsBusWidth-1:0] 	oSUfiAdrs,
	// Ufi Bus Master Write
	input  [pUfiDqBusWidth-1:0] 	iSUfiWd,
	input  [pUfiAdrsBusWidth-1:0] 	iSUfiAdrs,
	output 							oSUfiRdy,
	// Status
	output oTestErr,
	output oDone,
    // CLK Reset
    input  iSRST,
	input  inSRST,
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
// Read Write Tester
//-----------------------------------------------------------------------------
// wire [31:0] wMemTesterAdrs;
// wire [pRamDqWidth-1:0] wMemTesterWd, wMemTesterRd;
// wire wMemTesterWEd;
// wire [31:0] wMemTesterREd;

// MemoryReadWriteTester #(
// 	.pRamAdrsWidth(pRamAdrsWidth),
// 	.pRamDqWidth(pRamDqWidth)
// ) MemoryReadWriteTester (
// 	// R/W Signal
// 	.oAdrs(wMemTesterAdrs),
// 	.oWd(wMemTesterWd),
// 	.iWEd(wMemTesterWEd),
// 	.iRd(wMemTesterRd),
// 	.iREd(wMemTesterREd[31]),
// 	// Status
// 	.oErr(oTestErr),.oDone(oDone),
// 	// CLK Reset
//     .iRST(iSRST),	.iCLK(iSCLK)
// );

assign oTestErr = 1'b0;
assign oDone = 1'b0;

//-----------------------------------------------------------------------------
// Fifo Read Write Tester
//-----------------------------------------------------------------------------
localparam lpFifoDepth = 256;

wire [pUfiDqBusWidth-1:0] wRamIfPortUnitWd;
wire [pUfiAdrsBusWidth-1:0] wRamIfPortUnitAdrs;
wire [pUfiDqBusWidth-1:0] wRamIfPortUnitRd;
wire wRamIfPortUnitRvd;

RamReadWriteArbiter #(
	.pUfiDqBusWidth(pUfiDqBusWidth),
	.pUfiAdrsBusWidth(pUfiAdrsBusWidth),
	.pFifoDepth(lpFifoDepth),
	.pUfiEnableBit(pUfiEnableBit)
) RamReadWriteArbiter (
	// Ufi Write
	.iSUfiWd(iSUfiWd),
	.iSUfiAdrs(iSUfiAdrs),
	.oSUfiRdy(oSUfiRdy),
	// UFI Read
	.oSUfiRd(oSUfiRd),
	.oSUfiAdrs(oSUfiAdrs),
	// RamIfPort Bridge
	.oRamIfPortUnitWd(wRamIfPortUnitWd),
	.oRamIfPortUnitAdrs(wRamIfPortUnitAdrs),
	.iRamIfPortUnitDq(wRamIfPortUnitRd),
	.iRamIfPortUnitWe(wRamIfPortUnitRvd),
	// common
	.iRST(iSRST),
	.inARST(inSRST),
	.iCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// RAM I/F
//-----------------------------------------------------------------------------
reg [pRamDqWidth-1:0] qRamIfPortUnitWd;
reg [pRamAdrsWidth-1:0] qRamIfPortUnitAdrs;
reg  qRamIfPortUnitCmd;
reg  qRamIfPortUnitCke;

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
	.iAdrs(qRamIfPortUnitAdrs),
	.iCmd(qRamIfPortUnitCmd),
	.iWd(qRamIfPortUnitWd),
	.oRd(wRamIfPortUnitRd),
	.oRvd(wRamIfPortUnitRvd),
	// CLK Reset
	.iRST(iSRST),
	.iCKE(qRamIfPortUnitCke),
	.iCLK(iSCLK)
);

always @*
begin
	qRamIfPortUnitWd	<= wRamIfPortUnitWd;
	qRamIfPortUnitAdrs 	<= wRamIfPortUnitAdrs[pRamAdrsWidth-1:0];
	qRamIfPortUnitCmd 	<= wRamIfPortUnitAdrs[30];
	qRamIfPortUnitCke 	<= wRamIfPortUnitAdrs[pUfiEnableBit-1];
end

endmodule