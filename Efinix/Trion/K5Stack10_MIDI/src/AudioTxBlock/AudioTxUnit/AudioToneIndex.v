//----------------------------------------------------------
// Create 2022/9/10
// Author koutakimura
// -
// 与えられた Tone 情報で SIN FIFO のインデックスを生成する
// ※ BRAMに保存するデータに関しては
//----------------------------------------------------------
module AudioToneIndex #(
	parameter 						pToneFifoDepth 		= 128,
	parameter 						pSamplingBitWidth 	= 8,
	parameter						pIntegerFileName	= "IndexInteger.dat",
	parameter						pDecimalFileName	= "IndexDecimal.dat"
)(
    // Internal Port
	output 	[pSamplingBitWidth-1:0]	oToneIndex,
	input 	[ 6:0]					iAudioTone,
    // CLK Reset
	input 							iRST,
	input 							iCke,
	input 							iCLK
);


//-----------------------------------------------------------------------------
// Tone 格納 BRAM の確保・初期化
//-----------------------------------------------------------------------------
(* ram_style = "BLOCK" *) reg [pSamplingBitWidth-1:0] rIntFifo [0:pToneFifoDepth-1];
(* ram_style = "BLOCK" *) reg [pSamplingBitWidth-1:0] rDecFifo [0:pToneFifoDepth-1];

initial begin
    $readmemh(pIntegerFileName, rIntFifo);
    $readmemh(pDecimalFileName, rDecFifo);
end


//-----------------------------------------------------------------------------
// SIM FIFO参照用の インデックス計算
// Decimal(小数部) については、最上位 Bit をキャリー扱いとする。
// ※1. Decimal Carry 時の計算については、最上位 Bit を繰り上げ計算で 0 にすることで
// 残りの下位 Bit の加算により、再度 Carry が発生しているか確認できる。
// 
//-----------------------------------------------------------------------------
reg [pSamplingBitWidth-1:0] rIntIndex;				assign oToneIndex = rIntIndex;
reg [pSamplingBitWidth:0]	rDecIndex;
reg [pSamplingBitWidth:0]	qDecCarrySum [0:1];
reg qDecCarry;

always @(posedge iCLK)
begin
	if (iRST)			rIntIndex <= {pSamplingBitWidth{1'b0}};
	else if (iCke)		rIntIndex <= rIntFifo[iAudioTone] + rIntIndex + qDecCarry;
	else				rIntIndex <= rIntIndex;

	if (iRST)			rDecIndex <= {(pSamplingBitWidth + 1){1'b0}};
	else if (iCke)		rDecIndex <= qDecCarry ? qDecCarrySum[0] : qDecCarrySum[1];
	else 				rDecIndex <= rDecIndex;
end

always @*
begin
	qDecCarrySum[0]	<= rDecFifo[iAudioTone] + rDecIndex[pSamplingBitWidth-1:0] + rDecIndex[pSamplingBitWidth];	// ※1.の計算
	qDecCarrySum[1]	<= rDecFifo[iAudioTone] + rDecIndex[pSamplingBitWidth-1:0];
	qDecCarry 		<= rDecIndex[pSamplingBitWidth];
end

endmodule