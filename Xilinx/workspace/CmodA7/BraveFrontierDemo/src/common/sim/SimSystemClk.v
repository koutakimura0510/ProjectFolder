//----------------------------------------------------------
// Create  2022/08/23
// Author  koutakimura
// -
// テストベンチ用の CLK Generator
// 
//----------------------------------------------------------
module SimSystemClk #(
	parameter 	pSystemClkCycle = 2
)(
	output		oSysClk,
	output		oSysRst
);

reg	rSysClk;		assign oSysClk = rSysClk;
reg	rSysRst;		assign oSysRst = rSysRst;

//----------------------------------------------------------
// CLK の生成
//----------------------------------------------------------
always begin
    #(pSystemClkCycle/2);
    rSysClk = ~rSysClk;
end


//----------------------------------------------------------
// Rst 生成
//----------------------------------------------------------
reg [2:0] 	rRstCnt = 0;
reg 		rRst;
//
reg 		qRstEn;
//
always @(posedge iSysClk)
begin
	if (qRstEn) rRstCnt <= rRstCnt;
	else		rRstCnt <= rRstCnt + 1'b1;

	if (qRstEn) rRst <= 1'b0;
	else 		rRst <= 1'b1;
end

always @*
begin
	qRstEn <= (rRstCnt == 3'd7);
end

endmodule