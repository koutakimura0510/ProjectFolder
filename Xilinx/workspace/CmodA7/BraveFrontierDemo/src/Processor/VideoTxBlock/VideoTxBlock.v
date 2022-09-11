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
	// Display Size
    parameter       				pHdisplay		= 480,
    parameter       				pHback			= 43,
    parameter       				pHfront			= 8,
    parameter       				pHpulse			= 30,
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
	parameter 						pVpulseWidth	= 5
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
	output 							oMUfiEd,	// Adrs Data Enable
	output 							oMUfiVd,	// Data Valid
	output 							oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input 							iMUfiRdy,	// メモリと通信可能時 High
	// CLK Rst
	input  							iSysRst,
	input 							iSysClk,
	input 							iVideoClk
);

assign oMUfiWd		= {pUfiBusWidth{1'b0}};
assign oMUfiAdrs	= {pBusAdrsBit{1'b0}};
assign oMUfiEd		= 1'b0;
assign oMUfiVd		= 1'b0;
assign oMUfiCmd		= 1'b0;


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

VideoTxUnit #(
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
	.iSysClk			(iSysClk),
	.iVideoClk			(iVideoClk),
	.iSysRst			(iSysRst),
	// debug
	.oFe 				()
);


//-----------------------------------------------------------------------------
// Video Tx Generator Csr
//-----------------------------------------------------------------------------
VideoTxCsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),	
	.pBusAdrsBit		(pBusAdrsBit),
	.pCsrAdrsWidth		(pCsrAdrsWidth),
	.pCsrActiveWidth	(pCsrActiveWidth),
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
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);


endmodule