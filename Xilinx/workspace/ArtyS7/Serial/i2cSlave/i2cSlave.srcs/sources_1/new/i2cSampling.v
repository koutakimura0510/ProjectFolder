/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2C通信サンプリング回路
 * シリアルデータをパラレルデータに変換し1byteデータとして出力する
 * 受信データは8bit固定長とする
 */
module i2cSampling
(
input  iCLK,
input  iRST,
input  iSCL,
input  iSDA,
output [7:0] i2cByte
);

localparam [2:0] 
	disConnect 		= 3'd0,		// マスタがSCLがHIGHの間にSDAをLOWでStartシーケンス
	startCondition 	= 3'd1,		// SCLがHIGHの間にSDAをHIGHでStopシーケンス
	stopCondition 	= 3'd2;

localparam [3:0] 
	SclCnt 		= 4'd1,
	SclNull 	= 4'd0,
	SclDataByte	= 4'd8,
	SclAck	 	= 4'd9;


// i2c状態管理
reg [1:0] sftScl;	// sclの状態を管理を行うシフトレジスタ
reg [1:0] sftSda;	// sdaの状態を管理を行うシフトレジスタ
reg [2:0] i2cState;	// start stopシーケンサ管理

// i2cシリアルデータ操作
reg [7:0] sftSel;	// パラレル変換用にシリアルデータを保存するシフトレジスタ
reg [7:0] i2cByte;	// パラレル出力用
reg [3:0] sclCnt;	// sdaの受信回数カウント
wire sclEdge;		// sclの立ち上がり検出



// 現在のI2Cの状態を確認するためシフトレジスタにクロックのデータを保存する
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sftScl <= 2'd0;
		sftSda <= 2'd0;
	end else begin
		sftScl <= {sftScl[0], iSCL};
		sftSda <= {sftSda[0], iSDA};
	end
end

// start stop condition検出
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		i2cState <= disConnect;
	end else begin
		case (i2cState)
			disConnect: 	i2cState <= (sftScl == 2'b11 && sftSda == 2'b00) ? startCondition : disConnect;
			startCondition:	i2cState <= (sftScl == 2'b11 && sftSda == 2'b01) ? disConnect : startCondition;
			default:		disConnect;
		endcase
	end
end

// iSCLのエッジ検出
assign sclEdge = (sftScl == 2'b01) ? 1'b1 : 1'b0;

// sclの立ち上がりエッジで受信回数をカウント
// ackまでカウントしたらクリア
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sclCnt <= SclNull;
	end else if (sclEdge == 1'b1) begin
		if (sclCnt == SclDataByte) begin
			sclCnt <= SclNull;
		end else begin
			sclCnt <= sclCnt + SclCnt;
		end
	end
end

// sdaシリアルデータ保存
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sftSel <= 8'd0;
	end else if (sclEdge == 1'b1 && sclCnt != SclDataByte) begin
		sftSel <= {sftSel[6:0], iSDA};
	end
end

// シリアルデータをパラレルレジスタに保存
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		i2cByte <= 8'd0;
	end else if (sclEdge == 1'b1 && sclCnt == SclDataByte) begin
		i2cByte <= sftSel;
	end
end

endmodule