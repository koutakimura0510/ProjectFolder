//----------------------------------------------------------
// Create 2022/9/23
// Author koutakimura
// -
// 与えられたアドレスと読み込むデータの長さに応じて RAM にアクセスを行う
// ADMA は現時点では RAM にデータを書き込むことはない、
// そのため、MUFI 経由のデータを内部 FIFO に溜めて後段に流す処理となる
// 
//----------------------------------------------------------
module AudioDmaUnit #(
	parameter					pUfiBusWidth		= 16,
	parameter					pBusAdrsBit			= 32,
	parameter 					pMemAdrsWidth 		= 19
)(
    // Internal Port
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]	iMUfiRd,	// Memory からの Read Data
	input 						iMUfiREd,
	// Ufi Master Write
	output 	[pBusAdrsBit-1:0]	oMUfiAdrs,	// Memory に対するデータ出力
	output 						oMUfiWEd,
	output 						oMUfiREd,
	output 						oMUfiVd,
	// Ufi Master Common
	input						iMUfiRdy,
	//
	// DMA Read Side
	output 	[pUfiBusWidth-1:0]	oDmaRd,		// 後段への Read Data
	output 						oDmaREd,	// DMA Read Valid Data
	input 						iDmaRe,		// DMA Read Enable Data
	//
	input [pMemAdrsWidth-1:0]	iDmaAdrs,
	input [pMemAdrsWidth-1:0]	iDmaLen,
	input 						iDmaEn,
    // CLK Reset
	input 						iRst,
	input 						iClk
);


//-----------------------------------------------------------------------------
// R/W ステートマシン
//-----------------------------------------------------------------------------
reg		[pMemAdrsWidth-1:0]	rMUfiAdrs;		assign oMUfiAdrs	= rMUfiAdrs;
reg							rMUfiWEd;		assign oMUfiWEd		= rMUfiWEd;
reg							rMUfiREd;		assign oMUfiREd		= rMUfiREd;
reg							rMUfiVd;		assign oMUfiVd		= rMUfiVd;
//
reg							qMUfiWEd;
reg							qMUfiREd;
reg							qMUfiVd;
//
reg		[pMemAdrsWidth-1:0]	rDmaRAdrs;
reg 						qDmaRAdrsMatch;

always @(posedge iClk)
begin
	casex ({qDmaRAdrsMatch, iDmaRe, iMUfiRdy, iDmaEn})
		'bxxx0:		rDmaRAdrs <= iDmaAdrs;
		'b0111:		rDmaRAdrs <= rDmaRAdrs + 1'b1;
		'b1111:		rDmaRAdrs <= iDmaAdrs;
		default:	rDmaRAdrs <= rDmaRAdrs;
	endcase

	rMUfiAdrs	<= rDmaRAdrs;

	if (iRst)		rMUfiWEd	<= 1'b0;
	else if (iDmaEn)rMUfiWEd	<= qMUfiWEd;
	else			rMUfiWEd	<= 1'b0;

	if (iRst)		rMUfiREd	<= 1'b0;
	else if (iDmaEn)rMUfiREd	<= qMUfiREd;
	else 			rMUfiREd	<= 1'b0;

	if (iRst)		rMUfiVd		<= 1'b0;
	else if (iDmaEn)rMUfiVd 	<= qMUfiVd;
	else			rMUfiVd 	<= 1'b0;
end

always @*
begin
	qDmaRAdrsMatch	<= (rDmaRAdrs == iDmaLen);
	//	
	qMUfiWEd		<= iDmaRe & iMUfiRdy;
	qMUfiREd		<= iDmaRe;						// 後段がデータ受付可能であれば Read 要求とする
	qMUfiVd			<= iDmaRe;
end

//-----------------------------------------------------------------------------
// 後段へのデータ転送
// 読み込み命令転送回数と本Unit のデータ入力の回数を数えて、
// 一致していなければ本 Unit へのデータとする。
//-----------------------------------------------------------------------------
reg [pUfiBusWidth-1:0]	rDmaRd;			assign oDmaRd		= rDmaRd;
reg 					rDmaREd;		assign oDmaREd		= rDmaREd;

always @(posedge iClk)
begin
	rDmaRd	<= iMUfiRd;

	if (iRst)	rDmaREd	<= 1'b0;
	else 		rDmaREd	<= iMUfiREd;
end

endmodule