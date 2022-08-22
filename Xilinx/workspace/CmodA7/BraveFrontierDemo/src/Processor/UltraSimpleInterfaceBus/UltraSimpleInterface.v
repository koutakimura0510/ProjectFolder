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
	// variable parameter
	parameter [3:0]						pBusSlaveConnect 		= 1,				// Busに接続する Slave数 最大16
	parameter 							pBusDataBit				= 32,				// Bus幅
	parameter							pBusAdrsBit				= 16,
	parameter							pBlockAdrsMap			= 8,
	parameter [pBlockAdrsMap-1:0]		pGpioAdrsMap			= 'h1,
	parameter [pBlockAdrsMap-1:0]		pSPIAdrsMap				= 'h2,
	parameter [pBlockAdrsMap-1:0]		pI2CAdrsMap				= 'h3,
	parameter [pBlockAdrsMap-1:0]		pPGBAdrsMap				= 'h4,
	parameter [pBlockAdrsMap-1:0]		pAGBAdrsMap				= 'h5,
	parameter [pBlockAdrsMap-1:0]		pRAMAdrsMap				= 'h6,
	// Not variable parameter
	parameter 							pBusLen 				= (pBusDataBit * pBusSlaveConnect) - 1'b1,
	parameter [3:0]						pBusSlaveConnectWidth 	= pBusSlaveConnect - 1'b1
)(
    // Internal Port
	// Bus Master Read
	output	[31:0]						oMUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	output	[pBusSlaveConnectWidth:0]	oMUsiREd,	// Slave アクセス可能時 Assert
	// Bus Master Write
	input 	[31:0]						iMUsiWd,	// 書き込みデータ
	input 	[pBusAdrsBit-1:0]			iMUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	input 								iMUsiWEd,	// コマンド有効時 Assert
	// Bus Slave Read / Master In <- Slave Out
	output	[31:0]						oSUsiWd,	// 書き込みデータ
	output	[pBusAdrsBit-1:0]			oSUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	output								oSUsiWCke,	// コマンド有効時 Assert
	// Bus Slave Write / Master Out -> Slave In
	input	[pBusLen:0]					iSUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusSlaveConnectWidth:0]	iSUsiREd,	// Slave アクセス可能時 Assert
    // CLK Reset
    input           					iUsiClk, 
    input           					iUsiRst
);

//----------------------------------------------------------
// 手動でソースコードを変更しないで済むように Bit 指定を計算
//----------------------------------------------------------
localparam lpGpioAdrsMsb 	= (pBusDataBit	* pGpioAdrsMap) - 1;
localparam lpGpioAdrsLsb 	=  pBusDataBit	* (pGpioAdrsMap - 1);
//
localparam lpSPIAdrsMsb 	= (pBusDataBit  * pSPIAdrsMap) - 1;
localparam lpSPIAdrsLsb 	= pBusDataBit   * (pSPIAdrsMap - 1);
//
localparam lpI2CAdrsMsb 	= (pBusDataBit  * pI2CAdrsMap) - 1;
localparam lpI2CAdrsLsb 	= pBusDataBit   * (pI2CAdrsMap - 1);
//
localparam lpPGBAdrsMsb 	= (pBusDataBit  * pPGBAdrsMap) - 1;
localparam lpPGBAdrsLsb 	= pBusDataBit   * (pPGBAdrsMap - 1);
//
localparam lpAGBAdrsMsb 	= (pBusDataBit  * pAGBAdrsMap) - 1;
localparam lpAGBAdrsLsb 	= pBusDataBit   * (pAGBAdrsMap - 1);
//
localparam lpRAMAdrsMsb 	= (pBusDataBit 	* pRAMAdrsMap) - 1;
localparam lpRAMAdrsLsb 	= pBusDataBit 	* (pRAMAdrsMap - 1);
//
//----------------------------------------------------------
// バスクロックで バス経由データ保存
//----------------------------------------------------------
// Master -> Slave
reg [31:0] 						rMUsiWd;				assign oSUsiWd		= rMUsiWd;
reg [pBusAdrsBit-1:0]			rMUsiAdrs;				assign oSUsiAdrs	= rMUsiAdrs;
reg 							rMUsiWEd;				assign oSUsiWCke	= rMUsiWEd;
// Slave -> Master
reg [31:0] 						rSUsiRd;				assign oMUsiRd		= rSUsiRd;
reg	[pBusSlaveConnectWidth:0]	rSUsiREd;				assign oMUsiREd		= rSUsiREd;

always @(posedge iUsiClk)
begin
	// Master -> Slave Side
	if (iUsiRst) 	rMUsiWd 	<= {pBusDataBit{1'b0}};
	else 			rMUsiWd 	<= iMUsiWd;

	if (iUsiRst) 	rMUsiAdrs 	<= {pBusDataBit{1'b0}};
	else 			rMUsiAdrs 	<= iMUsiAdrs;

	if (iUsiRst) 	rMUsiWEd 	<= {pBusSlaveConnectWidth{1'b0}};
	else 			rMUsiWEd 	<= iMUsiWEd;

	// Slave -> Master Side
	if (iUsiRst) 	rSUsiREd 	<= {pBusSlaveConnectWidth{1'b0}};
	else 			rSUsiREd 	<= iSUsiREd;

	case (iMUsiAdrs[pBlockAdrsMap + 3'd7:8])
		pGpioAdrsMap:	rSUsiRd <= iSUsiRd[lpGpioAdrsMsb	:	lpGpioAdrsLsb];
		pSPIAdrsMap:	rSUsiRd <= iSUsiRd[lpSPIAdrsMsb		:	lpSPIAdrsLsb];
		pI2CAdrsMap:	rSUsiRd <= iSUsiRd[lpI2CAdrsMsb		:	lpI2CAdrsLsb];
		pPGBAdrsMap:	rSUsiRd <= iSUsiRd[lpPGBAdrsMsb		:	lpPGBAdrsLsb];
		pAGBAdrsMap:	rSUsiRd <= iSUsiRd[lpAGBAdrsMsb		:	lpAGBAdrsLsb];
		pRAMAdrsMap:	rSUsiRd <= iSUsiRd[lpRAMAdrsMsb		:	lpRAMAdrsLsb];
		default:		rSUsiRd <= 'h1234_5678;		// アドレスの判定バグを分かりやすくするためのデータ
	endcase
end

endmodule