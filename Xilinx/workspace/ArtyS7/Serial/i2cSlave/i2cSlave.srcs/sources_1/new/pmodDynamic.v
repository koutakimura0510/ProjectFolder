/*
 * Create 2021/11/23
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * 7セグダイナミック点灯用データ生成
 */
module pmodDynamic
(
input 			iRST,		// System Reset
input 			iCLK,		// System Clock
input           enKhz,
input  [7:0]    i2cByte,
output [3:0]    selSeg,
output          saSeg
);


endmodule