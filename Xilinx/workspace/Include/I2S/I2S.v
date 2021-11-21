/*
 * 1LRCLK位相がずれたデータとその時のクロックを取得
 */

module I2S(
	input CLK, RESET, LRCLK, BCLK, DIN,
	output reg [31:0] IDATA,
	output reg [7:0] BCOUNT,
	output reg BCLK_LAST, LRCLK_LAST
);

//* BCLK取得
always @(posedge CLK) begin
	BCLK_LAST <= BCLK;
end

//* LRCLKの立ち上がりと立ち下がりを判定しBCLKの回数をカウントする
always @(posedge CLK) begin
	if (RESET == 1'b1) begin
		BCOUNT <= 8'b0;
		LRCLK_LAST <= 1'b0;
	end else if (~BCLK_LAST & BCLK) begin
		if (LRCLK_LAST != LRCLK) begin
			BCOUNT <= 8'b0;
			LRCLK_LAST <= LRCLK;
		end else begin
			BCOUNT <= BCOUNT + 8'b1;
			LRCLK_LAST <= LRCLK;
		end
	end
end

//* I2Sの規格に従い、1_BCLK位相がずれた状態でデータを取り込む
always @(posedge CLK) begin
	if (RESET == 1'b1) begin
		IDATA <= 32'b0;
	end else if (~BCLK_LAST & BCLK) begin
		if (BCOUNT == 8'd31) begin
			IDATA <= {IDATA[30:0], DIN};
		end else begin
			IDATA <= {IDATA[30:0], DIN};
		end
	end
end

//* 取り込んだデータを、Lデータ・Rデータ別々に保存する
// always @(posedge CLK) begin
// 	if (RESET == 1'b1) begin
// 		datal <= 0;
// 		datar <= 0;
// 	end else if (~bclk_last & BCLK && bcount == 0) begin
// 		if (~LRCLK) begin
// 			datar <= datai;
// 		end else begin
// 			datal <= datai;
// 		end
// 	end
// end

endmodule