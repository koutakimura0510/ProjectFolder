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
output 			ioSCLF,
inout  			ioSDAF,
input  			iCLK,
input  			iRST,
input 			enClk,			// 100 / 400 / 800khz enable信号
input			iEnable,		// 0. discon 1. start
input [23:0]	sendByte,		// 送信データ address + cmd + data byte
input [7:0]		iLength,		// 送信データ数
// input [31:0]	waitTime,		// データ送信後の待機時間、デバイスによっては初期設定時の待機時間があるため設けた
output			oEnable			// 送信完了Enable信号
);

//----------------------------------------------------------
// I2C制御パラメータリスト
//----------------------------------------------------------
// i2c状態遷移
localparam [2:0] 
	disConnect 		= 3'd0,		// マスタのSCLがHIGHの間にSDAをLOWでStartシーケンス
	startCondition 	= 3'd1,		// SCLがHIGHの間にSDAをHIGHでStopシーケンス
	stopCondition 	= 3'd2;

localparam [3:0] 
	SclCntUp		= 4'd1,
	SclNull 		= 4'd0,
	SclDataByte		= 4'd8,
	SclAck	 		= 4'd7;

localparam [6:0]
	delayCntUp 		= 7'd1,
	delayCntClear	= 7'd0,
	delayCntMax		= 7'd2; // 63clk -> 600ns

//----------------------------------------------------------
// 変数宣言
//----------------------------------------------------------
// i2c信号生成
reg ioSclf;		assign ioSCLF  = ioSclf;
reg ioSdaf;		assign ioSDAF  = (ioSdaf == 1'bx) ? 1'bz : ioSdaf;
reg oenable;	assign oEnable = oenable;

// i2c状態遷移管理変数
reg [2:0] i2cState;

// scl送信回数
reg [3:0] sclCnt;	// sclの立上り回数
reg [7:0] mLength;	// (module)1byte送信回数

// sda送信データ参照rp
reg [31:0] sdaRp;

// sda出力データ遅延カウンタ
reg [6:0]  sdaDelayCnt;

//----------------------------------------------------------
// I2Cステートマシン制御
//----------------------------------------------------------

// i2cステートマシン管理
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		i2cState <= disConnect;
	end else if (iEnable == 1'b0) begin
		i2cState <= disConnect;
	end else begin
		case (i2cState)
			disConnect: begin
				i2cState <= (ioSclf == 1'b0 && ioSdaf == 1'b0) ? startCondition : disConnect;
			end

			startCondition: begin
				i2cState <= (iLength == mLength) ? stopCondition : startCondition;
			end

			stopCondition: begin
				i2cState <= (ioSclf == 1'b1 && ioSdaf == 1'b1) ? disConnect : stopCondition;
			end

			default: begin
				i2cState <= disConnect;
			end
		endcase
	end
end


//----------------------------------------------------------
// I2C クロック生成
//----------------------------------------------------------

// sclの立上り回数をカウント
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sclCnt <= SclNull;
	end else if (iEnable == 1'b0) begin
		sclCnt <= SclNull;
	end else if (enClk == 1'b1 && ioSclf == 1'b1) begin
		case (i2cState)
			disConnect: begin
				sclCnt <= SclNull;
			end

			startCondition: begin
				sclCnt <= (sclCnt == SclDataByte) ? SclNull : sclCnt + SclCntUp;
			end

			stopCondition: begin
				sclCnt <= SclNull;
			end

			default: begin
				sclCnt <= SclNull;
			end
		endcase
	end
end

// i2cのデータ送信回数をカウント
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		mLength <= 8'd0;
	end else if (iEnable == 1'b0) begin
		mLength <= 8'd0;
	end else if (enClk == 1'b1 && ioSclf == 1'b1) begin
		case (i2cState)
			disConnect: begin
				mLength <= 8'd0;
			end

			startCondition: begin
				if (sclCnt == SclDataByte) begin
					mLength <= mLength + 8'd1;
				end
			end

			stopCondition: begin
				mLength <= 8'd0;
			end

			default: begin
				mLength <= 8'd0;
			end
		endcase
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
		case (i2cState)
			disConnect: begin
				ioSclf <= (ioSdaf == 1'b0) ? 1'b0 : 1'b1;
			end

			startCondition: begin
				ioSclf <= ~ioSclf;
			end

			stopCondition: begin
				ioSclf <= 1'b1;
			end

			default: begin
				ioSclf <= 1'b1;
			end
		endcase
	end
end

// sda送信用sendByteのbit位置参照rpの更新
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sdaRp <= 32'd0;
	end else if (enClk == 1'b1 && ioSclf == 1'b1) begin
		case (i2cState)
			disConnect: begin
				sdaRp <= (iLength << 3) - 1'b1;
			end

			startCondition: begin
				if (sclCnt != SclDataByte) begin
					sdaRp <= sdaRp - 1'b1;
				end
			end

			stopCondition: begin
				sdaRp <= 32'd0;
			end

			default: begin
				sdaRp <= 32'd0;
			end
		endcase
	end
end


// sda送信データの変化遅延タイミング生成回路
// sclの立下りから最低300nsSdaの状態を保持する必要があるため
// 遅延用カウンタを設ける
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		sdaDelayCnt <= delayCntClear;
	end else if (ioSclf == 1'b0) begin
		sdaDelayCnt <= sdaDelayCnt + delayCntUp;
	end else begin
		sdaDelayCnt <= delayCntClear;
	end
end


// sda送信
// 0 ~ 7clkは通常の1byteデータ送信
// 8clkはACK受信のためハイ・インピーダンスにする
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		ioSdaf <= 1'b1;
	end else if (iEnable == 1'b0) begin
		ioSdaf <= 1'b1;
	end else begin
		case (i2cState)
			disConnect: begin
				if (enClk == 1'b1) begin
					ioSdaf <= 1'b0;
				end
			end

			startCondition: begin
				if (sdaDelayCnt == delayCntMax) begin
					if (iLength == mLength) begin // 指定バイト送信時、stop conditionに備えてlowにする
						ioSdaf <= 1'b0;
					end else if (sclCnt == SclDataByte) begin
						ioSdaf <= 1'bx;
					end else begin
						ioSdaf <= sendByte[sdaRp]; //byte data
					end
				end
			end

			stopCondition: begin
				if (ioSclf == 1'b1 && enClk == 1'b1) begin
					ioSdaf <= 1'b1;
				end
			end

			default: begin
				ioSdaf <= 1'b1;
			end
		endcase
	end
end


//----------------------------------------------------------
// 送信シーケンス処理
//----------------------------------------------------------

// バイトデータ送信時にenable信号を出力
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		oenable <= 1'b0;
	end else if (sclCnt == SclDataByte && iLength == mLength) begin
		oenable <= 1'b1;
	end else begin
		oenable <= 1'b0;
	end
end


endmodule