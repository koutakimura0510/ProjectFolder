/**-----------------------------------------------------------------------------
 * 23-04-28 v1.00: new release
 * 24-02-10 v2.00: ESP PSRAM に対応
 * 
 * ESP PSRAM
 * default setting, 1page =  CA[9:0] 1024byte linear burst wrap / page をまたぐ際は最大周波数 84MHz
 * 64Mbit = A[22:0]
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
wire [7:0]	wCfgCmdCsr;
wire		wCfgEnCsr;
wire		wCfgRstCsr;
wire		wCfgDoneCsr;

wire					wMatEnCsr;
wire					wMatRstCsr;
wire					wMatDoneCsr;
wire [pRamDqWidth-1:0]	wMatMemWdCsr;
wire					wMatMemWdOeCsr;
wire [7:0]				wMatMemWaCsr;
wire					wMatMemWeCsr;
wire [pRamDqWidth-1:0]	wMatMemRdCsr;
wire [7:0]				wMatMemRaCsr;


RamCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),	
	.pUsiBusWidth(pUsiBusWidth),			
	.pCsrAdrsWidth(pCsrAdrsWidth),			.pCsrActiveWidth(pCsrActiveWidth),
	.pRamDqWidth(pRamDqWidth)
) RamCsr (
	// Ufi Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Ufi Bus Master Write
	.iSUsiWd(iSUsiWd),			.iSUsiAdrs(iSUsiAdrs),
	// Csr Device Config
	.oCfgCmd(wCfgCmdCsr),		.oCfgEn(wCfgEnCsr),
	.oCfgRst(wCfgRstCsr),		.iCfgDone(wCfgDoneCsr),
	// Csr Memory Access Tester
	.oMatEn(wMatEnCsr),			.oMatRst(wMatRstCsr),		.iMatDone(wMatDoneCsr),
	.oMatMemWd(wMatMemWdCsr),	.oMatMemWdOe(wMatMemWdOeCsr),	.oMatMemWa(wMatMemWaCsr),	.oMatMemWe(wMatMemWeCsr),
	.iMatMemRd(wMatMemRdCsr),	.oMatMemRa(wMatMemRaCsr),
	// common
	.iSRST(iSRST),				.iSCLK(iSCLK)
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
wire [pRamDqWidth-1:0] 	wMatDq;
wire 					wMatClk;
wire 					wMatCs;
wire 					wMatOe;
wire 					wMatEn;
reg  [pRamDqWidth-1:0] 	qMatRd;
reg  					qMatRe;


MemoryAccessTester #(
	.pRamDqWidth(pRamDqWidth)
) MemoryAccessTester (
	// Test Write Port
	.oTestDq(wMatDq),			.oTestClk(wMatClk),
	.oTestCs(wMatCs),			.oTestOe(wMatOe),
	// Test Read Port
	.iTestRd(qMatRd),			.iTestRe(qMatRe),
	// Control, Status
	.oTestEn(wMatEn),			.oTestErr(),
	.oTestDone(wMatDoneCsr),	.iTestEn(wMatEnCsr),
	// Memory Access
	.iMemWd(wMatMemWdCsr),		.iMemWdOe(wMatMemWdOeCsr),
	.iMemWa(wMatMemWaCsr),		.iMemWe(wMatMemWeCsr),
	.oMemRd(wMatMemRdCsr),		.iMemRa(wMatMemRaCsr),
	// CLK Reset
    .iRST(wMatRstCsr),			.iCLK(iSCLK)
);

assign oTestErr	= 1'b0;
assign oDone	= 1'b0;

/**----------------------------------------------------------------------------
 * Ram If Port Unit
 *---------------------------------------------------------------------------*/
wire [pRamDqWidth-1:0] 	wRamRd;
wire 					wRamRe;
	
RAMIfPortUnit #(
	.pRamDqWidth(pRamDqWidth)
) RAMIfPortUnit (
	// RAM I/F Port
	.oRamDq(oRamDq),		.iRamDq(iRamDq),	.oRamDq_OE(oRamDq_Oe),
	.oRamClk(oRamClk),		.oRamCe(oRamCe),
	// Memory Config Port
	.iCfgDq(wCfgDq),		.iCfgClk(wCfgClk),
	.iCfgCs(wCfgCs),		.iCfgEn(wCfgEn),
	// Memory Test Write Port
	.iTestDq(wMatDq),		.iTestClk(wMatClk),
	.iTestCs(wMatCs),		.iTestOe(wMatOe),
	.iTestEn(wMatEn),
	// Memory Test Read Port
	.oRamRd(wRamRd),		.oRamRe(wRamRe),
	// CLK Reset
	.iRST(iSRST),
	.iCKE(),
	.iCLK(iSCLK)
);

always @*
begin
	qMatRd	<= wRamRd;
	qMatRe	<= wRamRe;
end

endmodule