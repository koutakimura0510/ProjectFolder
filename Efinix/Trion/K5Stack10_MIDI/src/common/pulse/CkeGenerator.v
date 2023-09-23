//----------------------------------------------------------
// Clk Enable信号生成モジュール
// 
// 	2022-7-18:	pSysClk のタイミングで pTimeCke 分カウント時 Cke 出力
// 	2022-7-28:	Enable 生成タイミングをパラメータ設定とレジスタ経由から設定できるように変更
//----------------------------------------------------------
module CkeGenerator #(
	// variable parameter
	parameter 	pDivReg		= "no",
	parameter	pDivWidth	= 16,
    parameter 	pSysClk  	= 25000000,  // 分周クロックの値を指定
    parameter 	pTimeCke 	= 1          // Enable 出力の時間指定
)(
	// Internal Clk
	input [pDivWidth-1:0]	iDiv,		// レジスタ入力の分周値, 0指定時常時 Cke ON
	input 					iCke,		// レジスタ入力使用時 Cke制御を行う
    output  				oCke,
	// Clk Reset
    input   				iRST,
    input   				iCLK
);

//-----------------------------------------------------------------------------
// include 
//-----------------------------------------------------------------------------
generate
	if (pDivReg == "no")
	begin
		localparam lpCtuCNTBits	= f_detect_bitwidth(pSysClk);
		localparam [lpCtuCNTBits-1:0] lpSysCnt = pSysClk-1'b1;

		//----------------------------------------------------------
		// Cke Counter
		//----------------------------------------------------------
		reg [lpCtuCNTBits-1:0] rTmpCount;
		reg qCke;

		always @( posedge iCLK )
		begin
			if (iRST)    	rTmpCount <= {lpCtuCNTBits{1'b0}};
			else if (qCke)  rTmpCount <= {lpCtuCNTBits{1'b0}};
			else            rTmpCount <= rTmpCount + 1'b1;
		end

		always @*
		begin
			qCke = rTmpCount == lpSysCnt;
		end

		//----------------------------------------------------------
		// 指定時間カウント時 Cke 出力
		//----------------------------------------------------------
		reg [7:0] rTimeCkeCnt;
		reg qTimeCke;							assign oCke = qTimeCke;
		reg qTimeRst;

		always @( posedge iCLK )
		begin
			if (qTimeRst)		rTimeCkeCnt <= 8'd0;
			else if (qCke)		rTimeCkeCnt <= rTimeCkeCnt + 1'b1;
			else				rTimeCkeCnt <= rTimeCkeCnt;
		end

		always @*
		begin
			qTimeRst <= |{iRST,qTimeCke};
			qTimeCke <= pTimeCke == rTimeCkeCnt;
		end
	end
	else
	begin
		//----------------------------------------------------------
		// Cke Counter
		//----------------------------------------------------------
		reg [pDivWidth-1:0] rTmpCount;
		reg rCke;						assign oCke = rCke;
		reg qCke;

		always @( posedge iCLK )
		begin
			casex ({iRST,qCke,iCke})
				3'b1xx: 	rTmpCount <= {pDivWidth{1'b0}};
				3'b001: 	rTmpCount <= rTmpCount + 1'b1;
				3'b011: 	rTmpCount <= {pDivWidth{1'b0}};
				default: 	rTmpCount <= {pDivWidth{1'b0}};
			endcase

			if (!iCke)		rCke <= 1'b0;
			else if (qCke)  rCke <= 1'b1;
			else 			rCke <= 1'b0;
		end

		always @*
		begin
			qCke = (iDiv < rTmpCount);
		end
	end
endgenerate

function integer f_detect_bitwidth;
	input integer number;
	integer bitwidth;
	integer bitcnt;
	integer	i;
	begin
		bitcnt = 0;
		for (i = 0; i < 32; i = i+1 )
		begin
			if (number[i]) 
			begin
				bitcnt++;
			end
		end

		if (bitcnt == 1)
		begin
			for (i = 0; i < 32; i = i+1 )
			begin
				if (number[i]) 
				begin
					f_detect_bitwidth = i+1;
				end
			end

			if (f_detect_bitwidth != 1)
			begin
				f_detect_bitwidth = f_detect_bitwidth - 1;
			end
		end
		else
		begin
			bitwidth = 0;
			if (number == 0)
			begin
				f_detect_bitwidth = 1;
			end
			else
			begin
				while (number != 0)
				begin
					bitwidth++;
					number = number >> 1;
			end
			f_detect_bitwidth = bitwidth;
			end
		end
	end
endfunction


endmodule
