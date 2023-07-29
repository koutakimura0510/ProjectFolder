`timescale 1ns / 1ps
/*-----------------------------------------------------------------------------
 * Create  2023/07/19
 * Author  kouta kimura
 * -
 * UFIB Testbench
 * 
 *-----------------------------------------------------------------------------*/
module UFIB_tb;


//-----------------------------------------------------------------------------
// System Simlation Parameter
//-----------------------------------------------------------------------------
localparam lpUfibMasterBlockNum = 1;
localparam lpRamDepth			= 256;

//-----------------------------------------------------------------------------
// System 共通変数
//-----------------------------------------------------------------------------
genvar x;

//-----------------------------------------------------------------------------
// Clk,Rst Generator
//-----------------------------------------------------------------------------
localparam	lpSCLKCycle = 2;	// CLK サイクル

reg	wSCLK = 0;
reg	wSRST = 1;
reg	wnSRST = 0;

always begin
    #(lpSCLKCycle/2);
    wSCLK = ~wSCLK;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 5);
	wSRST  = 0;
	wnSRST = ~wSRST;
	#(lpSCLKCycle * 5);
end
endtask

//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth      = 32;		// USIB Width
localparam lpBlockConnectNum  = 2;		// 現在接続しているブロックの個数
localparam lpBlockAdrsWidth   = f_detect_bitwidth(lpBlockConnectNum);
localparam lpCsrAdrsWidth     = 16;		// 各ブロック共通の基本CSR幅
localparam lpSUsiBusWidth     = (lpUsiBusWidth * lpBlockConnectNum);
localparam [lpBlockAdrsWidth-1:0]		// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
//   lpGpioAdrsMap         = 'h0,
//   lpSPIAdrsMap          = 'h1,
//   lpSynthesizerAdrsMap  = 'h2,
  lpRAMAdrsMap          = 'h3,
//   lpSysTimerAdrsMap     = 'h4,
  lpMCBAdrsMap		    = 'h5,
  lpNullAdrsMap         = 0;

// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが難しいと感じたため用意した。
localparam 
//   lpGpioCsrActiveWidth  = 8,
//   lpSPICsrActiveWidth   = 8,
//   lpSynCsrActiveWidth   = 8,
  lpRAMCsrActiveWidth   = 8,
//   lpTimerCsrActiveWidth = 8,
  lpMCBCsrActiveWidth	= 8,
  lpNullActiveWidth     = 8;  // 使用しない、ソースの追加がやりやすいように
  // lpI2CCsrActiveWidth  = 8,
  // lpVTBCsrActiveWidth  = 16,
  // lpATBCsrActiveWidth  = 8,
  // lpRAMCsrActiveWidth  = 8;
//-----------------------------------------------------------------------------
// USIB 経由の CSR 設定
wire [31:0]	wSUsiRd;
reg  [31:0] rSUsiWd 	= 0;	wire [31:0] wSUsiWd		= rSUsiWd;
reg  [31:0] rSUsiAdrs 	= 0;	wire [31:0] wSUsiAdrs 	= rSUsiAdrs;

task usi_csr_setting (
	input [31:0] wd,
	input [31:0] adrs
);
begin
	rSUsiWd   = wd;
	rSUsiAdrs = adrs;
	#(lpSCLKCycle);
end
endtask //usi_csr_setting
// ----------------------------------------------------------------------------
// Wait 関数 
task wait_flag(
	input [31:0] flag,
	input [31:0] adrs
);
begin
	usi_csr_setting(0, adrs);
	while (wSUsiRd == flag)	// iverilog の場合、等しい場合ループする
	begin
		#(lpSCLKCycle);
	end
end
endtask
// ----------------------------------------------------------------------------
// MCB UFI Burst
task mcb_flash_run(
	input rw
);
integer i;
begin
	for (i = 0; i < 256; i = i + 1)
	begin
		if (rw == 0)
		begin
			usi_csr_setting(i, 'h4005_0000);
			usi_csr_setting(i, 'h4005_0004);
		end
		else
		begin
			// usi_csr_setting('h40000000, 'h4005_0000);
			usi_csr_setting('h40000000 + i, 'h4005_0004);
		end
		usi_csr_setting(1, 'h4005_0008);
		usi_csr_setting(0, 'h4005_0008);
	end

	usi_csr_setting(1, 'h4005_000C);
	usi_csr_setting(0, 'h0000_0000);
	$display("mcb_flash_run %d", rw);
end
endtask

//----------------------------------------------------------
// UFIB part
//----------------------------------------------------------
localparam  lpRamAdrsWidth    		= f_detect_bitwidth(lpRamDepth);
localparam  lpRamDqWidth      		= 16;
localparam  lpUfiDqBusWidth   		= lpRamDqWidth;
localparam  lpUfiAdrsBusWidth 		= 32;
localparam  lpUfiBlockConnectNum 	= lpUfibMasterBlockNum;
localparam 	lpUfiBlockAdrsWidth		= f_detect_bitwidth(lpUfiBlockConnectNum);
localparam	lpMUfiDqWidth 			= lpUfiDqBusWidth   * lpUfiBlockConnectNum;
localparam	lpMUfiAdrsWidth			= lpUfiAdrsBusWidth * lpUfiBlockConnectNum;

initial
begin
	$display("--- lpRamAdrsWidth %d bit", lpRamAdrsWidth);
	$display("--- lpUfiBlockConnectNum %d bit", lpUfiBlockAdrsWidth);
end
//
localparam [lpUfiBlockAdrsWidth-1:0]	// UFI ブロックアドレスマッピング
	// lpUfiRWT1stAdrsMap	= 'h0,
	// lpUfiRWT2ndAdrsMap	= 'h1,
	// lpUfiRWT3rdAdrsMap	= 'h2,
	lpUfiMcbAdrsMap		= 'h0,
	lpUfiNullAdrsMap	= 	0;
//
wire [lpUfiDqBusWidth-1:0] 		wSUfiRd;
wire [lpUfiAdrsBusWidth-1:0] 	wSUfiAdrs;
wire [lpUfiDqBusWidth-1:0] 		wMUfiRd;
wire [lpUfiAdrsBusWidth-1:0] 	wMUfiAdrs;
//
wire [lpUfiDqBusWidth-1:0] 		wSUfiWd;
wire [lpUfiAdrsBusWidth-1:0] 	wSUfiWAdrs;
wire 							wSUfiRdy;
wire [lpUfiDqBusWidth-1:0] 		wMUfiWd[0:lpUfiBlockConnectNum-1];
wire [lpUfiAdrsBusWidth-1:0] 	wMUfiWAdrs[0:lpUfiBlockConnectNum-1];
wire [lpUfiBlockConnectNum-1:0]	wMUfiRdy;
//
reg [lpMUfiDqWidth-1:0]			qMUfiWd;
reg [lpMUfiAdrsWidth-1:0]		qMUfiWAdrs;

UFIB #(
	.pBlockConnectNum(lpUfiBlockConnectNum),
	.pBlockAdrsWidth(lpUfiBlockAdrsWidth),
	.pUfiDqBusWidth(lpUfiDqBusWidth),
	.pUfiAdrsBusWidth(lpUfiAdrsBusWidth)
) UFIB (
	// Ufi Bus Master Read
	.iSUfiRd(wSUfiRd),  .iSUfiAdrs(wSUfiAdrs),
	.oMUfiRd(wMUfiRd),  .oMUfiAdrs(wMUfiAdrs),
	// Ufi Bus Master Write
	.oSUfiWd(wSUfiWd),  .oSUfiAdrs(wSUfiWAdrs),
	.iSUfiRdy(wSUfiRdy),
	.iMUfiWd(qMUfiWd),  .iMUfiAdrs(qMUfiWAdrs),
	.oMUfiRdy(wMUfiRdy),
	// CLK Reset
	.iRST(wSRST),    	.iCLK(wSCLK)
);

generate
	for (x = 0; x < lpUfiBlockConnectNum; x = x + 1)
	begin
		always @*
		begin
			qMUfiWd[((x+1)*lpUfiDqBusWidth)-1:x*lpUfiDqBusWidth]		<= wMUfiWd[x];
			qMUfiWAdrs[((x+1)*lpUfiAdrsBusWidth)-1:x*lpUfiAdrsBusWidth]	<= wMUfiWAdrs[x];
		end
	end
endgenerate

//---------------------------------------------------------------------------
// UFIB ReadWriteTester
//---------------------------------------------------------------------------
// generate
// 	for (x = 0; x < lpUfibMasterBlockNum; x = x + 1)
// 	begin
// 		UfibReadWriteTester #(
// 			.pRamAdrsWidth(lpRamAdrsWidth),
// 			.pUfiAdrsMap(lpUfiRWT1stAdrsMap),
// 			.pUfiDqBusWidth(lpUfiDqBusWidth),
// 			.pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
// 			.pReadWrite(x+1)
// 		) UfibReadWriteTester (
// 			// Ufi Bus Master Read
// 			.iMUfiRd(wMUfiRd),		.iMUfiAdrs(wMUfiAdrs),
// 			// Ufi Bus Master Write
// 			.oMUfiWd(wMUfiWd[x]),	// 本来は lpUfiRWT1stAdrsMap を指定する。あくまでsim
// 			.oMUfiAdrs(wMUfiWAdrs[x]),
// 			.iMUfiRdy(wMUfiRdy[x]),
// 			// CLK Reset
// 			.iRST(wSRST),			.inRST(wnSRST),
// 			.iCLK(wSCLK)
// 		);
// 	end
// endgenerate

MicroControllerBlock #(
	// Usi
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpRAMAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),
	.pCsrAdrsWidth(lpCsrAdrsWidth),			.pCsrActiveWidth(lpMCBCsrActiveWidth),
	// Ufi
	.pUfiDqBusWidth(lpUfiDqBusWidth),		.pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
	.pUfiAdrsMap(lpUfiMcbAdrsMap),
	// Commnad
	.pSimlation("yes")
) MicroControllerBlock (
  // Usi Bus Master Read
	.iMUsiRd(wMUsiRd),
	.oSUsiRd(wSUsiRd[lpMCBAdrsMap]),
	// Usi Bus Master Write
	.oMUsiWd(wMUsiWdMcb),	.oMUsiAdrs(wMUsiAdrsMcb),
	.iSUsiWd(wSUsiWd),		.iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.iMUfiRd(wMUfiRd),		.iMUfiAdrs(wMUfiAdrs),
	// Ufi Bus Master Write
	.oMUfiWd(wMUfiWd[lpUfiMcbAdrsMap]),
	.oMUfiAdrs(wMUfiWAdrs[lpUfiMcbAdrsMap]),
	.iMUfiRdy(wMUfiRdy[lpUfiMcbAdrsMap]),
	// GPIO
	.oTxd(),       .iRxd(),
	// JTAG
	.jtag_inst1_TCK(),
	.jtag_inst1_TDI(),
	.jtag_inst1_TDO(),
	.jtag_inst1_SEL(),
	.jtag_inst1_CAPTURE(),
	.jtag_inst1_SHIFT(),
	.jtag_inst1_UPDATE(),
	.jtag_inst1_RESET(),
	// common
	.iSRST(wSRST),      .inSRST(wnSRST),
	.iSCLK(wSCLK)
);


//-----------------------------------------------------------------------------
// RAMBloock part
//-----------------------------------------------------------------------------
wire [lpRamAdrsWidth-1:0] 	wAdrs;
wire [lpRamDqWidth-1:0] 	wWd;
wire 						wCmd, wCe;
reg  [lpRamDqWidth-1:0] 	qRd;
wire 						wErr, wDone;

RAMBlock #(
	.pRamAdrsWidth(lpRamAdrsWidth),
	.pRamDqWidth(lpRamDqWidth),
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpRAMAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),
	.pCsrAdrsWidth(lpCsrAdrsWidth),			.pCsrActiveWidth(lpRAMCsrActiveWidth),
	.pUfiDqBusWidth(lpUfiDqBusWidth),		.pUfiAdrsBusWidth(lpUfiAdrsBusWidth),
	.pRamAdrsWidth(lpRamAdrsWidth),			.pRamDqWidth(lpRamDqWidth)
) RAMBlock (
	.oSRAMA(wAdrs),		.oSRAMD(wWd),
	.iSRAMD(qRd),
	.oSRAM_LB(),		.oSRAM_UB(),
	.oSRAM_OE(),
	.oSRAM_WE(wCmd),	.oSRAM_CE(wCe),
	// Usi
	.oSUsiRd(wSUsiRd[lpRAMAdrsMap]),
	.iSUsiWd(wSUsiWd),
	.iSUsiAdrs(wSUsiAdrs),
	// Ufi Bus Master Read
	.oSUfiRd(wSUfiRd),	.oSUfiAdrs(wSUfiAdrs),
	// Ufi Bus Master Write
	.iSUfiWd(wSUfiWd),	.iSUfiAdrs(wSUfiWAdrs),
	.oSUfiRdy(wSUfiRdy),
	// Status
	.oTestErr(),		.oDone(),
	// CLK Reset
    .iSRST(wSRST),		.inSRST(wnSRST),
	.iSCLK(wSCLK)
);
//-----------------------------------------------------------------------------
// Memory の確保

reg [lpRamDqWidth-1:0] rMem [lpRamDepth-1:0];
reg qMemWEd;

always @(posedge wSCLK)
begin
	if (qMemWEd) rMem[wAdrs] <= wWd;
	else 		 rMem[wAdrs] <= rMem[wAdrs];
end

always @*
begin
	qRd		<= rMem[wAdrs];
	qMemWEd <= (~wCmd) & (~wCe);
end


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$dumpfile("UFIB_tb.vcd");
	$dumpvars(0, UFIB_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	$display(" ----- SIM_END !!");
	reset_init();
	usi_csr_setting('h0, 'h40030000);
	mcb_flash_run(0);
	wait_flag(1, 'h0005_000C);
	#(lpSCLKCycle*1000);
	mcb_flash_run(1);
	#(lpSCLKCycle*1000);
	$display(" ----- SIM_END !!");
    $finish;
end


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------
function integer f_detect_bitwidth;
	input integer number;
	integer bitwidth;
	integer bitcnt;
	integer	i;
	begin
		bitcnt = 0;
		for (i = 0; i < 32; i = i+1 )
		begin
			if (number[i]) 
			begin
				bitcnt++;
			end
		end

		if (bitcnt == 1)
		begin
			for (i = 0; i < 32; i = i+1 )
			begin
				if (number[i]) 
				begin
					f_detect_bitwidth = i+1;
				end
			end

			if (f_detect_bitwidth != 1)
			begin
				f_detect_bitwidth = f_detect_bitwidth - 1;
			end
		end
		else
		begin
			bitwidth = 0;
			if (number == 0)
			begin
				f_detect_bitwidth = 1;
			end
			else
			begin
				while (number != 0)
				begin
					bitwidth++;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction


endmodule
// UFIB_tb
//----------------------------------------------------------------------------