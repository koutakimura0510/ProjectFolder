/* -
 * Arduino IO Pin
 * [Input]
 * IO7 LRCLK
 * IO6 BCLK
 * IO5 DIN
 *
 * [Output]
 * IO13 LRCLK
 * IO12 BCLK
 * IO11 DIN
 *
 * [I2S]
 * 48khzサンプリング　32bitデータ送信
 * I2SのCLKで同期せずに、FPGAのCLKで同期を行う
 *
 */

module I2S(
	CLK, RESET, ARDUINO_IO
);

input CLK, RESET;
inout [15:0] ARDUINO_IO;

reg bclk_last, lrclk_last;
reg [31:0] datai, datao;
reg [31:0] datar, datal;
reg [7:0] bcount;
reg datax;


//* 同期カウンタのため、メタ・ステーブル対策を行う
FF lrclk_ff (CLK, ARDUINO_IO[7], lrclk_ix);
FF bclk_ff  (CLK, ARDUINO_IO[6], bclk_ix);
FF data_ff  (CLK, ARDUINO_IO[5], data_ix);

always @(posedge CLK) begin
	bclk_last <= bclk_ix;
end

//* LRCLKの立ち上がりと立ち下がりを判定しBCLKの回数をカウントする
always @(posedge CLK) begin
	if (RESET == 1'b1) begin
		bcount <= 0;
		lrclk_last <= 0;
	end else if (~bclk_last & bclk_ix) begin
		if (lrclk_last != lrclk_ix) begin
			bcount <= 0;
			lrclk_last <= lrclk_ix;
		end else begin
			bcount <= bcount + 1;
			lrclk_last <= lrclk_ix;
		end
	end
end

//* I2Sの規格に従い、1_BCLK位相がずれた状態でデータを取り込む。データ取込み
always @(posedge CLK) begin
	if (RESET == 1'b1) begin
		datai <= 0;
	end else if (~bclk_last & bclk_ix) begin
		if (bcount == 31) begin
			datai <= {datai[30:0],data_ix};
		end else begin
			datai <= {datai[30:0],data_ix};
		end
	end
end

//* 取り込んだデータを、Lデータ・Rデータ別々に保存する
always @(posedge CLK) begin
	if (RESET == 1'b1) begin
		datal <= 0;
		datar <= 0;
	end else if (~bclk_last & bclk_ix && bcount == 0) begin
		if (~lrclk_ix) begin
			datar <= datai;
		end else begin
			datal <= datai;
		end
	end
end

//* 保存したデータを出力する
always @(posedge CLK) begin
	if (RESET == 1'b1) begin
		datao <= 0;
	end else if (~bclk_last & bclk_ix) begin
		if (bcount > 31) begin
			datao <= 0;
		end else if (bcount != 31) begin
			datao <= {datao[30:0],datao[31]};
		end else if (~lrclk_ix) begin
			datao <= datal;
		end else begin
			datao <= datar;
		end
	end else if (bclk_last & ~bclk_ix) begin
		datax <= datao[31];
	end
end


assign ARDUINO_IO[11] = datax;
assign ARDUINO_IO[12] = bclk_ix;
assign ARDUINO_IO[13] = lrclk_ix;


endmodule