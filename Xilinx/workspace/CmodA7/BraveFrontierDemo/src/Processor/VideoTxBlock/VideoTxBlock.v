//----------------------------------------------------------
// Create  2022/08/27
// Author  KoutaKimura
// -
// Video Tx Block
// 
//----------------------------------------------------------
module VideoTxBlock #(
	// variable
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h04,
	parameter						pBusAdrsBit		= 16,
	parameter						pUfiBusWidth	= 16,
	parameter 						pCsrAdrsWidth   = 16,
	parameter						pCsrActiveWidth = 16,
	parameter						pMemAdrsWidth	= 19,
	// Display Size
    // parameter       				pHdisplay		= 480,
    // parameter       				pHback			= 8,
    // parameter       				pHfront			= 2,
    // parameter       				pHpulse			= 2,
    // parameter       				pVdisplay		= 272,
    // parameter       				pVfront			= 2,
    // parameter       				pVback			= 1,
    // parameter       				pVpulse			= 2,
    parameter       				pHdisplay		= 480,
    parameter       				pHback			= 43,
    parameter       				pHfront			= 8,
    parameter       				pHpulse			= 10,
    parameter       				pVdisplay		= 272,
    parameter       				pVfront			= 12,
    parameter       				pVback			= 4,
    parameter       				pVpulse			= 10,
	// Color Depth
	parameter						pColorDepth		= 16,
	// Dual Clk FIFO Depth
	parameter						pDualClkFifoDepth = 1024,
	// Register Width
	parameter 						pHdisplayWidth	= 11,
	parameter 						pHfrontWidth	= 7,
	parameter 						pHbackWidth		= 7,
	parameter 						pHpulseWidth	= 7,
	parameter 						pVdisplayWidth	= 11,
	parameter 						pVfrontWidth	= 5,
	parameter 						pVbackWidth		= 5,
	parameter 						pVpulseWidth	= 5,
	//
	parameter						pTestPortUsed	= "no",
	parameter						pTestPortNum	= 4
)(
	// External Port
	output [7:4] 					oTftColorR,
	output [7:4] 					oTftColorG,
	output [7:4] 					oTftColorB,
	output 							oTftDclk,
	output 							oTftHSync,
	output 							oTftVSync,
	output 							oTftDe,
	output 							oTftBackLight,
	output 							oTftRst,
	// Internal Port
	// Ufi Slave Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Ufi Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]		iMUfiRd,	// Read Data
	input 							iMUfiREd,	// Read Data Enable
	// Ufi Master Write
	output [pUfiBusWidth-1:0]		oMUfiWd,
	output [pBusAdrsBit-1:0]		oMUfiAdrs,
	output 							oMUfiWEd,	// Write Adrs Data Enable
	output 							oMUfiREd,	// Read Adrs Data Enable
	output 							oMUfiVd,	// Data Valid
	output 							oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input 							iMUfiRdy,	// Ufi Bus 転送可能時 Assert
	// CLK Rst
	input  							iSysRst,
	input 							iSysClk,
	input 							iVideoClk,
	//
	output [pTestPortNum-1:0]		oTestPort
);


//-----------------------------------------------------------------------------
// Unit
//-----------------------------------------------------------------------------
wire [pHdisplayWidth-1:0] 	wHdisplayCsr;
wire [pVdisplayWidth-1:0] 	wVdisplayCsr;
wire [pHdisplayWidth:0]		wHSyncStartCsr;
wire [pHdisplayWidth:0]		wHSyncEndCsr;
wire [pHdisplayWidth:0]		wHSyncMaxCsr;
wire [pVdisplayWidth:0]		wVSyncStartCsr;
wire [pVdisplayWidth:0]		wVSyncEndCsr;
wire [pVdisplayWidth:0]		wVSyncMaxCsr;
wire 						wVtbSystemRstCsr;
wire 						wVtbVideoRstCsr;
wire 						wDisplayRstCsr;
wire [7:0]					wBlDutyRatioCsr;
wire [pMemAdrsWidth-1:0]	wDmaWAdrsCsr;
wire [pMemAdrsWidth-1:0]	wDmaRAdrsCsr;
wire [pMemAdrsWidth-1:0]	wDmaWLenCsr;
wire [pMemAdrsWidth-1:0]	wDmaRLenCsr;
wire 						wDmaEnCsr;
wire 						wFe;

VideoTxUnit #(
	.pBusAdrsBit		(pBusAdrsBit),
	.pUfiBusWidth		(pUfiBusWidth),
	.pMemAdrsWidth		(pMemAdrsWidth),
    .pHdisplayWidth		(pHdisplayWidth),
    .pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth),
	.pDualClkFifoDepth	(pDualClkFifoDepth)
) VideoTxUnit (
	.oTftColorR			(oTftColorR),
	.oTftColorG			(oTftColorG),
	.oTftColorB			(oTftColorB),
	.oTftDclk			(oTftDclk),
	.oTftHSync			(oTftHSync),
	.oTftVSync			(oTftVSync),
	.oTftDe				(oTftDe),
	.oTftBackLight		(oTftBackLight),
	.oTftRst			(oTftRst),
	//
	.iMUfiRd			(iMUfiRd),
	.iMUfiREd			(iMUfiREd),
	.oMUfiWd			(oMUfiWd),
	.oMUfiAdrs			(oMUfiAdrs),
	.oMUfiWEd			(oMUfiWEd),
	.oMUfiREd			(oMUfiREd),
	.oMUfiVd			(oMUfiVd),
	.oMUfiCmd			(oMUfiCmd),
	.iMUfiRdy			(iMUfiRdy),
	//
	.iHdisplay			(wHdisplayCsr),
	.iVdisplay			(wVdisplayCsr),
	.iHSyncStart		(wHSyncStartCsr),
	.iHSyncEnd			(wHSyncEndCsr),
	.iHSyncMax			(wHSyncMaxCsr),
	.iVSyncStart		(wVSyncStartCsr),
	.iVSyncEnd			(wVSyncEndCsr),
	.iVSyncMax			(wVSyncMaxCsr),
	//
	.iVtbSystemRst		(wVtbSystemRstCsr),
	.iVtbVideoRst		(wVtbVideoRstCsr),
	.iDisplayRst		(wDisplayRstCsr),
	.iBlDutyRatio		(wBlDutyRatioCsr),
	//
	.iDmaWAdrs			(wDmaWAdrsCsr),
	.iDmaRAdrs			(wDmaRAdrsCsr),
	.iDmaWLen			(wDmaWLenCsr),
	.iDmaRLen			(wDmaRLenCsr),
	.iDmaEn				(wDmaEnCsr),
	//
	.iSysClk			(iSysClk),
	.iVideoClk			(iVideoClk),
	.iSysRst			(iSysRst),
	// debug
	.oFe 				(wFe)
);


//-----------------------------------------------------------------------------
// Video Tx Csr Space
//-----------------------------------------------------------------------------
VideoTxCsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),	
	.pBusAdrsBit		(pBusAdrsBit),
	.pCsrAdrsWidth		(pCsrAdrsWidth),
	.pCsrActiveWidth	(pCsrActiveWidth),
	.pMemAdrsWidth		(pMemAdrsWidth),
    .pHdisplay			(pHdisplay),
    .pHfront			(pHfront),
    .pHback				(pHback),
    .pHpulse			(pHpulse),
    .pVdisplay			(pVdisplay),
    .pVfront			(pVfront),
    .pVback				(pVback),
    .pVpulse			(pVpulse),
    .pHdisplayWidth		(pHdisplayWidth),
    .pHbackWidth		(pHbackWidth),
    .pHfrontWidth		(pHfrontWidth),
    .pHpulseWidth		(pHpulseWidth),
    .pVdisplayWidth		(pVdisplayWidth),
    .pVfrontWidth		(pVfrontWidth),
    .pVbackWidth		(pVbackWidth),
    .pVpulseWidth		(pVpulseWidth)
) VideoTxCsr (
	.oSUsiRd			(oSUsiRd),
	.oSUsiREd			(oSUsiREd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	.oHdisplay			(wHdisplayCsr),
	.oVdisplay			(wVdisplayCsr),
	.oHSyncStart		(wHSyncStartCsr),
	.oHSyncEnd			(wHSyncEndCsr),
	.oHSyncMax			(wHSyncMaxCsr),
	.oVSyncStart		(wVSyncStartCsr),
	.oVSyncEnd			(wVSyncEndCsr),
	.oVSyncMax			(wVSyncMaxCsr),
	.oVtbSystemRst		(wVtbSystemRstCsr),
	.oVtbVideoRst		(wVtbVideoRstCsr),
	.oDisplayRst		(wDisplayRstCsr),
	.oBlDutyRatio		(wBlDutyRatioCsr),
	.oDmaWAdrs			(wDmaWAdrsCsr),
	.oDmaRAdrs			(wDmaRAdrsCsr),
	.oDmaWLen			(wDmaWLenCsr),
	.oDmaRLen			(wDmaRLenCsr),
	.oDmaEn				(wDmaEnCsr),
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);



//-----------------------------------------------------------------------------
// TestPort
//-----------------------------------------------------------------------------
generate
	if (pTestPortUsed == "yes")
	begin
		assign oTestPort[0] = wFe;
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