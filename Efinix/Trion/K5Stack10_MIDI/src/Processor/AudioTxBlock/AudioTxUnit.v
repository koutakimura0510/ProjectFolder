//----------------------------------------------------------
// Create 2022/9/9
// Author koutakimura
// -
// Audio の制御を司るユニット
// 
//----------------------------------------------------------
module AudioTxUnit #(
	parameter					pUsiBusWidth			= 32,
	parameter					pUfiBusWidth		= 16,
	parameter					pMemAdrsWidth		= 19,	// 外部メモリアドレスサイズ
	parameter					pSamplingBitWidth	= 8,	// 分解能
	//
	parameter					pDualClkFifoDepth	= 32,
	parameter					pDmaFifoDepth		= 32,
	parameter					pFifoDepthOverride	= "no",
	//
	parameter					pTestPortUsed		= "no",
	parameter					pTestPortNum		= 4
)(
	// External Port
	output 						oAudioMclk,
    // Internal Port
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]	iMUfiRd,
	input 						iMUfiREd,
	// Ufi Master Write
	output 	[pUsiBusWidth-1:0]	oMUfiAdrs,
	output 						oMUfiWEd,
	output 						oMUfiREd,
	output 						oMUfiVd,
	// Ufi Master Common
	input						iMUfiRdy,
	//
	input [pMemAdrsWidth-1:0]	iDmaAdrs,
	input [pMemAdrsWidth-1:0]	iDmaLen,
	input 						iDmaEn,
    // CLK Reset
    input           			iSRST,
    input           			iSCLK,
	input 						iAudioRst,
	input 						iAudioClk,
	//
	output [pTestPortNum-1:0]	oTestPort
);


//-----------------------------------------------------------------------------
// DMA
//-----------------------------------------------------------------------------
localparam lpDmaFifoDepth = (pFifoDepthOverride == "yes") ? pDmaFifoDepth : 32;

wire [pSamplingBitWidth-1:0] 	wDmaRd;
wire 							wDmaREd;
reg 							qDmaRe;

AudioDmaUnit #(
	.pUsiBusWidth		(pUsiBusWidth),
	.pUfiBusWidth		(pUfiBusWidth),
	.pMemAdrsWidth		(pMemAdrsWidth),
	.pDmaFifoDepth		(lpDmaFifoDepth)
) AudioDmaUnit (
	.iMUfiRd			(iMUfiRd),
	.iMUfiREd			(iMUfiREd),
	.oMUfiAdrs			(oMUfiAdrs),
	.oMUfiWEd			(oMUfiWEd),
	.oMUfiREd			(oMUfiREd),
	.oMUfiVd			(oMUfiVd),
	.iMUfiRdy			(iMUfiRdy),
	.oDmaRd				(wDmaRd),
	.oDmaREd			(wDmaREd),
	.iDmaRe				(qDmaRe),
	.iDmaAdrs			(iDmaAdrs),
	.iDmaLen			(iDmaLen),
	.iDmaEn				(iDmaEn),
	.iRST				(iSRST),
	.iCLK				(iSCLK)
);


//-----------------------------------------------------------------------------
// Dual Clk Fifo 及び クロック変換
//-----------------------------------------------------------------------------
localparam lpDualClkFifoDepth 	= (pFifoDepthOverride == "yes") ? pDualClkFifoDepth : 32;
localparam lpFullAlMost 		= lpDualClkFifoDepth >> 2;

wire [pSamplingBitWidth-1:0] 	wAudioDualFifoRd;
wire 							wAudioDualFifoFull;
reg 							qAudioDualFifoRde;
reg [1:0] 						rAudioRst;
reg [1:0] 						rAudioCke;

fifoDualControllerGray # (
    .pBuffDepth     (lpDualClkFifoDepth),
    .pBitWidth      (pSamplingBitWidth),
	.pFullAlMost	(5)
) InstAudioDualClkFifo (
    .iWD            (wDmaRd),
    .iWE            (wDmaREd),
    .oFLL           (wAudioDualFifoFull),
    .oRD            (wAudioDualFifoRd),
    .oRVD           (),
    .iRE            (qAudioDualFifoRde),
    .oEMP           (),
    .iSrcRst        (iSRST),
    .iDstRst        (iAudioRst),
    .iSrcClk        (iSCLK),
    .iDstClk        (iAudioClk)
);

always @*
begin
	qDmaRe <= (~wAudioDualFifoFull);
end


//-----------------------------------------------------------------------------
// Tone データから 波形インデックスの抽出
// 音階ではなく、PCMで音源データを生成する場合は、本 module は使用する必要はなく、
// WaveTableRom に直接 音源データを接続すればよい。
// あくまでも、MIDI や 音階の手打ちなどに対応している module である。
// 
//-----------------------------------------------------------------------------
localparam  lpIntegerFileName = "IndexInteger.dat";
localparam  lpDecimalFileName = "IndexDecimal.dat";
//
wire [pSamplingBitWidth-1:0]	wToneIndex;
reg  [6:0]						qAudioTone;
reg 							qToneIndexCke;

AudioToneIndex # (
	.pToneFifoDepth		(128),
	.pSamplingBitWidth	(pSamplingBitWidth),
	.pIntegerFileName	(lpIntegerFileName),
	.pDecimalFileName	(lpDecimalFileName)
) AudioToneIndex (
	.oToneIndex			(wToneIndex),
	.iAudioTone			(qAudioTone),
	.iRST				(iAudioRst),
	.iCke				(qToneIndexCke),
	.iCLK				(iAudioClk)
);

always @*
begin
	qAudioTone 	<= wAudioDualFifoRd[6:0];
end


//-----------------------------------------------------------------------------
// Index から波形データ抽出
//-----------------------------------------------------------------------------
localparam lpSinFileName = "SinTable.dat";
localparam lpSin1Cycle	 = 256;
//
wire [pSamplingBitWidth-1:0] wWave;

WaveTableRom #(
	.pFifoDepth			(lpSin1Cycle),
	.pSamplingBitWidth	(pSamplingBitWidth),
	.pFileName			(lpSinFileName)
) WaveTableRom (
	.oWave				(wWave),
	.iWaveIndex			(wToneIndex),
	.iCLK				(iAudioClk)
);


//---------------------------------------------------------------------------
// 波形データから PWM 出力
//---------------------------------------------------------------------------
wire 							wPwm;
reg  [pSamplingBitWidth-1:0] 	qDutyRatio;
wire 							wDutyCycleCke;

DutyGenerator #(
	.pPWMDutyWidth	(pSamplingBitWidth),
	.pIVtimerWidth	(1)
) AudioPwmOutput (
	.oPwm			(wPwm),
	.oDutyCycleCke	(wDutyCycleCke),
	.oIVCke			(),
	.iPWMEn			(1'b1),			// 音源は基本出力固定
	.iDutyRatio		(qDutyRatio),
	.iIVtimer		(1'b0),			// インターバルタイマーによる分周は生成しない
	.iRST			(iAudioRst),
	.iCLK			(iAudioClk)
);

always @*
begin
	qDutyRatio 			<= wWave;
	qAudioDualFifoRde	<= wDutyCycleCke;
	qToneIndexCke 		<= wDutyCycleCke;
end

OBUF AudioMclk (.I(wPwm), .O(oAudioMclk));


//-----------------------------------------------------------------------------
// TestPort
//-----------------------------------------------------------------------------
generate
	if (pTestPortUsed == "yes")
	begin
		assign oTestPort[0] = wPwm;
		assign oTestPort[1] = iSRST;
		assign oTestPort[2] = 1'b0;
		assign oTestPort[3] = 1'b0;
	end
	else
	begin
		assign oTestPort = {pTestPortNum{1'b0}};
	end
endgenerate

endmodule