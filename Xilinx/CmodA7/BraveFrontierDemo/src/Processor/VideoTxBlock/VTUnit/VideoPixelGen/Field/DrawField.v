//----------------------------------------------------------
// Create 2022/11/23
// Author koutakimura
// -
// FIled1 描画データの管理を行う
//----------------------------------------------------------
module DrawField #(
    parameter                   		pMapChipX  		= 16,
    parameter                   		pMapChipY  		= 16,
	parameter							pColorDepth		= 16
)(
	// Internal Port
	// Internal Port
	input	[pMapInfoWidth-1:0]			iRamWd,				// MapInfo Write Data
	input	[pMapSizeBitWidth-1:0]		iRamWAdrs,			// MapInfo Write Adrs	
	input 								iRamWCke,			// MapInfo Write Enable
	//
	input	[pMapSizeBitWidth-1:0]		iMapInfoRAdrs,		// (DisplayVpos + UnitXpos + FiledXpos) / MapchipXSize の値
	// control
	input 									iEds,		// Enable Data Src
	output 									oFull,		// FIFO Full
	output 									oVdd,		// Valid Dest Data 
    output 	[pColorDepth-1:0]    			oDd,		// Dest Data
	input 									iEdd,		// Enable Data Dest
	output 									oEmp,		// FIFO Empty
	// Clk rst
    input									iRst,
    input									iClk
);


//-----------------------------------------------------------------------------
// BRAM に Filad 描画データを書き込み、読み込み
//-----------------------------------------------------------------------------
(* ram_style = "block" *) reg [pColorDepth-1:0] rMapChipRam [0:32768];

always @(posedge iClk)
begin
	if (iMapInfoWCke)	rMapInfoFifo[iMapInfoWAdrs] <= iMapInfoWd;

	rMapInfo <= rMapInfoFifo[iMapInfoRAdrs];
end



endmodule