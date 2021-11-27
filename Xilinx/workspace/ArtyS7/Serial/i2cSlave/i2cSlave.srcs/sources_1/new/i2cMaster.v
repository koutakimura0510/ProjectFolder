/*
 * Create 2021/11/27
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2C Master処理 8bit固定長
 */
module i2cMaster
(
inout  			ioSCLF,
inout  			ioSDAF,
input  			iCLK,
input  			iRST,
input 			enClk,			// scl enable信号
input			iEnable			// 0. discon 1. start
// input [7:0]		recData[0:7],	// 送信データ
// input [7:0]		recLength,		// 送信データ数
// input [31:0]	waitTime,		// データ送信後の待機時間、デバイスによっては初期設定時の待機時間があるため設けた
// output			mEnable			// 送信完了Enable信号
);

// i2c状態遷移
localparam [2:0] 
	disConnect 		= 3'd0,		// マスタのSCLがHIGHの間にSDAをLOWでStartシーケンス
	startCondition 	= 3'd1,		// SCLがHIGHの間にSDAをHIGHでStopシーケンス
	stopCondition 	= 3'd2;

localparam [3:0] 
	SclCntUp	= 4'd1,
	SclNull 	= 4'd0,
	SclDataByte	= 4'd8,
	SclAck	 	= 4'd9;

// i2c信号生成
reg ioSclf;		assign ioSCLF = ioSclf;
reg ioSdaf;		assign ioSDAF = ioSdaf;

// scl送信回数カウント変数
reg [3:0] sclCnt;


// scl送信回数カウント変数
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sclCnt <= SclNull;
	end else if (iEnable == 1'b0) begin
		sclCnt <= SclNull;
	end else if (enClk == 1'b1 && ioSclf == 1'b1) begin
		if (sclCnt == SclDataByte) begin
			sclCnt <= SclNull;
		end else begin
			sclCnt <= sclCnt + SclCntUp;
		end
	end
end

// scl生成
// reset時は次回start condition生成の為にHighにする
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		ioSclf <= 1'b1;
	end else if (iEnable == 1'b0) begin
		ioSclf <= 1'b1;
	end else if (enClk == 1'b1) begin
		ioSclf <= ~ioSclf;
	end
end

// sda送信
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		ioSdaf <= 1'b1;
	end else if (iEnable == 1'b0) begin
		ioSdaf <= 1'b1;
	end else begin
		ioSdaf <= ~ioSdaf;
	end
end

endmodule