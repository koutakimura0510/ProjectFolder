//----------------------------------------------------------
// Create 2022/9/8
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module AudioTxCsr #(
	parameter 						pBlockAdrsMap 		= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  			= 'h05,
	parameter						pBusAdrsBit			= 16,
	parameter 						pCsrAdrsWidth   	= 16,
	parameter						pCsrActiveWidth 	= 8,
	//
    parameter       				pAudioSamplingRate 	= 8,
	parameter						pMemAdrsWidth		= 19
)(
    // Internal Port
	// Csr Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// Csr Output
	output 	[pMemAdrsWidth-1:0]		oDmaAdrs,
	output 	[pMemAdrsWidth-1:0]		oDmaLen,
	output 		 					oDmaEn,
    // CLK Reset
    input           				iSysRst,
    input           				iSysClk
);


//-----------------------------------------------------------------------------
// DMA Adrs
//-----------------------------------------------------------------------------
localparam [pMemAdrsWidth-1:0] lpDmaAdrs	= 'h40000;
localparam [pMemAdrsWidth-1:0] lpDmaLen		= 'h30000;


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pMemAdrsWidth-1:0]	rDmaAdrs;	assign oDmaAdrs 	= rDmaAdrs;		// DMA 開始アドレス
reg [pMemAdrsWidth-1:0]	rDmaLen;	assign oDmaLen 		= rDmaLen;		// DMA 読み込みサイズ
reg 					rDmaEn;		assign oDmaEn 		= rDmaEn;		// DMA Enable
//
reg 					qCsrWCke00;
reg 					qCsrWCke04;
reg 					qCsrWCke08;
reg 					qCsrWCke0c;
reg 					qCsrWCke10;
reg 					qCsrWCke14;
reg 					qCsrWCke18;
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rDmaAdrs	<= lpDmaAdrs;
		rDmaLen		<= lpDmaLen;
		rDmaEn		<= 1'b0;
	end
	else
	begin
		rDmaAdrs	<= qCsrWCke10 ? iSUsiWd[pMemAdrsWidth-1:0] 	: rDmaAdrs;
		rDmaLen		<= qCsrWCke14 ? iSUsiWd[pMemAdrsWidth-1:0] 	: rDmaLen;
		rDmaEn		<= qCsrWCke18 ? iSUsiWd[ 0:0] 				: rDmaEn;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
	qCsrWCke10 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke14 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke18 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd  = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd <= 'h0;
		rSUsiREd <= 1'b0;
	end
	else
	begin
		// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
		case (iSUsiAdrs[pCsrActiveWidth - 1:0])
			'h00:		rSUsiRd	<= {{(32 - 0){1'b0}}		};
			'h04:		rSUsiRd	<= {{(32 - 0){1'b0}}		};
			'h08:		rSUsiRd	<= {{(32 - 0){1'b0}}		};
			'h0c:		rSUsiRd	<= {{(32 - 0){1'b0}}		};
			'h10:		rSUsiRd	<= {{(32 - pMemAdrsWidth){1'b0}},	rDmaAdrs	};
			'h14:		rSUsiRd	<= {{(32 - pMemAdrsWidth){1'b0}},	rDmaLen		};
			'h18:		rSUsiRd	<= {{(32 - 1){1'b0}},				rDmaEn		};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:pCsrAdrsWidth] == pAdrsMap};
end

endmodule