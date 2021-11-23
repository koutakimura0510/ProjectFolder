/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * I2C通信サンプリング回路
 * シリアルデータをパラレルデータに変換し1byteデータとして出力する
 */
module i2cSampling
(
input  iCLK,
input  iRST,
input  iSCL,
input  iSDA,
output i2cByte
);
endmodule
