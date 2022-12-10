//----------------------------------------------------------
// Create 2022/12/03
// Author koutakimura
// -
// Debug 用途に Demo 動作
//----------------------------------------------------------
module VpgDemo #(
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
    input  	[pHdisplayWidth-1:0]    		iHpos,		// 現在の横座標
    input  	[pVdisplayWidth-1:0]    		iVpos,		// 現在の縦座標
	input 									iFe,
	// FIFO Side
    input	[pColorDepth-1:0]				iColor,		// 描画色
	input 									iEds,		// Enable Data Src
	output 									oFull,		// FIFO Full
	output 									oVdd,		// Valid Dest Data 
    output 	[pColorDepth-1:0]    			oDd,		// Dest Data
	input 									iEdd,		// Enable Data Dest
	output 									oEmp,		// FIFO Empty
	// Clk rst
    input                       			iRst,
    input                       			iClk
);


//-----------------------------------------------------------------------------
// 
//-----------------------------------------------------------------------------
reg rLeftDir;
reg rRightDir;
wire wRWallPX;
wire wLWallPX;

always @(posedge iClk)
begin
	if (iRst)
	begin 
		rLeftDir  <= 1'b0;
		rRightDir <= 1'b1;
	end
	else
	begin
		case ({wRWallPX, wLWallPX})
			'b01:		rLeftDir <= 1'b0;
			'b10:		rLeftDir <= 1'b1;
			default:	rLeftDir <= rLeftDir;
		endcase

		case ({wRWallPX, wLWallPX})
			'b01:		rRightDir <= 1'b1;
			'b10:		rRightDir <= 1'b0;
			default:	rRightDir <= rRightDir;
		endcase
	end
end


//-----------------------------------------------------------------------------
// 描画座標の更新
//-----------------------------------------------------------------------------
localparam pDashGainBitWdith = 4;
localparam pJumpJyroBitWidth = 4;

wire signed [pHdisplayWidth:0] wDLeftX;
wire signed [pHdisplayWidth:0] wDRightX;
wire signed [pVdisplayWidth:0] wDTopY;
wire signed [pVdisplayWidth:0] wDUnderY;

ObjectPosGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pDashGainBitWdith	(pDashGainBitWdith),
	.pJumpJyroBitWidth	(pJumpJyroBitWidth)
) ObjectPosGen (
	.oDLeftX			(wDLeftX),
	.oDRightX			(wDRightX),
	.oDTopY				(wDTopY),
	.oDUnderY			(wDUnderY),
	//
	.iHdisplay			(iHdisplay),
	.iVdisplay			(iVdisplay),
	.iFe				(iFe),
	//
	.iDInitX			(0),
	.iDInitY			(271-31),
	.iDSizeX			(31),
	.iDSizeY			(31),
	//
	.iDashGainX			(4),
	.iDashCkeX			(1'b1),
	//
	.iJumpPeakY			(100),
	.iJumpGainY			(10),
	.iJumpJyroMaxY		(10),
	.iJumpJyroMinY		(1),
	.iJumpUpdateTiming  (1),
	.iJumpCkeY			(1'b1),
	//
	.iBasicGainX		(0),
	.iBasicGainY		(0),
	//
	.iLeftCkeX			(rLeftDir),
	.iRightCkeX			(rRightDir),
	.iTopCkeY			(1'b1),
	.iUnderCkeY			(1'b0),
	//
	.oRightWallPointX	(wRWallPX),
	.oLeftWallPointX	(wLWallPX),
	//
	.iRst				(iRst),
	.iClk				(iClk)
);



//-----------------------------------------------------------------------------
// 四角形の生成
//-----------------------------------------------------------------------------
wire [pColorDepth-1:0] wPixel;

DotSquareGen #(
	.pHdisplayWidth		(pHdisplayWidth),
	.pVdisplayWidth		(pVdisplayWidth),
	.pColorDepth		(pColorDepth)
) DotSquareGen (
	.oPixel 			(wPixel),
	// .oPixel 			(oDd),
	.iColor				(iColor),
	.iHpos				(iHpos),
	.iVpos				(iVpos),
	.iDLeftX			(wDLeftX),
	.iDRightX			(wDRightX),
	.iDTopY				(wDTopY),
	.iDUnderY			(wDUnderY),
	//
	.iRst				(iRst),
	.iClk				(iClk)
);


//-----------------------------------------------------------------------------
// 他の DotGenerator とタイミングを合わせるため FIFO 経由で出力データの制御を行う
//-----------------------------------------------------------------------------
reg rWe;	// 前段の pixelデータが 1clk 遅れのためタイミングを合わせる

fifoController #(
	.pFifoDepth		(pFifoDepth),
	.pFifoBitWidth	(pFifoBitWidth)
) InstDotSquareFifo (
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