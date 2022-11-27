//----------------------------------------------------------
// Create  2022/11/26
// Author  koutakimura
// Editor  VSCode ver1.73.1
// Build   Vivado22.2
// Device  
// -
// BRAM の合成結果を確認するためのプロジェクト
// 
//----------------------------------------------------------
module BramTop_sim;


//----------------------------------------------------------
// System Clk Generator
//----------------------------------------------------------
localparam	lpSysClkCycle = 4;	// CLK サイクル

reg	rSysClk = 0;
reg	rSysRst = 1;

always begin
    #(lpSysClkCycle/2);
    rSysClk = ~rSysClk;
end
//
// Reset 処理
task reset_init;
begin
	#(lpSysClkCycle * 5);
	rSysRst = 0;
	#(lpSysClkCycle * 5);
end
endtask


//----------------------------------------------------------
// Top module
//----------------------------------------------------------
wire wLed;

BramTop BramTop (
	.iRst	(rSysRst),
	.iClk	(rSysClk),
	.oLed	(wLed)
);


//----------------------------------------------------------
// 初期動作
//----------------------------------------------------------
initial
begin
	reset_init();
    $stop;
end



endmodule