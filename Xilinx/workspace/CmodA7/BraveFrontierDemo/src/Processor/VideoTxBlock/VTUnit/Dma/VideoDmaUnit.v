//----------------------------------------------------------
// Create 2022/9/17
// Author koutakimura
// -
// 与えられたアドレスと読み込むデータの長さに応じて RAM にアクセスを行う
// 
//----------------------------------------------------------
module VideoDmaUnit #(
	parameter					pUfiBusWidth		= 16,
	parameter					pBusAdrsBit			= 32,
	parameter 					pMemAdrsWidth 		= 19,
	parameter					pFifoDepth			= 1024,
	// not variable
	parameter					pFifoBitWidth		= pUfiBusWidth
)(
    // Internal Port
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]	iMUfiRd,
	input 						iMUfiREd,
	// Ufi Master Write
	output	[pUfiBusWidth-1:0]	oMUfiWd,
	output 	[pBusAdrsBit-1:0]	oMUfiAdrs,
	output 						oMUfiEd,
	output 						oMUfiVd,
	output 						oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input						iMUfiRdy,
	//
	// DMA Write Side
	input 	[pUfiBusWidth-1:0]	iDmaWd,		// 前段の Write Data
	input  						iDmaWEd,
	output 						oDmaFull,
	// DMA Read Side
	output 	[pUfiBusWidth-1:0]	oDmaRd,		// 後段への Read Data
	output 						oDmaREd,	// DMA Read Valid Data
	input 						iDmaRe,	// DMA Read Enable Data
	//
	input [pMemAdrsWidth-1:0]	iDmaWAdrs,
	input [pMemAdrsWidth-1:0]	iDmaRAdrs,
	input [pMemAdrsWidth-1:0]	iDmaWLen,
	input [pMemAdrsWidth-1:0]	iDmaRLen,
	input 						iDmaEn,
    // CLK Reset
	input 						iRst,
	input 						iClk
);


//-----------------------------------------------------------------------------
// DMA を使用して UFIB 経由で RAM に書き込むデータを保持
// 前段のブロックとのタイミング調停も兼ねる
//-----------------------------------------------------------------------------
reg 	[pUfiBusWidth-1:0]	qMUfiRd;		assign oDmaRd		= qMUfiRd;
reg 						qMUfiREd;		assign oDmaREd		= qMUfiREd;
reg		[pFifoBitWidth-1:0]	qMUfiWd;		assign oMUfiWd		= qMUfiWd;
reg		[pMemAdrsWidth-1:0]	qMUfiAdrs;		assign oMUfiAdrs	= qMUfiAdrs;
reg							qMUfiEd;		assign oMUfiEd		= qMUfiEd;
reg							qMUfiVd;		assign oMUfiVd		= qMUfiVd;
reg							qMUfiCmd;		assign oMUfiCmd		= qMUfiCmd;
wire 	[pFifoBitWidth-1:0] wDmaFifoRd;
wire 						wRvd;
wire 						wEmp;
reg 						qDmaFifoRe;

fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) VideoDmaFifo (
	.iWd			(iDmaWd),
	.iWe			(iDmaWEd),
	.oFull			(oDmaFull),
	.oRd			(wDmaFifoRd),
	.iRe			(qDmaFifoRe),
	.oRvd			(wRvd),
	.oEmp			(wEmp),
	.iRst			(iRst),
	.iClk			(iClk)
);

//-----------------------------------------------------------------------------
// R/W ステートマシン
//-----------------------------------------------------------------------------
reg		[pMemAdrsWidth-1:0]	rDmaWAdrs;
reg		[pMemAdrsWidth-1:0]	rDmaRAdrs;
reg 						rDmaWAdrsSel;
reg 						rDmaRAdrsSel;
reg 						qDmaWAdrsOverCheck;
reg 						qDmaWAdrsMatch;
reg 						qDmaRAdrsMatch;

always @(posedge iClk)
begin
	casex ({qDmaWAdrsOverCheck, qDmaWAdrsMatch, iMUfiRdy, iDmaEn})
		'bxxx0:		rDmaWAdrsSel <= 1'b0;
		'b0111:		rDmaWAdrsSel <= ~rDmaWAdrsSel;
		default: 	rDmaWAdrsSel <=  rDmaWAdrsSel;
	endcase

	casex ({qDmaWAdrsOverCheck, qDmaRAdrsMatch, iMUfiRdy, iDmaEn})
		'bxxx0:		rDmaRAdrsSel <= 1'b0;
		'b0111:		rDmaRAdrsSel <= ~rDmaRAdrsSel;
		default: 	rDmaRAdrsSel <=  rDmaRAdrsSel;
	endcase

	casex ({rDmaWAdrsSel, qDmaWAdrsMatch, iDmaRe, iMUfiRdy, iDmaEn})
		'bxxxx0:	rDmaWAdrs <= iDmaWAdrs;
		'bx0011:	rDmaWAdrs <= rDmaWAdrs + 1'b1;
		'b01011:	rDmaWAdrs <= iDmaRAdrs;
		'b11011:	rDmaWAdrs <= iDmaWAdrs;
		default: 	rDmaWAdrs <= rDmaWAdrs;
	endcase

	casex ({rDmaRAdrsSel, qDmaRAdrsMatch, iDmaRe, iMUfiRdy, iDmaEn})
		'bxxxx0:	rDmaRAdrs <= iDmaRAdrs;
		'bx0011:	rDmaRAdrs <= rDmaRAdrs + 1'b1;
		'b01011:	rDmaRAdrs <= iDmaWAdrs;
		'b11011:	rDmaRAdrs <= iDmaRAdrs;
		default: 	rDmaRAdrs <= rDmaRAdrs;
	endcase
end

//
always @*
begin
	qDmaWAdrsOverCheck 	<= (rDmaWAdrs == rDmaRAdrs);	// WAdrs が RAdrs を越さないようにする
	qDmaWAdrsMatch 		<= (rDmaWAdrs == iDmaWLen);
	qDmaRAdrsMatch 		<= (rDmaRAdrs == iDmaRLen);
	//
	qMUfiRd		<= iMUfiRd;
	qMUfiREd	<= iMUfiRdy ? iMUfiREd : 1'b0;
	qMUfiWd		<= wDmaFifoRd;
	qMUfiAdrs	<= iDmaRe ? rDmaRAdrs : rDmaWAdrs;
	qMUfiEd		<= (iDmaRe | wRvd)  & iDmaEn;			// RW 発行
	qMUfiVd		<= (iDmaRe | (~wEmp))  & iDmaEn;		// 空でなければ Ufi 転送要求とする
	qMUfiCmd	<= iDmaRe;								// 後段から Read要求がなければ、WCMD とする
	qDmaFifoRe	<= (~iDmaRe) & iMUfiRdy & iDmaEn;
end

/*
 DMA サイクル
 まず前提として、FrameBuffer の書き込みは、Read よりも早くなければならない。FPS 確保のため。
 1.DualFrameBuufer 構造として、WDMA,RDMA は別々のアドレスを指定する。
 2.起動時は、後段の DualClkFifo が Full になるまで RAM の何も書かれていない領域から 0 を Read する。
 3.Full になると iDmaRe が Deassert されるので、WDMA に切り替え前段の FIFO からの入力データを UFI 経由で RAM に書き込みを行う。
 4.
 */


endmodule