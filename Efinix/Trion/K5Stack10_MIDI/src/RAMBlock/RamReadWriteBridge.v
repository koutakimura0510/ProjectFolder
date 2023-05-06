/*-----------------------------------------------------------------------------
 * Create  2023/5/6
 * Author  koutakimura
 * -
 * RAM IF moudle の Write/Read 処理
 * V1.0 : new Relaese
 * 
 * UsiAdrs Bit Assign
 * [31]    1'b1 Enable, 1'b0 Disable
 * [30:29] 2'b00 無効, 2'b01 WriteCmd, 2'b10 ReadCmd, 2'b11 無効
 * [28:25] Block ID
 * [24: 0] RAM Adrs
 *-----------------------------------------------------------------------------*/
module RamReadWriteBridge #(
	parameter pUfiDqBusWidth = 16,
	parameter pUfiAdrsBusWidth = 32,
	parameter pFifoDepth = 256,
	parameter pUfiEnableBit = 31
)(
	// Bus Slave Write
	input  [pUfiDqBusWidth-1:0] iSUfiWd,
	input  [pUfiAdrsBusWidth-1:0] iSUfiAdrs,
	output oSUfiRdy,
	// Bus Slave Read
	output [pUfiDqBusWidth-1:0] oSUfiRd,
	output [pUfiAdrsBusWidth-1:0] oSUfiAdrs,
	// RAM IF Write Port
	output [pUfiDqBusWidth-1:0] oRamIfPortUnitWd,
	output [pUfiAdrsBusWidth-1:0] oRamIfPortUnitAdrs,
	// RAM IF Read Port
	input  [pUfiDqBusWidth-1:0] iRamIfPortUnitDq,
	input  iRamIfPortUnitWe,
    // CLK Reset
    input  iRST,
	input  inARST,
    input  iCLK
);


//-----------------------------------------------------------------------------
// Fifo Write
//-----------------------------------------------------------------------------
wire [1:0] wFifoWriteFull;
wire wFifoWriteEmp;
reg  qFifoWriteRe;

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiDqBusWidth)
) DqWriteSyncFifoController (
	.iWd(iSUfiWd),
	.iWe(iSUfiAdrs[pUfiEnableBit]),
	.oFull(wFifoWriteFull[0]),
	.oRd(oRamIfPortUnitWd),
	.iRe(qFifoWriteRe),
	.oRvd(),				// AdrsBus に Enabel信号が含まれているため使用しない
	.oEmp(),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiAdrsBusWidth)
) AdrsWriteSyncFifoController (
	.iWd(iSUfiAdrs),
	.iWe(iSUfiAdrs[pUfiEnableBit]),
	.oFull(wFifoWriteFull[1]),
	.oRd(oRamIfPortUnitAdrs),
	.iRe(qFifoWriteRe),
	.oRvd(),
	.oEmp(),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);

always @*
begin
	qFifoWriteRe <= 1'b1;//~wFifoWriteEmp;	// FIFOにデータがある場合は常にRAMへ出力する。
end


//-----------------------------------------------------------------------------
// Fifo Read
//-----------------------------------------------------------------------------
wire [1:0] wFifoReadFull;
wire wFifoReadEmp;
reg  qAdrsReadFifoWe, qAdrsReadFifoRe;

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiDqBusWidth)
) DqReadSyncFifoController (
	.iWd(iRamIfPortUnitDq),
	.iWe(iRamIfPortUnitWe),
	.oFull(wFifoReadFull[0]),
	.oRd(oSUfiRd),
	.iRe(qAdrsReadFifoRe),
	.oRvd(),
	.oEmp(wFifoReadEmp),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);

SyncFifoController #(
	.pFifoDepth(pFifoDepth),
	.pFifoBitWidth(pUfiAdrsBusWidth)
) AdrsReadSyncFifoController (
	.iWd(iSUfiAdrs),
	.iWe(qAdrsReadFifoWe),
	.oFull(wFifoReadFull[1]),
	.oRd(oSUfiAdrs[30:0]),
	.iRe(qAdrsReadFifoRe),
	.oRvd(oSUfiAdrs[31:0]),
	.oEmp(),
	// CLK Reset
	.inARST(inARST),
	.iCLK(iCLK)
);

always @*
begin
	qAdrsReadFifoWe <= iSUfiAdrs[pUfiEnableBit] & (iSUfiAdrs[30:29] == 2'b10)
	qAdrsReadFifoRe <= ~wFifoReadEmp;
end

assign oMUfiRdy = &{~wFifoReadFull[0],wFifoWriteFull[0],~wFifoWriteFull[1],~wFifoWriteFull[1]};

endmodule