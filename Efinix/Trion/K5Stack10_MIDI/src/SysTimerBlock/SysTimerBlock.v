/**-----------------------------------------------------------------------------
 * Create  2023/7/2
 * Author  Kouta Kimura
 * -
 * Systick Timer、様々な周期のカウンターを管理する。
 * 
 *-----------------------------------------------------------------------------*/
module SysTimerBlock #(
	// variable parameter
	parameter pBlockAdrsWidth = 8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8,
	parameter pSysClk = 50000000
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire [31:0] wCnt10msCsr;
wire [31:0] wCnt1msCsr;
wire [31:0] wCnt1usCsr;

SysTimerCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),			.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth)
) SysTimerCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// Csr Input
	.iTimerCnt10ms(wCnt10msCsr),
	.iTimerCnt1ms(wCnt1msCsr),
	.iTimerCnt1us(wCnt1usCsr),
	// CLK Reset
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Counter
//-----------------------------------------------------------------------------
localparam lpClk10ms 	= pSysClk / 100;
localparam lpClk1ms		= pSysClk / 1000;
localparam lpClk1us		= pSysClk / 1000000;

ClkCounter #(
	.pDivNum(lpClk10ms)
) ClkCounter10ms (
	.oTimerCnt(wCnt10msCsr),
	.iRST(iSRST),	.iCLK(iSCLK)
);

ClkCounter #(
	.pDivNum(lpClk1ms)
) ClkCounter1ms (
	.oTimerCnt(wCnt1msCsr),
	.iRST(iSRST),	.iCLK(iSCLK)
);

ClkCounter #(
	.pDivNum(lpClk1us)
) ClkCounter1us (
	.oTimerCnt(wCnt1usCsr),
	.iRST(iSRST),	.iCLK(iSCLK)
);

endmodule