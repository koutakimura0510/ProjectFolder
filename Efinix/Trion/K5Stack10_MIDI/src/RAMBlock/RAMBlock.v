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
	//
	parameter pRamAdrsWidth 	= 18,	// GPIO アドレス幅
	parameter pRamDqWidth 		= 16	// GPIO データ幅
)(
	// SRAM I/F Port
	output [pRamDqWidth-1:0] 		oSRAMD,
	input  [pRamDqWidth-1:0] 		iSRAMD,
	output 							oSRAMD_OE,				// "0" In, "1" Out
	output 							oSRAM_RWDS,
	input 							iSRAM_RWDS,
	output 							oSRAM_RWDS_OE,
	output 							oSRAM_pCLK,
	output 							oSRAM_nCLK,
	output 							oSRAM_nCE,
	output 							oSRAM_nRST,
	// Bus Master Read
	output [pUsiBusWidth-1:0] 		oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] 		iSUsiWd,
	input  [pUsiBusWidth-1:0] 		iSUsiAdrs,
	// Ufi Bus Master Read
	output [pUfiDqBusWidth-1:0] 	oSUfiRd,
	output [pUfiAdrsBusWidth-1:0] 	oSUfiAdrs,
	// Ufi Bus Master Write
	input  [pUfiDqBusWidth-1:0] 	iSUfiWd,
	input  [pUfiAdrsBusWidth-1:0] 	iSUfiAdrs,
	output							oSUfiRdy,
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

reg  [15:0] qHdcCapDqCsr;
wire [15:0] wHdcWDqCsr;
wire [47:0] wHdcCmdAdrsCsr;
wire 		wHdcRwCmdCsr;
wire 		wHdcSeqEnCsr;
reg  		qHdcDoneCsr;

RAMCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),	
	.pUsiBusWidth(pUsiBusWidth),			
	.pCsrAdrsWidth(pCsrAdrsWidth),			.pCsrActiveWidth(pCsrActiveWidth),
	.pRamAdrsWidth(pRamAdrsWidth),			.pRamDqWidth(pRamDqWidth)
) RamCsr (
	// Ufi Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Ufi Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// Csr Memory Common
	.oRamRst(wCsrRamRst),
	.iMemRd(qMemRdCsr),
	// Csr Device Config
	.iHdcCapDq(qHdcCapDqCsr),
	.oHdcWDq(wHdcWDqCsr),
	.oHdcCmdAdrs(wHdcCmdAdrsCsr),
	.oHdcRwCmd(wHdcRwCmdCsr),
	.oHdcSeqEn(wHdcSeqEnCsr),
	.iHdcDone(qHdcDoneCsr),
	// common
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
localparam lpFifoDepth = 256;	// FIFO 最小構成

wire [pUfiDqBusWidth-1:0] 	wRamIfPortUnitWd;
wire [pUfiAdrsBusWidth-1:0] wRamIfPortUnitAdrs;
wire [pUfiDqBusWidth-1:0] 	wRamIfPortUnitRd;
wire 						wRamIfPortUnitRvd;

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
wire [ 7:0] wMemDq;					assign oSRAMD 		= wMemDq;
wire 		wMemDqOe;				assign oSRAMD_OE 	= wMemDqOe;
wire 		wMemRwds;				assign oSRAM_RWDS	= wMemRwds;
wire 		wMemRwdsOe;				assign oSRAM_RWDS_OE= wMemRwdsOe;
wire 		wMemClk;				assign oSRAM_pCLK	= wMemClk;
									assign oSRAM_nCLK	= ~wMemClk;
wire 		wMemCs;					assign oSRAM_nCE	= wMemCs;
									assign oSRAM_nRST	= inSRST;
//
reg [pRamDqWidth-1:0]	qHdcMemDq;
reg [15:0]				wHdcCapDq;
reg [15:0]				qHdcWDq;
reg [47:0]				qHdcCmdAdrs;
reg 					qHdcRwCmd;
reg 					qHdcSeqEn;
wire 					wHdcDone;

HyperRamDeviceConfig HyperRamDeviceConfig (
	// memory I/F for write side
	.oMemDq(wMemDq),		.oMemDqOe(wMemDqOe),
	.oMemRwds(wMemRwds),	.oMemRwdsOe(wMemRwdsOe),
	.oMemClk(wMemClk),		.oMemCs(wMemCs),
	// memory I/F for read side
	.iMemDq(qHdcMemDq),
	// internal data
	.oCapDq(wHdcCapDq),
	.iWDq(qHdcWDq),			.iCmdAdrs(qHdcCmdAdrs),
	// control status
	.iRwCmd(qHdcRwCmd),		.iSeqEn(qHdcSeqEn),
	.oDone(wHdcDone),
	// clk common
	.iRST(iSRST),			.iCKE(1'b0),	.iCLK(iSCLK)
);

always @*
begin
	qHdcMemDq 	<= iSRAMD;
	qHdcCapDqCsr<= wHdcCapDq;
	qHdcWDq		<= wHdcWDqCsr;
	qHdcCmdAdrs	<= wHdcCmdAdrsCsr;
	
	qHdcRwCmd	<= wHdcRwCmdCsr;
	qHdcSeqEn	<= wHdcSeqEnCsr;
	qHdcDoneCsr	<= wHdcDone;
	
	// qRamIfPortUnitWd	<= wRamIfPortUnitWd;
	// qRamIfPortUnitAdrs 	<= wRamIfPortUnitAdrs[pRamAdrsWidth-1:0];
	// qRamIfPortUnitCmd 	<= wRamIfPortUnitAdrs[30];
	// qRamIfPortUnitCke 	<= wRamIfPortUnitAdrs[pUfiEnableBit-1];
end
// reg [pRamDqWidth-1:0] 	qRamIfPortUnitWd;
// reg [pRamAdrsWidth-1:0] qRamIfPortUnitAdrs;
// reg  					qRamIfPortUnitCmd;
// reg  					qRamIfPortUnitCke;
	
// RAMIfPortUnit #(
// 	.pRamAdrsWidth(pRamAdrsWidth),
// 	.pRamDqWidth(pRamDqWidth)
// ) RAMIfPortUnit (
// 	// SRAM I/F Port
// 	.oSRAMD(oSRAMD),			.iSRAMD(iSRAMD),
// 	.oSRAMD_OE(oSRAMD_OE),
// 	.oSRAM_RWDS(oSRAM_RWDS),	.iSRAM_RWDS(iSRAM_RWDS),
// 	.oSRAM_RWDS_OE(oSRAM_RWDS_OE),
// 	.oSRAM_pCLK(oSRAM_pCLK),	.oSRAM_nCLK(oSRAM_nCLK),
// 	.oSRAM_nCE(oSRAM_nCE),		.oSRAM_nRST(oSRAM_nRST),
// 	//
// 	.iAdrs(qRamIfPortUnitAdrs),
// 	.iCmd(qRamIfPortUnitCmd),
// 	.iWd(qRamIfPortUnitWd),
// 	.oRd(wRamIfPortUnitRd),
// 	.oRvd(wRamIfPortUnitRvd),
// 	// CLK Reset
// 	.iRST(iSRST),
// 	.iCKE(qRamIfPortUnitCke),
// 	.iCLK(iSCLK)
// );


endmodule