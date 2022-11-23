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
input			iSCL,
input 			iLE,			// 全データ送信完了時 High
input			iBE,			// 1バイトデータ送信完了時 High
input 			iOledCV,		// oled設定コマンド送信完了時High
input 			iClearSW,		// 表示クリアデータ送信用SW
input  [ 7:0]	iAddress,		// 送信先のデバイスのアドレス
input  [ 7:0]	iByteA,			// oled send data bytes A
input  [ 7:0]	iByteB,			// slave send data bytes B
output [ 7:0]	oSendByte,		// address + cmd + data bytes
output [31:0]	oLength			// SendByteの長さを指定
);

reg [ 7:0] obyte;		assign oSendByte = obyte;
reg [31:0] olen;		assign oLength   = olen;

//----------------------------------------------------------
// 送信データ設定ステートマシン
//----------------------------------------------------------
localparam [1:0]
	oAddressMode 	= 2'd0,
	oCmdMode 		= 2'd1,
	oByteMode 		= 2'd2;

reg [1:0] obyteState;

// 状態遷移
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		obyteState <= oAddressMode;
	end else begin
		case (obyteState)
			oAddressMode: 	obyteState <= (iBE == 1'b1) ? oCmdMode : oAddressMode;
			oCmdMode:		obyteState <= (iBE == 1'b1) ? oByteMode : oCmdMode;
			oByteMode:		obyteState <= (iLE == 1'b1) ? oAddressMode : oByteMode;
			default: 		obyteState <= oAddressMode;
		endcase
	end
end

//----------------------------------------------------------
// 送信データの生成
//----------------------------------------------------------
localparam [7:0]
    CMD_BYTE		= 8'h00,        // 設定コマンド送信
    WR_BYTE         = 8'h40;        // 書き込みバイト送信


// 送信バイトの設定
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		obyte <= 8'd0;
	end else begin
		case (obyteState)
			oAddressMode: 	obyte <= iAddress;
			oCmdMode:		obyte <= (iOledCV == 1'b1) ? WR_BYTE : CMD_BYTE;
			oByteMode:		obyte <= (iOledCV == 1'b1) ? iByteB  : iByteA;
			default: 		obyte <= 8'd0;
		endcase
	end
end


// 送信バイト数の長さを設定
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		olen <= 31'd3;
	end else if (iOledCV == 1'b1) begin
		olen <= 31'd1025;
	end else begin
		olen <= 31'd3;
	end
end


// TODO フレームバッファ構造にしたら、送信データの配列長をoutputする処理追加

endmodule