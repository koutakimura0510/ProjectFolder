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
	output		oSysClk
);

reg	rSysClk;		assign oSysClk = rSysClk;

//----------------------------------------------------------
// CLK の生成
//----------------------------------------------------------
initial
begin
	rSysClk <= 1'b0;
end

always
begin
    #(pSystemClkCycle/2);
    rSysClk = ~rSysClk;
end


endmodule