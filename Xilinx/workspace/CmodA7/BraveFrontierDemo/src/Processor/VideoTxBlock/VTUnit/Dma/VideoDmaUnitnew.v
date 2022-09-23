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
	output 						oMUfiWEd,
	output 						oMUfiREd,
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
	input 						iDmaRe,		// DMA Read Enable Data
	//
	input [pMemAdrsWidth-1:0]	iFBufAdrs1,	// DMA 書き込み開始アドレス
	input [pMemAdrsWidth-1:0]	iDmaRAdrs,	// DMA 読み込み開始アドレス
	input [pMemAdrsWidth-1:0]	iDmaWLen,	// DMA 書き込み長さ
	input [pMemAdrsWidth-1:0]	iDmaRLen,	// DMA 読み込み長さ
	input 						iDmaEn,
    // CLK Reset
	input 						iRst,
	input 						iClk
);


//-----------------------------------------------------------------------------
// DMA を使用して UFIB 経由で RAM に書き込むデータを保持
// 前段のブロックとのタイミング調停も兼ねる
//-----------------------------------------------------------------------------
wire 	[pUfiBusWidth-1:0]  wDmaFifoRd;
wire 						wEmp;
reg 						rDmaFifoRe;
reg 						qDmaFifoRe;

fifoControllerLutRam #(
	.pFifoDepth			(pFifoDepth),
	.pFifoBitWidth		(pFifoBitWidth),
	.pFifoFastOutValue	(3)
) VideoDmaFifo (
	.iWd			(iDmaWd),
	.iWe			(iDmaWEd),
	.oFull			(oDmaFull),
	.oRd			(wDmaFifoRd),
	.iRe			(rDmaFifoRe),
	.oEmp			(wEmp),
	.iRst			(iRst),
	.iClk			(iClk)
);

//-----------------------------------------------------------------------------
// R/W ステートマシン
//-----------------------------------------------------------------------------
reg 	[pUfiBusWidth-1:0]	rDmaRd;			assign oDmaRd		= rDmaRd;
reg 						rDmaREd;		assign oDmaREd		= rDmaREd;
reg		[pUfiBusWidth-1:0]	rMUfiWd;		assign oMUfiWd		= rMUfiWd;
reg		[pMemAdrsWidth-1:0]	rMUfiAdrs;		assign oMUfiAdrs	= rMUfiAdrs;
reg							rMUfiWEd;		assign oMUfiWEd		= rMUfiWEd;
reg							rMUfiREd;		assign oMUfiREd		= rMUfiREd;
reg							rMUfiVd;		assign oMUfiVd		= rMUfiVd;
reg							rMUfiCmd;		assign oMUfiCmd		= rMUfiCmd;
//
reg							qMUfiWEd;
reg							qMUfiREd;
reg							qMUfiVd;
reg							qMUfiCmd;
//
reg		[pMemAdrsWidth-1:0]	rFBufAdrs1;
reg		[pMemAdrsWidth-1:0]	rDmaRAdrs;
reg 	[pMemAdrsWidth-1:0]	rWCnt;
reg 	[pMemAdrsWidth-1:0]	rRCnt;
reg 						rDmaAdrsSel;
reg 						qDmaWCntMax;
reg 						qDmaRCntMax;

always @(posedge iClk)
begin
	// Frame Buffer 領域の切り替え
	casex ({qDmaWCntMax, qDmaRCntMax, rDmaFifoRe, iDmaEn})
		'bxxx0:		rDmaAdrsSel <= 1'b0;
		'b0111:		rDmaAdrsSel <= ~rDmaAdrsSel;
		default: 	rDmaAdrsSel <=  rDmaAdrsSel;
	endcase

	// アドレスの更新
	casex ({qDmaWCntMax, rDmaFifoRe, iDmaEn})
		'bxx0:		rWCnt <= {pMemAdrsWidth{1'b0}};
		'b011:		rWCnt <= rWCnt + 1'b1;
		'b111:		rWCnt <= {pMemAdrsWidth{1'b0}};
		default: 	rWCnt <= rWCnt;
	endcase

	casex ({qDmaRCntMax, rDmaFifoRe, iDmaEn})
		'bxx0:		rRCnt <= {pMemAdrsWidth{1'b0}};
		'b011:		rRCnt <= rRCnt + 1'b1;
		'b111:		rRCnt <= {pMemAdrsWidth{1'b0}};
		default: 	rRCnt <= rRCnt;
	endcase

	casex ({rFBufAdrs1Sel, qFBufAdrs1OverCheck, qFBufAdrs1Match, rDmaFifoRe})
		'bxxxx:		rFBufAdrs1 <= rFBufAdrs1 + 1'b1;
		'bxxxx:		rFBufAdrs1 <= iFBufAdrs1;
		'bxx01:		rFBufAdrs1 <= iDmaRAdrs;
		default: 	rFBufAdrs1 <= rFBufAdrs1;
	endcase

	casex ({rDmaRAdrsSel, qDmaRAdrsMatch, iDmaRe, rDmaFifoRe, iMUfiRdy})
		'b01101:	rDmaRAdrs <= rFBufAdrs1 + 1'b1;
		'b01101:	rDmaRAdrs <= iFBufAdrs1;
		'b11101:	rDmaRAdrs <= iDmaRAdrs;
		default: 	rDmaRAdrs <= rDmaRAdrs;
	endcase

	if (wRVd)		rMUfiWd		<= wDmaFifoRd;
	else 			rMUfiWd		<= 8'h0f;

	if (wRVd) 		rMUfiAdrs	<= rFBufAdrs1;
	else 			rMUfiAdrs	<= rDmaRAdrs;

	if (iRst)		rMUfiWEd	<= 1'b0;
	else if (iDmaEn)rMUfiWEd	<= qMUfiWEd;
	else			rMUfiWEd	<= 1'b0;

	if (iRst)		rMUfiREd	<= 1'b0;
	else if (iDmaEn)rMUfiREd	<= qMUfiREd;
	else 			rMUfiREd	<= 1'b0;

	if (iRst)		rMUfiVd		<= 1'b0;
	else if (iDmaEn)rMUfiVd 	<= qMUfiVd;
	else			rMUfiVd 	<= 1'b0;

	if (iDmaEn)		rMUfiCmd	<= qMUfiCmd;
	else 			rMUfiCmd	<= 1'b0;

	if (iRst)		rDmaFifoRe	<= 1'b0;
	else if (iDmaEn)rDmaFifoRe	<= qDmaFifoRe;
	else 			rDmaFifoRe	<= 1'b0;

	// 後段ブロックへの処理
	rDmaRd	<= iMUfiRd;

	if (iRst)		rDmaREd	<= 1'b0;
	else			rDmaREd	<= iMUfiREd;
end
  
always @*
begin
	qDmaWCntMax <= (rWCnt == iDmaLen);
	qDmaRCntMax <= (rRCnt == iDmaLen);
	//
	qMUfiWEd	<= (iDmaRe | (~wEmp)) & iMUfiRdy;
	qMUfiREd	<= iDmaRe;						// 後段がデータ受付可能であれば Read 要求とする
	qMUfiVd		<= (iDmaRe | (~wEmp));			// 空でなければ Ufi 転送要求とする
	qMUfiCmd	<= (iDmaRe & (~wRVd));			// 後段から Read要求がなければ、WCMD とする
	qDmaFifoRe	<= (~iDmaRe) & iMUfiRdy & (~qFBufAdrs1OverCheck) & (~wEmp);
end

/*
 DMA サイクル
 まず前提として、FrameBuffer への書き込みは、Read よりも早くなければならない。
 1.DualFrameBuufer 構造として、WDMA,RDMA は別々のアドレスを指定する。
 2.起動時は、後段の DualClkFifo が Full になるまで RAM の何も書かれていない領域から 0 を Read する。
 3.Full になると iDmaRe が Deassert されるので、WDMA に切り替え前段の FIFO からの入力データを UFI 経由で RAM に書き込みを行う。
 4.
 */


endmodule