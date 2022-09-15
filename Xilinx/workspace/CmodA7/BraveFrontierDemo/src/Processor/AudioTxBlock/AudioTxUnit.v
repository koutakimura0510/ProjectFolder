//----------------------------------------------------------
// Create 2022/9/9
// Author koutakimura
// -
// Audio の制御を司るユニット
// 
//----------------------------------------------------------
module AudioTxUnit #(
	parameter					pSamplingBitWidth	= 8,	// 分解能
	parameter					pMemBitWidth		= 19
)(
    // Internal Port
	output 						oAudioMclk,
	input 						iAudioCke,
	input [ 6:0]				iAudioTone,
	input 						iAudioSel,
	input [ 7:0]				iAudioDuty,
	input [pMemBitWidth-1:0]	iAudioDmaAdrs,
	input [pMemBitWidth-1:0]	iAudioDmaLen,
	input 						iAudioDmaEn,
    // CLK Reset
	input 						iAudioRst,
	input 						iAudioClk
);


//-----------------------------------------------------------------------------
// クリティカルパス対策
//-----------------------------------------------------------------------------
wire 		wAudioCke;
wire [ 6:0]	wAudioTone;

SftReg #(
	.pBitWidth		(1),
	.pSftRegDepth	(3),
	.pLutRam		("no")
) AudioCkeSft (
	.iD				(iAudioCke),
	.oQ				(wAudioCke),
	.iRst			(iAudioRst),
	.iClk			(iAudioClk)
);

SftReg #(
	.pBitWidth		(7),
	.pSftRegDepth	(3),
	.pLutRam		("no")
) AudioToneSft (
	.iD				(iAudioTone),
	.oQ				(wAudioTone),
	.iRst			(iAudioRst),
	.iClk			(iAudioClk)
);


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
	.iAudioTone			(wAudioTone),
	.iRst				(iAudioRst),
	.iCke				(qIndexCke),
	.iClk				(iAudioClk)
);


//-----------------------------------------------------------------------------
// Index から波形データ抽出
//-----------------------------------------------------------------------------
localparam  lpSinFileName = "SinTable.dat";
//
wire [pSamplingBitWidth-1:0] wWave;

WaveTableRom #(
	.pFifoDepth			(256),
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
	.iPWMEn			(wAudioCke),
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

endmodule