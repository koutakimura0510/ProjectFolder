/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2C Slave処理
 * MasterのESP32からI2C通信でデータを受信し、受信データを７セグに表示する
 * サンプルとして送信されるデータは16進数で0~Fを1秒間隔で送信される
 * 
 * 送受信サイクルはI2Cの下記の通りである
 * 1cycle => address byte
 * 2cycle => cmd or data byte
 */
module i2cTop
(
inout 			ioSCL,		// ESP32 SCL
inout 			ioSDA,		// ESP32 SDA
// input 			iEnable,	// Control 0:Disconnect I2C-Bus
input 			iRST,		// System Reset
input 			iCLK,		// System Clock
output [6:0]    oSEG,       // Pmod SSD 7seg digit
output          oSEL        // 0. 1digit 1. 2ditit
);



endmodule