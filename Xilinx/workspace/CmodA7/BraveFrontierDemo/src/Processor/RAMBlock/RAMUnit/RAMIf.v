//----------------------------------------------------------
// Create 2022/9/11
// Author koutakimura
// -
// 外部 RAM Interface module
// RAM については CmodA7 データシート確認
// -
// 制御信号による R/W 制御は下記である。
// OE LowHigh にかかわらず、WE が優先される。
// WE CE OE
//  x  H  x = High-Z / Not Selected (Power Down)
//  H  L  H = High-Z / Output Disabled
//  H  L  L = Dout / Read
//  L  L  x = Din  / Write
// 
//----------------------------------------------------------
module RAMIf #(
	parameter						pRamAdrsWidth	= 19,
	parameter						pRamDqWidth		= 8
)(
	// External Port
	output 	[pRamAdrsWidth-1:0]		oMemAdrs,
	inout	[pRamDqWidth-1:0]		ioMemDq,
	output 							oMemOE,			// Output Enable
	output 							oMemWE,			// Write Enable
	output 							oMemCE,			// Chip Select
	//
	input	[pRamAdrsWidth-1:0]		iAdrs,
	input 	[pRamDqWidth-1:0]		iWd,
	input 							iCE,			// Low Active
	input 							iCmd,			// High Read, Low Write
	output 	[pRamDqWidth-1:0]		oRd,
	output 							oREd,
    // Internal Port
    input							iRst,
	input 							iSysClk,
    input							iMemClk
);


//-----------------------------------------------------------------------------
// Max 40Mhz で動作可能
// 40Mhz で動作させた場合でも HoldTime などの時間は保持できるため、
// ユーザー側で特別な制御をする必要がなくなる。
// そのため、アドレスや書き込みデータはスルー制御とすることができる。
//-----------------------------------------------------------------------------
reg  [pRamAdrsWidth-1:0]	rAdrs;
reg  [pRamDqWidth-1:0]	 	rWd;
reg  [pRamDqWidth-1:0] 		rRd;				assign oRd  = rRd;
reg 						rREd;				assign oREd = rREd;
reg 						rOE;
reg 						rWE;
reg 						rCE;
wire [pRamDqWidth-1:0] 		wRd;

always @(posedge iMemClk)
begin
	// 初期状態が Active でも問題ないため、外部制御信号に Reset は付けない
	rOE 	<= ~iCmd;
	rWE 	<= iCmd;
	rCE		<= iCE;
	rAdrs 	<= iAdrs;
	rWd		<= iWd;

	if (rWE)	rRd <= wRd;
	else  		rRd <= rRd;

	if (iRst)		rREd <= 1'b0;
	else if (rWE) 	rREd <= 1'b1;
	else  			rREd <= 1'b0;
end

//-----------------------------------------------------------------------------
// IOBUF
// .T High -> .IO High-Z
//-----------------------------------------------------------------------------
genvar i,j;

generate
	for (i = 0; i < pRamDqWidth; i = i + 1)
	begin
		IOBUF MemDq	(.I(rWd[i]), .O(wRd[i]), .IO(ioMemDq[i]), .T(iCmd));
	end

	for (j = 0; j < pRamAdrsWidth; j = j + 1)
	begin
		OBUF MemAdrs (.I(rAdrs[j]), .O(oMemAdrs[j]));
	end

	OBUF 	MemOE	(.I(rOE),	.O(oMemOE));
	OBUF 	MemWE	(.I(rWE), 	.O(oMemWE));
	OBUF 	MemCE	(.I(rCE), 	.O(oMemCE));
endgenerate

endmodule