//----------------------------------------------------------
// Create 2022/09/21
// Author koutakimura
// -
// Read レイテンシ 0 の FIFO 作成
// 
//----------------------------------------------------------
module fifoControllerLutRam #(
    parameter 					pFifoDepth        	= 16,		// FIFO BRAMのサイズ指定
    parameter 					pFifoBitWidth     	= 8,		// bitサイズ
	parameter 					pFifoFastOutValue	= 0			// 指定値により、0よりも早く Full 出力、前段との Readレイテンシのタイミング調整用
)(
	// src side
    input   [pFifoBitWidth-1:0] iWd,        // write data
    input                       iWe,        // write enable 有効データ書き込み
    output                      oFull,      // 最大書き込み時High
	// dst side
    output  [pFifoBitWidth-1:0] oRd,        // read data
    input                       iRe,        // read enable
    output                      oEmp,       // バッファ空時High
	//
    input                       iRst,
    input                       iClk
);

//----------------------------------------------------------
// FIFO の深さの bit幅取得
//----------------------------------------------------------
localparam pAddrWidth  = fBitWidth(pFifoDepth);


//-----------------------------------------------------------------------------
// アドレスの更新
//-----------------------------------------------------------------------------
reg [pAddrWidth-1:0] rWA, rRA;
reg [pAddrWidth-1:0] qWA [0:pFifoFastOutValue];

always @(posedge iClk)
begin
    if (iRst)       rWA <= {pAddrWidth{1'b0}};
    else if (iWe)   rWA <= rWA + 1'b1;
    else            rWA <= rWA;
	//
    if (iRst)      	rRA <= {pAddrWidth{1'b0}};
    else if (iRe)  	rRA <= rRA + 1'b1;
    else           	rRA <= rRA;
end

//----------------------------------------------------------
// ハンドシェイク信号出力
//----------------------------------------------------------
localparam lpFifoFastOutValue = pFifoFastOutValue + 2;

reg [pFifoFastOutValue:0] qFull;
reg rFull;							assign oFull = rFull;
reg qEMP;							assign oEmp  = qEMP;

always @(posedge iClk)
begin
    if (iRst)       rFull <= 1'b0;
    else            rFull <= |{qFull};
end

integer n;

generate
always @*
begin
		for (n = 1; n < lpFifoFastOutValue; n = n + 1)
		begin
			qWA[n-1'b1]		<= (rWA + n);
			qFull[n-1'b1] 	<= qWA[n-1'b1] == rRA;
		end

    qEMP <= (rWA  == rRA);
end
endgenerate


//----------------------------------------------------------
// FIFO 動作
//----------------------------------------------------------
wire [pFifoBitWidth-1:0] wRD;					assign oRd = wRD;

LutRam #(
    .pBuffDepth    (pFifoDepth),
    .pBitWidth     (pFifoBitWidth),
    .pAddrWidth    (pAddrWidth)
) LutRam (
    // write side       read side
    .iWD    (iWd),      .oRD    (wRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (iWe),
	//
    .iClk   (iClk)
);

// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction
////////////////////////////////////////////////////////////
endmodule