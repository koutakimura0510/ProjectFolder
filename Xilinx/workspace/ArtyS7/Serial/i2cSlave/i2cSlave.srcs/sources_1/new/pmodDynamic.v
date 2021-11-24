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

reg [3:0] selSeg;	// 上位4bit 下位4bitどちらかを保存
reg saSeg;			// 桁選択

/*
 * enKhzの立ち上がりで選択桁を変更する
 */
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		saSeg <= 1'd0;
	end else if (enKhz == 1'b1) begin
		if (saSeg == 1'b0) begin
			saSeg <= 1'd1;
		end else begin
			saSeg <= 1'd0;
		end
	end
end

/*
 * 選択桁に対応し、上位と下位bitの表示データを切り替える
 */
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		selSeg <= 4'd0;
	end else begin
		selSeg <= (saSeg == 1'b1) ? i2cByte[3:0] : i2cByte[7:4];
	end
end

endmodule