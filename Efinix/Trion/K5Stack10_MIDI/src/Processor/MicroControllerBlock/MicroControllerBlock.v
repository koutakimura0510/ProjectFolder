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
	parameter 							pBlockAdrsWidth 		= 8,
	parameter [pBlockAdrsWidth-1:0] 		pAdrsMap  			= 'h01,
	parameter							pUsiBusWidth			= 16,	// Usi,Ufi 共通
	parameter							pUfiBusWidth		= 8,
	parameter 							pCsrAdrsWidth   	= 16,
	parameter							pCsrActiveWidth 	= 16,
	parameter							pMemAdrsWidth		= 19
)(
	// external port
	input 								iUartRx,
	output 								oUartTx,
    // Internal Port
	// Bus Master Read
	input	[31:0]						iMUsiRd,	// CSR Read Data
	input	[pBusBlockConnect-1:0]		iMUsiREd,	// Read Assert
	// Bus Master Write
	output	[31:0]						oMUsiWd,	// Write Data
	output	[pUsiBusWidth-1:0]			oMUsiAdrs,	// Write address
	output								oMUsiWEd,	// Write Data Enable
	// Ufi Master Read
	input 	[pUfiBusWidth-1:0]			iMUfiRd,	// Read Data
	input 								iMUfiREd,	// Read Data Enable
	// Ufi Master Write
	/*
	2022-10-29
	使用予定の PSRAM のアドレスは h0000_0000 ~ h01FF_FFFF [24:0]
	[31:25] はフリースペースになるため、MCB から UFIB 経由で Slave にアクセスするときに、
	どの Slave に要求しているかの条件分岐に使用することにした。
	条件分岐は UFIB module 内で行う。

	oMUfiAdrs
	[31:28] BRAM ID 0~15
	[27:25] 100:Atb, 010:Vtb, 001:Ram
	[24: 0] HyperRam Adrs

	Ram アクセス時は制御信号 (WEd,REd,Vd,Cmd,Rdy)全て使用するが、
	Atb,Vtb アクセス時は 現在 WEd のみ使用する。
	外部RAM,ROM に保存されているシステムデータを BRAM に書き込むことはするが、現状読み込み動作は想定していない。(writeだけで十分なはず)
	*/
	output 	[pUfiBusWidth-1:0]			oMUfiWd,	// Write Data
	output 	[pUsiBusWidth-1:0]			oMUfiAdrs,	// R/W Common Adrs
	output 								oMUfiWEd,	// Write Adrs Data Enable
	output 								oMUfiREd,	// Read Adrs Data Enable
	output 								oMUfiVd,	// Data Valid
	output 								oMUfiCmd,	// High Read, Low Write
	// Ufi Master Common
	input 								iMUfiRdy,	// Ufi Bus 転送可能時 Assert
    // CLK Reset
    input           					iSRST,
    input           					iSCLK
);


//-----------------------------------------------------------------------------
// 未使用 pin
//-----------------------------------------------------------------------------
assign oMUfiWd		= {pUfiBusWidth{1'b0}}; // のちのち UFI 処理追加
assign oMUfiAdrs	= {pUsiBusWidth{1'b0}};
assign oMUfiWEd		= 1'b0;
assign oMUfiREd		= 1'b0;
assign oMUfiVd		= 1'b0;
assign oMUfiCmd		= 1'b0;


//-----------------------------------------------------------------------------
// デバッグ用 MicroBlaze
// MicroBlaze MCS DS865 - 2012 DataSheet 参照
//-----------------------------------------------------------------------------
// Read
wire [31:0]					wMcbManualRd;
wire [31:0]					wMUsiRd;
wire [pBusBlockConnect-1:0]	wMUsiREd;
// Write
wire [31:0] 				wMcbCsrWd;
wire [pUsiBusWidth-1:0] 		wMcbCsrAdrs;
wire 						wMcbCsrCke;

// microblaze_mcs_0 MCS (
// 	.Clk			(iSCLK),
// 	.Reset			(iSRST),
// 	.UART_rxd		(iUartRx),
// 	.UART_txd		(oUartTx),
// 	.GPIO1_tri_i	(wMcbManualRd),
// 	.GPIO2_tri_i	(wMUsiRd),
// 	.GPIO3_tri_i	({{(32-pBusBlockConnect){1'b0}}, wMUsiREd}),
// 	// .GPIO4_tri_i	(0),
// 	.GPIO1_tri_o	(wMcbCsrWd),
// 	.GPIO2_tri_o	(wMcbCsrAdrs),
// 	.GPIO3_tri_o	(wMcbCsrCke)
// 	// .GPIO4_tri_o	()
// );


//-----------------------------------------------------------------------------
// MCS
//-----------------------------------------------------------------------------
// wire [31:0]					wMUsiRd;
// wire [pBusBlockConnect-1:0]	wMUsiREd;
// wire [31:0] 				wMcbCsrWd;
// wire [pUsiBusWidth-1:0] 		wMcbCsrAdrs;
// wire 						wMcbCsrCke;

// MicroControllerUnit #(
// 	.pUsiBusWidth			(pUsiBusWidth),
// 	.pUfiBusWidth			(pUfiBusWidth),
// 	.pMemAdrsWidth			(pMemAdrsWidth)
// ) MicroControllerUnit (
// 	.iMUsiRd				(wMUsiRd),
// 	.iMUsiREd				(wMUsiREd),
// 	.oMUsiWd				(wMcbCsrWd),
// 	.oMUsiAdrs				(wMcbCsrAdrs),
// 	.oMUsiWEd				(wMcbCsrCke),
// 	.iSRST				(iSRST),
// 	.iSCLK				(iSCLK)
// );


//-----------------------------------------------------------------------------
// CSR
//-----------------------------------------------------------------------------
MicroControllerCsr #(
	.pBusBlockConnect		(pBusBlockConnect),
	.pBlockAdrsWidth			(pBlockAdrsWidth),
	.pAdrsMap				(pAdrsMap),
	.pUsiBusWidth			(pUsiBusWidth),
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
	// Csr に 書き込んでレジスタ経由で出力し直す
	.iMUsiRd				(iMUsiRd),
	.iMUsiREd				(iMUsiREd),
	.oMUsiRd				(wMUsiRd),
	.oMUsiREd				(wMUsiREd),
	//
	.iSRST				(iSRST),
	.iSCLK				(iSCLK)
);

endmodule