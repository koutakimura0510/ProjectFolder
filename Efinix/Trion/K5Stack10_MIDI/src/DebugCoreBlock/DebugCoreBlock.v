//-----------------------------------------------------------------------------
// Create 2023/4/17
// Author koutakimura
// -
// V1.0 : new Relaese
// 
//-----------------------------------------------------------------------------
module DebugCoreBlock #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8
)(
	// MIPI Output Ctrl
	input  oUART_TX,
	// Control Status data
	input  [7:0] iMidiRd,
	input  iMidiVd,
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);

//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
wire [2:0] wDebugMonitorSel;

DebugCoreCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth)
) DebugCoreCsr (
	// CSR
	.oI2SModuleRst(wI2SModuleRst),
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
    // CLK RST
	.iSRST(iSRST),			.iSCLK(iSCLK)
);


//-----------------------------------------------------------------------------
// UART TX
//-----------------------------------------------------------------------------
reg  [7:0] qUartTxData;

UartTX #(
	.pBaudRateGenDiv(3200)
) UartTX (
	// External Port
	.oUART_TX(oUART_TX),
	// Encord Data
	.oRd(iMidiRd),	.oVd(iMidiVd),
	// CLK RST
	.iRST(iSRST),	.iCLK(iSCLK)
);

always @*
begin
	case ({wDebugMonitorSel})
	'h00:	qUartTxData <= iMidiRd;
	default:qUartTxData <= 8'h12;
	endcase
end

endmodule