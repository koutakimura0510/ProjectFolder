/*-----------------------------------------------------------------------------
 * Create  2023/05/05
 * Author  koutakimura
 * -
 * 非同期リセット付き単相同期クロックFIFOコントローラ module
 * 
 * 2023-07-22 : Trion プリミティブを使用する仕様に更新
 * 2023-08-05 : 複雑なレイテンシに対応できるように oRemaingCntAlert 追加
 *-----------------------------------------------------------------------------*/
//////////////////////////////////////////////////////////////////////////////////
//  READ_WIDTH | BRAM_SIZE | READ Depth  | RDADDR Width |            |          //
// WRITE_WIDTH |           | WRITE Depth | WRADDR Width |  WE Width  | RAM_MODE //
// ============|===========|=============|==============|============|==========//
//     1       |  "5Kb"   |     4196     |    12-bit    |    1-bit   |   SDP    //
//     2       |  "5Kb"   |     2048     |    11-bit    |    1-bit   |   SDP    //
//     4       |  "5Kb"   |     1024     |    10-bit    |    1-bit   |   SDP    //
//     8       |  "5Kb"   |      512     |     9-bit    |    1-bit   |   SDP    //
//    16       |  "5Kb"   |      256     |     8-bit    |    1-bit   |   SDP    //
//////////////////////////////////////////////////////////////////////////////////

module SyncFifoController #(
	parameter 	pFifoDepth        	= 16,		// FIFO BRAMのサイズ指定
	parameter 	pFifoBitWidth     	= 8,		// bitサイズ
	parameter	pFifoRemaingCntBorder	= 127,
	parameter	pFifoRemaingCntUsed		= "no"
)(
    input   [pFifoBitWidth-1:0] iWd,        		// write data
    input                       iWe,        		// write enable 有効データ書き込み
    output                      oFull,      		// 最大書き込み時High
	output						oRemaingCntAlert,	// FIFO 残りデータ数がパラメータを超えた場合 Assert
    output  [pFifoBitWidth-1:0] oRd,        		// read data
    input                       iRe,        		// read enable
    output                      oRvd,       		// 有効データ出力
    output                      oEmp,       		// バッファ空時High
    input                       inARST,
    input                       iCLK
);


//----------------------------------------------------------
// FIFO の深さの bit幅取得
//----------------------------------------------------------
genvar x;
localparam pAddrWidth  = fBitWidth(pFifoDepth);
localparam [pAddrWidth-1:0] lpFifoRemaingCntBorder = pFifoRemaingCntBorder;

//-----------------------------------------------------------------------------
// アドレスの更新
//-----------------------------------------------------------------------------
reg  [pAddrWidth-1:0] rWa, rRa;
wire [pAddrWidth-1:0] wWa = rWa + 1'b1;
reg  qWe,qRe;
reg  qRemaingCntAlert;				assign oRemaingCntAlert = qRemaingCntAlert;
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
	qFull	<= (wWa == rRa);
	qEmp	<= (rWa == rRa); 
	qWe		<=  iWe & (~qFull);
	qRe		<=  iRe & (~qEmp);
end

generate
if (pFifoRemaingCntUsed == "yes")
begin
	always @*
	begin
		qRemaingCntAlert <= (rWa - rRa) < lpFifoRemaingCntBorder ? 1'b0 : 1'b1;
	end
end
else
begin
	always @*
	begin
		qRemaingCntAlert <= 1'b0;
	end
end
endgenerate


//-----------------------------------------------------------------------------
// BRAM
//-----------------------------------------------------------------------------
// DualPortBramTrion #(
//     .pBuffDepth(pFifoDepth),
//     .pBitWidth(pFifoBitWidth),
//     .pAddrWidth(pAddrWidth),
// 	.pFifoBlockRam(pFifoBlockRam)
// ) DualPortBramTrion (
// 	.iWd(iWd),
// 	.iWa(rWa),
// 	.iWe(qWe),
// 	.oRd(oRd),
// 	.iRa(rRa),
// 	.iCLK(iCLK)
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
		.pAddrWidth(pAddrWidth)
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
		.iRCLK(iCLK),
		.iWCLK(iCLK)
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
	$display("--- lpDataWidth %d bit", lpDataWidth);
	$display("--- lpBramGenNum %d Depth", lpBramGenNum);
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