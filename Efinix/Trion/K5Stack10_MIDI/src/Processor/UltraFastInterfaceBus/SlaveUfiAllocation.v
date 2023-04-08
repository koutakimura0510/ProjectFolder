//----------------------------------------------------------
// Create 2022/11/18
// Author koutakimura
// -
// Ufi-Slave-I/F を持つ module で、module 内でデータの割り振り分岐を行う必要がある場合に使用する。
// 
// 
//----------------------------------------------------------
module SlaveUfiAllocation #(
	// variable parameter
	parameter 							pUfiBusWidth	  	= 32,	// バス幅
	parameter							pUsiBusWidth		  	= 32,	// アドレス Bit幅
	parameter							pUfiAllocationNum 	=  9,	// 分岐先の Slave の数
)(
    // Internal Port
	// Slave write data
	input 	[pUfiBusWidth-1:0] 			iSUfiWd,					// Master から受信する 書き込みデータ
	input 	[pUsiBusWidth-1:0] 			iSUfiWAdrs,					// Master から受信する アドレス指定
	input 								iSUfiWEd,					// Master から受信する 書き込み Enable
	// 
	output 	[pUfiBusWidth-1:0] 			oSUfiWd,					// Slave に対する 書き込みデータ
	output 	[pUsiBusWidth-1:0]			oSUfiWAdrs,					// Slave に対する R/W 共通のアドレス指定バス
	output 	[pUfiAllocationNum-1:0]		oSUfiWEd,					// Slave に対する 書き込み有効信号
	
    // input								iRST,
    input								iCLK
);


//----------------------------------------------------------
// 起動時に BRAM が更新されていても問題ないため
// Rst は接続性ない
//----------------------------------------------------------
reg [pUfiBusWidth-1:0] 		rSUfiWd;			assign oSUfiWd		= rSUfiWd;
reg [pUsiBusWidth-1:0] 		rSUfiWAdrs;			assign oSUfiWAdrs	= rSUfiWAdrs;
reg [pUfiAllocationNum-1:0] rSUfiWEd;			assign oSUfiWEd		= rSUfiWEd;
//
reg [pUfiAllocationNum-1:0] qAllocationCke;

always @(posedge iCLK)
begin
	rSUfiWd		<=	iSUfiWd;
	rSUfiWAdrs	<=	iSUfiWAdrs;
	rSUfiWEd 	<= 	qAllocationCke;
end

// アドレスの区切り時点でアドレス範囲を比較
genvar n;

generate
	for (n = 0; n < pUfiAllocationNum; n = n + 1)
	begin
		qAllocationCke[n] <= iSUfiWAdrs[31:28] == n;
	end
endgenerate



endmodule