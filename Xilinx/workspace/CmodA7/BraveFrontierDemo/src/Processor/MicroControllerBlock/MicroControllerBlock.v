//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// プロセッサ内部構造の Master を司るブロック
// 独自の I/F BUS をマスターの立場から操作し、
// BUS に接続されている Slaveブロック の操作を行う。
//----------------------------------------------------------
module MicroControllerBlock #(
	parameter							pBusBlockConnect 	= 1,
	parameter 							pBlockAdrsMap 		= 8,
	parameter [pBlockAdrsMap-1:0] 		pAdrsMap  			= 'h01,
	parameter							pBusAdrsBit			= 16,	// Usi,Ufi 共通
	parameter							pUfiBusWidth		= 8,
	parameter 							pCsrAdrsWidth   	= 16,
	parameter							pCsrActiveWidth 	= 16,
	parameter							pMemAdrsWidth		= 19
)(
    // Internal Port
	// Bus Master Read
	input	[31:0]						iMUsiRd,	// CSR Read Data
	input	[pBusBlockConnect-1:0]		iMUsiREd,	// Read Assert
	// Bus Master Write
	output	[31:0]						oMUsiWd,	// Write Data
	output	[pBusAdrsBit-1:0]			oMUsiAdrs,	// Write address
	output								oMUsiWEd,	// Write Data Enable
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]			iMUfiRd,	// Read Data
	input 								iMUfiREd,	// Read Data Enable
	// Ufi Master Write
/*
 2022-10-29
 使用予定の PSRAM のアドレスは h0000_0000 ~ h01FF_FFFF [24:0]
 [31:25] はフリースペースになるため、MCS から UFIB 経由で Slave にアクセスするときに、
 どの Slave に要求しているかの条件分岐に使用することにした。
 条件分岐は UFIB module 内で行う。
 oMUfiAdrs
 [31:28] 予約
 [27:25] 100:Atb, 010:Vtb, 001:Ram
 [24: 0] HyperRam Adrs
 */
	output 	[pUfiBusWidth-1:0]			oMUfiWd,
	output 	[pBusAdrsBit-1:0]			oMUfiAdrs,
	output 								oMUfiWEd,	// Write Adrs Data Enable
	output 								oMUfiREd,	// Read Adrs Data Enable
	output 								oMUfiVd,	// Data Valid
	output 								oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input 								iMUfiRdy,	// Ufi Bus 転送可能時 Assert
    // CLK Reset
    input           					iSysRst,
    input           					iSysClk
);

assign oMUfiWd		= {pUfiBusWidth{1'b0}}; // のちのち UFI 処理追加
assign oMUfiAdrs	= {pBusAdrsBit{1'b0}};
assign oMUfiWEd		= 1'b0;
assign oMUfiREd		= 1'b0;
assign oMUfiVd		= 1'b0;
assign oMUfiCmd		= 1'b0;


//----------------------------------------------------------
// デバッグ用 MicroBlaze
//----------------------------------------------------------
// wire [31:0] 		wMcsWd;
// wire [ 7:0] 		wMcsAdrs;
// wire 				wMcsCke;
// reg  [31:0]			qMcsManualRd;
// reg  [31:0]			qMcsAutoRd;
// reg  [pBusBlockConnect-1:0] 	qMcsRd;

// microblaze_mcs_0 MCS (
// 	.Clk			(iSysClk),
// 	.Reset			(iSysRst),
// 	.UART_rxd		(iUartRx),
// 	.UART_txd		(oUartTx),
// 	.GPIO1_tri_i	(qMcsManualRd),
// 	.GPIO2_tri_i	(qMcsAutoRd),
// 	.GPIO3_tri_i	({23'd0, qMcsRd}),
// 	.GPIO1_tri_o	(wMcsWd),
// 	.GPIO2_tri_o	(wMcsAdrs),
// 	.GPIO3_tri_o	(wMcsCke)
// );

//-----------------------------------------------------------------------------
// MCS
//-----------------------------------------------------------------------------
wire [31:0]					wMUsiRd;
wire [pBusBlockConnect-1:0]	wMUsiREd;
wire [31:0] 				wMcbCsrWd;
wire [pBusAdrsBit-1:0] 		wMcbCsrAdrs;
wire 						wMcbCsrCke;

MicroControllerUnit #(
	.pBusAdrsBit			(pBusAdrsBit),
	.pUfiBusWidth			(pUfiBusWidth),
	.pMemAdrsWidth			(pMemAdrsWidth)
) MicroControllerUnit (
	.iMUsiRd				(wMUsiRd),
	.iMUsiREd				(wMUsiREd),
	.oMUsiWd				(wMcbCsrWd),
	.oMUsiAdrs				(wMcbCsrAdrs),
	.oMUsiWEd				(wMcbCsrCke),
	.iSysRst				(iSysRst),
	.iSysClk				(iSysClk)
);


//-----------------------------------------------------------------------------
// CSR
//-----------------------------------------------------------------------------
MicroControllerCsr #(
	.pBusBlockConnect		(pBusBlockConnect),
	.pBlockAdrsMap			(pBlockAdrsMap),
	.pAdrsMap				(pAdrsMap),
	.pBusAdrsBit			(pBusAdrsBit),
	.pCsrAdrsWidth			(pCsrAdrsWidth),
	.pCsrActiveWidth		(pCsrActiveWidth),
	.pMemAdrsWidth			(pMemAdrsWidth)
) MICRO_CONTROLLER_CSR (
	// Slave Output Side
	.iWd					(wMcbCsrWd),
	.iAdrs					(wMcbCsrAdrs),
	.iWCke					(wMcbCsrCke),
	.oRd					(wMcbManualRd),
	.oMUsiWd				(oMUsiWd),
	.oMUsiAdrs				(oMUsiAdrs),
	.oMUsiWEd				(oMUsiWEd),
	// Slave Input Side
	.iMUsiRd				(iMUsiRd),
	.iMUsiREd				(iMUsiREd),
	.oMUsiRd				(wMUsiRd),
	.oMUsiREd				(wMUsiREd),
	//
	.iSysRst				(iSysRst),
	.iSysClk				(iSysClk)
);

endmodule