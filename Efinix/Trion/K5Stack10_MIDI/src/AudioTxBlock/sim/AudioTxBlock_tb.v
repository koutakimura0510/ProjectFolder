/*-----------------------------------------------------------------------------
 * Simlation
 * 
 * 23-09-24 v1.00 : New Release
 *-----------------------------------------------------------------------------*/
module AudioTxBlock_tb;

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

//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth      = 32;		// USIB データ、アドレス共通バス幅
localparam lpBlockConnectNum  = 1;		// 現在接続しているブロックの個数
localparam lpBlockAdrsWidth   = f_detect_bitwidth(lpBlockConnectNum);
localparam lpCsrAdrsWidth     = 16;		// 各ブロック共通の基本CSR幅
localparam lpSUsiBusWidth     = (lpUsiBusWidth * lpBlockConnectNum);
localparam [lpBlockAdrsWidth-1:0]		// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
//   lpGpioAdrsMap		= 'h0,
//   lpSPIAdrsMap		= 'h1,
  lpAtbAdrsMap  	= 'h2,
//   lpRAMAdrsMap		= 'h3,
//   lpSysTimerAdrsMap	= 'h4,
//   lpMCBAdrsMap		= 'h5,
//   lpVtbAdrsMap		= 'h6,
  lpNullAdrsMap		= 0;

// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが難しいと感じたため用意した。
localparam 
//   lpGpioCsrActiveWidth  = 8,
//   lpSPICsrActiveWidth   = 8,
  lpAtbCsrActiveWidth   = 8,
//   lpRAMCsrActiveWidth   = 8,
//   lpTimerCsrActiveWidth = 8,
//   lpMCBCsrActiveWidth	= 8,
//   lpVtbCsrActiveWidth	= 16,
  lpNullActiveWidth     = 8;  // 使用しない、ソースの追加がやりやすいように

//-----------------------------------------------------------------------------
// Task function
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


//-----------------------------------------------------------------------------
// Rrs(Rom Read Sequence) Part
//-----------------------------------------------------------------------------
localparam lpSfcNum = 3;	// Serial Flash Memory Number

wire wI2sMclk;
wire wI2sBclk;
wire wI2sLrclk;
wire wI2sSdata;
wire [lpSfcNum-1:0] wSfmSck;
wire [lpSfcNum-1:0] wSfmMosi;
reg  [lpSfcNum-1:0] qSfmMiso;
wire [lpSfcNum-1:0] wSfmCs;

AudioTxBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpAtbAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpAtbCsrActiveWidth),
	.pSfmNum(lpSfcNum)
) AudioTxBlock (
	// I2S Signals
	.oI2S_MCLK(wI2sMclk),		.oI2S_BCLK(wI2sBclk),
	.oI2S_LRCLK(wI2sLrclk),		.oI2S_SDATA(wI2sSdata),
	// SPI Signals
	.oSfmSck(wSfmSck),			.oSfmMosi(wSfmMosi),
	.iSfmMiso(qSfmMiso),		.oSfmCs(wSfmCs),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpAtbAdrsMap]),
	// Bus Master Write
	.iSUsiWd(rSUsiWd),	.iSUsiAdrs(rSUsiAdrs),
	// common
	.iMRST(wMRST),		.iSRST(wSRST),		.inSRST(wnSRST),
	.iMCLK(wMCLK),		.iSCLK(wSCLK)
);

always @*
begin
	qSfmMiso <= 24'h001122;
end

//-----------------------------------------------------------------------------
// Simlation Start
//-----------------------------------------------------------------------------
initial begin
	$dumpfile("AudioTxBlock_tb.vcd");
	$dumpvars(0, AudioTxBlock_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	usi_csr_setting(24'h020202, 32'h4002000C);
	usi_csr_setting(24'h000007, 32'h40020020);
	usi_csr_setting(24'h000007, 32'h40020018);
	usi_csr_setting(24'h000000, 32'h4002001C);
	#(lpSCLKCycle * 4800);
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