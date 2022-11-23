//----------------------------------------------------------
// Create 2022/10/14
// Author koutakimura
// -
// 座標とマップ情報からマップチップのデータを算出し、マップのピクセルデータを生成する
//----------------------------------------------------------
module FieldDraw #(
    parameter                   			pHdisplayWidth  = 11,
    parameter                   			pVdisplayWidth  = 11,
	parameter								pColorDepth		= 16,
	//
	parameter								pFifoDepth 		= 16,
	parameter								pFifoBitWidth	= 16
)(
	// Internal Port
	input	[pHdisplayWidth-1:0]			iHdisplay,	// 画面横サイズ
	input	[pVdisplayWidth-1:0]			iVdisplay,	// 画面縦サイズ
    input  	[pHdisplayWidth-1:0]			iHpos,		// 現在の横座標
    input  	[pVdisplayWidth-1:0]			iVpos,		// 現在の縦座標
	input 									iFe,		// Frame End
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
// マップ情報・座標から BRAM に保存されているマップチップのデータを算出
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
reg rWe;	// 前段の pixelデータが 1clk 遅れのためタイミングを合わせる

fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) InstFieldDrawFifo (
	// src side
	.iWd			(wPixel),
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

always @(posedge iClk)
begin
	if (iRst) 		rWe <= 1'b0;
	else if (iEds)	rWe <= 1'b1;
	else 			rWe <= 1'b0;
end


endmodule