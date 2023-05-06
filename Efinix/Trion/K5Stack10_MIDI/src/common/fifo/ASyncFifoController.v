/*-----------------------------------------------------------------------------
 * Create  2023/05/05
 * Author  koutakimura
 * -
 * 非同期リセット付き非同期クロックFIFOコントローラ module
 * アドレス -> グレイコード変換 -> バイナリコード(２進数)変換を使用
 *-----------------------------------------------------------------------------*/
module ASyncFifoController #(
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
    input                       iWCLK,
    input                       iRCLK
);


//----------------------------------------------------------
// FIFO の深さの bit幅取得
//----------------------------------------------------------
integer x;
localparam pAddrWidth  = fBitWidth(pFifoDepth);


//-----------------------------------------------------------------------------
// WAdrs の更新、Write Side グレイコード生成
//-----------------------------------------------------------------------------
reg  [pAddrWidth-1:0] rWa, rRa;
reg  [pAddrWidth-1:0] rWGa[2:0], rRGa[2:0];
reg  [pAddrWidth-1:0] qWbin, qRbin;
wire [pAddrWidth-1:0] wWa = rWa + 1'b1;
reg  qWe,qRe;
reg  qFull;							assign oFull = qFull;
reg  qEmp;							assign oEmp = qEmp;
reg  rRe;							assign oRvd = rRe;

always @(posedge iWCLK, negedge inARST)
begin
	if (!inARST)	rWa <= {pAddrWidth{1'b0}};
	else if	(qWe)	rWa <= wWa;
	else 			rWa <= rWa;

	if (!inARST)	rWGa[0] <= {pAddrWidth{1'b0}};	// Binary -> GrayCode
	else 			rWGa[0] <= {rWa[pAddrWidth-1],rWa[pAddrWidth-2:0] ^ rWa[pAddrWidth-1:1]};
end

always @(posedge iRCLK, negedge inARST)
begin
	if (!inARST)	{rWGa[2],rWGa[1]} <= {{pAddrWidth{1'b0}},{pAddrWidth{1'b0}}};
	else 			{rWGa[2],rWGa[1]} <= {rWGa[1],rWGa[0]};
end

generate	// GrayCode -> Binary
always @*
begin
	for (x = pAddrWidth-1; x >= 0; x = x-1)
	begin
		if (x == pAddrWidth-1) 	qWbin[x] <= rWGa[2][x];
		else					qWbin[x] <= rWGa[2][x] ^ qWbin[x+1];
	end
end
endgenerate


//-----------------------------------------------------------------------------
// RAdrs Read Side グレイコード生成
//-----------------------------------------------------------------------------
always @(posedge iRCLK, negedge inARST)
begin
	if (!inARST)	rRa <= {pAddrWidth{1'b0}};
	else if	(qRe)	rRa <= rRa + 1'b1;
	else 			rRa <= rRa;

	if (!inARST)	rRGa[0] <= {pAddrWidth{1'b0}};
	else 			rRGa[0] <= {rRa[pAddrWidth-1],rRa[pAddrWidth-2:0] ^ rRa[pAddrWidth-1:1]};

	if (!inARST)	rRe <= 1'b0;
	else if	(qRe)	rRe <= 1'b1;
	else 			rRe <= 1'b0;
end

always @(posedge iWCLK, negedge inARST)
begin
	if (!inARST)	{rRGa[2],rRGa[1]} <= {{pAddrWidth{1'b0}},{pAddrWidth{1'b0}}};
	else 			{rRGa[2],rRGa[1]} <= {rRGa[1],rRGa[0]};
end

generate
always @*
begin
	for (x = pAddrWidth-1; x >= 0; x = x-1)
	begin
		if (x == pAddrWidth-1) 	qRbin[x] <= rRGa[2][x];
		else					qRbin[x] <= rRGa[2][x] ^ qRbin[x+1];
	end
end
endgenerate

always @*
begin
	qFull <= (wWa == qRbin);
	qEmp <= (qWbin == rRa); 
	qWe <= iWe & (~qFull);
	qRe <= iRe & (~qEmp);
end


//-----------------------------------------------------------------------------
// BRAM
//-----------------------------------------------------------------------------
ASyncDualPortBramTrion #(
    .pBuffDepth(pFifoDepth),
    .pBitWidth(pFifoBitWidth),
    .pAddrWidth(pAddrWidth),
	.pFifoBlockRam(pFifoBlockRam)
) ASyncDualPortBramTrion (
	.iWd(iWd),
	.iWa(rWa),
	.iWe(qWe),
	.oRd(oRd),
	.iRa(rRa),
	.iWCLK(iWCLK),
	.iRCLK(iRCLK)
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