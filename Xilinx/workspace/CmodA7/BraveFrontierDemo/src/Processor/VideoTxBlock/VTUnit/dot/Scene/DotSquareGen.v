//----------------------------------------------------------
// Create 2022/09/08
// Author koutakimura
// -
// Window 全体に加工を施す module 使用例としては下記のとおりである
// 
// 
//----------------------------------------------------------
module SceneChange #(
    parameter                   	pHdisplayWidth  = 11,
    parameter                   	pVdisplayWidth  = 11,
	parameter						pColorDepth		= 16,
	parameter 						pFifoDepth		= 16,
	parameter 						pFifoBitWidth	= 16
)(
	// Internal Port
	// Status
    input  [pColorDepth-1:0]		iPixel,		// 描画色
    input  [pHdisplayWidth-1:0]     iHpos,		// 現在の横幅の座標
    input  [pVdisplayWidth-1:0]     iVpos,		// 現在の立幅の座標
    input  [pHdisplayWidth-1:0]     iDxs,		// 描画開始 X座標 Draw X Start
    input  [pHdisplayWidth-1:0]     iDxe,		// 描画終了 X座標 Draw X End
    input  [pVdisplayWidth-1:0]     iDys,		// 描画開始 Y座標 Draw Y Start
    input  [pVdisplayWidth-1:0]     iDye,		// 描画終了 Y座標 Draw Y End
	// control
	input 							iEds,
	output 							oFull,
    output [pColorDepth-1:0]    	oDd,		// Dest Data
	output 							oVdd,		// Valid Dest Data 
	input 							iEdd,		// Enable Dest Data
	output 							oEmp,
	// Clk rst
    input                       	iRst,
    input                       	iClk
);


//----------------------------------------------------------
// 指定色のデータ及び範囲外であれば透過値最大のデータを出力
//----------------------------------------------------------
reg [pColorDepth-1:0] rPixel;
reg rWe;
reg qCke;
reg [3:0] qPosMatch;

always @(posedge iClk)
begin
	if (qCke) 		rPixel <= iPixel;
    else 			rPixel <= {pColorDepth{1'b1}};

    if (iRst)   	rWe <= 1'd0;
	else if (iEds)	rWe <= 1'b1;
    else        	rWe <= 1'd0;
end

always @*
begin
	// 指定範囲チェック
    qPosMatch[0] <= (iDxs  <= iHpos);
    qPosMatch[1] <= (iHpos < iDxe);
    qPosMatch[2] <= (iDys  <= iVpos);
    qPosMatch[3] <= (iVpos < iDye);
	qCke <= &(qPosMatch);
end


//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) InstDotSquareFifo (
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