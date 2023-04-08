//----------------------------------------------------------
// Create 2022/10/14
// Author koutakimura
// -
// MCUnit Master として、システムを駆動させる。
//----------------------------------------------------------
module MicroControllerUnit #(
	parameter							pBlockConnectNum	= 1,
	parameter							pUsiBusWidth			= 16,
	parameter							pUfiBusWidth		= 8,
	parameter							pMemAdrsWidth		= 19
)(
	// External Port
	// input 					iUartRx,
	// output 					oUartTx,
    // Internal Port
	// Bus Master Read
	input	[31:0]						iMUsiRd,	// Slave の CSR Read値
	input	[pBlockConnectNum-1:0]		iMUsiREd,	// Slave CSR Read値入力時 Assert
	// Bus Master Write
	output	[31:0]						oMUsiWd,	// 書き込みデータ
	output	[pUsiBusWidth-1:0]			oMUsiAdrs,
	output								oMUsiWEd,	// コマンド有効時 Assert
	//
	// output 	[pUfiBusWidth-1:0]			oMUfiWd,
	// output 	[pUsiBusWidth-1:0]			oMUfiAdrs,
	// output 								oMUfiEd,
	// output 								oMUfiVd,
    // CLK Reset
    input           					iSRST,
    input           					iSCLK
);

assign oMUsiWd   = 0;
assign oMUsiAdrs = 0;
assign oMUsiWEd  = 0;

endmodule