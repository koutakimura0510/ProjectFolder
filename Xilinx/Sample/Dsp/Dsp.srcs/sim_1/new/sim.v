`timescale 1ns / 1ps
/*
Create  2022/12/10
Author  kimura
Editor  VSCode ver1.73.1
Build   Vivado22.2
Device  non
-
DspTop のシミュレーションファイル
本シミュレーションではクロックの供給のみを行う。
*/

module sim;

localparam lpCycle = 2;
reg  rClk = 0;
reg  rRst = 0;
wire wLed;

initial
begin
	rRst = 1;
	#(lpCycle * 10);
	rRst = 0;
end

always
begin
	#(lpCycle);
	rClk = ~rClk;
end

DspTop DspTop (
	.oLed	(wLed),
	.iClk	(rClk),
	.iRst	(rRst)
);

endmodule
