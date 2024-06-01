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
	parameter pCsrActiveWidth = 8
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


//-----------------------------------------------------------------------------
// locparama
//-----------------------------------------------------------------------------
localparam lpSystickTimerBitWidth 	= 32;
localparam lpSystickTimerNum 		= 3;	// Timer Numver

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire [31:0] wSysteickTimerCntCsr [0:lpSystickTimerNum-1];
wire [31:0] wSysteickTimerDivCsr [0:lpSystickTimerNum-1];
wire [lpSystickTimerNum-1:0] wSystickTimerEnCsr;

SysTimerCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),		.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),			.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pSystickTimerBitWidth(lpSystickTimerBitWidth),
	.pSystickTimerNum(lpSystickTimerNum)
) SysTimerCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// Csr Output
	.oSystickTimerDiv1(wSysteickTimerDivCsr[0]),
	.oSystickTimerDiv2(wSysteickTimerDivCsr[1]),
	.oSystickTimerDiv3(wSysteickTimerDivCsr[2]),
	.oSystickTimerEn(wSystickTimerEnCsr),
	// Csr Input
	.iSystickTimerCnt1(wSysteickTimerCntCsr[0]),
	.iSystickTimerCnt2(wSysteickTimerCntCsr[1]),
	.iSystickTimerCnt3(wSysteickTimerCntCsr[2]),
	// CLK Reset
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// Counter
//-----------------------------------------------------------------------------
genvar genx;

generate
	for (genx = 0; genx < lpSystickTimerNum; genx = genx + 1)
	begin
		ClkCounter #(
			.pTimerCntBitWidth(lpSystickTimerBitWidth)
		) SysteickTimer (
			.oTimerCnt(wSysteickTimerCntCsr[genx]),
			.iTimerDiv(wSysteickTimerDivCsr[genx]),
			.iRST(wSystickTimerEnCsr[genx]),
			.iCLK(iSCLK)
		);
	end
endgenerate

endmodule