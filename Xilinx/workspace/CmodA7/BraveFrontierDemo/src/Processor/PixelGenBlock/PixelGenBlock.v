//----------------------------------------------------------
// Create  2022/08/27
// Author  KoutaKimura
// -
// Video 信号の管理を司るブロック
// 
//----------------------------------------------------------
module PixelGenBlock #(
	// variable
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h05,
	parameter						pBusAdrsBit		= 16,
	//
    parameter       				pHdisplay		= 480,
    parameter       				pHback			= 43,
    parameter       				pHfront			= 8,
    parameter       				pHpulse			= 30,
    parameter       				pVdisplay		= 272,
    parameter       				pVfront			= 12,
    parameter       				pVback			= 4,
    parameter       				pVpulse			= 10,
	//
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
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// CLK Rst
	input 							iSysClk,
	input 							iPixelClk,
	input  							iSysRst
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

PixelGenUnit #(
    .pHdisplayWidth		(pHdisplayWidth),
    .pVdisplayWidth		(pVdisplayWidth)
) PIXEL_GEN_UNIT (
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
	.iSysClk			(iSysClk),
	.iPixelClk			(iPixelClk),
	.iSysRst			(iSysRst)
);


//-----------------------------------------------------------------------------
// Csr
//-----------------------------------------------------------------------------
PixelGenCsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),	
	.pBusAdrsBit		(pBusAdrsBit),
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
) PIXEL_GEN_CSR (
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
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

endmodule