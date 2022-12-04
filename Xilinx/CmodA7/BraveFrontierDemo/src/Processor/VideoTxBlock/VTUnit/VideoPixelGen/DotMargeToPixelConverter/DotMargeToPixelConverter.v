 //----------------------------------------------------------
 // Create 2022/09/07
 // Author koutakimura
 // -
 // ドットデータを結合し一つのピクセルデータに変換する
 //----------------------------------------------------------
module DotMargeToPixelConverter #(
	parameter						pColorDepth		= 16,
	parameter 						pFifoDepth		= 16,
	parameter 						pFifoBitWidth	= 16
)(
	// Internal Port
    input  [pColorDepth-1:0]		iField,
    input  [pColorDepth-1:0]		iNpc,
    input  [pColorDepth-1:0]		iPlayer,
    input  [pColorDepth-1:0]		iObject,
    input  [pColorDepth-1:0]		iEffect1,
    input  [pColorDepth-1:0]		iEffect2,
    input  [pColorDepth-1:0]		iForeground,
    input  [pColorDepth-1:0]		iMenuWindow,
    input  [pColorDepth-1:0]		iVpgDemo,
	input  [pColorDepth-1:0]		iSceneChange,
	// control
	input 							iEds,		// Enable Data Source
	output 							oFull,
    output [pFifoBitWidth-1:0]    	oDd,		// Dest Data
	output 							oVdd,		// Valid Dest Data 
	input 							iEdd,		// Enable Dest Data
	output 							oEmp,
	// Clk rst
    input                       	iRst,
    input                       	iClk
);


//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
reg [pFifoBitWidth-1:0] rPixel;
reg rWe;

always @(posedge iClk)
begin
	rPixel <= iVpgDemo[11:0];

	if (iRst) 		rWe <= 1'b0;
	else if (iEds)	rWe <= 1'b1;
	else 			rWe <= 1'b0;	// 実際は 上記のドットの合算とタイミングを合わせる
end


//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) InstDotMargeToPixelConverterFifo (
	// src side
	.iWd			(rPixel),
	.iWe			(rWe),
	.oFull			(oFull),
	// dst side
	.oRd			(oDd),
	.oRvd			(oVdd),
	.iRe			(iEdd),
	.oEmp			(oEmp),
	//
	.iRst			(iRst),
	.iClk			(iClk)
);


endmodule