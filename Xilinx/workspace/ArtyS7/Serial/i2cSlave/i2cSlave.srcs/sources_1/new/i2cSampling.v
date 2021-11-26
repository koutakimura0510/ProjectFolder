/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2C通信サンプリング回路、仕様は下記の通りである
 * 1. シリアルデータをパラレルデータに変換し1byteデータとして出力する
 * 2. 受信データは8bit固定長とする
 * 3. 書き込み専用とし、read信号は受け付けない(CPUがmasterでFPGAのデータを読み込む場面が想定できないため)
 */
module i2cSampling
(
input  iSCL,
input  iSDA,
input  iCLK,
input  iRST,
output sclAck,
output [7:0] i2cByte
);

localparam [2:0] 
	disConnect 		= 3'd0,		// マスタのSCLがHIGHの間にSDAをLOWでStartシーケンス
	startCondition 	= 3'd1,		// SCLがHIGHの間にSDAをHIGHでStopシーケンス
	stopCondition 	= 3'd2;

localparam [3:0] 
	SclCntUp	= 4'd1,
	SclNull 	= 4'd0,
	SclDataByte	= 4'd8,
	SclAck	 	= 4'd9;

reg sclack;			assign sclAck  = sclack;	// inout切替信号出力
reg [7:0] i2cbyte;	assign i2cByte = i2cbyte;	// パラレルデータ出力
reg [3:0] sclcnt;	// sclの受信回数カウント
reg [7:0] sftSel;	// パラレル変換用にシリアルデータを保存するシフトレジスタ
reg [1:0] sftScl;	// sclの状態を管理を行うシフトレジスタ
reg [1:0] sftSda;	// sdaの状態を管理を行うシフトレジスタ
reg [2:0] i2cState;	// start stopシーケンサ管理
reg getByte;		// アドレスバイトは必要ないため、データバイト部分のみパラレル変換を行うための制御信号
wire psclEdge;
wire nsclEdge;
wire discon;		// stop condition


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
// 基本sclがHighの間はsdaは変化しないため
// High中にclkが変化したらconditionの検出とみなす
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		i2cState <= disConnect;
	end else begin
		case (i2cState)
			disConnect: 	i2cState <= (sftScl == 2'b11 && sftSda == 2'b10) ? startCondition : disConnect;
			startCondition:	i2cState <= (sftScl == 2'b11 && sftSda == 2'b01) ? disConnect : startCondition;
			default:		i2cState <= disConnect;
		endcase
	end
end

// start conditionを検出したらcnt開始
// 回路を増やす可能性があるため、wireを利用している
assign discon 	= (i2cState == disConnect) ? 1'b0 : 1'b1;

// iSCLのエッジ検出
assign psclEdge = (sftScl == 2'b01) ? 1'b1 : 1'b0;
assign nsclEdge = (sftScl == 2'b10) ? 1'b1 : 1'b0;

// sclの立ち上がりエッジで受信回数をカウント
// ackまでカウントしたらクリア
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sclcnt <= SclNull;
	end else if (discon == 1'b0) begin
		sclcnt <= SclNull;
	end else if (psclEdge == 1'b1) begin
		if (sclcnt == SclDataByte) begin
			sclcnt <= SclNull;
		end else begin
			sclcnt <= sclcnt + SclCntUp;
		end
	end
end

// sdaシリアルデータ保存、ack信号時はデータを保存しない
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sftSel <= 8'd0;
	end else if (psclEdge == 1'b1) begin
		sftSel <= {sftSel[6:0], iSDA};
	end
end

// SCLのカウント数で判定を行いinoutのackのenable信号を出す
// ack部分のsclの立下りでinputに切り替える
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sclack <= 1'd0;
	end else if (discon == 1'b0) begin
		sclack <= 1'b0;
	end else if (nsclEdge == 1'b1) begin
		if (sclcnt == SclDataByte) begin
			sclack <= 1'b1;
		end else begin
			sclack <= 1'b0;
		end
	end
end

// パラレル変換制御信号制御
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		getByte <= 1'b0;
	end else if (discon == 1'b0) begin
		getByte <= 1'b0;
	end else if (psclEdge == 1'b1 && sclcnt == SclDataByte) begin
		if (getByte == 1'b1) begin
			getByte <= 1'b0;
		end else begin
			getByte <= 1'b1;
		end
	end
end

// 8bitシリアルデータをパラレルレジスタに保存
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		i2cbyte <= 8'd0;
	end else if (psclEdge == 1'b1 && sclcnt == SclDataByte && getByte == 1'b1) begin
		i2cbyte <= sftSel;
	end
end

endmodule