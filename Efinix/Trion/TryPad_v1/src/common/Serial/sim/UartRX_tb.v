/*-----------------------------------------------------------------------------
 * Create  2023/04/15
 * Author  koutakimura
 * -
 * UartRX のテストベンチ
 * tb module が UART TX の役割を持つ
 *-----------------------------------------------------------------------------*/
module UartRX_tb;

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
localparam lpCLKCycle = 2;	// CLK サイクル
localparam lpUartSendData = 'b1001110101;	// LSB Farst

reg	rCLK = 0;
reg	rRST = 1;

always begin
    #(lpCLKCycle/2);
    rCLK = ~rCLK;
end

task reset_init;	// Reset 処理
begin
	#(lpCLKCycle * 5);
	rRST = 0;
	#(lpCLKCycle * 5);
end
endtask //


//-----------------------------------------------------------------------------
// UART RX
//-----------------------------------------------------------------------------
reg  [9:0] rUartRX;
wire [7:0] wRd;
wire wVd;
reg  [7:0] rCnt;

UartRX #(
	.pBaudRateGenDiv(8)
) UartRX (
	.iUartRX(rUartRX[9]),
	//
	.oUartRxThru(),
	.oRd(wRd),
	.oVd(wVd),
	//
	.iRST(rRST),
	.iCLK(rCLK)
);

always @(negedge rCLK)
begin
	if (rRST) 				rCnt <= 0;
	else if (rCnt==8)		rCnt <= 0;
	else 					rCnt <= rCnt + 1'b1;;

	if (rRST) 				rUartRX <= 'b1001110101;
	else if (rCnt==8)		rUartRX <= {rUartRX[8:0], 1'b1};
	else 					rUartRX <= rUartRX;
end


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	$dumpfile("UartRX_tb.vcd");
	$dumpvars(0, UartRX_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpCLKCycle * 4800);
    $finish;
end


endmodule