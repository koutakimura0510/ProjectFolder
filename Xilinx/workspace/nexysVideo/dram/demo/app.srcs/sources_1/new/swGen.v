/*
 * Create 2021/12/29
 * Author kouta kimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * スイッチ非同期信号のチャタリング、メタステーブル対策モジュール
 */
module swGen (
    input  iCLK,     // system clk
    input  iEnable,  // enable
    input  iBTN,
    output oBTN
);

reg [1:0] meta = 0;
reg [2:0] sft  = 0;
reg [1:0] pedge= 0;
wire chatta;


//----------------------------------------------------------
// 負論理なので反転して立ち上がり値取得
//----------------------------------------------------------
always @(posedge iCLK) begin
	meta <= {meta[0], ~iBTN};
end


//----------------------------------------------------------
// 比較機、3点一致したら1を出力
//----------------------------------------------------------
always @(posedge iCLK) begin
	if (iEnable == 1'b1) begin
		sft <= {sft[1:0], meta[1]};
    end
end

assign chatta = &sft;


//----------------------------------------------------------
// スイッチの立上りエッジのみ出力する、長押し処理は入れていない
//----------------------------------------------------------
always @(posedge iCLK) begin
	pedge <= {pedge[0], chatta};
end

assign oBTN = pedge[0] & ~pedge[1];

endmodule