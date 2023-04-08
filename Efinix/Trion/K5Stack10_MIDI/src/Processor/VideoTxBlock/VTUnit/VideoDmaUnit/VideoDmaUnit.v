//----------------------------------------------------------
// Create 2022/9/17
// Author koutakimura
// -
// 与えられたアドレスと読み込むデータの長さに応じて RAM にアクセスを行う
// 
//----------------------------------------------------------
module VideoDmaUnit #(
	parameter					pUfiBusWidth		= 16,
	parameter					pUsiBusWidth			= 32,
	parameter 					pMemAdrsWidth 		= 19,
	parameter					pFifoDepth			= 1024,
	// not variable
	parameter					pFifoBitWidth		= pUfiBusWidth
)(
    // Internal Port
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]	iMUfiRd,	// FBUF Read Data
	input 						iMUfiREd,	// FBUF Read Data Cke
	// Ufi Master Write
	output	[pUfiBusWidth-1:0]	oMUfiWd,
	output 	[pUsiBusWidth-1:0]	oMUfiAdrs,
	output 						oMUfiWEd,	// VDMA の Write 要求時 Assert
	output 						oMUfiREd,	// VDMA の Read 要求時 Assert
	output 						oMUfiVd,	// VDMA が 転送要求時 Assert
	output 						oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input						iMUfiRdy,	// MUfi 経由で転送可能時 Assert
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
	input [pMemAdrsWidth-1:0]	iFbufAdrs1,	// DMA 書き込み開始アドレス
	input [pMemAdrsWidth-1:0]	iFbufAdrs2,	// DMA 読み込み開始アドレス
	input [pMemAdrsWidth-1:0]	iFbufLen1,	// DMA 書き込み長さ
	input [pMemAdrsWidth-1:0]	iFbufLen2,	// DMA 読み込み長さ
	input 						iDmaEn,
    // CLK Reset
	input 						iRST,
	input 						iCLK
);


//-----------------------------------------------------------------------------
// UFIB Sw バスの所有権切り替え頻度
//-----------------------------------------------------------------------------
localparam pSwBitWidth  = 1;


//-----------------------------------------------------------------------------
// DMA を使用して UFIB 経由で RAM に書き込むデータを保持
// 前段のブロックとのタイミング調停も兼ねる
//-----------------------------------------------------------------------------
wire 	[pUfiBusWidth-1:0]  wDmaFifoRd;
wire 						wRVd;
wire 						wEmp;
reg 						qDmaFifoRe;

fifoControllerLutRam #(
	.pFifoDepth			(pFifoDepth),
	.pFifoBitWidth		(pFifoBitWidth),
	.pFifoFastOutValue	(5)
) VideoDmaFifo (
	.iWd			(iDmaWd),
	.iWe			(iDmaWEd),
	.oFull			(oDmaFull),
	.oRd			(wDmaFifoRd),
	.iRe			(qDmaFifoRe),
	.oRVd			(wRVd),
	.oEmp			(wEmp),
	.iRST			(iRST),
	.iCLK			(iCLK)
);


//-----------------------------------------------------------------------------
// VDMA R/W ステートマシン
// ExtRam に MUfi 経由でアクセスし
// 
//-----------------------------------------------------------------------------
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
reg 						rDmaAdrsSel;
reg 						qDmaWAdrsMatch;
reg 						qDmaRAdrsMatch;
//
reg 	[pSwBitWidth-1:0]	rTargetSwitchCnt;
reg 						qTargetSwitch;

always @(posedge iCLK)
begin
	// Frame Buffer 領域の切り替え
	// 60FPS 固定のつもりではあるが、
	// WDma の転送速度が RDma より遅い場合、
	// RDma は前回の領域で再度読み込みを行う -> 59fps とかになる
	casex ({qDmaRAdrsMatch, qDmaWAdrsMatch, iMUfiRdy, iDmaEn})
		'bxxx0:			rDmaAdrsSel <= 1'b0;
		'b1111:			rDmaAdrsSel <= ~rDmaAdrsSel;
		default: 		rDmaAdrsSel <=  rDmaAdrsSel;
	endcase

	// WAdrs の更新
	casex ({rDmaAdrsSel, qDmaRAdrsMatch, qDmaWAdrsMatch, wRVd, iMUfiRdy, qTargetSwitch, iDmaEn})
		'bxxxxxx0:		rDmaWAdrs <= iFbufAdrs1;
		'bxx01111:		rDmaWAdrs <= rDmaWAdrs + 1'b1;
		'b011x1x1:		rDmaWAdrs <= iFbufAdrs2;
		'b111x1x1:		rDmaWAdrs <= iFbufAdrs1;
		default:		rDmaWAdrs <= rDmaWAdrs;
	endcase

	// RAdrs の更新
	casex ({rDmaAdrsSel, qDmaRAdrsMatch, qDmaWAdrsMatch, iDmaRe, iMUfiRdy, qTargetSwitch, iDmaEn})
		'bxxxxxx0:		rDmaRAdrs <= iFbufAdrs2;			// DMA Enable
		'bx0x1111:		rDmaRAdrs <= rDmaRAdrs + 1'b1;		// Ufi, DMA, 後段が有効時 アドレス更新
		'b010x1x1:		rDmaRAdrs <= iFbufAdrs2;
		'b011x1x1:		rDmaRAdrs <= iFbufAdrs1;
		'b110x1x1:		rDmaRAdrs <= iFbufAdrs1;
		'b111x1x1:		rDmaRAdrs <= iFbufAdrs2;
		default:		rDmaRAdrs <= rDmaRAdrs;
	endcase

	if (wRVd)			rMUfiWd		<= wDmaFifoRd;
	else 				rMUfiWd		<= 8'h0f;

	if (wRVd) 			rMUfiAdrs	<= rDmaWAdrs;
	else 				rMUfiAdrs	<= rDmaRAdrs;

	if (iRST)			rMUfiWEd	<= 1'b0;
	else if (iDmaEn)	rMUfiWEd	<= qMUfiWEd;
	else				rMUfiWEd	<= 1'b0;

	if (iRST)			rMUfiREd	<= 1'b0;
	else if (iDmaEn)	rMUfiREd	<= qMUfiREd;
	else 				rMUfiREd	<= 1'b0;

	if (iRST)			rMUfiVd		<= 1'b0;
	else if (iDmaEn)	rMUfiVd 	<= qMUfiVd;
	else				rMUfiVd 	<= 1'b0;

	if (iDmaEn)			rMUfiCmd	<= qMUfiCmd;
	else 				rMUfiCmd	<= 1'b0;

	if 	(iRST)					rTargetSwitchCnt <= {pSwBitWidth{1'b0}};
	else if (!qTargetSwitch)	rTargetSwitchCnt <= {pSwBitWidth{1'b0}};
	else if (iMUfiRdy)			rTargetSwitchCnt <= rTargetSwitchCnt + 1'b1;
	else 						rTargetSwitchCnt <= rTargetSwitchCnt;
end

always @*
begin
	// 2022-09-24 10:25 Git変更内容確認 上記のレイテンシ0 FIFO に対応した
	// Wadrs はフレーム終端で待機しており、Radrs がフレーム終端に達した場合に、adrs の切り替えを行う
	qDmaWAdrsMatch 		<= rDmaAdrsSel ? (rDmaWAdrs == iFbufLen2) : (rDmaWAdrs == iFbufLen1);
	qDmaRAdrsMatch 		<= rDmaAdrsSel ? (rDmaRAdrs == iFbufLen1) : (rDmaRAdrs == iFbufLen2);
	// Write Buffer へアクセス
	// Bus が転送可能 かつ RW がフレーム終端でなければ、Write 可能とする
	qMUfiWEd			<= qTargetSwitch & (iDmaRe | qDmaFifoRe) & iMUfiRdy & (~(qDmaWAdrsMatch & qDmaRAdrsMatch));
	qMUfiCmd			<= iDmaRe & (~qDmaFifoRe);						// 後段から Read要求がなければ、WCMD とする
	qMUfiVd				<= qTargetSwitch & (iDmaRe | (~wEmp));			// 空でなければ Ufi 転送要求とする
	qDmaFifoRe			<= qTargetSwitch & (~iDmaRe) & iMUfiRdy & (~qDmaWAdrsMatch);
	// Read Buffer へアクセス
	qMUfiREd			<= iDmaRe;										// 後段がデータ受付可能であれば Read 要求とする
	//
	// 2022-09-24 ある程度データ転送を行ったら、他の DMA デバイスにバス使用の権利を譲る
	qTargetSwitch 		<= ~(rTargetSwitchCnt == {pSwBitWidth{1'b1}});
end


//-----------------------------------------------------------------------------
// 後段へのデータ転送
//-----------------------------------------------------------------------------
reg [pUfiBusWidth-1:0]	rDmaRd;			assign oDmaRd		= rDmaRd;
reg 					rDmaREd;		assign oDmaREd		= rDmaREd;

always @(posedge iCLK)
begin
	rDmaRd	<= iMUfiRd;

	if (iRST)	rDmaREd	<= 1'b0;
	else 		rDmaREd	<= iMUfiREd;
end


endmodule