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
parameter pSclClk = 125
)(
input 			ioSCL,			// ESP32 SCL
inout 			ioSDA,			// ESP32 SDA
inout			ioSCLF,			// fpga scl
inout			ioSDAF,			// fpga sda
// input 			iEnable,	// Control 0:Disconnect I2C-Bus
input 			iRST,			// System Reset
input 			iCLK,			// System Clock
output [6:0]    oSEG,       	// Pmod SSD 7seg digit
output          oSEL        	// 0. 1digit 1. 2digit
);

// I2C信号接続
wire ffscl, ffsda;    			// ノイズ除去を行ったI2C信号
wire [7:0] i2cByte; 			// パラレル変換を行ったI2Cデータ
wire sclAck;					// ACK判定用のenable信号
wire oledEnable;				// 0. discon 1. start

// 7seg信号接続
wire [3:0] selSeg;
wire saSeg;

// enable信号
wire enSet;						// device setting
wire enKhz;						// dynamic flash
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
oledState		ssd1306(.iCLK(iCLK), .iRST(iRST), .enSet(enSet), .oledEnable(oledEnable));
i2cMaster		oled(.ioSCLF(ioSCLF), .ioSDAF(ioSDAF), .iCLK(iCLK), .iRST(iRST), .enClk(en400Khz), .iEnable(oledEnable));

endmodule