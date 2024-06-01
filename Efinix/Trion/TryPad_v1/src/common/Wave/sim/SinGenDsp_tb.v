`timescale 1ns / 1ps
//----------------------------------------------------------
// Create  2022/08/12
// Author  KoutaKimura
// SPI の Master Slave を切り替えながらデータの送受信を行う。
// 
//----------------------------------------------------------
module SinGenDsp_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSCLKCycle   = 2;	// CLK サイクル
localparam	lpSimlationTime = 20000;	// シミュレーション時間を指定
// parameter [3:0]		pBlockConnectNum		= 10; 				// Busに接続する Slave数 最大16
// parameter [3:0]		pBlockConnectNumWidth 	= pBlockConnectNum - 1'b1;	// Busに接続する Slave数 最大16

//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
reg	rSCLK = 0;
reg	rSRST = 1;	//初期値
reg	rnSRST = 0;	//初期値

always
begin
    #(lpSCLKCycle);
    rSCLK = ~rSCLK;
end

// Reset 処理
task reset_init;
begin
	#(lpSCLKCycle * 5);
	rnSRST = ~rnSRST;
	rSRST = ~rSRST;
	#(lpSCLKCycle * 5);
end
endtask 

//-----------------------------------------------------------------------------
// module 
//-----------------------------------------------------------------------------
wire signed [15:0] wSin;
wire wVd;

SinGenDsp SinGenDsp(
	.oSin(wSin),
	.oVd(wVd),
	.iRST(rSRST),
	.iCLK(rSCLK)
);


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$dumpfile("SinGenDsp_tb.vcd");
	$dumpvars(0, SinGenDsp_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpSimlationTime);
    $finish;
end


endmodule