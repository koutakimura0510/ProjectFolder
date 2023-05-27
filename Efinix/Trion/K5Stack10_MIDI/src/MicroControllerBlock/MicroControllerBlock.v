//----------------------------------------------------------
// Create 2023/5/27
// Author koutakimura
// -
// プロセッサ内部構造の Master を司るブロック
// 独自の I/F BUS をマスターの立場から操作し、
// BUS に接続されている Slaveブロック の操作を行う。
//----------------------------------------------------------
module MicroControllerBlock #(
	parameter pUsiBusWidth 		= 32,
	parameter pUfiDqBusWidth 	= 16,
	parameter pUfiAdrsBusWidth 	= 32,
	parameter pUfiEnableBit 	= 32
)(
	// Usi Bus Master Read
	input  [pUsiBusWidth-1:0] iMUsiRd,
	// Usi Bus Master Write
	output [pUsiBusWidth-1:0] oMUsiWd,
	output [pUsiBusWidth-1:0] oMUsiAdrs,
	// Ufi Bus Master Read
	input  [pUfiDqBusWidth-1:0] iMUfiRd,
	input  [pUfiAdrsBusWidth-1:0] iMUfiAdrs,
	// Ufi Bus Master Write
	output [pUfiDqBusWidth-1:0] oMUfiWd,
	output [pUfiAdrsBusWidth-1:0] oMUfiAdrs,
	input  iMUfiRdy,
	// common
    input  iSRST,
    input  iSCLK
);


//-----------------------------------------------------------------------------
// 未使用 pin
//-----------------------------------------------------------------------------
assign oMUsiWd		= {pUsiBusWidth{1'b0}}; // のちのち UFI 処理追加
assign oMUsiAdrs	= {pUsiBusWidth{1'b0}};

assign oMUfiWd		= {pUfiDqBusWidth{1'b0}};
assign oMUfiAdrs	= {pUfiAdrsBusWidth{1'b0}};


//-----------------------------------------------------------------------------
// CSR
//-----------------------------------------------------------------------------
// MicroControllerCsr #(
// 	.pBlockConnectNum		(pBlockConnectNum),
// 	.pBlockAdrsWidth			(pBlockAdrsWidth),
// 	.pAdrsMap				(pAdrsMap),
// 	.pUsiBusWidth			(pUsiBusWidth),
// 	.pCsrAdrsWidth			(pCsrAdrsWidth),
// 	.pCsrActiveWidth		(pCsrActiveWidth),
// 	.pMemAdrsWidth			(pMemAdrsWidth)
// ) MICRO_CONTROLLER_CSR (
// 	// Slave Output Side
// 	.iWd					(wMcbCsrWd),
// 	.iAdrs					(wMcbCsrAdrs),
// 	.iWCke					(wMcbCsrCke),
// 	.oRd					(wMcbManualRd),
// 	.oMUsiWd				(oMUsiWd),
// 	.oMUsiAdrs				(oMUsiAdrs),
// 	.oMUsiWEd				(oMUsiWEd),
// 	// Slave Input Side
// 	// Csr に 書き込んでレジスタ経由で出力し直す
// 	.iMUsiRd				(iMUsiRd),
// 	.iMUsiREd				(iMUsiREd),
// 	.oMUsiRd				(wMUsiRd),
// 	.oMUsiREd				(wMUsiREd),
// 	//
// 	.iSRST				(iSRST),
// 	.iSCLK				(iSCLK)
// );

endmodule