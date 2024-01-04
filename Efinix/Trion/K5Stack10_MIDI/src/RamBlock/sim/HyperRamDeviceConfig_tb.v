/**-----------------------------------------------------------------------------
 * HyperRam Device Configration test bench
 * 
 * 23-11-19 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module HyperRamDeviceConfig_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSysClkCycle = 2;	// CLK サイクル
// parameter [3:0]		pBlockConnectNum		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBlockConnectNumWidth 	= pBlockConnectNum - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	iSCLK = 0;
reg	iSRST = 1;

always begin
    #(lpSysClkCycle/2);
    iSCLK = ~iSCLK;
end

//-----------------------------------------------------------------------------
// Read Write Tester
//-----------------------------------------------------------------------------
localparam lpRamAdrsWidth = 15;
localparam lpRamDqWidth = 16;

wire [ 7:0] wMemDq;
wire 		wMemDqOe;
wire 		wMemRwds;
wire 		wMemRwdsOe;
wire 		wMemClk;
wire 		wMemCs;
reg  [ 7:0]	rMemDq;
//
wire [15:0]	wCapDq;
reg  [15:0]	rWDq;
reg  [47:0]	rCmdAdrs;
//
reg  [ 3:0] qLatencyCnt;
reg 		rRwCmd;
reg 		rSeqEn;
wire 		wDone;

HyperRamDeviceConfig HyperRamDeviceConfig (
	// memory I/F for write side
	.oMemDq(wMemDq),		.oMemDqOe(wMemDqOe),
	.oMemRwds(wMemRwds),	.oMemRwdsOe(wMemRwdsOe),
	.oMemClk(wMemClk),		.oMemCs(wMemCs),
	// memory I/F for read side
	.iMemDq(rMemDq),
	// internal data
	.oCapDq(wCapDq),
	.iWDq(rWDq),			.iCmdAdrs(rCmdAdrs),
	// control status
	.iLatencyCnt(4'd0),
	.iRwCmd(rRwCmd),		.iSeqEn(rSeqEn),
	.oDone(wDone),
	// clk common
	.iRST(iSRST),			.iCKE(1'b0),	.iCLK(iSCLK)
);

always @(posedge iSCLK)
begin
	if (iSRST) 	rMemDq <= 8'd0;
	else 		rMemDq <= rMemDq + 1'b1;
	
	rWDq		<= 16'h1234;
	rCmdAdrs	<= 48'hC0_00_00_04_00_00;
	
	if (iSRST) 	rRwCmd <= 1'b0;
	else 		rRwCmd <= 1'b0;
	
	if (iSRST) 	rSeqEn <= 1'b0;
	else 		rSeqEn <= 1'b1;
end

always @*
begin
	qLatencyCnt <= 4'd7;
end

//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	$display(" ----- SIM START !!");
	$dumpfile("HyperRamDeviceConfig_tb.vcd");
	$dumpvars(0, HyperRamDeviceConfig_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	ReadWriteTesterDoneWait(0);
	#(lpSysClkCycle * 20);
	$display(" ----- SIM END !!");
	$finish;
end


/**----------------------------------------------------------------------------
 * Task Function
 *---------------------------------------------------------------------------*/
// Done フラグが立つまで待機する
task ReadWriteTesterDoneWait(
	input integer flag
);
begin
	while (wDone == flag)
	begin
		#(lpSysClkCycle);
	end
end
endtask

// Reset Initialize
task reset_init;
begin
	$display(" ----- RESET START !!");
	#(lpSysClkCycle * 5);
	iSRST = 0;
	#(lpSysClkCycle * 5);
	$display(" ----- RESET END !!");
end
endtask //



endmodule