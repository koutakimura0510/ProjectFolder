/*------------------------------------------------------------------------------
 * Create  2022-09-04
 * Author  kouta kimura
 * 
 * BMPファイル書き出し, 詳しくは C言語 bitmap フォルダ参考
 * 2022-09-04 v1.00 : release
 * 2025-03-22 v1.01 : BMP 保存時に上下逆で保存されるため、一度メモリ上に保存し更に反転させてBMP出力するように更新
 * 2025-03-28 v1.02 : BMP の仕様により、幅が4の倍数でない場合のパディング領域追加に対応
 *-----------------------------------------------------------------------------*/
module BmpFileSaver #(
	parameter	[31:0]	pWidth			= 480,		// 画像幅
	parameter	[31:0]	pHeight			= 240,		// 画像高さ
	parameter	[31:0]	pBmpFormat		= 3,		// バイト数
	parameter			pBmpHeaderSize	= 54,
	// not
	parameter 	[31:0]	pBmpFileSize	= pBmpHeaderSize + (pWidth * pHeight * pBmpFormat),
	parameter	[31:0]	pBmpImageSize	= (pWidth * pHeight * pBmpFormat)
)(
	input [7:0] 		iColorR,
	input [7:0] 		iColorG,
	input [7:0] 		iColorB,
	input 				iVde,
	input 				iAFE,
	output				oFull,
	//
	output 				oSaveEnd,	// 書き出し終了
	//
	input 				iRST,
	input 				iCLK
);


//-----------------------------------------------------------------------------
// ファイル書き出し
//-----------------------------------------------------------------------------
localparam [2:0]
	lpFileOpen 		= 0,
	lpFileWrite 	= 1,
	lpFileBmpWrite 	= 2,
	lpFileClose 	= 3,
	lpFileWriteEnd 	= 4,
	lpFileOpenError	= 5;

integer i = 0;
integer fd = 0;			// ファイルディスクリプタ
integer padsize = 0;	// パディングエリアのサイズ
integer st_count = 0;	// ステートマシンの実行回数
//
reg rSaveEnd;			assign oSaveEnd = rSaveEnd;
reg rFull;				assign oFull = rFull;
//
reg [2:0] rFileSt;
reg [127:0] pFileSave = "image_data";
reg [23:0] rRom[0:pWidth*pHeight];
reg [23:0] rColor;
reg [31:0] rYpos;
reg [31:0] rXpos;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSaveEnd 	= 1'b0;
		rFileSt		= lpFileOpen;
		rYpos		= pHeight - 1;
		rXpos		= 32'd0;
		rFull		= 1'b0;
		st_count 	= 0;
	end
	else
	begin
		case (rFileSt)
		lpFileOpen:
		begin
			st_count = st_count + 1;
			$sformat(pFileSave, "image_%0d.bmp", st_count);	// 可変ファイル名を生成
			fd = $fopen(pFileSave, "wb");
			rSaveEnd 	= 1'b0;
			rFull		= 1'b0;
			rYpos		= pHeight - 1;
			rXpos		= 32'd0;

			if (!fd)
			begin
				rFileSt = lpFileOpenError;
				$display("File Open NG %s", pFileSave);
			end
			else
			begin
				$display("File Open OK %s", pFileSave);
				$display("width   = %d", pWidth);
				$display("height = %d", pHeight);
				$fwrite(fd, "%c", 8'h42);					// 0 ~ 1 BMP フォーマット種類
				$fwrite(fd, "%c", 8'h4d);					// 0 ~ 1 BMP フォーマット種類
				$fwrite(fd, "%c", pBmpFileSize[ 7: 0]);		// 2 ~ 5 ファイルサイズ
				$fwrite(fd, "%c", pBmpFileSize[15: 8]);		// 2 ~ 5 ファイルサイズ
				$fwrite(fd, "%c", pBmpFileSize[23:16]);		// 2 ~ 5 ファイルサイズ
				$fwrite(fd, "%c", pBmpFileSize[31:24]);		// 2 ~ 5 ファイルサイズ
				$fwrite(fd, "%c", 8'd0);					// 6 ~ 9 予約領域1 ~ 2
				$fwrite(fd, "%c", 8'd0);					// 6 ~ 9 予約領域1 ~ 2
				$fwrite(fd, "%c", 8'd0);					// 6 ~ 9 予約領域1 ~ 2
				$fwrite(fd, "%c", 8'd0);					// 6 ~ 9 予約領域1 ~ 2
				$fwrite(fd, "%c", 8'd54);					// 10 ~ 13 ファイル先頭から画像データまでのオフセット数（バイト単位）
				$fwrite(fd, "%c", 8'd0);					// 10 ~ 13 ファイル先頭から画像データまでのオフセット数（バイト単位）
				$fwrite(fd, "%c", 8'd0);					// 10 ~ 13 ファイル先頭から画像データまでのオフセット数（バイト単位）
				$fwrite(fd, "%c", 8'd0);					// 10 ~ 13 ファイル先頭から画像データまでのオフセット数（バイト単位）
				$fwrite(fd, "%c", 8'd40);					// 14 ~17 ヘッダサイズ
				$fwrite(fd, "%c", 8'd0);					// 14 ~17 ヘッダサイズ
				$fwrite(fd, "%c", 8'd0);					// 14 ~17 ヘッダサイズ
				$fwrite(fd, "%c", 8'd0);					// 14 ~17 ヘッダサイズ
				$fwrite(fd, "%c", pWidth[ 7: 0]);			// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pWidth[15: 8]);			// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pWidth[23:16]);			// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pWidth[31:24]);			// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pHeight[ 7: 0]);			// 22 ~ 25 画像高さ
				$fwrite(fd, "%c", pHeight[15: 8]);			// 22 ~ 25 画像高さ
				$fwrite(fd, "%c", pHeight[23:16]);			// 22 ~ 25 画像高さ
				$fwrite(fd, "%c", pHeight[31:24]);			// 22 ~ 25 画像高さ
				$fwrite(fd, "%c", 8'd1);					// 26 ~ 27 プレーン数 常に1
				$fwrite(fd, "%c", 8'd0);					// 26 ~ 27 プレーン数 常に1
				$fwrite(fd, "%c", 8'd24);					// 28 ~ 29 1画素あたりの BitSize
				$fwrite(fd, "%c", 8'd0);					// 28 ~ 29 1画素あたりの BitSize
				$fwrite(fd, "%c", 8'd0);					// 30 ~ 33 圧縮形式, BI_RGB(無圧縮)
				$fwrite(fd, "%c", 8'd0);					// 30 ~ 33 圧縮形式, BI_RGB(無圧縮)
				$fwrite(fd, "%c", 8'd0);					// 30 ~ 33 圧縮形式, BI_RGB(無圧縮)
				$fwrite(fd, "%c", 8'd0);					// 30 ~ 33 圧縮形式, BI_RGB(無圧縮)
				$fwrite(fd, "%c", pBmpImageSize[ 7: 0]);	// 34 ~ 37 画像データ部のサイズ
				$fwrite(fd, "%c", pBmpImageSize[15: 8]);	// 34 ~ 37 画像データ部のサイズ
				$fwrite(fd, "%c", pBmpImageSize[23:16]);	// 34 ~ 37 画像データ部のサイズ
				$fwrite(fd, "%c", pBmpImageSize[31:24]);	// 34 ~ 37 画像データ部のサイズ
				$fwrite(fd, "%c", 8'd0);					// 38 ~ 41 水平解像度
				$fwrite(fd, "%c", 8'd0);					// 38 ~ 41 水平解像度
				$fwrite(fd, "%c", 8'd0);					// 38 ~ 41 水平解像度
				$fwrite(fd, "%c", 8'd0);					// 38 ~ 41 水平解像度
				$fwrite(fd, "%c", 8'd0);					// 42 ~ 45 垂直解像度
				$fwrite(fd, "%c", 8'd0);					// 42 ~ 45 垂直解像度
				$fwrite(fd, "%c", 8'd0);					// 42 ~ 45 垂直解像度
				$fwrite(fd, "%c", 8'd0);					// 42 ~ 45 垂直解像度
				$fwrite(fd, "%c", 8'd0);					// 46 ~ 49 色数
				$fwrite(fd, "%c", 8'd0);					// 46 ~ 49 色数
				$fwrite(fd, "%c", 8'd0);					// 46 ~ 49 色数
				$fwrite(fd, "%c", 8'd0);					// 46 ~ 49 色数
				$fwrite(fd, "%c", 8'd0);					// 50 ~ 53 重要色数
				$fwrite(fd, "%c", 8'd0);					// 50 ~ 53 重要色数
				$fwrite(fd, "%c", 8'd0);					// 50 ~ 53 重要色数
				$fwrite(fd, "%c", 8'd0);					// 50 ~ 53 重要色数
				rFileSt = lpFileWrite;
			end
		end

		lpFileWrite:
		begin
			if (iVde)
			begin
				// 配列の最後のアドレスから保存していく。
				rRom[rXpos + (rYpos * pWidth)] = {iColorR,iColorG,iColorB};
				rXpos = rXpos + 1;
				if (rXpos == pWidth)
				begin
					rYpos = rYpos - 1;
					rXpos = 0;
				end
			end
			
			if (iAFE)
			begin
				rFileSt		= lpFileOpen;
				rSaveEnd	= 1'b1;
				rFull		= 1'b0;
				padsize = (4 - ((pWidth * 3) % 4)) % 4; // パディングサイズの計算
				$display("BMP File Write");
				$display("padsize = %d", padsize);
				
				for (rYpos = 0; rYpos < pHeight; rYpos = rYpos + 1)
				begin
					for (rXpos = 0; rXpos < pWidth; rXpos = rXpos + 1)
					begin
						rColor = rRom[rXpos + (rYpos * pWidth)];
						$fwrite(fd, "%c", rColor[7:0]);
						$fwrite(fd, "%c", rColor[15:8]);
						$fwrite(fd, "%c", rColor[23:16]);
					end
					
					// 必要なパディングを追加
					for (i = 0; i < padsize; i = i + 1)
					begin
						$fwrite(fd, "%c", 8'd0);
					end
				end
				
				$fclose(fd);
				$display("BMP File Close ----");
			end
			else
			begin
				rFileSt		= lpFileWrite;
				rSaveEnd	= 1'b0;
				rFull		= 1'b1;
			end
		end
		
		lpFileOpenError:
		begin
			rSaveEnd = 1'b1;
		end
		endcase
	end
end

endmodule
