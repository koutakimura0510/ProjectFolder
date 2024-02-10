`timescale 1ns / 1ps
/**-----------------------------------------------------------------------------
 * 24-02-10 v1.00: new release
 * 
 *-----------------------------------------------------------------------------*/
module RAMBlock_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSCLKCycke = 2;	// CLK サイクル
// parameter [3:0]		pBlockConnectNum		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBlockConnectNumWidth 	= pBlockConnectNum - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSCLK = 0;
reg	rSRST = 1;
reg	rnSRST = 0;

always begin
    #(lpSCLKCycke/2);
    rSCLK = ~rSCLK;
end

//----------------------------------------------------------
// task Reset
//----------------------------------------------------------
task reset_init;
begin
	#(lpSCLKCycke * 5);
	rSRST = 0;
	rnSRST= 1;
	#(lpSCLKCycke * 5);
end
endtask

//----------------------------------------------------------
// Wait time
//----------------------------------------------------------
task wait_time (
	input integer tmr
);
begin
	#(lpSCLKCycke * tmr);
end
endtask

//----------------------------------------------------------
// task Usi Buf 経由の CSR 設定
//----------------------------------------------------------
wire [31:0] 		wSUsiRd;
wire 				wSUsiREd;
//
reg [31:0] 			rSUsiWd = 0;
reg [31:0] 			rSUsiAdrs = 0;
//
task usi_csr_write (
	input [31:0] wd,
	input [15:0] adrs,
	input [3:0] block_id
);
begin
	rSUsiWd   = wd;
	rSUsiAdrs = {2'b01,10'd0,block_id,adrs[15:0]};
	#(lpSCLKCycke);
end
endtask //usi_csr_setting


//-----------------------------------------------------------------------------
// Read Write Tester
//-----------------------------------------------------------------------------
localparam [3:0] lpRAMAdrsMap = 4'h3;
localparam lpRamAdrsWidth = 5;
localparam lpRamDqWidth = 16;

wire 	[lpRamDqWidth-1:0]	wRamDq;
reg		[lpRamDqWidth-1:0]	rRamDq;
wire 	[1:0]				wRamDq_Oe;
wire 	[1:0]				wRamClk;
wire 	[1:0]				wRamCe;
wire						wErr, wDone;

RamBlock #(
	.pAdrsMap(lpRAMAdrsMap),
	.pRamAdrsWidth(lpRamAdrsWidth),
	.pRamDqWidth(lpRamDqWidth)
) RamBlock (
	// SRAM I/F Port
	.oRamDq(wRamDq),		.iRamDq(rRamDq),
	.oRamDq_Oe(wRamDq_Oe),
	.oRamClk(wRamClk),		.oRamCe(wRamCe),
	// Bus Master Read
	.oSUsiRd(),
	// Bus Master Write
	.iSUsiWd(rSUsiWd),		.iSUsiAdrs(rSUsiAdrs),
	// Ufi Bus Master Read
	.oSUfiRd(),				.oSUfiAdrs(),
	// Ufi Bus Master Write
	.iSUfiWd(16'd0),		.iSUfiAdrs(0),		.oSUfiRdy(),
	// Status
	.oTestErr(wErr),		.oDone(wDone),
	// CLK Reset
    .iSRST(rSRST),			.inSRST(rnSRST),	.iSCLK(rSCLK)
);


//-----------------------------------------------------------------------------
// Memory の確保
//-----------------------------------------------------------------------------
// reg [lpRamDqWidth-1:0] rMem [65535:0];
// reg qMemWEd;

// always @(posedge rSCLK)
// begin
// 	if (qMemWEd) rMem[wAdrs] <= wWd;
// 	else 		 rMem[wAdrs] <= rMem[wAdrs];
// end

// always @*
// begin
// 	qRd <= rMem[wAdrs];
// 	qMemWEd <= (~wCmd) & (~wCe);
// end


//-----------------------------------------------------------------------------
// Done フラグが立つまで待機する
//-----------------------------------------------------------------------------
task ReadWriteTesterDoneWait(
	input integer flag
);
begin
	while (wDone == flag)
	begin
		#(lpSCLKCycke);
	end
end
endtask


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial begin
	$dumpfile("RAMBlock_tb.vcd");
	$dumpvars(0, RAMBlock_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	usi_csr_write(32'h2,16'h0011,lpRAMAdrsMap);
	usi_csr_write(32'h35,16'h0010,lpRAMAdrsMap);
	usi_csr_write(32'h3,16'h0011,lpRAMAdrsMap);
	usi_csr_write(32'h1,16'h0011,lpRAMAdrsMap);
	wait_time(100);
	// ReadWriteTesterDoneWait(0);
	// ReadWriteTesterDoneWait(1);
	// ReadWriteTesterDoneWait(0);
	// ReadWriteTesterDoneWait(1);
	// ReadWriteTesterDoneWait(0);
    $finish;
end


endmodule