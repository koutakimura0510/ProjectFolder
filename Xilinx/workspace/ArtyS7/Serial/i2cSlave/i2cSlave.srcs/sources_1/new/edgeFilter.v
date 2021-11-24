/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * シリアル通信のメタ・ステーブル対策とノイズフィルタ回路
 */
module edgeFilter
(
input  		iCLK,
input  		iRST,
input  		iSerial,
output 		oSerial
);

reg oSerial;
reg [1:0] meta;		// メタ・ステーブル対策
reg [2:0] sft;		// ノイズ除去用フィルタ
wire chatta;		// 3点一致検出用信号

// 2段フリップフロップで受信
always @(posedge iCLK) begin
	if (iRST == 1'd1) begin
		meta <= 2'd0;
	end else begin
		meta <= {meta[0], iSerial};
	end
end

// チャタリング除去
always @(posedge iCLK) begin
	if (iRST == 1'd0) begin
		sft <= 3'd0;
	end else begin
		sft <= {sft[1:0], meta[1]};
	end
end

// 比較器、High Low信号が3点一致したら1を出力
assign chatta = (sft[0] == sft[1] == sft[2]) ? 1'd1 : 1'd0;

// 非同期信号をシステムクロックに同期させて出力
// リセットがかからなければ前回の出力状態を維持する
always @(posedge iCLK) begin
	if (iRST == 1'd1) begin
		oSerial <= 1'd0;
	end else begin
		if (chata == 1'd1) begin
			oSerial <= sft[2];
		end
	end
end

endmodule
