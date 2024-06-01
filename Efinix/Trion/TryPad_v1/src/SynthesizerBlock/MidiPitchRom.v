/*-----------------------------------------------------------------------------
 * 任意波形 Table の管理
 * 
 * 23-08-31 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module MidiPicthRom #(
	parameter	pBramDepth 		= 256,
	parameter	pAudioBitDepth 	= 8,
	parameter	pFileName		= "./dat/SinTable.dat"
)(
    // Src Side
	input 	[pAudioBitDepth-1:0]	iToneIndex,
	// Dst Side
	output 	[pAudioBitDepth-1:0]	oAudioFreq,
    // CLK Reset
	input 							iCLK
);


//-----------------------------------------------------------------------------
// Wave 格納 BRAM の確保・初期化
//-----------------------------------------------------------------------------
(* ram_style = "BLOCK" *) reg [pAudioBitDepth-1:0] rWaveFifo [0:pBramDepth-1];

initial begin
    $readmemh(pFileName, rWaveFifo);
end


//-----------------------------------------------------------------------------
// Wave データ出力
//-----------------------------------------------------------------------------
reg [pAudioBitDepth-1:0] rWave;			assign oAudioFreq = rWave;

always @(posedge iCLK)
begin
	rWave <= rWaveFifo[iToneIndex];
end

endmodule