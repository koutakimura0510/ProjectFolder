//----------------------------------------------------------
// Create 2023/4/28
// Author koutakimura
// -
// 外部 RAM Interface module
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
module RAMIfPortUnit #(
	parameter pRamAdrsWidth	= 19,
	parameter pRamDqWidth = 8
)(
	// SRAM I/F Port
	output [pRamAdrsWidth-1:0] oSRAMA,
	output [pRamDqWidth-1:0] oSRAMD,
	input  [pRamDqWidth-1:0] iSRAMD,
	output oSRAM_LB,	// N Lower Byte Control
	output oSRAM_UB,	// N Upper Byte Control
	output oSRAM_OE,	// N Output Enable
	output oSRAM_WE,	// N Write Enable
	output oSRAM_CE,	// N Chip Select 
	//
	input  [pRamAdrsWidth-1:0] iAdrs,
	input  [pRamDqWidth-1:0] iWd,
	output [pRamDqWidth-1:0] oRd,
	output oREd,
	input  iCmd,  // "1" Read, "0" Write
    // Clk Reset
    input  iRST,
	input  iCKE,
    input  iCLK
);


//-----------------------------------------------------------------------------
// 調停が必要ない場合 50Mhz で動作可能
// それ以上はタイミング調整のロジックが必要
// 
// 50Mhz で動作させた場合で CLK遷移で Setuo/HoldTime は確保できるため、
// ユーザー側で特別な制御をする必要がなくなる。
// そのため、アドレスや書き込みデータはスルー制御とすることができる。
// 
// 
//-----------------------------------------------------------------------------
reg  [pRamAdrsWidth-1:0] rAdrs;
reg  [pRamDqWidth-1:0] rWd;
reg  rOE, rWE, rCE;
wire [pRamDqWidth-1:0] wRd;
reg  [pRamDqWidth-1:0] rRd;
reg  rREd;

always @(posedge iCLK)
begin
	rAdrs 	<= iAdrs;
	rWd 	<= iWd;

	if (iCKE)
	begin
		rOE <= ~iCmd;
		rWE <=  iCmd;
		rCE <=  1'b0;
	end
	else
	begin
		rOE <= 1'b1;
		rWE <= 1'b0;
		rCE <= 1'b1;
	end

	if (rWE) rRd <= iSRAMD;
	else  	 rRd <= rRd;

	if (iRST)		rREd <= 1'b0;
	else if (rWE) 	rREd <= 1'b1;
	else  			rREd <= 1'b0;
end

assign oSRAMA = rAdrs;
assign oSRAMD = rWd;
assign oSRAM_LB = 1'b0; // 常に有効
assign oSRAM_UB = 1'b0; // 常に有効
assign oSRAM_OE = rOE;
assign oSRAM_WE = rWE;
assign oSRAM_CE = rCE;
assign oRd = rRd;
assign oREd = rREd;

endmodule