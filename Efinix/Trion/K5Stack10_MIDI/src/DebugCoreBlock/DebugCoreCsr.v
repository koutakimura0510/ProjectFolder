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
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h01,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth	= 8,
	parameter pCsrActiveWidth = 8,
	parameter p_non_variable = 0
)(
	// Csr Output
	output oI2SModuleRst,
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input  [pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// CLK RST
	input iSRST,
	input iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg rI2SModuleRst;		assign 	oI2SModuleRst	= rI2SModuleRst;	// 汎用 GPIO ON/OFF 制御
//
reg qCsrWCke00;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rI2SModuleRst	<= 1'b0;
	end
	else
	begin
		rI2SModuleRst	<= qCsrWCke00 ? iSUsiWd[0:0] : rI2SModuleRst;
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
		'h00:	 rSUsiRd <= {{(32 - 1){1'b0}}, rI2SModuleRst};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule