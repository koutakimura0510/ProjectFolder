//----------------------------------------------------------
// swのチャタリング除去回路
//----------------------------------------------------------
module swGen (
    input   iCLK, 
    input   iEnable, 
    input   iBtn,
    output  oBtn
);

reg [1:0] meta;
reg [2:0] sft;
reg [1:0] pedge;
// wire chatta;

always @(posedge iCLK) begin
	meta <= {meta[0], iBtn};
end
	
always @(posedge iCLK) begin
	if (iEnable == 1'b1) begin
		sft <= {sft[1:0], meta[1]};
    end
end

assign oBtn = &sft; // 3bitで1出力
// assign chatta = &sft;

// always @(posedge iCLK) begin
// 	pedge <= {pedge[0], chatta};
// end
	
// assign oBtn = pedge[0] & ~pedge[1];

endmodule
