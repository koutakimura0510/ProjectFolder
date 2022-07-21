//----------------------------------------------------------
// SW のチャタリング除去モジュール
// 
// 2022/7/18
// プロジェクト作成に伴い System Verilog で置き換え
//----------------------------------------------------------
module SwAsyncGen (
    input   iSysClk, 
    input   iCke, 
    input   iUserSw,
    output  oUserSw
);

logic [1:0] rMeta;
logic [2:0] rSftReg;
// logic [1:0] pedge;

always_ff @(posedge iSysClk)
begin
	rMeta <= {rMeta[0], iUserSw};
end

always_ff @(posedge iSysClk)
begin
	if (iCke) rSftReg <= {rSftReg[1:0], rMeta[1]};
end

assign oUserSw = &rSftReg; // 3bitで1出力
// assign chatta = &sft;

// always @(posedge iCLK) begin
// 	pedge <= {pedge[0], chatta};
// end
	
// assign oBtn = pedge[0] & ~pedge[1];

endmodule
