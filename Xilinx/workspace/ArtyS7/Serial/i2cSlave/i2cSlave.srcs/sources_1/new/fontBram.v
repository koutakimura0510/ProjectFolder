/*
 * Create 2021/12/04
 * Author koutakimura
 * Editor VSCode ver1.62.1
 * Build  Vivado20.2
 * Borad  ArtyS7
 * -
 * 取得したバイトデータから、BRAMに保存されたフォントデータを取得
 */
module fontBram
#(
parameter pBufferSize = 1024,	// Bram Size
)(
input 			iRST,			// System Reset
input 			iCLK,			// System Clock
input   [7:0]   iByte,
output  [7:0]   oByte
);


//----------------------------------------------------------
// font 6x8 dot
//----------------------------------------------------------
(* ram_style = "BLOCK" *) reg [7:0] font_rom_6w8h [0:pBufferSize];
initial begin
	$readmemh(font6.dat, font_rom_6w8h);
end


//----------------------------------------------------------
// 出力データの設定
//----------------------------------------------------------
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		oByte <= 8'd0;
	end else begin
		oByte <= font_rom_6w8h[hrp + wrp];
	end
end


//----------------------------------------------------------
// フォント配列参照用rpの更新
//----------------------------------------------------------
reg [9:0] hrp;	// 縦軸のHeightRp
reg [2:0] wrp;	// 横軸のWidthRp

// 縦軸rpの更新
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		hrp <= 10'd0;
	end else begin
		hrp <= hrp; // 取得データに応じて縦軸を計算する
	end
end

// 横軸rpの更新
always @(posedge iCLK) begin
	if (iRST == 1'b1) begin
		wrp <= 3'd0;
	end else begin
		wrp <= wrp + 1'b1;
	end
end



endmodule