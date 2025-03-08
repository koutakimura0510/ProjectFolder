/**-----------------------------------------------------------------------------
 * 23-04-28 v1.00: new release
 * 24-02-10 v2.00: ESP PSRAM に対応
 * 
 * ESP PSRAM
 * default setting, 1page =  CA[9:0] 1024byte linear burst wrap / page をまたぐ際は最大周波数 84MHz
 * CA[4:0] 32byte wrap burst mode
 * 64Mbit = A[22:0]
 *-----------------------------------------------------------------------------*/
module RamBlock #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0]	pAdrsMap = 'h04,
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth 	= 16,
	parameter pCsrActiveWidth 	= 8,
	parameter pUfiBusWidth		= 48,
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
	output [pUfiBusWidth-1:0] 		oSUfiRd,
	output 							oSUfiVd,
	// Ufi Bus Master Write
	input  [pUfiBusWidth-1:0] 		iSUfiWd,
	output							oSUfiRdy,
	// Status
	output 							oTestErr,
	output 							oDone,
    // CLK Reset
    input  							iSRST,
	input  							inSRST,
    input  							iSCLK
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
wire [7:0]				wMemClkDivCsr;


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
	.oMatEn(wMatEnCsr),			.oMatRst(wMatRstCsr),			.iMatDone(wMatDoneCsr),
	.oMatMemWd(wMatMemWdCsr),	.oMatMemWdOe(wMatMemWdOeCsr),	.oMatMemWa(wMatMemWaCsr),	.oMatMemWe(wMatMemWeCsr),
	.iMatMemRd(wMatMemRdCsr),	.oMatMemRa(wMatMemRaCsr),
	// Csr Memory Access Video
	// 
	.oMemClkDiv(wMemClkDivCsr),
	// common
	.iSRST(iSRST),				.iSCLK(iSCLK)
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
	// Control / Status
	.iCfgCmd(wCfgCmdCsr),	.iCfgEn(wCfgEnCsr),
	.oCfgDone(wCfgDoneCsr),	.iMemClkDiv(wMemClkDivCsr),
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
	// Control
	.iMemClkDiv(wMemClkDivCsr),
	// CLK Reset
    .iRST(wMatRstCsr),			.iCLK(iSCLK)
);

assign oTestErr	= 1'b0;
assign oDone	= 1'b0;


/**----------------------------------------------------------------------------
 * Memory Access Video
 *---------------------------------------------------------------------------*/
wire [pRamDqWidth-1:0] 	wMavDq;
wire 					wMavCs;
wire 					wMavClk;
wire 					wMavOe;
wire 					wMavEn;
reg  [pRamDqWidth-1:0] 	qMavRd;
reg  					qMavRe;
//
reg [15:0] 				qMavBurstLen;
reg 					qMavRwSel;
reg [28:0]				qMavAdrs;
reg 					qMavVd;
wire					wMavRdy;

MemoryAccessVideo #(
	.pRamDqWidth(pRamDqWidth)
) MemoryAccessVideo (
	// Video Write Port
	.oVideoDq(wMavDq),				.oVideoCs(wMavCs),
	.oVideoClk(wMavClk),			.oVideoOe(wMavOe),
	.oVideoEn(wMavEn),
	// Video Read Port
	.iVideoRd(qMavRd),				.iVideoRe(qMavRe),
	// Ufib Port to Video Port
	.iVideoBurstLen(qMavBurstLen),	.iVideoRwSel(qMavRwSel),
	.iVideoAdrs(qMavAdrs),			.iVideoVd(qMavVd),
	.oVideoDone(),					.oVideoRdy(wMavRdy),
	// Control
	.iMemClkDiv(wMemClkDivCsr),
	// CLK Reset
    .iRST(iSRST),					.iCLK(iSCLK)
);
 
 
//-----------------------------------------------------------------------------
// Ufib Core Unit
//-----------------------------------------------------------------------------
wire [15:0] wUfibMemBurstLen;
wire 		wUfibMemRwSel;
wire [28:0]	wUfibMemAdrs;
wire 		wUfibMemVd;
reg			qUfibMemRe;
//
reg  [pRamDqWidth-1:0]	qUfibMemRd;
reg  					qUfibMemRvd;

UfibCoreUnit #(
	.pUfiBusWidth(pUfiBusWidth),
	.pTransWaitEnable("no")
) UfibCoreUnit (
	// Ufi Write
	.oSUfiRd(oSUfiRd),	.oSUfiVd(oSUfiVd),
	// UFI Read
	.iSUfiWd(iSUfiWd),	.oSUfiRdy(oSUfiRdy),
	// Memory Control / Status
	.oMemBurstLen(wUfibMemBurstLen),	.oMemRwSel(wUfibMemRwSel),
	.oMemAdrs(wUfibMemAdrs),			.oMemVd(wUfibMemVd),
	.iMemRe(qUfibMemRe),
	// Memory Read Data
	.iMemRd({32'd0,qUfibMemRd}),		.iMemRvd(qUfibMemRvd),
	// common
	.iRST(iSRST),	.inARST(inSRST),	.iCLK(iSCLK)
);

always @*
begin
	qMavBurstLen	<= wUfibMemBurstLen;
	qMavRwSel		<= wUfibMemRwSel;
	qMavAdrs		<= wUfibMemAdrs;
	qMavVd			<= wUfibMemVd;
	qUfibMemRe 		<= wMavRdy;
end


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
	// Memory Video Write Port
	.iVideoDq(wMavDq),		.iVideoClk(wMavClk),
	.iVideoCs(wMavCs),		.iVideoOe(wMavOe),
	.iVideoEn(wMavEn),
	// Memory Test Read Port
	.oRamRd(wRamRd),		.oRamRe(wRamRe),
	// Control
	.iMemClkDiv(wMemClkDivCsr),
	// CLK Reset
	.iRST(iSRST),
	.iCKE(),
	.iCLK(iSCLK)
);

always @*
begin
	qMatRd		<= wRamRd;
	qMatRe		<= wRamRe;
	//
	qUfibMemRd	<= wRamRd;
	qUfibMemRvd	<= wRamRe;
	//
	qMavRd		<= wRamRd;
	qMavRe		<= wRamRe;
end

endmodule