//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module RAMCsr #(
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth	= 8,
	parameter pCsrActiveWidth = 8,
	parameter pRamAdrsWidth	= 19,
	parameter pRamDqWidth = 16,
	parameter p_non_variable = 0
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input  [pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr Output
	output oRamRst,
	// Csr Input
	input  [pRamDqWidth-1:0] iMemRd,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg rRamRst;				assign oRamRst = rRamRst;
//
reg [pRamDqWidth-1:0] rMemRd;
//
reg	qCsrWCke00;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rRamRst	<= 1'b1;
		rMemRd	<= {pRamDqWidth{1'b0}};
	end
	else
	begin
		rRamRst	<= qCsrWCke00 ? iSUsiWd[0:0] : rRamRst;
		rMemRd	<= iMemRd;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - 1	){1'b0}}, rRamRst};
		'h40:	 rSUsiRd <= {{(32 - pRamDqWidth	){1'b0}}, iMemRd};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule