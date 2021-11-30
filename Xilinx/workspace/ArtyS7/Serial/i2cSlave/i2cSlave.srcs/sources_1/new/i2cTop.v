/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.62.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * Project名がSlaveだがmaster処理も含まれている
 * -
 * I2C Slave処理
 * MasterのESP32からI2C通信でデータを受信し、受信データをシリアル->パラレル変換を行い7セグに表示する
 * -
 * I2C Master処理
 * FPGAをMasterとし、OLED SSD1306の初期設定を行い表示を行う
 * -
 * グリッチ対策として組み合わせ回路の出力をDFFに受けてから外部に出力するようにする
 */
module i2cTop
#(
parameter pSysClk = 100000000,	// System Clk 100MHz
parameter pSetClk = 100000,
parameter pDynClk = 500000,
parameter pSclClk = 125			// 125 -> 400kHz, 63 -> 800kHz
)(
input 			ioSCL,			// ESP32 SCL
inout 			ioSDA,			// ESP32 SDA
output			ioSCLF,			// fpga scl
inout			ioSDAF,			// fpga sda
// input 			iEnable,	// Control 0:Disconnect I2C-Bus
input 			iRST,			// System Reset
input 			iCLK,			// System Clock
input			iClearSW,		// display off
output [6:0]    oSEG,       	// Pmod SSD 7seg digit
output          oSEL        	// 0. 1digit 1. 2digit
);

// I2C slave信号
wire ffscl, ffsda;    			// ノイズ除去を行ったI2C信号
wire [7:0] i2cByte; 			// パラレル変換を行ったI2Cデータ
wire sclAck;					// ACK判定用のenable信号

// I2C master信号
wire [ 7:0] iLength;			// slaveに送信するデータの回数
wire [23:0] sendByte;			// アドレス・コマンド・データバイトを含んだ送信データ
wire sendComplete;				// 1byte送信完了時High

// OLED信号
wire oledPowerOn;				// 電源投入してから待機時間完了後High
wire initComplete;				// 初期設定完了後High
wire wTimeEnable;				// 待機時間完了Enable
wire [15:0] oledSetByte;		// コマンド用の送信データ
// wire clearSW;					// 表示消去sw

// 7seg信号
wire [3:0] selSeg;
wire saSeg;

// enable信号
wire enSet;						// device setting 1ms
wire enKhz;						// dynamic flash 5ms
wire en400Khz;					// i2c400khz


// Enable信号生成
enGen           #(.pSysClk(pSysClk), .pSetClk(pSetClk), .pDynClk(pDynClk), .pSclClk(pSclClk)) 
				engen(.iCLK(iCLK), .iRST(iRST), .enSet(enSet), .enKhz(enKhz), .en400Khz(en400Khz));

// I2Cフィルタ回路、ノイズ除去とSystemClkに同期させたI2Cの信号を出力、inoutのACK送信も行う
edgeFilter      sclFF(.ioSerial(ioSCL), .ioDir(1'b0), .iCLK(iCLK), .iRST(iRST), .sclAck(sclAck), .oSerial(ffscl));
edgeFilter      sdaFF(.ioSerial(ioSDA), .ioDir(1'b1), .iCLK(iCLK), .iRST(iRST), .sclAck(sclAck), .oSerial(ffsda));

// 8bitシリアル->1byteパラレル変換、ackのenable信号を出力
i2cSampling     i2c(.iSCL(ffscl), .iSDA(ffsda), .iCLK(iCLK), .iRST(iRST), .sclAck(sclAck), .i2cByte(i2cByte));

// パラレル変換したデータを4bitずつに分けて2桁7セグに表示
pmodDynamic     dynamic(.iCLK(iCLK), .iRST(iRST), .enKhz(enKhz), .i2cByte(i2cByte), .selSeg(selSeg), .saSeg(saSeg));
pmodSeg         seg(.iCLK(iCLK), .iRST(iRST), .selSeg(selSeg), .saSeg(saSeg), .oSEG(oSEG), .oSEL(oSEL));

// oled ssd1306操作
oledState		ssd1306(.iCLK(iCLK), .iRST(iRST),
						.enSet(enSet), .sendComplete(sendComplete), .clear(iClearSW),
						.sendByte(oledSetByte), .oledPowerOn(oledPowerOn), .initComplete(initComplete), .wTimeEnable(wTimeEnable));

// masterの送信データ制御モジュール
sendByteState	send(.iCLK(iCLK), .iRST(iRST), .sendComplete(sendComplete), .initComplete(initComplete),
					.iAddress(8'h78), .iByteA(oledSetByte), .iByteB({8'h40, 8'hff}), .oSendByte(sendByte));

// oledデータ送信
i2cMaster		oled(.ioSCLF(ioSCLF), .ioSDAF(ioSDAF), .iCLK(iCLK), .iRST(iRST),
					.enClk(en400Khz), .iEnable(oledPowerOn), .wTimeEnable(wTimeEnable), .sendByte(sendByte), .iLength(8'd3),
					.oEnable(sendComplete));

// TODO
// OLEDの表示方法が現在は直接送信のため、後々フレームバッファ構造にしなければならない（ダブルかトリプル）
//
// 【拡張】
// 受信データをFIFOに保存するmoduleの追加
// 文字コードを取り扱うBRAMの追加
// 1バイト表示データをoledのセグメント表示形式に変換するmoduleの追加
// セグメント形式に変換したデータをフレームバッファに挿入するmoduleの追加
// i2cMasterに上記の変更を適応
// コマンドバイト時は3byte送信だが、データバイト時は連続送信が可能なため対応
// 
// 【更に拡張】
// フレームバッファ領域をDRAMに保存するためのMIGを作成する
// FPGAがDRAMと自由にアクセスできるRTLを記述する
// HDMI出力可能にする
// HDMI出力に音源データを乗せる
// 
// 【更に更に拡張】
// ZynqではなくMicroblazeの使用を検討する。
// Zynq $7000 / Spartan7 $3000~4500 Artix $4000~6000
// 
// 値段だけでなく機能の追加のしやすさなど、様々な仕様を検討の上決定する事


endmodule