//----------------------------------------------------------
// Create 2022/9/12
// Author koutakimura
// -
// System Clk と Memory Clk の クロック変換用途
// 
//----------------------------------------------------------
module RAMDualClkFifo #(
	parameter						pDualClkFifoDepth 	= 256,
	parameter						pRamDqWidth			= 8,
	parameter						pRamAdrsWidth		= 19
)(
	input 	[pRamDqWidth-1:0]		iWd,
	input	[pRamAdrsWidth-1:0]		iAdrs,
	input 							iCmd,
	input 							iWEd,
	output 							oFull,
	//
	output 	[pRamDqWidth-1:0]		oWd,
	output	[pRamAdrsWidth-1:0]		oAdrs,
	output							oCmd,
	input 							iREd,
	output 							oEmp,
	output 							oRVd,
	// 
	// Memory からの ReadData
	input 	[pRamDqWidth-1:0]		iMemWd,
	input 							iMemWEd,
	output 	[pRamDqWidth-1:0]		oMemRd,
	output 							oMemREd,
	input 							iMemRe,
	output 							oMemFull,

    // Internal Port
    input							iRst,
	input 							iSysClk,
    input							iMemClk
);


//-----------------------------------------------------------------------------
// FIFO の制御信号は、各FIFO が同じタイミングで動作することを
// 前提とするため一つのみ使用する。
//-----------------------------------------------------------------------------

// SysCLK -> MemClk 変換
fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(pRamDqWidth)
) RamDualClkFifoWd (
	.iWD		(iWd),
	.iWE		(iWEd),
	.oFLL		(oFull),
	.oRD		(oWd),
	.iRE		(iREd),
	.oRVD		(oRVd),
	.oEMP		(oEmp),
	.iSrcRst	(iRst),
	.iDstRst	(iRst),
	.iSrcClk	(iSysClk),
	.iDstClk	(iMemClk)
);

fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(pRamAdrsWidth)
) RamDualClkFifoAdrs (
	.iWD		(iAdrs),
	.iWE		(iWEd),
	.oFLL		(),
	.oRD		(oAdrs),
	.iRE		(iREd),
	.oRVD		(),
	.oEMP		(),
	.iSrcRst	(iRst),
	.iDstRst	(iRst),
	.iSrcClk	(iSysClk),
	.iDstClk	(iMemClk)
);

fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(1'b1)
) RamDualClkFifoCmd (
	.iWD		(iCmd),
	.iWE		(iWEd),
	.oFLL		(),
	.oRD		(oCmd),
	.iRE		(iREd),
	.oRVD		(),
	.oEMP		(),
	.iSrcRst	(iRst),
	.iDstRst	(iRst),
	.iSrcClk	(iSysClk),
	.iDstClk	(iMemClk)
);

// MemClk -> SysClk 変換
// Memory からの書き込みよりも読み出しが速く、
// FIFO が Full にならない前提で処理を行う。
fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(pRamDqWidth)
) RamDualClkFifoRd (
	.iWD		(iMemWd),
	.iWE		(iMemWEd),
	.oFLL		(oMemFull),
	.oRD		(oMemRd),
	.iRE		(iMemRe),
	.oRVD		(oMemREd),
	.oEMP		(),
	.iSrcRst	(iRst),
	.iDstRst	(iRst),
	.iSrcClk	(iMemClk),
	.iDstClk	(iSysClk)
);

endmodule