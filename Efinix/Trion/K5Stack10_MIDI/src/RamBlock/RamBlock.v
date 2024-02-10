/*-----------------------------------------------------------------------------
 * Create  2023/4/28
 * Author  koutakimura
 * -
 * 外部 RAM の制御を行う module
 * V1.0 : new Relaese
 * 
 *-----------------------------------------------------------------------------*/
module RamBlock #(
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
	parameter pRamDqWidth 		= 16,	// GPIO データ幅
	//
	parameter pDevConfIntGen	= "no"
)(
	// SRAM I/F Port
	output	[pRamDqWidth-1:0] 		oRamDq,
	input	[pRamDqWidth-1:0] 		iRamDq,
	output	[1:0]					oRamDq_Oe,				// "0" In, "1" Out
	output	[1:0]					oRamClk,
	output	[1:0]					oRamCe,
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
reg  [pRamDqWidth-1:0] qMemRdCsr;

wire [7:0]	wCfgCmdCsr;
wire		wCfgEnCsr;
wire		wCfgRstCsr;
wire		wCfgDoneCsr;

reg  [15:0] qHdcCapDqCsr;
wire [15:0] wHdcWDqCsr;
wire [47:0] wHdcCmdAdrsCsr;
wire [ 3:0] wHdcLatencyCntCsr;
wire 		wHdcRwCmdCsr;
wire 		wHdcSeqEnCsr;
reg  		qHdcDoneCsr;

RamCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),	
	.pUsiBusWidth(pUsiBusWidth),			
	.pCsrAdrsWidth(pCsrAdrsWidth),			.pCsrActiveWidth(pCsrActiveWidth),
	.pRamAdrsWidth(pRamAdrsWidth),			.pRamDqWidth(pRamDqWidth)
) RamCsr (
	// Ufi Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Ufi Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// Csr Device Config
	.oCfgCmd(wCfgCmdCsr),	.oCfgEn(wCfgEnCsr),
	.oCfgRst(wCfgRstCsr),	.iCfgDone(wCfgDoneCsr),
	// Csr Memory Common
	.iMemRd(qMemRdCsr),
	// Csr Device Config
	.iHdcCapDq(qHdcCapDqCsr),
	.oHdcWDq(wHdcWDqCsr),					.oHdcCmdAdrs(wHdcCmdAdrsCsr),
	.oHdciLatencyCnt(wHdcLatencyCntCsr),	.oHdcRwCmd(wHdcRwCmdCsr),
	.oHdcSeqEn(wHdcSeqEnCsr),				.iHdcDone(qHdcDoneCsr),
	// common
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


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
	.iRST(iSRST),	.inARST(inSRST),	.iCLK(iSCLK)
);

/**----------------------------------------------------------------------------
 * Mcu Memory Access
 *---------------------------------------------------------------------------*/


/**----------------------------------------------------------------------------
 * Device Configration
 *---------------------------------------------------------------------------*/
wire [15:0] wCfgDq;
wire wCfgClk;
wire wCfgCs;
wire wCfgEn;

DeviceCfg DeviceCfg (
	// Ram port
	.oCfgDq(wCfgDq),		.oCfgClk(wCfgClk),
	.oCfgCs(wCfgCs),		.oCfgEn(wCfgEn),
	// control
	.iCfgCmd(wCfgCmdCsr),	.iCfgEn(wCfgEnCsr),
	.oCfgDone(wCfgDoneCsr),
	// common
	.iRST(wCfgRstCsr),		.iCKE(),	.iCLK(iSCLK)
);


/**----------------------------------------------------------------------------
 * Memory Tester
 *---------------------------------------------------------------------------*/
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

/**----------------------------------------------------------------------------
 * Ram If Port Unit
 *---------------------------------------------------------------------------*/
reg [pRamDqWidth-1:0] 	qRamIfPortUnitWd;
reg [pRamAdrsWidth-1:0] qRamIfPortUnitAdrs;
reg  					qRamIfPortUnitCmd;
reg  					qRamIfPortUnitCke;
	
RAMIfPortUnit #(
	.pRamDqWidth(pRamDqWidth)
) RAMIfPortUnit (
	// RAM I/F Port
	.oRamDq(oRamDq),
	.iRamDq(iRamDq),
	.oRamDq_OE(oRamDq_Oe),
	.oRamClk(oRamClk),
	.oRamCe(oRamCe),
	// Config Port
	.iCfgDq(wCfgDq),
	.iCfgClk(wCfgClk),
	.iCfgCs(wCfgCs),
	.iCfgEn(wCfgEn),
	// CLK Reset
	.iRST(iSRST),
	.iCKE(),
	.iCLK(iSCLK)
);


endmodule