//-----------------------------------------------------------------------------
// Create  2023/1/7
// Author  kimura
// Editor  VSCode ver1.70.0
// -
// Max 20bit
// 
// オプション
// (* async_reg = "true" *) reg [1:0] x;
// (* syn_use_dsp = "yes" *) signed [27:0] x;
// (* syn_ramstyle = "block_ram" *) reg [DWIDTH-1:0] mem [DEPTH-1:0];
// (* syn_ramstyle = "registers" *) reg [DWIDTH-1:0] mem [DEPTH-1:0];
//-----------------------------------------------------------------------------
module EfxRamFifoController #(
    parameter					pFifoBitWidth	= 8,						// Data Width
	parameter					pFifoDepth		= 512,						// Data Width との調整に注意
	parameter					pFullAlMost 	= 6,						// 指定値分 FULL になるよりも早く Assert
	parameter [0:0]				pEmpRst			= 1'b1,						// Empty Rst の値
	parameter [0:0]				pFullRst		= 1'b0,						// Full Rst の値
	parameter 					pAddrWidth  	= fBitWidth(pFifoDepth)		// 13 bit 固定
)(
	// src side
    input   [pFifoBitWidth-1:0] iWd,        // write data
    input                       iWe,        // write enable Active High
    output                      oFull,      // Fifo Full Assert, Active High
	// dst side
    output  [pFifoBitWidth-1:0] oRd,        // read data
    input                       iRe,        // read enable Active High
    output                      oRvd,       // Valid Data
    output                      oEmp,       // Fifo Empty
	//
    input                       iRST,
    input                       iCLK
);
	// .iWd	(),				.iWe	(),
	// .oFull	(),
	// .oRd	(),				.iRe	(),
	// .oRvd	(),				.oEmp	(),
	// .iRST	(qSRST),		.iCLK	(iSCLK)


//-----------------------------------------------------------------------------
// アドレスの更新
//-----------------------------------------------------------------------------
reg [pAddrWidth-1:0] rWa, rRa, rRaOld;
reg qWe, qRe;

always @(posedge iCLK)
begin
    if (iRST)       rWa <= {pAddrWidth{1'b0}};
    else if (qWe)   rWa <= rWa + 1'b1;
    else            rWa <= rWa;
	//
    if (iRST)      	rRa <= {pAddrWidth{1'b0}};
    else if (qRe)  	rRa <= rRa + 1'b1;
    else           	rRa <= rRa;
	// 前回のrpが更新されていたら新規データを出力できる状態と判断する
    if (iRST)   	rRaOld <= {pAddrWidth{1'b0}};
    else        	rRaOld <= rRa;
end


//----------------------------------------------------------
// ハンドシェイク信号出力
//----------------------------------------------------------
localparam lpFullAlMost = pFullAlMost + 1;

reg 					rFull;						assign oFull = rFull;
reg 					rEmp;						assign oEmp  = rEmp;
reg 					rRvd;						assign oRvd  = rRvd;
reg 					qFullAllmost, qEmp, qRvd;
reg [pFullAlMost-1:0] 	qFull;
reg [pAddrWidth-1:0] 	qWAn [0:pFullAlMost];

always @(posedge iCLK)
begin
	if (iRST)				rFull <= pFullRst;
	else if (qFullAllmost)	rFull <= 1'b1;
	else					rFull <= 1'b0;

	if (iRST)				rEmp <= pEmpRst;
	else if (qEmp)			rEmp <= 1'b1;
	else					rEmp <= 1'b0;

	if (iRST)				rRvd <= 1'b0;
	else if	(qRvd)			rRvd <= 1'b1;
	else					rRvd <= 1'b0;
end
//
integer n;

generate
	always @*
	begin
		for (n = 1; n < lpFullAlMost; n = n + 1)
		begin
			qWAn[n-1]   <= rWa + n;
			qFull[n-1]	<= (qWAn[n-1] == rRa);
		end
		qFullAllmost <= |{qFull};
	end
endgenerate

always @*
begin
    qEmp <= (rWa == rRa);
    qRvd <= (rRa != rRaOld);
    qWe  <= iWe;
    qRe  <= iRe & (~qEmp);
end


//----------------------------------------------------------
// Efx RAM Instance
//----------------------------------------------------------
wire [pFifoBitWidth-1:0] wRd;				assign oRd = wRd;

EfxRam10Primitive #(
	.pBitWidth(pFifoBitWidth),	.pAddrWidth(pAddrWidth)
) EfxRam10Primitive (
	// Write Side
	.iWd(iWd),		.iWa(rWa),
	.iWe(qWe),
	// Read Side
	.oRd(wRd),		.iRa(rRa),
	.iRe(qRe),
	// common
	.iRST(iRST),	.iCLK(iCLK)
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