//----------------------------------------------------------
// Create 2022/9/12
// Author koutakimura
// -
// System Clk と Memory Clk の クロック変換用途
// 
//----------------------------------------------------------
module RAMDualClkFifo #(
	parameter						pUfiIdNumber		= 3,
	parameter						pDualClkFifoDepth 	= 256,
	parameter						pRamDqWidth			= 8,
	parameter						pRamAdrsWidth		= 19,
	parameter						pFullAlMost 		= 16
)(
	// 前段との結線
	input 	[pRamDqWidth-1:0]		iWd,
	input	[pRamAdrsWidth-1:0]		iAdrs,
	input 							iCmd,
	input 							iWEd,
	output 							oFull,
	// 後段への結線
	output 	[pRamDqWidth-1:0]		oWd,
	output	[pRamAdrsWidth-1:0]		oAdrs,
	output							oCmd,
	input 							iREd,
	output 							oEmp,
	output 							oRVd,
	// Memory からの ReadData
	input 	[pRamDqWidth-1:0]		iMemWd,
	input 							iMemWEd,
	output 	[pRamDqWidth-1:0]		oMemRd,
	output 							oMemREd,
	input 							iMemRe,
	output 							oMemFull,
	// Ufi ID Lssue
	input 	[pUfiIdNumber-1:0]		iSUfiIdI,
	output 	[pUfiIdNumber-1:0]		oSUfiIdO,
	//
	input 							iSrcRst,
	input 							iDstRst,
    // Internal Port
	input 							iSCLK,
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
	// .pFullAlMost(pFullAlMost)
) RamDualClkFifoWd (
	.iWD		(iWd),
	.iWE		(iWEd),
	.oFLL		(oFull),
	.oRD		(oWd),
	.iRE		(iREd),
	.oRVD		(oRVd),
	.oEMP		(oEmp),
	.iSrcRst	(iSrcRst),
	.iDstRst	(iDstRst),
	.iSrcClk	(iSCLK),
	.iDstClk	(iMemClk)
);

fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(pRamAdrsWidth)
	// .pFullAlMost(pFullAlMost)
) RamDualClkFifoAdrs (
	.iWD		(iAdrs),
	.iWE		(iWEd),
	.oFLL		(),
	.oRD		(oAdrs),
	.iRE		(iREd),
	.oRVD		(),
	.oEMP		(),
	.iSrcRst	(iSrcRst),
	.iDstRst	(iDstRst),
	.iSrcClk	(iSCLK),
	.iDstClk	(iMemClk)
);

fifoDualControllerGray #(
	.pBuffDepth	(pDualClkFifoDepth),
	.pBitWidth	(1'b1),
	.pFullAlMost(pFullAlMost)
) RamDualClkFifoCmd (
	.iWD		(iCmd),
	.iWE		(iWEd),
	.oFLL		(),
	.oRD		(oCmd),
	.iRE		(iREd),
	.oRVD		(),
	.oEMP		(),
	.iSrcRst	(iSrcRst),
	.iDstRst	(iDstRst),
	.iSrcClk	(iSCLK),
	.iDstClk	(iMemClk)
);


//-----------------------------------------------------------------------------
// UFIB への データ出力
// TODO 応急措置
// 無理やりタイミングを合わせるため、FifoGray3 module の Empty 信号は
// レイテンシ0 の組み合わせ出力となっている。
// メモリクロックがシステムクロックより遅い場合、タイミングエラーが出るため注意
// 
//-----------------------------------------------------------------------------
wire 					wEmp;
reg						qWEdId;
reg  					qREdId;
wire [pRamDqWidth-1:0]	wMemRd;
wire 					wMemREd;
reg	 [pRamDqWidth-1:0]	rMemRd; 		assign oMemRd	= rMemRd;
reg 					rMemREd; 		assign oMemREd	= rMemREd;

fifoDualControllerGray3 #(
	.pBuffDepth		(pDualClkFifoDepth),
	.pBitWidth		(pRamDqWidth)
	// .pFullAlMost	(pFullAlMost)
) RamDualClkFifoRd (
	.iWD			(iMemWd),
	.iWE			(iMemWEd),
	.oFLL			(oMemFull),
	.oRD			(wMemRd),
	.iRE			(qREdId),
	.oRVD			(wMemREd),
	.oEMP			(wEmp),
	.iSrcRst		(iSrcRst),
	.iDstRst		(iDstRst),
	.iSrcClk		(iMemClk),
	.iDstClk		(iSCLK)
);

always @*
begin
	rMemRd	<= wMemRd;
	rMemREd	<= wMemREd;
end

// タイミングは DualFIFORd と合わせる
// RW のタイミングによっては捨てデータが発生してしまうため
// 他の FIFO よりも多く深さをとることで改善ずる目的
localparam lpFifoDepthId = pDualClkFifoDepth << 1;

fifoController #(
	.pFifoDepth		(lpFifoDepthId),
	.pFifoBitWidth	(pUfiIdNumber)
	// .pFullAlMost	(pFullAlMost)
) RamFifoId (
	.iWd			(iSUfiIdI),
	.iWe			(qWEdId),
	.oFull			(),
	.oRd			(oSUfiIdO),
	.iRe			(qREdId),
	.oRvd			(),
	.oEmp			(),
	.iRST			(iSrcRst),
	.iCLK			(iSCLK)
);

always @*
begin
	qWEdId <= iCmd & iWEd;		// Read時の ID のみ情報として必要、write cmd は弾く
	qREdId <= (~wEmp) & iMemRe;	// 読み出しとタイミングを合わせる
end

endmodule