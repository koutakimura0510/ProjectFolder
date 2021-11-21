module I2S_OUT (
    input CLK, RESET,
    input LRCLK, BCLK_LAST, BCLK,
    input [7:0] BCOUNT,
    input [31:0] LDATA, RDATA,
    output SOUND_DATA
);

reg [31:0] datao;
reg datax;

//* 保存したデータを出力する
always @(posedge CLK) begin
	if (RESET == 1'b1) begin
		datao <= 0;
	end else if (~BCLK_LAST & BCLK) begin
		if (BCOUNT > 31) begin
			datao <= 0;
		end else if (BCOUNT != 31) begin
			datao <= {datao[30:0], datao[31]};
		end else if (~LRCLK) begin
			datao <= LDATA;
		end else begin
			datao <= RDATA;
		end
	end else if (BCLK_LAST & ~BCLK) begin
		datax <= datao[31];
	end
end

assign SOUND_DATA = datax;

endmodule