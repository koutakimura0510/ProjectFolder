/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.62.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2C Slave処理
 * MasterのESP32からI2C通信でデータを受信し、受信データをシリアル->パラレル変換を行い7セグに表示する
 * サンプルとして送信されるデータは下記の通りである
 * 1. address 3F + wbit
 * 2. 0~Fを1秒間隔で送信される
 */
module i2cTop
(
parameter pSysClk = 100000000,	// System Clk 100MHz
parameter pDynClk = 500000
)(
inout 			ioSCL,			// ESP32 SCL
inout 			ioSDA,			// ESP32 SDA
// input 			iEnable,	// Control 0:Disconnect I2C-Bus
input 			iRST,			// System Reset
input 			iCLK,			// System Clock
output [6:0]    oSEG,       	// Pmod SSD 7seg digit
output          oSEL        	// 0. 1digit 1. 2digit
);

// I2C信号接続
wire ffscl, ffsda;    	// ノイズ除去を行ったI2C信号
wire [7:0] i2cByte; 	// パラレル変換を行ったI2Cデータ

// 7seg信号接続
wire [3:0] selSeg;
wire saSeg;

// ダイナミック点灯用enable信号
wire enKhz;

initial begin
	ioSCL = 1'bz;
	ioSDA = 1'bz;
end

// module
enGen           #(.pSysClk(pSysClk), .pDynClk(pDynClk)) 
				engen(.iCLK(iCLK), .iRST(iRST), .enKhz(enKhz));
edgeFilter      sclFF(.iCLK(iCLK), .iRST(iRST), .iSerial(ioSCL), .oSerial(ffscl));
edgeFilter      sdaFF(.iCLK(iCLK), .iRST(iRST), .iSerial(ioSDA), .oSerial(ffsda));
i2cSampling     i2c(.iCLK(iCLK), .iRST(iRST), .iSCL(ffscl), .iSDA(ffsda), .i2cByte(i2cByte));
pmodDynamic     dynamic(.iCLK(iCLK), .iRST(iRST), .enKhz(enKhz), .i2cByte(i2cByte), .selSeg(selSeg), .saSeg(saSeg));
pmodSeg         seg(.iCLK(iCLK), .iRST(iRST), .selSeg(selSeg), saSeg(saSeg) .oSEG(oSEG), .oSEL(oSEL));

endmodule