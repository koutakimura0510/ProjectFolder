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
inout  		ioSerial,
input		ioDir,		// 双方向対応を行うかbitで指定 1.true 0.false
input  		iCLK,
input  		iRST,
input 		sclAck,
output 		oSerial
);

reg osel;			assign oSerial = osel;
assign ioSerial = (sclAck == 1'b1 && ioDir == 1'b1) ? 1'b0 : 1'bz;

// 非同期信号処理
reg [1:0] meta;		// メタ・ステーブル対策
reg [2:0] sft;		// ノイズ除去用フィルタ
wire filter;		// 3点一致検出用信号

// 2段フリップフロップで受信
always @(posedge iCLK) begin
	if (iRST == 1'd1) begin
		meta <= 2'd0;
	end else if (sclAck == 1'b1 && ioDir == 1'b1) begin
		meta <= {meta[0], 1'b0};
	end else begin
		meta <= {meta[0], ioSerial};
	end
end

// チャタリング除去
always @(posedge iCLK) begin
	if (iRST == 1'd1) begin
		sft <= 3'd0;
	end else begin
		sft <= {sft[1:0], meta[1]};
	end
end

// 比較器、High Low信号が3点一致したら1を出力
assign filter = (sft[0] == sft[1] && sft[1] == sft[2]) ? 1'd1 : 1'd0;


// 非同期信号をシステムクロックに同期させて出力
// リセットがかからなければ前回の出力状態を維持する
always @(posedge iCLK) begin
	if (iRST == 1'd1) begin
		osel <= 1'd0;
	end else begin
		if (filter == 1'd1) begin
			osel <= sft[2];
		end
	end
end

endmodule
