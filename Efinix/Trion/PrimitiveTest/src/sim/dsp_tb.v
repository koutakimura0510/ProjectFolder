/*-----------------------------------------------------------------------------
 * Create  2023/6/3
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * -
 * V1.0：Trion DSP プリミティブを使用した乗算回路のシミュレーション 
 *-----------------------------------------------------------------------------*/	
module dsp_tb;

//----------------------------------------------------------
// Top Module Connect
//----------------------------------------------------------
localparam	lpSCLKCycle   = 2;	// CLK サイクル
localparam	lpSimlationTime = 2000;	// シミュレーション時間を指定

//----------------------------------------------------------
// clk,rst gen
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
// DSP
//-----------------------------------------------------------------------------
reg  [17:0] rA, rB;
wire [35:0] wX;
wire [35:0] wRes = rA * rB;


dsp dsp(
	.iA(rA),
	.iB(rB),
	.oX(wX),
	.iCLK(rSCLK)
);

always @(posedge rSCLK)
begin
	if (rSRST) 	rA <= 18'd0;
	else 		rA <= rA + 1'b1;

	if (rSRST) 	rB <= 18'd0;
	else 		rB <= rB + 1'b1;
end


//----------------------------------------------------------
// Simlation Start
//----------------------------------------------------------
initial
begin
	$dumpfile("dsp_tb.vcd");
	$dumpvars(0, dsp_tb);	// 引数0:下位モジュール表示, 1:Topのみ
	reset_init();
	#(lpSimlationTime);
    $finish;
end

endmodule