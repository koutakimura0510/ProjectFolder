//----------------------------------------------------------
// Create  2022/09/04
// Author  KoutaKimura
// -
// Rawファイル書き出し
// 
// 参考文献
// https://imagingsolution.net/imaging/imaging-programing/bitmap-file-format/
// https://algorithm.joho.info/image-processing/bmp-file-data-header/#:~:text=BMP%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E6%A7%8B%E9%80%A0,-BMP%EF%BC%88%E4%BB%8A%E5%9B%9E%E3%81%AF&text=BMP%E3%81%AF%E3%83%90%E3%82%A4%E3%83%8A%E3%83%AA%E5%BD%A2%E5%BC%8F%E3%81%A7,%E3%82%88%E3%81%86%E3%81%AB%E3%81%AA%E3%81%A3%E3%81%A6%E3%81%84%E3%81%BE%E3%81%99%E3%80%82&text=%E3%81%BE%E3%81%9A%E3%80%81%E5%85%88%E9%A0%AD%E3%81%8B%E3%82%89%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E6%83%85%E5%A0%B1,%E3%83%87%E3%83%BC%E3%82%BF%E9%83%A8%E3%81%8C%E7%B6%9A%E3%81%8D%E3%81%BE%E3%81%99%E3%80%82
// https://www.setsuki.com/hsp/ext/bmp.htm
//----------------------------------------------------------
module BmpFileSaver #(
	parameter 			pRawFileSave	= "./ImageData.raw",
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
	input 				iRst,
	input 				iClk
);


//-----------------------------------------------------------------------------
// ファイル書き出し
//-----------------------------------------------------------------------------
localparam [2:0]
	lpFileOpen 		= 0,
	lpFileWrite 	= 1,
	lpFileClose 	= 2,
	lpFileWriteEnd 	= 3,
	lpFileOpenError	= 4;

//
integer fd = 0;	// ファイルディスクリプタ
reg rSaveEnd;							assign oSaveEnd = rSaveEnd;
reg [2:0] rFileSt;

always @(posedge iClk)
begin
	if (iRst)
	begin
		rSaveEnd 	= 1'b0;
		rFileSt		= lpFileOpen;
	end
	else
	begin
		case (rFileSt)
		lpFileOpen:
		begin
			fd = $fopen(pRawFileSave, "wb");
			rSaveEnd 	= 1'b0;

			if (!fd)
			begin
				rFileSt = lpFileOpenError;
				$display("File Open NG %s\n", pRawFileSave);
			end
			else
			begin
				$display("File Open OK %s\n", pRawFileSave);
				$display("BMP Write Start ----\n");
				$fwrite(fd, "%d", 16'h4d42);		// 0 ~ 1 BMP フォーマット種類
				$fwrite(fd, "%d", pBmpFileSize);	// 2 ~ 5 ファイルサイズ
				$fwrite(fd, "%d", 32'd0);			// 6 ~ 9 予約領域1 ~ 2
				$fwrite(fd, "%d", 32'd54);			// 10 ~ 13 ファイル先頭から画像データまでのオフセット数（バイト単位）
				$fwrite(fd, "%d", 32'd40);			// 14 ~17 ヘッダサイズ
				$fwrite(fd, "%d", pHdisplay);		// 18 ~ 21 画像幅
				$fwrite(fd, "%d", pVdisplay);		// 22 ~ 25 画像高さ
				$fwrite(fd, "%d", 16'd1);			// 26 ~ 27 プレーン数 常に1
				$fwrite(fd, "%d", 16'd24);			// 28 ~ 29 1画素あたりの BitSize
				$fwrite(fd, "%d", 32'd0);			// 30 ~ 33 圧縮形式, BI_RGB(無圧縮)
				$fwrite(fd, "%d", pBmpImageSize);	// 34 ~ 37 画像データ部のサイズ
				$fwrite(fd, "%d", 32'd0);			// 38 ~ 41 水平解像度
				$fwrite(fd, "%d", 32'd0);			// 42 ~ 45 垂直解像度
				$fwrite(fd, "%d", 32'd0);			// 46 ~ 49 色数
				$fwrite(fd, "%d", 32'd0);			// 50 ~ 53 重要色数
				rFileSt = lpFileWrite;
			end
		end

		lpFileWrite:
		begin
			if (iAFE)
			begin
				rFileSt = lpFileClose;
			end
			else
			begin
				if (iVde)
				begin
					$fwrite(fd, "%c", iColorR);
					$fwrite(fd, "%c", iColorG);
					$fwrite(fd, "%c", iColorB);
				end
				rFileSt = lpFileWrite;
			end
			rSaveEnd 	= 1'b0;
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
			rFileSt  = lpFileOpen;
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
