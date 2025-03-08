/*-----------------------------------------------------------------------------
 * 1.
 * [31:31] Enable Bit				"1" Enable,   	"1" Disable
 * [30:30] R/W Select Bit			"1" ReadCmd,	"1" WriteCmd
 * [29:29] Burst Type Select Bit	"1" linear 		"0" wrapped
 * [28:16] NC
 * [15: 0] Burst Length
 *
 * 2. 
 * [31:31] Enable Bit				"1" Enable,   	"1" Disable
 * [30:29] NC
 * [28: 0] Memory R/W Start Adrs	Max 512[MB]
 *
 * [Read]
 * Master は Slave から出力されるデータは、必ず受け付ける状態でなければならない。
 *
 * 24-03-04 v1.00: new release
 *-----------------------------------------------------------------------------*/
module UFIBv2 #(
	// variable parameter
	parameter pBlockConnectNum 	= 	2,	// UfiBus Master接続ブロック数
	parameter pBlockAdrsWidth 	= 	2,
	parameter pUfiBusWidth		=  48,	// バスのデータ幅は、使用する外部RAMのデータ幅と合わせている
	// not valiable parameter
	parameter pMUfiDqWidth 		= pUfiBusWidth * pBlockConnectNum
)(
	// Ufi Bus Master Read
	input  [pUfiBusWidth-1:0] 		iSUfiRd,
	output [pUfiBusWidth-1:0] 		oMUfiRd,
	input  							iSUfiVd,
	output [pBlockConnectNum-1:0] 	oMUfiVd,
	// Ufi Bus Master Write
	output [pUfiBusWidth-1:0] 		oSUfiWd,
	input  [pMUfiDqWidth-1:0] 		iMUfiWd,
	input  							iSUfiRdy,
	output [pBlockConnectNum-1:0]	oMUfiRdy,
    // CLK Reset
    input  							iRST,
    input  							iCLK 
);

// read
assign oMUfiRd	= iSUfiRd;
assign oMUfiVd	= {iSUfiVd,1'b0};
// write
assign oSUfiWd	= iMUfiWd[pMUfiDqWidth-1:pUfiBusWidth];
assign oMUfiRdy	= {iSUfiRdy,1'b0};

endmodule