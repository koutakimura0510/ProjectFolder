//----------------------------------------------------------
// Create 2022/10/14
// Author koutakimura
// -
// MCUnit Master として、システムを駆動させる。
//----------------------------------------------------------
module MicroControllerUnit #(
	parameter							pBusBlockConnect	= 1,
	parameter							pBusAdrsBit			= 16,
	parameter							pUfiBusWidth		= 8,
	parameter							pMemAdrsWidth		= 19
)(
	// External Port
	// input 					iUartRx,
	// output 					oUartTx,
    // Internal Port
	// Bus Master Read
	input	[31:0]						iMUsiRd,	// Slave の CSR Read値
	input	[pBusBlockConnect-1:0]		iMUsiREd,	// Slave CSR Read値入力時 Assert
	// Bus Master Write
	output	[31:0]						oMUsiWd,	// 書き込みデータ
	output	[pBusAdrsBit-1:0]			oMUsiAdrs,
	output								oMUsiWEd,	// コマンド有効時 Assert
	//
	// output 	[pUfiBusWidth-1:0]			oMUfiWd,
	// output 	[pBusAdrsBit-1:0]			oMUfiAdrs,
	// output 								oMUfiEd,
	// output 								oMUfiVd,
    // CLK Reset
    input           					iSysRst,
    input           					iSysClk
);

assign oMUsiWd   = 0;
assign oMUsiAdrs = 0;
assign oMUsiWEd  = 0;

endmodule