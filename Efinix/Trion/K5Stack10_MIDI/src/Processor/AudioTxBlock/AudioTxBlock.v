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
	parameter						pBusAdrsBit			= 32,
	parameter						pUfiBusWidth		= 16,
	parameter 						pCsrAdrsWidth 		= 8,
	parameter						pCsrActiveWidth 	= 8,
	parameter						pMemAdrsWidth		= 19,
	//
	parameter						pSamplingBitWidth	= 8,	// 分解能
	//
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
	output	[pBusAdrsBit-1:0]		oMUfiAdrs,
	output 							oMUfiWEd,	// Adrs Data Enable
	output 							oMUfiREd,	// Adrs Data Enable
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
localparam lpDualClkFifoDepth	= 1024;
localparam lpDmaFifoDepth		= 1024;
localparam lpFifoDepthOverride	= "no";

wire 	[pMemAdrsWidth-1:0] 	wDmaAdrsCsr;
wire 	[pMemAdrsWidth-1:0] 	wDmaLenCsr;
wire 							wDmaEnCsr;

AudioTxUnit #(
	.pBusAdrsBit		(pBusAdrsBit),
	.pUfiBusWidth		(pUfiBusWidth),
	.pMemAdrsWidth		(pMemAdrsWidth),
	.pSamplingBitWidth	(pSamplingBitWidth),
	.pDualClkFifoDepth	(lpDualClkFifoDepth),
	.pDmaFifoDepth		(lpDmaFifoDepth),
	.pFifoDepthOverride	(lpFifoDepthOverride),
	.pTestPortUsed		(pTestPortUsed),
	.pTestPortNum		(pTestPortNum)
) AudioTxUnit (
	.oAudioMclk			(oAudioMclk),
	//
	.iMUfiRd			(iMUfiRd),
	.iMUfiREd			(iMUfiREd),
	//
	.oMUfiAdrs			(oMUfiAdrs),
	.oMUfiWEd			(oMUfiWEd),
	.oMUfiREd			(oMUfiREd),
	.oMUfiVd			(oMUfiVd),
	.iMUfiRdy			(iMUfiRdy),
	//
	.iDmaAdrs			(wDmaAdrsCsr),
	.iDmaLen			(wDmaLenCsr),
	.iDmaEn				(wDmaEnCsr),
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
	.pMemAdrsWidth		(pMemAdrsWidth)
) AudioTxCsr (
	.oSUsiRd			(oSUsiRd),
	.oSUsiREd			(oSUsiREd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	.oDmaAdrs			(wDmaAdrsCsr),
	.oDmaLen			(wDmaLenCsr),
	.oDmaEn				(wDmaEnCsr),
	.iSysRst			(iSysRst),
	.iSysClk			(iSysClk)
);

endmodule