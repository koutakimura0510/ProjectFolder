/*-----------------------------------------------------------------------------
 * Create  2023/05/05
 * Author  koutakimura
 * -
 * 非同期リセット付き非同期クロックFIFOコントローラ module
 * アドレス -> グレイコード変換 -> バイナリコード(２進数)変換を使用
 *-----------------------------------------------------------------------------*/
module ASyncFifoController #(
    parameter 	pFifoDepth		= 16,		// FIFO BRAMのサイズ指定
    parameter 	pFifoBitWidth	= 8,		// bitサイズ
	parameter	pFifoRemaingCntBorder	= 127
)(
	input   [pFifoBitWidth-1:0] iWd,	// write data
	input	iWe,						// write enable 有効データ書き込み
	output	oFull,						// 最大書き込み時High
	output	oRemaingCntAlert,			// FIFO 残りデータ数がパラメータを超えた場合 Assert
	output  [pFifoBitWidth-1:0] oRd,	// read data
	input	iRe,						// read enable
	output	oRvd,						// 有効データ出力
	output	oEmp,						// バッファ空時High
	input	inARST,
	input	iWCLK,
	input	iRCLK
);


//----------------------------------------------------------
// FIFO の深さの bit幅取得
//----------------------------------------------------------
integer i;
genvar x;
localparam pAddrWidth  = fBitWidth(pFifoDepth);
localparam [pAddrWidth-1:0] lpFifoRemaingCntBorder = pFifoRemaingCntBorder;


//-----------------------------------------------------------------------------
// WAdrs の更新、Write Side グレイコード生成
//-----------------------------------------------------------------------------
reg  [pAddrWidth-1:0] rWa, rRa;
reg  [pAddrWidth-1:0] rWGa[2:0], rRGa[2:0];
reg  [pAddrWidth-1:0] qWbin, qRbin;
wire [pAddrWidth-1:0] wWa = rWa + 1'b1;
reg  qWe,qRe;
reg  qRemaingCntAlert;							assign oRemaingCntAlert = qRemaingCntAlert;
reg  qFull;										assign oFull = qFull;
reg  qEmp;										assign oEmp = qEmp;
reg  rRe;										assign oRvd = rRe;

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
	for (i = pAddrWidth-1; i >= 0; i = i-1)
	begin
		if (i == pAddrWidth-1) 	qWbin[i] <= rWGa[2][i];
		else					qWbin[i] <= rWGa[2][i] ^ qWbin[i+1];
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
	for (i = pAddrWidth-1; i >= 0; i = i-1)
	begin
		if (i == pAddrWidth-1) 	qRbin[i] <= rRGa[2][i];
		else					qRbin[i] <= rRGa[2][i] ^ qRbin[i+1];
	end
end
endgenerate

always @*
begin
	qRemaingCntAlert <= (rWa - qRbin) < lpFifoRemaingCntBorder ? 1'b0 : 1'b1;
	qFull <= (wWa == qRbin);
	qEmp <= (qWbin == rRa); 
	qWe <= iWe & (~qFull);
	qRe <= iRe & (~qEmp);
end


//-----------------------------------------------------------------------------
// BRAM
//-----------------------------------------------------------------------------
// ASyncDualPortBramTrion #(
//     .pBuffDepth(pFifoDepth),
//     .pBitWidth(pFifoBitWidth),
//     .pAddrWidth(pAddrWidth),
// 	.pFifoBlockRam(pFifoBlockRam)
// ) ASyncDualPortBramTrion (
// 	.iWd(iWd),
// 	.iWa(rWa),
// 	.iWe(qWe),
// 	.oRd(oRd),
// 	.iRa(rRa),
// 	.iWCLK(iWCLK),
// 	.iRCLK(iRCLK)
// );

localparam lpDataWidth	= f_get_datawidth(pFifoDepth);
localparam lpBramGenNum = f_barm_gennum(pFifoBitWidth,lpDataWidth);

reg  [lpDataWidth-1:0] qWd[lpBramGenNum-1:0];
wire [(lpDataWidth*lpBramGenNum)-1:0] wRd;

generate
for (x = 0; x < lpBramGenNum; x = x + 1)
begin : TrionSDPBRAM
	TrionSDPBRAM #(
		.pDataWidth(lpDataWidth),
		.pAddrWidth(pAddrWidth),
		.pClkDomainAsync("yes")
	) TrionSDPBRAM (
		// Write Side
		.iWd(qWd[x]),
		.iWa(rWa),
		.iWe(qWe),
		// Read Side
		.oRd(wRd[((x+1)*lpDataWidth)-1:x*lpDataWidth]),
		.iRa(rRa),
		.iRe(qRe),
		// common
		.iRCLK(iRCLK),
		.iWCLK(iWCLK)
	);

	always @*
	begin
		qWd[x] <= iWd[((x+1)*lpDataWidth)-1:x*lpDataWidth];
	end

end
endgenerate

assign oRd = wRd;

initial
begin
	$display("--- Async Fifo lpDataWidth %d bit", lpDataWidth);
	$display("--- Async Fifo lpBramGenNum %d Block", lpBramGenNum);
end


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
// Depth から Block Ram の Bit幅を求める
function[ 7:0] f_get_datawidth;
input [31:0] pFifoDepth;
begin
	case (pFifoDepth)
	'd256:		f_get_datawidth = 16;
	'd512:		f_get_datawidth = 8;
	'd1024:		f_get_datawidth = 4;
	'd2048:		f_get_datawidth = 2;
	'd4096:		f_get_datawidth = 1;
	default:	f_get_datawidth = 0;
	endcase
end
endfunction

//-----------------------------------------------------------------------------
// 指定された データ幅と Depth から求めたデータ幅から BRAM 使用個数を求める
function[ 7:0] f_barm_gennum;
input [31:0] pFifoBitWidth;
input [31:0] lpDataWidth;
integer i;

begin
	if (pFifoBitWidth <= lpDataWidth)
	begin
		f_barm_gennum = 1;
	end
	else
	begin
		f_barm_gennum = 1;
		for (i = pFifoBitWidth; lpDataWidth < i; i = i - lpDataWidth)
		begin
			f_barm_gennum++;
		end
	end
end
endfunction


//-----------------------------------------------------------------------------
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