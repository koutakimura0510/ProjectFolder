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
	parameter 					pMemAdrsWidth 		= 19,
	parameter					pDmaFifoDepth		= 32
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
// FIFO Bit幅取得
//-----------------------------------------------------------------------------
localparam pFIfoBitWidth  = fBitWidth(pDmaFifoDepth) - 3;


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
//
reg		[pFIfoBitWidth-1:0]	rSwitchCnt;
reg 						qSwicthCke;

always @(posedge iClk)
begin
	casex ({qSwicthCke, iDmaRe, iMUfiRdy, iDmaEn})
		'bxxx0: 	rSwitchCnt	<= {pFIfoBitWidth{1'b0}};
		'b1xxx:		rSwitchCnt	<= {pFIfoBitWidth{1'b0}};
		'b0111:		rSwitchCnt	<= rSwitchCnt + 1'b1;
		default: 	rSwitchCnt	<= rSwitchCnt;
	endcase

	casex ({qDmaRAdrsMatch, qSwicthCke, iDmaRe, iMUfiRdy, iDmaEn})
		'bxxxx0:	rDmaRAdrs <= iDmaAdrs;
		'b00111:	rDmaRAdrs <= rDmaRAdrs + 1'b1;
		'b10111:	rDmaRAdrs <= iDmaAdrs;
		default:	rDmaRAdrs <= rDmaRAdrs;
	endcase

	rMUfiAdrs	<= rDmaRAdrs;

	if (iRst)			rMUfiWEd	<= 1'b0;
	else if (iDmaEn)	rMUfiWEd	<= qMUfiWEd;
	else				rMUfiWEd	<= 1'b0;

	if (iRst)			rMUfiREd	<= 1'b0;
	else if (iDmaEn)	rMUfiREd	<= qMUfiREd;
	else 				rMUfiREd	<= 1'b0;

	if (iRst)			rMUfiVd		<= 1'b0;
	else if (iDmaEn)	rMUfiVd 	<= qMUfiVd;
	else				rMUfiVd 	<= 1'b0;


end

always @*
begin
	qDmaRAdrsMatch	<= (rDmaRAdrs == iDmaLen);
	//
	qMUfiWEd		<= iDmaRe & iMUfiRdy & (~qSwicthCke);
	qMUfiREd		<= iDmaRe;
	qMUfiVd			<= iDmaRe & (~qSwicthCke);

	// DMA 一つだけ使用の場合は気にする必要はないが、二つ以上使用する場合の注意
	// WEd・REd 発行後に入力される Read データまでのタイミングが大きくずれる場合がある。
	// 後段の FIFO の深さが 32 とした場合、それ以上の回数の RCmd を発行してしまい、
	// 結果的に Read データを取得できずに捨ててしまうことになる。
	// そのため、指定回数分 RCmd を発行した場合に、他の DMA デバイスにバス使用の権利を譲る形式とした。
	qSwicthCke		<= rSwitchCnt == {pFIfoBitWidth{1'b1}};
end

//-----------------------------------------------------------------------------
// 後段へのデータ転送
//-----------------------------------------------------------------------------
reg [pUfiBusWidth-1:0]	rDmaRd;			assign oDmaRd	= rDmaRd;
reg 					rDmaREd;		assign oDmaREd	= rDmaREd;

always @(posedge iClk)
begin
	rDmaRd	<= iMUfiRd;

	if (iRst)	rDmaREd	<= 1'b0;
	else 		rDmaREd	<= iMUfiREd;
end


//-----------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//-----------------------------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction

endmodule