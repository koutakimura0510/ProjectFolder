//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// プロセッサ内部構造の Master を司るブロック
// 独自の I/F BUS をマスターの立場から操作し、
// BUS に接続されている Slaveブロック の操作を行う。
// -
// リソース削減のため、コマンドとアドレスは同じ Port を使用する
//----------------------------------------------------------
module MicroControllerBlock #(
	parameter [3:0]	pBusSlaveConnect 	= 1,				// Busに接続する Slave数 最大16
	parameter		pBusAdrsBit			= 16,
	// Not Set Param
	parameter [3:0]	pBusSlaveConnectWidth 	= pBusSlaveConnect - 1'b1	// Busに接続する Slave数 最大16
)(
	// External Port
	input 								iUartRx,
	output 								oUartTx,
    // Internal Port
	// Bus Master Read
	input	[31:0]						iMUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusSlaveConnectWidth:0]	iMUsiVd,	// Slave アクセス可能時 Assert
	// Bus Master Write
	output	[31:0]						oMUsiWd,	// 書き込みデータ
	output	[pBusAdrsBit-1:0]			oMUsiAdrs,	// 書き込み元のアドレス指定
	output								oMUsiWEd,	// コマンド有効時 Assert
    // CLK Reset
    input           					iSysClk,
    input           					iSysRst
);


//----------------------------------------------------------
// デバッグ用 MicroBlaze
//----------------------------------------------------------
wire [31:0] 		wMcsWd;
wire [ 7:0] 		wMcsAdrs;
wire 				wMcsCke;
reg  [31:0]			qMcsManualRd;
reg  [31:0]			qMcsAutoRd;
reg  [pBusSlaveConnectWidth:0] 	qMcsRd;

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

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire [31:0]						wMcbManualRd;
wire [31:0]						wMcbAutoRd;
wire [pBusSlaveConnectWidth:0] 	wMcbRd;
reg  [31:0] 					qMcbCsrWd;
reg  [ 7:0]						qMcbCsrAdrs;
reg  							qMcbCsrCke;

MicroControllerCsr #(
	.pBusSlaveConnectWidth	(pBusSlaveConnectWidth),
	.pBusAdrsBit			(pBusAdrsBit)
) MICRO_CONTROLLER_CSR (
	.iWd		(qMcbCsrWd),
	.iAdrs		(qMcbCsrAdrs),
	.iCke		(qMcbCsrCke),
	.oRd		(wMcbManualRd),
	.iMUsiRd	(iMUsiRd),
	.iMUsiVd	(iMUsiVd),
	.oMUsiWd	(oMUsiWd),
	.oMUsiAdrs	(oMUsiAdrs),
	.oMUsiWEd	(oMUsiWEd),
	.oMUsiRd	(wMcbAutoRd),
	.oMUsiVd	(wMcbRd),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);

always @*
begin
	qMcsManualRd	<= wMcbManualRd;
	qMcsAutoRd		<= wMcbAutoRd;
	qMcsRd			<= wMcbRd;
	qMcbCsrWd		<= wMcsWd;
	qMcbCsrAdrs		<= wMcsAdrs;
	qMcbCsrCke		<= wMcsCke;
end

// //----------------------------------------------------------
// // msb側の1を検出しbit幅を取得する
// //----------------------------------------------------------
// function[  7:0]	fBitWidth;
//     input [31:0] iVAL;
//     integer			i;

//     begin
//     fBitWidth = 1;
//     for (i = 0; i < 32; i = i+1 )
//         if (iVAL[i])
// 		begin
//             fBitWidth = i+1;
//         end
//     end
// endfunction


endmodule