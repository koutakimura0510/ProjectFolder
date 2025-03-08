/*-----------------------------------------------------------------------------
 * Note Number から Picth Index 算出
 * 
 * 23-08-30 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module MidiPitchIndex #(
	parameter	pBramDepth 			= 128,
	parameter	pAudioBitDepth 		= 8,
	parameter	pIntegerFileName	= "./dat/IndexInteger.dat",
	parameter	pDecimalFileName	= "./dat/IndexDecimal.dat"
)(
    // Midi Note Input
	input 	[6:0]	iNoteNumber,
	// Output Index
	output 	[pAudioBitDepth-1:0]	oPitchIndex,
    // common
	input	iRST,
	input	iCKE,
	input	iCLK
);


//-----------------------------------------------------------------------------
// Index Initialize
//-----------------------------------------------------------------------------
(* syn_romstyle = "block_rom" *) reg [pAudioBitDepth-1:0] rIntBram [0:pBramDepth-1];
(* syn_romstyle = "block_rom" *) reg [pAudioBitDepth-1:0] rDecBram [0:pBramDepth-1];

initial begin
    $readmemh(pIntegerFileName, rIntBram);
    $readmemh(pDecimalFileName, rDecBram);
end


//-----------------------------------------------------------------------------
// SIN FIFO参照用の インデックス計算
// Decimal(小数部) については、最上位 Bit をキャリー扱いとする。
// 
// ※1. Decimal Carry 時の計算については、最上位 Bit を繰り上げ計算で 0 にすることで
// 残りの下位 Bit の加算により、再度 Carry が発生しているか確認できる。
// 
//-----------------------------------------------------------------------------
reg [pAudioBitDepth-1:0] rIntIndex;				assign oPitchIndex = rIntIndex;
reg [pAudioBitDepth:0]	rDecIndex;
reg [pAudioBitDepth:0]	qDecCarrySum;
reg qDecCarry;

always @(posedge iCLK)
begin
	if (iRST)			rIntIndex <= {pAudioBitDepth{1'b0}};
	else if (iCKE)		rIntIndex <= rIntBram[iNoteNumber] + rIntIndex + qDecCarry;
	else				rIntIndex <= rIntIndex;

	if (iRST)			rDecIndex <= {(pAudioBitDepth + 1){1'b0}};
	else if (iCKE)		rDecIndex <= qDecCarrySum[pAudioBitDepth-1:0];
	else 				rDecIndex <= rDecIndex;
end

always @*
begin
	qDecCarrySum	<= rDecBram[iNoteNumber] + rDecIndex[pAudioBitDepth-1:0] + rDecIndex[pAudioBitDepth];	// ※1.の計算
	qDecCarry 		<= qDecCarrySum[pAudioBitDepth];
end

endmodule