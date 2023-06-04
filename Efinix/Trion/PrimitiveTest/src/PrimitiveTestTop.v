/*-----------------------------------------------------------------------------
 * Create  2023/6/3
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * Device  K5Stack10 Main Board
 * -
 * V1.0：Trion のプリミティブ検証用プロジェクト,
 * 
 *-----------------------------------------------------------------------------*/	
module PrimitiveTestTop (
	// GPIOR
	output 	[2:0] oLed,
	// PLL TL0
	input 	iSCLK,
	output 	PLL_BR0_RSTN,
	input 	PLL_BR0_LOCKED
);


//-----------------------------------------------------------------------------
// System Reset Gen
//-----------------------------------------------------------------------------
reg rSRST, rnSRST;
wire wSRST, wnSRST;
reg  qlocked;

always @(posedge iSCLK)
begin
	if (!qlocked) 	rnSRST <= 1'b0;
	else 			rnSRST <= 1'b1;
	
	if (!qlocked) 	rSRST <= 1'b1;
	else 			rSRST <= 1'b0;
end

always @*
begin
	qlocked <= &{PLL_BR0_LOCKED};
end

assign wSRST	= rSRST;
assign wnSRST	= rnSRST;
assign PLL_BR0_RSTN = 1'b1;

//-----------------------------------------------------------------------------
// DSP
//-----------------------------------------------------------------------------
reg  signed [17:0] rA, rB;
wire signed [35:0] wX;

dsp dsp(
	.iA(rA),
	.iB(rB),
	.oX(wX),
	.iCLK(iSCLK)
);

always @(posedge iSCLK)
begin
	if (wSRST) 	rA <= 18'd0;
	else 		rA <= rA + 1'b1;

	if (wSRST) 	rB <= 18'd0;
	else 		rB <= rB + 1'b1;
end


//-----------------------------------------------------------------------------
// IO Connect
// Trion,Titanium はユーザーが使用可能な IOプリミティブは無いため、
// 階層を深くせずソースの修正が簡単にすることを目的として Top module に接続する仕様にした
// OE "0"=Input, "1"=Output
//-----------------------------------------------------------------------------
reg [2:0] qGpioAltMode;

assign oLed[0] 	= qGpioAltMode[0];
assign oLed[1] 	= qGpioAltMode[1];
assign oLed[2] 	= &{wX};

//-----------------------------------------------------------------------------
// LED Toggle
//-----------------------------------------------------------------------------
localparam lpCntMax = 25000000-1;

reg [27:0] rCnt;
reg rLed;

always @(posedge iSCLK)
begin
	if (rSRST) 					rCnt <= 0;
	else if (lpCntMax==rCnt) 	rCnt <= 0;
	else 						rCnt <= rCnt + 1'b1;

	if (rSRST) 					rLed <= 0;
	else if (lpCntMax==rCnt) 	rLed <= ~rLed;
	else 						rLed <= rLed;
end

always @*
begin
	qGpioAltMode[0] <= qlocked;
	qGpioAltMode[1] <= rLed;
	qGpioAltMode[2] <= rLed;
end

//---------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//---------------------------------------------------------------------------
function[  7:0]	func_getwidth;
    input [31:0] iVAL;
    integer			i;

    begin
    func_getwidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            func_getwidth = i+1;
        end
    end
endfunction

endmodule