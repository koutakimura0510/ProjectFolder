/*
 * Create 2021/11/28
 * Author koutakimura
 * Editor VSCode ver1.62.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * slaveの送信データを管理するステートマシン
 */
module sendByteState
(
input 			iCLK,
input 			iRST,
input 			iLE,			// データ送信完了時High
input 			iOledCV,		// oled設定コマンド送信完了時High
input 			iClearSW,		// 表示クリアデータ送信用SW
input  [ 7:0]	iAddress,		// 送信先のデバイスのアドレス
input  [15:0]	iByteA,			// oled send data bytes A
input  [15:0]	iByteB,			// slave send data bytes B
output [23:0]	oSendByte,		// address + cmd + data bytes
output [31:0]	oLength			// SendByteの長さを指定
);

reg [23:0] obyte;		assign oSendByte = obyte;
reg [31:0] olen;		assign oLength   = olen;

//----------------------------------------------------------
// 送信データの生成
//----------------------------------------------------------

// 送信バイトの設定
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		obyte <= 24'd0;
	end else if (iOledCV == 1'b1) begin
		if (iClearSW == 1'b1 && iLE == 1'b1) begin
			obyte <= {iAddress, 8'h00};
		end else begin
			obyte <= {iAddress, iByteB};
		end
	end else begin
		obyte <= {iAddress, iByteA};
	end
end

always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		obyte <= 8'd0;
	end else begin
		obyte <= D;
	end
end

// 送信バイト数の長さを設定
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		olen <= 31'd3;
	end else if (initComplete == 1'b1) begin
		olen <= 31'd1026;
	end else begin
		olen <= 31'd3;
	end
end


// TODO フレームバッファ構造にしたら、送信データの配列長をoutputする処理追加

endmodule