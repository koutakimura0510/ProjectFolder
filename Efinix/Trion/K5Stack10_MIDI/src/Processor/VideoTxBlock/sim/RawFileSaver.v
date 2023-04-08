//----------------------------------------------------------
// Create  2022/09/04
// Author  KoutaKimura
// -
// Rawファイル書き出し
// 
// 参考文献
// https://qiita.com/takeru0x5569/items/b054cdcf9e014f332edd
//----------------------------------------------------------
module RawFileSaver #(
	parameter pRawFileSave	= "./ImageData.raw"
)(
	input [7:0] iColorR,
	input [7:0] iColorG,
	input [7:0] iColorB,
	input 		iVde,
	input 		iAFE,
	//
	output 		oSaveEnd,	// 書き出し終了
	//
	input 		iRST,
	input 		iCLK
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

always @(posedge iCLK)
begin
	if (iRST)
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
				$display("File Open NG %s\n", pRawFileSave);
				// $fwrite(fd, "%c", iColorR);
				rFileSt = lpFileOpenError;
			end
			else
			begin
				$display("File Open OK %s\n", pRawFileSave);
				$display("Raw Write Start ----\n");
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
			$display("Raw Write End ----\n");
			$display("Raw File Close ----\n");
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
