/*-----------------------------------------------------------------------------
 * Simlation
 * 
 * 23-09-24 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module AudioRomRead_tb;

//-----------------------------------------------------------------------------
// Clk,Rst Generator
//-----------------------------------------------------------------------------
genvar x;
localparam	lpSCLKCycle = 4;	// CLK サイクル
localparam	lpMCLKCycle = 7;	// CLK サイクル

reg	wSCLK = 0;		reg	wSRST = 1;		reg	wnSRST = 0;
reg	wMCLK = 0;		reg	wMRST = 1;		reg	wnMRST = 0;

always begin
    #(lpSCLKCycle/2);
    wSCLK = ~wSCLK;
end

always begin
    #(lpMCLKCycle/2);
    wMCLK = ~wMCLK;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 10);
	wSRST  = 0;
	wnSRST = ~wSRST;
	wMRST  = 0;
	wnMRST = ~wMRST;
	#(lpSCLKCycle * 10);
end
endtask


//-----------------------------------------------------------------------------
// Rrs(Rom Read Sequence) Part
//-----------------------------------------------------------------------------
localparam lpSfmPageWidth 	= 16;
localparam lpSfmPageSize	= 16;

reg  [7:0]	rRrsRd;
reg 		rRrsDone;
wire [7:0] 	wRrsWd;
wire 		wRrsEn;
wire 		wRrsCsCtrl;

reg 		qSfmEn;
reg 		qSfmCycleEn;
reg [7:0]	qSfmCsHoldTime;
reg [15:0]	qSfmStartAdrs;
reg [15:0]	qSfmEndAdrs;
wire 		wSfmDone;

AudioRomRead #(
	.pSfmPageWidth(lpSfmPageWidth),
	.pSfmPageSize(lpSfmPageSize)
) AudioRomRead (
	.oSfmSck(),		.oSfmMosi(),
	.iSfmMiso(),	.oSfmCs(),
	// Read Fifo I/F
	.oRd(),			.oRvd(),
	.oEmp(),		.iRe(1'b1),
	// control status
	.iSfmEn(qSfmEn),					.iSfmCycleEn(qSfmCycleEn),
	.iSfmDiv(8'd2),						.iSfmCsHoldTime(qSfmCsHoldTime),
	.iSfmStartAdrs(qSfmStartAdrs),		.iSfmEndAdrs(qSfmEndAdrs),
	.oSfmDone(wSfmDone),
	// Cpu Side
	.iSfmCpuWd(8'hA2),
	.iSfmCpuEn(1'b1),
	.iSfmCpuCsCtrl(1'b0),
	.iSfmCpuValid(1'b1),
	.oSfmCpuRd(),
	.oSfmCpuDone(),
	// common
	.iSRST(wSRST),
	.inSRST(wnSRST),
	.iSCLK(wSCLK)
);

always @*
begin
	qSfmEn			<= wSfmDone ? 1'b0 : 1'b1;
	qSfmCycleEn		<= 1'b0;
	qSfmCsHoldTime	<= 8'd0;
	qSfmStartAdrs	<= 16'd0;
	qSfmEndAdrs		<= 16'd2;
end

//-----------------------------------------------------------------------------
// Spi Flash Rom Demo
//-----------------------------------------------------------------------------
reg [7:0] 	rDoneCycle;
reg 		qDoneCke;

always @(posedge wSCLK)
begin
	if (!wRrsEn)		rRrsRd <= 8'd0;
	else if (qDoneCke)	rRrsRd <= rRrsRd + 1'b1;
	else 				rRrsRd <= rRrsRd;

	if (!wRrsEn)		rDoneCycle <= 8'd0;
	else if (qDoneCke)	rDoneCycle <= 8'd0;
	else 				rDoneCycle <= rDoneCycle + 1'b1;

	if (wSRST)			rRrsDone <= 1'b0;
	else if (qDoneCke)	rRrsDone <= 1'b1;
	else 				rRrsDone <= 1'b0;
end

always @*
begin
	qDoneCke <= rDoneCycle == 8'd8;
end

//-----------------------------------------------------------------------------
// Simlation Start
//-----------------------------------------------------------------------------
initial begin
	$dumpfile("AudioRomRead_tb.vcd");
	$dumpvars(0, AudioRomRead_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpSCLKCycle * 4800);
    $finish;
end


endmodule