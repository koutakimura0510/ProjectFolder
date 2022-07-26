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
	parameter							pBusAdrsBit				= 15,
	parameter							pBlockAdrsMap			= 8,
	parameter [pBlockAdrsMap-1:0]		pGpioAdrsMap			= 'h0,
	parameter [pBlockAdrsMap-1:0]		pPWMAdrsMap				= 'h1,
	parameter [pBlockAdrsMap-1:0]		pSPIAdrsMap				= 'h2,
	parameter [pBlockAdrsMap-1:0]		pI2CAdrsMap				= 'h3,
	parameter [pBlockAdrsMap-1:0]		pPGBAdrsMap				= 'h4,
	parameter [pBlockAdrsMap-1:0]		pAGBAdrsMap				= 'h5,
	parameter [pBlockAdrsMap-1:0]		pVDMAAdrsMap			= 'h6,
	parameter [pBlockAdrsMap-1:0]		pADMAAdrsMap			= 'h7,
	parameter [pBlockAdrsMap-1:0]		pPSRAMAdrsMap			= 'h8,
	// Not variable parameter
	parameter 							pBusLen 				= (pBusDataBit * pBusSlaveConnect) - 1'b1,
	parameter [3:0]						pBusSlaveConnectWidth 	= pBusSlaveConnect - 1'b1
)(
    // Internal Port
	// Bus Master Read
	output	[31:0]						oMUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	output	[pBusSlaveConnectWidth:0]	oMUsiVd,	// Slave アクセス可能時 Assert
	// Bus Master Write
	input 	[31:0]						iMUsiWd,	// 書き込みデータ
	input 	[pBusAdrsBit:0]				iMUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	input 								iMUsiWCke,	// コマンド有効時 Assert
	// Bus Slave Read / Master In <- Slave Out
	output	[31:0]						oSUsiWd,	// 書き込みデータ
	output	[pBusAdrsBit:0]				oSUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	output								oSUsiWCke,	// コマンド有効時 Assert
	// Bus Slave Write / Master Out -> Slave In
	input	[pBusLen:0]					iSUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusSlaveConnectWidth:0]	iSUsiVd,	// Slave アクセス可能時 Assert
    // CLK Reset
    input           					iUsiClk, 
    input           					iUsiRst
);


//----------------------------------------------------------
// バスクロックで バス経由データ保存
//----------------------------------------------------------
// Master -> Slave
reg [31:0] 			rMUsiWd;				assign oSUsiWd		= rMUsiWd;
reg [pBusAdrsBit:0]	rMUsiAdrs;				assign oSUsiAdrs	= rMUsiAdrs;
reg 				rMUsiWCke;				assign oSUsiWCke	= rMUsiWCke;
// Slave -> Master
reg [31:0] 			rSUsiRd;				assign oMUsiRd		= rSUsiRd;
reg	[pBusSlaveConnectWidth:0]	rSUsiVd;	assign oMUsiVd		= rSUsiVd;

always @(posedge iUsiClk)
begin
	// Master -> Slave Side
	if (iUsiRst) 	rMUsiWd <= {pBusDataBit{1'b0}};
	else 			rMUsiWd <= iMUsiWd;

	if (iUsiRst) 	rMUsiAdrs <= {pBusDataBit{1'b0}};
	else 			rMUsiAdrs <= iMUsiAdrs;

	if (iUsiRst) 	rMUsiWCke <= {pBusSlaveConnectWidth{1'b0}};
	else 			rMUsiWCke <= iMUsiWCke;

	// Slave -> Master Side
	if (iUsiRst) 	rSUsiVd <= {pBusSlaveConnectWidth{1'b0}};
	else 			rSUsiVd <= iSUsiVd;

	case (iMUsiAdrs[pBlockAdrsMap + 3'd7:8])
		pGpioAdrsMap:	rSUsiRd <= iSUsiRd[ 31:  0];
		pPWMAdrsMap:	rSUsiRd <= iSUsiRd[ 63: 32];
		pSPIAdrsMap:	rSUsiRd <= iSUsiRd[ 95: 64];
		pI2CAdrsMap:	rSUsiRd <= iSUsiRd[127: 96];
		pPGBAdrsMap:	rSUsiRd <= iSUsiRd[159:128];
		pAGBAdrsMap:	rSUsiRd <= iSUsiRd[191:160];
		pVDMAAdrsMap:	rSUsiRd <= iSUsiRd[223:192];
		pADMAAdrsMap:	rSUsiRd <= iSUsiRd[255:224];
		pPSRAMAdrsMap:	rSUsiRd <= iSUsiRd[287:256];
		default:		rSUsiRd <= 'h1234_5678;		// アドレスの判定バグを分かりやすくするためのデータ
	endcase
end

endmodule