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
wire 	[pUfiBusWidth-1:0]  wDmaFifoRd;
wire 						wRvd;
wire 						wEmp;
reg 						rDmaFifoRe;
reg 						qDmaFifoRe;

fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) VideoDmaFifo (
	.iWd			(iDmaWd),
	.iWe			(iDmaWEd),
	.oFull			(oDmaFull),
	.oRd			(wDmaFifoRd),
	.iRe			(rDmaFifoRe),
	.oRvd			(wRvd),
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
reg		[pMemAdrsWidth-1:0]	rDmaWAdrs;
reg		[pMemAdrsWidth-1:0]	rDmaRAdrs;
reg 						rDmaWAdrsSel;
reg 						rDmaRAdrsSel;
reg 						qDmaWAdrsOverCheck;
reg 						qDmaWAdrsMatch;
reg 						qDmaRAdrsMatch;

always @(posedge iClk)
begin
	// TOD 取り合えず Read 転送のみ実装する
	// casex ({qDmaWAdrsOverCheck, qDmaWAdrsMatch, wRvd, iDmaEn})
	// 	'bxxx0:		rDmaWAdrsSel <= 1'b0;
	// 	'b0111:		rDmaWAdrsSel <= ~rDmaWAdrsSel;
	// 	default: 	rDmaWAdrsSel <=  rDmaWAdrsSel;
	// endcase

	casex ({qDmaRAdrsMatch, iMUfiRdy, iDmaEn})
		'bxx0:		rDmaRAdrsSel <= 1'b0;
		'b111:		rDmaRAdrsSel <= ~rDmaRAdrsSel;
		default: 	rDmaRAdrsSel <=  rDmaRAdrsSel;
	endcase

	// casex ({rDmaWAdrsSel, qDmaWAdrsOverCheck, qDmaWAdrsMatch, iDmaRe, wRvd, iDmaEn})
	// 	'bxxxxx0:	rDmaWAdrs <= iDmaWAdrs;
	// 	'bx00011:	rDmaWAdrs <= rDmaWAdrs + 1'b1;
	// 	'b001011:	rDmaWAdrs <= iDmaRAdrs;
	// 	'b101011:	rDmaWAdrs <= iDmaWAdrs;
	// 	default: 	rDmaWAdrs <= rDmaWAdrs;
	// endcase

	// casex ({rDmaRAdrsSel, qDmaRAdrsMatch, iDmaRe, iMUfiRdy, iDmaEn})
	// 	'bxxxx0:	rDmaRAdrs <= iDmaRAdrs;
	// 	'bx0111:	rDmaRAdrs <= rDmaRAdrs + 1'b1;
	// 	'b01111:	rDmaRAdrs <= iDmaWAdrs;
	// 	'b11111:	rDmaRAdrs <= iDmaRAdrs;
	// 	default: 	rDmaRAdrs <= rDmaRAdrs;
	// endcase

	casex ({rDmaRAdrsSel, qDmaRAdrsMatch, iDmaRe, iMUfiRdy, iDmaEn})
		'bxxxx0:	rDmaRAdrs <= iDmaRAdrs;
		'bx0111:	rDmaRAdrs <= rDmaRAdrs + 1'b1;
		'b01111:	rDmaRAdrs <= iDmaWAdrs;
		'b11111:	rDmaRAdrs <= iDmaRAdrs;
		default: 	rDmaRAdrs <= rDmaRAdrs;
	endcase

	if (iDmaRe) 	rMUfiWd 	<= 12'haaa;					// Read サイクル時はゴミデータ送信
	else			rMUfiWd 	<= {pUfiBusWidth{1'b0}};	// 一応 Writeサイクル時を示すデータにしておく

	if (iDmaRe) 	rMUfiAdrs	<= rDmaRAdrs;
	else 			rMUfiAdrs	<= rMUfiAdrs; // 本来はここに Writeアドレスが代入される

	if (iDmaEn)		rMUfiWEd   <= qMUfiWEd;
	else			rMUfiWEd   <= 1'b0;

	if (iDmaEn)		rMUfiREd   <= qMUfiREd;
	else 			rMUfiREd   <= 1'b0;

	if (iDmaEn)		rMUfiVd    <= qMUfiVd;
	else			rMUfiVd    <= 1'b0;

	if (iDmaEn)		rMUfiCmd   <= qMUfiCmd;
	else 			rMUfiCmd   <= 1'b1;
	//
	rDmaFifoRe <= qDmaFifoRe;

	//
	// 後段ブロックへの処理
	rDmaRd	<= iMUfiRd;
	rDmaREd	<= iMUfiREd;
end

//
always @*
begin
	// qDmaWAdrsOverCheck 	<= ((rDmaWAdrs+1'b1) == rDmaRAdrs);	// WAdrs が RAdrs を越さないようにする
	// qDmaWAdrsMatch 		<= (rDmaWAdrs == iDmaWLen) | (rDmaWAdrs == iDmaRLen);
	qDmaRAdrsMatch 		<= (rDmaRAdrs == iDmaWLen) | (rDmaRAdrs == iDmaRLen);
	//
	// qDmaRd		<= iMUfiRd;
	// qDmaREd		<= iMUfiRdy ? iMUfiREd : 1'b0;
	// qMUfiWd		<= iDmaRe ? 8'haa : wDmaFifoRd;
	// qMUfiAdrs	<= iDmaRe ? rDmaRAdrs : rDmaWAdrs;

	// qMUfiWEd	<= (iDmaRe | wRvd)  & iDmaEn & iMUfiRdy;// RW 発行
	qMUfiWEd	<= iDmaRe & iMUfiRdy;
	qMUfiREd	<= iDmaRe;
	// qMUfiVd		<= (iDmaRe | (~wEmp))  & iDmaEn;	// 空でなければ Ufi 転送要求とする
	qMUfiVd		<= iDmaRe;						// 空でなければ Ufi 転送要求とする
	qMUfiCmd	<= iDmaRe;								// 後段から Read要求がなければ、WCMD とする
	// qDmaFifoRe	<= (~iDmaRe) & iMUfiRdy & iDmaEn;
	qDmaFifoRe	<= 1'b0; // RDMA デバッグのため、書き込み側のデータは必要ない
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