//----------------------------------------------------------
// Create 2022/7/10
// Author koutakimura
// -
// プロセッサ内部構造の Master を司るブロック
// 独自の I/F BUS をマスターの立場から操作し、
// BUS に接続されている Slaveブロック の操作を行う。
// 
//----------------------------------------------------------
module MicroControllerBlock #(
	parameter 		pBusNum 	= 1,		// Busに接続する Slave数
	parameter 		pBusWidth	= fBitWidth(pBusNum) - 1
)(
    // Internal Port
	// Bus System Read Side
	input  [31:0]			iUsiRd,		// Bus 読み込みデータ
	input 					iUsiCke,	// Bus 読み込みデータ入力時 High
	output [pBusWidth:0] 	oUsiRdy,	// MCB 現在新規データ受信可能時 High
	// Bus System Write Side
	input  [pBusWidth:0]	iUsiRdy,	// Bus 書き込み可能時 High
	output [31:0]			oUsiAdrs,	// Bus アドレス出力
	output [31:0]			oUsiWd,		// Bus 書き込みデータ
	output [pBusWidth:0]	oUsiCke,	// 有効データ・アドレス出力時 High
	output 
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// デバッグ用 MicroBlaze
//----------------------------------------------------------


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