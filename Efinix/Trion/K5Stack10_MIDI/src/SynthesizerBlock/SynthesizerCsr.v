//------------------------------------------------------------------------------
// Create 2023/4/15
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
// 
// 2023/04/15 V1.0 nre release
//------------------------------------------------------------------------------
module SynthesizerCsr #(
	parameter pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth 	= 8,
	parameter pDmaAdrsWidth 	= 16,
	parameter p_non_variable 	= 0
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input	[pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr Output
	output 	oI2SModuleRst,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsStart,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsEnd,
	output	oDmaEnable,
	input	iDmaDone,
	// CLK RST
	input 	iSRST,
	input 	iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg rI2SModuleRst;							assign oI2SModuleRst	= rI2SModuleRst;	// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsStart;		assign oDmaAdrsStart 	= rDmaAdrsStart;	// 
reg [pDmaAdrsWidth-1:0] rDmaAdrsEnd;		assign oDmaAdrsEnd 		= rDmaAdrsEnd;		// 
reg rDmaEnable;								assign oDmaEnable 		= rDmaEnable;		// DMA Function Enable
reg rDmaCycleEnable;																	// Dma Auto Cycle Mode
//
reg qCsrWCke00;
reg qCsrWCke04;
reg qCsrWCke08;
reg qCsrWCke0C;
reg qCsrWCke10;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rI2SModuleRst 	<= 1'b0;
		rDmaAdrsStart 	<= {pDmaAdrsWidth{1'b0}};
		rDmaAdrsEnd 	<= {pDmaAdrsWidth{1'b1}};
		rDmaEnable 		<= 1'b0;
		rDmaCycleEnable	<= 1'b0;
	end
	else
	begin
		rI2SModuleRst	<= qCsrWCke00 ? iSUsiWd[0:0] : rI2SModuleRst;
		rDmaAdrsStart	<= qCsrWCke04 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsStart;
		rDmaAdrsEnd		<= qCsrWCke08 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsEnd;
		rDmaEnable		<= iDmaDone	  ? rDmaCycleEnable : qCsrWCke0C ? iSUsiWd[0:0] : rDmaEnable;
		rDmaCycleEnable	<= qCsrWCke10 ? iSUsiWd[0:0] : rDmaCycleEnable;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0C <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000C});
	qCsrWCke10 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - 1			 ){1'b0}}, rI2SModuleRst};
		'h04:	 rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsStart};
		'h08:	 rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsEnd};
		'h0C:	 rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaEnable};
		'h10:	 rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaCycleEnable};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule