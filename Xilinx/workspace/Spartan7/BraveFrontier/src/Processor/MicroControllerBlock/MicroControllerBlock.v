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
	parameter 		pBusNum 	= 1,		// Busに接続する Slave数
	parameter 		pBusWidth	= fBitWidth(pBusNum) - 1
)(
    // Internal Port
	// Bus System Read Side
	input	[31:0]			iSUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	input	[pBusWidth:0]	iSUsiCke,	// 有効データ入力時 Assert
	output	[pBusWidth:0] 	oMUsiRdy,	// MCB 新規データ受信可能時 Assert
	// Bus System Write Side
	input	[pBusWidth:0]	iSUsiRdy,	// Slave アクセス可能時 Assert
	output	[31:0]			oMUsiWd,	// 書き込みデータ
	output	[31:0]			oMUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)まだ実装していない
										// {29: 0} アドレス入力
	output	[pBusWidth:0]	oMUsiCke,	// コマンド有効時 Assert
	output 
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// デバッグ用 MicroBlaze
//----------------------------------------------------------


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
// MicroControllerCsr MICRO_CONTROLLER_CSR 

//----------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//----------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i])
		begin
            fBitWidth = i+1;
        end
    end
endfunction


endmodule