/*-----------------------------------------------------------------------------
 * Create  2023/05/05
 * Author  koutakimura
 * -
 * 非同期リセット付き単相同期クロックFIFOコントローラ module
 * 
 *-----------------------------------------------------------------------------*/
module SyncFifoController #(
    parameter 	pFifoDepth        	= 16,		// FIFO BRAMのサイズ指定
    parameter 	pFifoBitWidth     	= 8,		// bitサイズ
	parameter	pFifoBlockRam		= "yes"		// yes BRAM, no reg
)(
    input   [pFifoBitWidth-1:0] iWd,        // write data
    input                       iWe,        // write enable 有効データ書き込み
    output                      oFull,      // 最大書き込み時High
    output  [pFifoBitWidth-1:0] oRd,        // read data
    input                       iRe,        // read enable
    output                      oRvd,       // 有効データ出力
    output                      oEmp,       // バッファ空時High
    input                       inARST,
    input                       iCLK
);


//----------------------------------------------------------
// FIFO の深さの bit幅取得
//----------------------------------------------------------
localparam pAddrWidth  = fBitWidth(pFifoDepth);


//-----------------------------------------------------------------------------
// アドレスの更新
//-----------------------------------------------------------------------------
reg  [pAddrWidth-1:0] rWa, rRa;
wire [pAddrWidth-1:0] wWa = rWa + 1'b1;
reg  qWe,qRe;
reg  qFull;							assign oFull = qFull;
reg  qEmp;							assign oEmp = qEmp;
reg  rRe;							assign oRvd = rRe;

always @(posedge iCLK, negedge inARST)
begin
	if (!inARST)	rWa <= {pAddrWidth{1'b0}};
	else if	(qWe)	rWa <= wWa;
	else 			rWa <= rWa;

	if (!inARST)	rRa <= {pAddrWidth{1'b0}};
	else if	(qRe)	rRa <= rRa + 1'b1;
	else 			rRa <= rRa;

	if (!inARST)	rRe <= 1'b0;
	else if	(qRe)	rRe <= 1'b1;
	else 			rRe <= 1'b0;
end

always @*
begin
	qFull <= (wWa == rRa);
	qEmp <= (rWa == rRa); 
	qWe <= iWe & (~qFull);
	qRe <= iRe & (~qEmp);
end


//-----------------------------------------------------------------------------
// BRAM
//-----------------------------------------------------------------------------
DualPortBramTrion #(
    .pBuffDepth(pFifoDepth),
    .pBitWidth(pFifoBitWidth),
    .pAddrWidth(pAddrWidth),
	.pFifoBlockRam(pFifoBlockRam)
) DualPortBramTrion (
	.iWd(iWd),
	.iWa(rWa),
	.iWe(qWe),
	.oRd(oRd),
	.iRa(rRa),
	.iCLK(iCLK)
);


//-----------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//-----------------------------------------------------------------------------
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
endmodule


//-----------------------------------------------------------------------------
// Sample
//-----------------------------------------------------------------------------
// parameter pFifoDepth = 16;
// parameter pFifoBitWidth = 16;
// parameter pFifoBlockRam = "yes";

// wire [pFifoBitWidth-1:0] wRd;
// wire wFull, wEmp;
// wire wRvd;

// SyncFifoController #(
//     .pFifoDepth(pFifoDepth),
//     .pFifoBitWidth(pFifoBitWidth),
// 	.pFifoBlockRam(pFifoBlockRam)
// ) SyncFifoController (
//     .iWd(),
//     .iWe(),
//     .oFull(wFull),
//     .oRd(wRd),
//     .iRe(),
//     .oRvd(wRvd),
//     .oEmp(wEmp),
//     .inARST(),
// 	.iCLK()
// );