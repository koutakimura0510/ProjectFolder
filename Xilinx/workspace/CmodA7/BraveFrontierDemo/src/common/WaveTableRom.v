//----------------------------------------------------------
// Create 2022/9/10
// Author koutakimura
// -
// 任意波形 Table の管理
// 
//----------------------------------------------------------
module WaveTableRom #(
	parameter 						pFifoDepth	 		= 256,
	parameter 						pSamplingBitWidth 	= 8,
	parameter						pFileName			= "../dat/SinTable.dat"
)(
    // Internal Port
	output 	[pSamplingBitWidth-1:0]	oWave,
	input 	[pSamplingBitWidth-1:0]	iWaveIndex,
    // CLK Reset
	input 							iClk
);


//-----------------------------------------------------------------------------
// Wave 格納 BRAM の確保・初期化
//-----------------------------------------------------------------------------
(* ram_style = "BLOCK" *) reg [pSamplingBitWidth-1:0] rWaveFifo [0:pFifoDepth-1];

initial begin
    $readmemh(pFileName, rWaveFifo);
end


//-----------------------------------------------------------------------------
// Wave データ出力
//-----------------------------------------------------------------------------
reg [pSamplingBitWidth-1:0] rWave;			assign oWave = rWave;

always @(posedge iClk)
begin
	rWave <= rWaveFifo[iWaveIndex];
end

endmodule