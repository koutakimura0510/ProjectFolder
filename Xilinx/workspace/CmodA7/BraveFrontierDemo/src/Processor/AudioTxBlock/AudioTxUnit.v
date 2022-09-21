//----------------------------------------------------------
// Create 2022/9/9
// Author koutakimura
// -
// Audio の制御を司るユニット
// 
//----------------------------------------------------------
module AudioTxUnit #(
	parameter					pUfiBusWidth		= 16,
	parameter					pBusAdrsBit			= 32,
	parameter					pSamplingBitWidth	= 8,	// 分解能
	parameter					pMemBitWidth		= 19,	// 外部メモリアドレスサイズ
	parameter					pTestPortUsed		= "no",
	parameter					pTestPortNum		= 4
)(
    // Internal Port
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]	iMUfiRd,
	input 						iMUfiREd,
	// Ufi Master Write
	output 	[pBusAdrsBit-1:0]	oMUfiAdrs,
	output 						oMUfiEd,
	output 						oMUfiVd,
	// Ufi Master Common
	input						iMUfiRdy,
	//
	output 						oAudioMclk,
	input 						iAudioCke,
	input [ 6:0]				iAudioTone,
	input 						iAudioSel,
	input [ 7:0]				iAudioDuty,
	input [pMemBitWidth-1:0]	iAudioDmaAdrs,
	input [pMemBitWidth-1:0]	iAudioDmaLen,
	input 						iAudioDmaEn,
    // CLK Reset
    input           			iSysRst,
    input           			iSysClk,
	input 						iAudioRst,
	input 						iAudioClk,
	//
	output [pTestPortNum-1:0]	oTestPort
);


assign oMUfiAdrs	= {pBusAdrsBit{1'b0}};
assign oMUfiEd		= 1'b0;
assign oMUfiVd		= 1'b0;


//-----------------------------------------------------------------------------
// DMA
//-----------------------------------------------------------------------------
// AudioDma 
// 	.iMUfiRd			(iMUfiRd),
// 	.iMUfiREd			(iMUfiREd),
// 	.oMUfiAdrs			(oMUfiAdrs),
// 	.oMUfiEd			(oMUfiEd),
// 	.oMUfiVd			(oMUfiVd),
// 	.iMUfiRdy			(iMUfiRdy),


// //-----------------------------------------------------------------------------
// // Dual Clk Fifo
// //-----------------------------------------------------------------------------
// fifoDualControllerGray # (
//     .pBuffDepth     (pBuffDepth),
//     .pBitWidth      (pBitWidth)
// ) AudioDualClkFifo (
//     .iWD            (iWd),
//     .iWE            (iWe),
//     .oRD            (wRd),
//     .iRE            (iRe),
//     .oRVD           (wRVd),
//     .oFLL           (ofull),
//     .oEMP           (),
//     .iSrcRst        (iSysRst),
//     .iDstRst        (iSysRst),
//     .iSrcClk        (iAudioClk),
//     .iDstClk        (iAudioClk)
// );



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
reg 							qIndexCke;
wire [pSamplingBitWidth-1:0]	wToneIndex;

AudioToneIndex # (
	.pToneFifoDepth		(128),
	.pSamplingBitWidth	(pSamplingBitWidth),
	.pIntegerFileName	(lpIntegerFileName),
	.pDecimalFileName	(lpDecimalFileName)
) AudioToneIndex (
	.oToneIndex			(wToneIndex),
	.iAudioTone			(iAudioTone),
	.iRst				(iAudioRst),
	.iCke				(qIndexCke),
	.iClk				(iAudioClk)
);


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
	.iClk				(iAudioClk)
);


//---------------------------------------------------------------------------
// 波形データから PWM 出力
//---------------------------------------------------------------------------
wire wPwm;
wire wDutyCycleCke;
reg  [7:0] wDuty;

DutyGenerator #(
	.pPWMDutyWidth	(pSamplingBitWidth),
	.pIVtimerWidth	(1)
) AudioPwmOutput (
	.oPwm			(wPwm),
	.oDutyCycleCke	(wDutyCycleCke),
	.oIVCke			(),
	.iPWMEn			(iAudioCke),
	.iDutyRatio		(wDuty),
	.iIVtimer		(1'b0),			// インターバルタイマーによる分周は生成しない
	.iRst			(iAudioRst),
	.iClk			(iAudioClk)
);

always @*
begin
	qIndexCke	<= wDutyCycleCke;
	wDuty		<= iAudioSel ? iAudioDuty : wWave;
end

OBUF AudioMclk (.I(wPwm), .O(oAudioMclk));

generate
	if (pTestPortUsed == "yes")
	begin
		assign oTestPort[0] = wPwm;
		assign oTestPort[1] = iSysRst;
		assign oTestPort[2] = 1'b0;
		assign oTestPort[3] = 1'b0;
	end
	else
	begin
		assign oTestPort = {pTestPortNum{1'b0}};
	end
endgenerate

endmodule