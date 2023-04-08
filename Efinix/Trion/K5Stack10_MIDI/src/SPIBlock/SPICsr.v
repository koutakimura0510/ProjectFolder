//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module SPICsr #(
	// variable parameter
	parameter  pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth = 8,
	parameter pCsrActiveWidth = 8,
	parameter pDivClk = 16
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
	// Csr Output
	output oSPIEn,
	output [pDivClk-1:0] oSPIDiv,
	output [7:0] oMWd,
	output oMSpiCs,
	// Csr Input
	input  [7:0] iMRd,
	input  iMSpiIntr,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);

//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
reg 				rSPIEn;				assign oSPIEn 		= rSPIEn;			// 通信開始
reg [pDivClk-1:0]	rSPIDiv;			assign oSPIDiv 		= rSPIDiv;			// CLK Division
reg [7:0]			rMWd;				assign oMWd			= rMWd;				// Send Data
reg 				rMSpiCs;			assign oMSpiCs		= rMSpiCs;			// chip select 
//
reg [7:0]			rMRd;	// 読み込みデータ
//
reg 				qCsrWCke00;
reg 				qCsrWCke04;
reg 				qCsrWCke08;
reg 				qCsrWCke0c;

always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rSPIEn			<= 1'b0;
		rSPIDiv			<= {pDivClk{1'b1}};
		rMWd			<= 8'd0;
		rMSpiCs			<= 1'b1;
		//
		rMRd			<= 8'd0;
	end
	else
	begin
		rSPIEn			<= iMSpiIntr  ? 1'b0 : qCsrWCke00 ? iSUsiWd[0:0] : rSPIEn;
		rSPIDiv			<= qCsrWCke04 ? iSUsiWd[pDivClk-1:0] : rSPIDiv;
		rMWd			<= qCsrWCke08 ? iSUsiWd[7:0] : rMWd;
		rMSpiCs			<= qCsrWCke0c ? iSUsiWd[0:0] : rMSpiCs;
		rMRd			<= iMRd;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {31'd0, rSPIEn};
		'h04:	 rSUsiRd <= {{(32 - pDivClk){1'b0}}, rSPIDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
		'h08:	 rSUsiRd <= {24'd0, rMWd};
		'h0c:	 rSUsiRd <= {31'd0, rMSpiCs};
		'h80:	 rSUsiRd <= {24'd0, rMRd};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule