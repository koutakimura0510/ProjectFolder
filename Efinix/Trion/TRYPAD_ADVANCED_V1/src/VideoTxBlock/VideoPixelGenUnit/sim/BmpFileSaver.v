/*------------------------------------------------------------------------------
 * Create  2022-09-04
 * Author  kouta kimura
 * 
 * BMPファイル書き出し, 詳しくは C言語 bitmap フォルダ参考
 * 2022-09-04 v1.00 : release
 * 2025-03-22 v1.01 : BMP 保存時に上下逆で保存されるため、一度メモリ上に保存し更に反転させてBMP出力するように更新
 *-----------------------------------------------------------------------------*/
module BmpFileSaver #(
	parameter 			pFileSave		= "./ImageData.bmp",
	parameter	[31:0]	pHdisplay		= 480,
	parameter	[31:0]	pVdisplay		= 240,
	parameter	[31:0]	pBmpFormat		= 3,
	parameter			pBmpHeaderSize	= 54,
	// not
	parameter 	[31:0]	pBmpFileSize	= pBmpHeaderSize + (pHdisplay * pVdisplay * pBmpFormat),
	parameter	[31:0]	pBmpImageSize	= (pHdisplay * pVdisplay * pBmpFormat)
)(
	input [7:0] 		iColorR,
	input [7:0] 		iColorG,
	input [7:0] 		iColorB,
	input 				iVde,
	input 				iAFE,
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

//
integer i = 0;
integer fd = 0;	// ファイルディスクリプタ
reg rSaveEnd;							assign oSaveEnd = rSaveEnd;
reg [2:0] rFileSt;
//
reg [23:0] rRom[0:pHdisplay*pVdisplay];
reg [23:0] rColor;
reg [31:0] rYpos;
reg [31:0] rXpos;

always @(posedge iCLK)
begin
	if (iRST)
	begin
		rSaveEnd 	= 1'b0;
		rFileSt		= lpFileOpen;
		rYpos		= pVdisplay - 1;
		rXpos		= 32'd0;
	end
	else
	begin
		case (rFileSt)
		lpFileOpen:
		begin
			$fclose(fd);
			fd = $fopen(pFileSave, "wb");
			rSaveEnd 	= 1'b0;
			rYpos		= rYpos;
			rXpos		= rXpos;

			if (!fd)
			begin
				rFileSt = lpFileOpenError;
				$display("File Open NG %s\n", pFileSave);
			end
			else
			begin
				$display("File Open OK %s\n", pFileSave);
				$display("BMP Write Start ----\n");
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
				$fwrite(fd, "%c", pHdisplay[ 7: 0]);		// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pHdisplay[15: 8]);		// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pHdisplay[23:16]);		// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pHdisplay[31:24]);		// 18 ~ 21 画像幅
				$fwrite(fd, "%c", pVdisplay[ 7: 0]);		// 22 ~ 25 画像高さ
				$fwrite(fd, "%c", pVdisplay[15: 8]);		// 22 ~ 25 画像高さ
				$fwrite(fd, "%c", pVdisplay[23:16]);		// 22 ~ 25 画像高さ
				$fwrite(fd, "%c", pVdisplay[31:24]);		// 22 ~ 25 画像高さ
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
				rRom[rXpos + (rYpos * pHdisplay)] = {iColorR,iColorG,iColorB};
				rXpos = rXpos + 1;
				if (rXpos == pVdisplay)
				begin
					rYpos = rYpos - 1;
					rXpos = 0;
				end
			end
			rFileSt = iAFE ? lpFileBmpWrite : lpFileWrite;
			rSaveEnd = 1'b0;
		end
		
		lpFileBmpWrite:
		begin
			for (i = 0; i < (pHdisplay * pVdisplay); i = i + 1)
			begin
				rColor = rRom[i];
				$fwrite(fd, "%c", rColor[7:0]);
				$fwrite(fd, "%c", rColor[15:8]);
				$fwrite(fd, "%c", rColor[23:16]);
			end
			
			rFileSt = lpFileClose;
			rSaveEnd = 1'b0;
		end

		lpFileClose:
		begin
			$fclose(fd);
			$display("BMP Write End ----\n");
			$display("BMP File Close ----\n");
			rFileSt 	= lpFileWriteEnd;
			rSaveEnd 	= 1'b1;
		end

		lpFileWriteEnd:
		begin
			rFileSt  = rFileSt;
			rSaveEnd = 1'b0;
		end

		lpFileOpenError:
		begin
			rSaveEnd = 1'b1;
		end
		endcase
	end
end

endmodule
