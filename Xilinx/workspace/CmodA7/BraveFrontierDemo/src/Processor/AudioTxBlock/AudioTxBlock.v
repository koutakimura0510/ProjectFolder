//----------------------------------------------------------
// Create 2022/9/9
// Author koutakimura
// -
// Audio の管理を司るブロック
// 
//----------------------------------------------------------
module AudioTxBlock #(
	parameter 						pBlockAdrsMap 		= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  		= 'h05,
	parameter						pUfiBusWidth		= 16,
	parameter						pBusAdrsBit			= 32,
	parameter 						pCsrAdrsWidth 		= 8,
	parameter						pCsrActiveWidth 	= 8,
	//
	parameter						pSamplingBitWidth	= 8,	// 分解能
	parameter						pMemBitWidth		= 19,
	parameter						pTestPortUsed		= "no",
	parameter						pTestPortNum		= 4
)(
	// External Port
	output							oAudioMclk,
    // Internal Port
	// Bus Slave Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]		iMUfiRd,	// Read Data
	input 							iMUfiREd,	// Read Data Enable
	// Ufi Master Write
	output [pBusAdrsBit-1:0]		oMUfiAdrs,
	output 							oMUfiEd,	// Adrs Data Enable
	output 							oMUfiVd,
	// Ufi Master Common
	input 							iMUfiRdy,	// Ufi Bus 転送可能時 Assert
    // CLK Reset
    input           				iSysRst,
    input           				iSysClk,
    input           				iAudioRst,
	input 							iAudioClk,
	//
	output [pTestPortNum-1:0]		oTestPort
);


//----------------------------------------------------------
// AudioTxUnit
//----------------------------------------------------------
wire 						wAudioCkeCsr;
wire 	[ 6:0]				wAudioToneCsr;
wire 						wAudioSelCsr;
wire 	[ 7:0]				wAudioDutyCsr;
wire 	[ pMemBitWidth-1:0] wAudioDmaAdrsCsr;
wire 	[ pMemBitWidth-1:0] wAudioDmaLenCsr;
wire 						wAudioDmaEnCsr;

AudioTxUnit #(
	.pSamplingBitWidth	(pSamplingBitWidth),
	.pMemBitWidth		(pMemBitWidth),
	.pTestPortUsed		(pTestPortUsed),
	.pTestPortNum		(pTestPortNum)
) AudioTxUnit (
	.oAudioMclk			(oAudioMclk),
	//
	.iMUfiRd			(iMUfiRd),
	.iMUfiREd			(iMUfiREd),
	.oMUfiAdrs			(oMUfiAdrs),
	.oMUfiEd			(oMUfiEd),
	.oMUfiVd			(oMUfiVd),
	.iMUfiRdy			(iMUfiRdy),
	//
	.iAudioCke			(wAudioCkeCsr),
	.iAudioTone			(wAudioToneCsr),
	.iAudioSel			(wAudioSelCsr),
	.iAudioDuty			(wAudioDutyCsr),
	.iAudioDmaAdrs		(wAudioDmaAdrsCsr),
	.iAudioDmaLen		(wAudioDmaLenCsr),
	.iAudioDmaEn		(wAudioDmaEnCsr),
    .iSysRst			(iSysRst),
	.iSysClk 			(iSysClk),
	.iAudioRst			(iAudioRst),
	.iAudioClk			(iAudioClk),
	//
	.oTestPort			(oTestPort)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
AudioTxCsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),
	.pBusAdrsBit		(pBusAdrsBit),
	.pCsrAdrsWidth		(pCsrAdrsWidth),
	.pCsrActiveWidth	(pCsrActiveWidth),
	.pMemBitWidth		(pMemBitWidth)
) AudioTxCsr (
	.oSUsiRd			(oSUsiRd),
	.oSUsiREd			(oSUsiREd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	.oAudioCke			(wAudioCkeCsr),
	.oAudioTone			(wAudioToneCsr),
	.oAudioSel			(wAudioSelCsr),
	.oAudioDuty			(wAudioDutyCsr),
	.oAudioDmaAdrs		(wAudioDmaAdrsCsr),
	.oAudioDmaLen		(wAudioDmaLenCsr),
	.oAudioDmaEn		(wAudioDmaEnCsr),
	.iSysRst			(iSysRst),
	.iSysClk			(iSysClk)
);

endmodule