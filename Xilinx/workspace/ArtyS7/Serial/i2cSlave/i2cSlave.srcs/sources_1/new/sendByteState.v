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
input 			sendComplete,	// データ送信完了時High
input 			initComplete,	// oled設定コマンド送信完了次High
input  [ 7:0]	iAddress,		// 送信先のデバイスのアドレス
input  [15:0]	iByteA,			// oled send data bytes A
input  [15:0]	iByteB,			// slave send data bytes B
output [23:0]	oSendByte		// address + cmd + data bytes
);

reg [23:0] obyte;		assign oSendByte = obyte;


//----------------------------------------------------------
// 送信データの生成
//----------------------------------------------------------
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		obyte <= 24'd0;
	end else if (initComplete == 1'b1) begin
		obyte <= {iAddress, iByteB};
	end else begin
		obyte <= {iAddress, iByteA};
	end
end

endmodule