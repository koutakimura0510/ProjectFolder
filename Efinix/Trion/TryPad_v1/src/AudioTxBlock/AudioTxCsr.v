/*-----------------------------------------------------------------------------
 * [Csr 規則]
 * 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
 * 上位モジュールへの output port は必ずレジスタ経由で出力する。
 *
 * 23-09-02 v1.00 : new release
 *-----------------------------------------------------------------------------*/
module AudioTxCsr #(
	parameter pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth 	= 8,
	parameter p_non_variable 	= 0
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0] 	oSUsiRd,
	// Bus Master Write
	input	[pUsiBusWidth-1:0] 	iSUsiWd,
	input	[pUsiBusWidth-1:0] 	iSUsiAdrs,
	// Csr
	// CLK RST
	input 	iSRST,
	input 	iSCLK
);

//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule