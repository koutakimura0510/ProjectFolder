/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.62.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2C Slave処理
 * MasterのESP32からI2C通信でデータを受信し、受信データをシリアル->パラレル変換を行い7セグに表示する
 * -
 * グリッチ対策として組み合わせ回路の出力をDFFに受けてから外部に出力するようにする
 */
module i2cTop
#(
parameter pSysClk = 100000000,	// System Clk 100MHz
parameter pDynClk = 500000
)(
input 			ioSCL,			// ESP32 SCL
input 			ioSDA,			// ESP32 SDA
// input 			iEnable,	// Control 0:Disconnect I2C-Bus
input 			iRST,			// System Reset
input 			iCLK,			// System Clock
output [6:0]    oSEG,       	// Pmod SSD 7seg digit
output          oSEL,        	// 0. 1digit 1. 2digit
output			oSCLF,			// fpga scl
output			oSDAF			// fpga sda
);

// I2C信号接続
wire ffscl, ffsda;    	// ノイズ除去を行ったI2C信号
wire [7:0] i2cByte; 	// パラレル変換を行ったI2Cデータ

// 7seg信号接続
wire [3:0] selSeg;
wire saSeg;

// ダイナミック点灯用enable信号
wire enKhz;

assign oSCLF = ffscl;
assign oSDAF = ffsda;

// Enable信号生成
enGen           #(.pSysClk(pSysClk), .pDynClk(pDynClk)) 
				engen(.iCLK(iCLK), .iRST(iRST), .enKhz(enKhz));

// I2Cフィルタ回路
edgeFilter      sclFF(.iCLK(iCLK), .iRST(iRST), .iSerial(ioSCL), .oSerial(ffscl));
edgeFilter      sdaFF(.iCLK(iCLK), .iRST(iRST), .iSerial(ioSDA), .oSerial(ffsda));

// 8bitシリアル->1byteパラレル変換
i2cSampling     i2c(.iCLK(iCLK), .iRST(iRST), .iSCL(ffscl), .iSDA(ffsda), .i2cByte(i2cByte));

// パラレル変換したデータを4bitずつに分けて2桁7セグに表示
pmodDynamic     dynamic(.iCLK(iCLK), .iRST(iRST), .enKhz(enKhz), .i2cByte(i2cByte), .selSeg(selSeg), .saSeg(saSeg));
pmodSeg         seg(.iCLK(iCLK), .iRST(iRST), .selSeg(selSeg), .saSeg(saSeg), .oSEG(oSEG), .oSEL(oSEL));

endmodule