//----------------------------------------------------------
// Create 2022/9/16
// Author koutakimura
// -
// 与えられたアドレスと読み込むデータの長さに応じて RAM にアクセスを行う
// 
//----------------------------------------------------------
module AudioDma #(
	parameter					pUfiBusWidth		= 16,
	parameter					pBusAdrsBit			= 32,
	parameter 					pMemBitWidth 		= 19
)(
    // Internal Port
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]	iMUfiRd,	// Memory からの Read Data
	input 						iMUfiREd,
	// Ufi Master Write
	output 	[pBusAdrsBit-1:0]	oMUfiAdrs,	// Memory に対するデータ出力
	output 						oMUfiEd,
	output 						oMUfiVd,
	// Ufi Master Common
	input						iMUfiRdy,
	//
	output 	[pUfiBusWidth-1:0]	oDd,
	output 						oEdd,
	input 						iEdd,
	//
	input [pMemBitWidth-1:0]	iAudioDmaAdrs,
	input [pMemBitWidth-1:0]	iAudioDmaLen,
	input 						iAudioDmaEn,
    // CLK Reset
	input 						iRst,
	input 						iCke,
	input 						iClk
);





endmodule