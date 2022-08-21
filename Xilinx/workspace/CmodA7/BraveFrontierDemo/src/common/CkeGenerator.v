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
    input   				iSysClk, 
    input   				iSysRst
);


generate
	if (pDivReg == "no")
	begin
		localparam lpCtuCNTBits	= fBitWidth(pSysClk);
		localparam [lpCtuCNTBits-1:0] lpSysCnt = pSysClk-1'b1;

		//----------------------------------------------------------
		// Cke Counter
		//----------------------------------------------------------
		reg [lpCtuCNTBits-1:0] rTmpCount;
		reg qCke;

		always @( posedge iSysClk )
		begin
			if (iSysRst)    rTmpCount <= 0;
			else if (qCke)  rTmpCount <= 0;
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
		reg qTimeCke;                               assign oCke = qTimeCke;

		always @( posedge iSysClk )
		begin
			if (iSysRst)        rTimeCkeCnt <= 0;
			else if (qTimeCke)  rTimeCkeCnt <= 0;
			else if (qCke)      rTimeCkeCnt <= rTimeCkeCnt + 1'b1;
			else                rTimeCkeCnt <= rTimeCkeCnt;
		end

		always @*
		begin
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

		always @( posedge iSysClk )
		begin
			casex ({iSysRst,qCke,iCke})
				3'b1xx: 	rTmpCount <= {pDivWidth{1'b0}};
				3'b001: 	rTmpCount <= rTmpCount + 1'b1;
				3'b011: 	rTmpCount <= {pDivWidth{1'b0}};
				default: 	rTmpCount <= {pDivWidth{1'b0}};
			endcase

			if (iCke)		rCke <= 1'b0;
			else if (qCke)  rCke <= 1'b1;
			else 			rCke <= 1'b0;
		end

		always @*
		begin
			qCke = (rTmpCount == iDiv);
		end
	end
endgenerate



//----------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//----------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule
