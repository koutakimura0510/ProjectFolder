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
module MicroControllerUnit #(
	parameter [3:0]			pBusSlaveConnect 	= 1,				// Busに接続する Slave数 最大16
	// Not Set Param
	parameter [3:0]			pBusSlaveConnectWidth 	= pBusSlaveConnect - 1'b1	// Busに接続する Slave数 最大16
)(
	// External Port
	input 					iUartRx,
	output 					oUartTx,
    // Internal Port
	// Bus Master Read
	input	[31:0]			iMUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusSlaveConnectWidth:0]	iMUsiVd,	// Slave アクセス可能時 Assert
	// Bus Master Write
	output	[31:0]			oMUsiWd,	// 書き込みデータ
	output	[31:0]			oMUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	output					oMUsiWCke,	// コマンド有効時 Assert
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


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