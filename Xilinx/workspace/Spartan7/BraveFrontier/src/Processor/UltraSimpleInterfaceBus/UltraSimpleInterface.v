//----------------------------------------------------------
// Create 2022/7/23
// Author koutakimura
// -
// 汎用バスシステム I/F モジュール
// 
// 接続 Image
// Master <---> Bus <---> Slave
// 				  | <---> Slave
// 				  | <---> Slave
// 				  | <---> Slave
// 
//----------------------------------------------------------
module UltraSimpleInterface #(
	parameter [3:0]			pBusNum 	= 1,				// Busに接続する Slave数 最大16
	parameter 				pBusBit		= 32,				// Bus幅
	// Not Set Param
	parameter 				pBusLen 	= (pBusBit * pBusNum) - 1'b1,
	parameter [3:0]			pBusWidth 	= pBusNum - 1'b1	// Busに接続する Slave数 最大16
)(
    // Internal Port
	// Bus Master Read
	input	[31:0]			oMUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusWidth:0]	oMUsiRdy,	// Slave アクセス可能時 Assert
	// Bus Master Write
	input 	[31:0]			iMUsiWd,	// 書き込みデータ
	input 	[31:0]			iMUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	input 					iMUsiWCke,	// コマンド有効時 Assert
	// Bus Slave Read / Master In <- Slave Out
	input	[31:0]			oSUsiWd,	// 書き込みデータ
	input	[31:0]			oSUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	input					oSUsiWCke,	// コマンド有効時 Assert
	// Bus Slave Write / Master Out -> Slave In
	input	[pBusLen:0]		iSUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusWidth:0]	iSUsiRdy,	// Slave アクセス可能時 Assert
    // CLK Reset
    input           		iUsiClk, 
    input           		iUsiRst
);


//----------------------------------------------------------
// Bus Address
//----------------------------------------------------------
localparam [7:0] 
	lpBusAdrsGPIO 	= 8'h01,
	lpBusAdrsPWM 	= 8'h02,
	lpBusAdrsSPI 	= 8'h03,
	lpBusAdrsI2C 	= 8'h04,
	lpBusAdrsPGB 	= 8'h05,
	lpBusAdrsAGB 	= 8'h06,
	lpBusAdrsVDMA 	= 8'h07,
	lpBusAdrsADMA 	= 8'h08,
	lpBusAdrsPSRAM 	= 8'h09;


//----------------------------------------------------------
// バスクロックで バス経由データ保存
//----------------------------------------------------------
// Master -> Slave
reg [31:0] 			rMUsiWd;	assign oSUsiWd		= rMUsiWd;
reg [31:0] 			rMUsiAdrs;	assign oSUsiAdrs	= rMUsiAdrs;
reg 				rMUsiWCke;	assign oSUsiWCke	= rMUsiWCke;
// Slave -> Master
reg [31:0] 			rSUsiRd;	assign oMUsiRd		= rSUsiRd;
reg	[pBusWidth:0]	rSUsiRdy	assign oMUsiRdy		= rSUsiRdy;

always @(posedge iUsiClk)
begin
	// Master -> Slave Side
	if (iUsiRst) 	rMUsiWd <= {pBusBit{1'b0}};
	else 			rMUsiWd <= iMUsiWd;

	if (iUsiRst) 	rMUsiAdrs <= {pBusBit{1'b0}};
	else 			rMUsiAdrs <= iMUsiAdrs;

	if (iUsiRst) 	rMUsiWCke <= {pBusWidth{1'b0}};
	else 			rMUsiWCke <= iMUsiWCke;

	// Slave -> Master Side
	if (iUsiRst) 	rSUsiRdy <= {pBusWidth{1'b0}};
	else 			rSUsiRdy <= iSUsiRdy;

	case (iMUsiAdrs[23:16])
	begin
		lpBusAdrsGPIO:	rSUsiRd <= iSUsiRd[ 31:  0];
		lpBusAdrsPWM:	rSUsiRd <= iSUsiRd[ 63: 32];
		lpBusAdrsSPI:	rSUsiRd <= iSUsiRd[ 95: 64];
		lpBusAdrsI2C:	rSUsiRd <= iSUsiRd[127: 96];
		lpBusAdrsPGB:	rSUsiRd <= iSUsiRd[159:128];
		lpBusAdrsAGB:	rSUsiRd <= iSUsiRd[191:160];
		lpBusAdrsVDMA:	rSUsiRd <= iSUsiRd[223:192];
		lpBusAdrsADMA:	rSUsiRd <= iSUsiRd[255:224];
		lpBusAdrsPSRAM:	rSUsiRd <= iSUsiRd[287:256];
		default:		rSUsiRd <= 'h1234_5678;		// アドレスの判定バグを分かりやすくするためのデータ
	end
	endcase
end

endmodule