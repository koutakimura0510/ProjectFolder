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
	parameter							pBusBlockConnect 		= 1,				// Bus接続ブロック数
	parameter 							pUsiBusWidth			= 32,				// Bus幅
	parameter							pBusAdrsBit				= 32,
	parameter							pBlockAdrsMap			= 8,
	parameter [pBlockAdrsMap-1:0]		pGpioAdrsMap			= 'h1,
	parameter [pBlockAdrsMap-1:0]		pSPIAdrsMap				= 'h2,
	parameter [pBlockAdrsMap-1:0]		pI2CAdrsMap				= 'h3,
	parameter [pBlockAdrsMap-1:0]		pVTBAdrsMap				= 'h4,
	parameter [pBlockAdrsMap-1:0]		pAGBAdrsMap				= 'h5,
	parameter [pBlockAdrsMap-1:0]		pRAMAdrsMap				= 'h6,
	parameter 							pCsrAdrsWidth			= 8,
	// Not variable parameter
	parameter 							pBusLen 				= (pUsiBusWidth * pBusBlockConnect) - 1'b1,
	parameter [3:0]						pBusBlockConnectWidth 	= pBusBlockConnect - 1'b1
)(
    // Internal Port
	// Bus Master Read
	output	[31:0]						oMUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	output	[pBusBlockConnectWidth:0]	oMUsiREd,	// Slave アクセス可能時 Assert
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
	input	[pBusBlockConnectWidth:0]	iSUsiREd,	// Slave アクセス可能時 Assert
    // CLK Reset
    input           					iUsiClk, 
    input           					iUsiRst
);

//----------------------------------------------------------
// 手動でソースコードを変更しないで済むように Bit 指定を計算
//----------------------------------------------------------
localparam lpGpioAdrsMsb 	= (pUsiBusWidth	* pGpioAdrsMap) - 1;
localparam lpGpioAdrsLsb 	=  pUsiBusWidth	* (pGpioAdrsMap - 1);
//
localparam lpSPIAdrsMsb 	= (pUsiBusWidth  * pSPIAdrsMap) - 1;
localparam lpSPIAdrsLsb 	= pUsiBusWidth   * (pSPIAdrsMap - 1);
//
localparam lpI2CAdrsMsb 	= (pUsiBusWidth  * pI2CAdrsMap) - 1;
localparam lpI2CAdrsLsb 	= pUsiBusWidth   * (pI2CAdrsMap - 1);
//
localparam lpPGBAdrsMsb 	= (pUsiBusWidth  * pVTBAdrsMap) - 1;
localparam lpPGBAdrsLsb 	= pUsiBusWidth   * (pVTBAdrsMap - 1);
//
localparam lpAGBAdrsMsb 	= (pUsiBusWidth  * pAGBAdrsMap) - 1;
localparam lpAGBAdrsLsb 	= pUsiBusWidth   * (pAGBAdrsMap - 1);
//
localparam lpRAMAdrsMsb 	= (pUsiBusWidth 	* pRAMAdrsMap) - 1;
localparam lpRAMAdrsLsb 	= pUsiBusWidth 	* (pRAMAdrsMap - 1);
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
reg	[pBusBlockConnectWidth:0]	rSUsiREd;				assign oMUsiREd		= rSUsiREd;
//
reg [pBusBlockConnect-1:0]		qAdrsMatch;

always @(posedge iUsiClk)
begin
	// Master -> Slave Side
	if (iUsiRst) 	rMUsiWd 	<= {pUsiBusWidth{1'b0}};
	else 			rMUsiWd 	<= iMUsiWd;

	if (iUsiRst) 	rMUsiAdrs 	<= {pUsiBusWidth{1'b0}};
	else 			rMUsiAdrs 	<= iMUsiAdrs;

	if (iUsiRst) 	rMUsiWEd 	<= {pBusBlockConnectWidth{1'b0}};
	else 			rMUsiWEd 	<= iMUsiWEd;

	// Slave -> Master Side
	if (iUsiRst) 	rSUsiREd 	<= {pBusBlockConnectWidth{1'b0}};
	else 			rSUsiREd 	<= iSUsiREd;

	case (iMUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:pCsrAdrsWidth])
		pGpioAdrsMap:	rSUsiRd <= iSUsiRd[lpGpioAdrsMsb	:	lpGpioAdrsLsb];
		pSPIAdrsMap:	rSUsiRd <= iSUsiRd[lpSPIAdrsMsb		:	lpSPIAdrsLsb];
		pI2CAdrsMap:	rSUsiRd <= iSUsiRd[lpI2CAdrsMsb		:	lpI2CAdrsLsb];
		pVTBAdrsMap:	rSUsiRd <= iSUsiRd[lpPGBAdrsMsb		:	lpPGBAdrsLsb];
		pAGBAdrsMap:	rSUsiRd <= iSUsiRd[lpAGBAdrsMsb		:	lpAGBAdrsLsb];
		pRAMAdrsMap:	rSUsiRd <= iSUsiRd[lpRAMAdrsMsb		:	lpRAMAdrsLsb];
		default:		rSUsiRd <= 'h1234_5678;		// アドレスの判定バグを分かりやすくするためのデータ
	endcase
end

endmodule