//----------------------------------------------------------
// Create 2023/7/15
// Author koutakimura
// -
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
// 
//----------------------------------------------------------
module MicroControllerCsr #(
	// 各ブロック共通のパラメータ
	parameter pBlockAdrsWidth	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h06,
	parameter pUsiBusWidth		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth	= 8,
	// Block 固有のパラメータ
	parameter pUfiDqBusWdith	= 16,
	parameter pUfiAdrsBusWdith	= 32,
	//
	parameter p_non_variable	= 0
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input  [pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr Output
	output [15:0] 	oRamWd,
	output [31:0] 	oRamAdrs,
	output 			oRamEn,
	// Csr Input
	input 			iRamRdy,
	// CLK RST
	input iSRST,
	input iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [15:0]	rRamWd;				assign 	oRamWd		= rRamWd;
reg [31:0]	rRamAdrs;			assign 	oRamAdrs  	= rRamAdrs;
reg 		rRamEn;				assign 	oRamEn		= rRamEn;
//
reg 		rRamRdy;
//
reg qCsrWCke00;
reg qCsrWCke04;
reg qCsrWCke08;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rRamWd		<= {16{1'b0}};
		rRamAdrs	<= {32{1'b0}};
		rRamEn 		<= 1'b0;
		//
		rRamRdy		<= 1'b0;
	end
	else
	begin
		rRamWd		<= qCsrWCke00 ? iSUsiWd[15:0] : rRamWd;
		rRamAdrs	<= qCsrWCke04 ? iSUsiWd[31:0] : rRamAdrs;
		rRamEn		<= qCsrWCke08 ? iSUsiWd[ 0:0] : rRamEn;
		//
		rRamRdy		<= iRamRdy;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - 16	){1'b0}}, rRamWd};
		'h04:	 rSUsiRd <= {rRamAdrs};
		'h08:	 rSUsiRd <= {{(32 - 1	){1'b0}}, rRamEn};
		'h40:	 rSUsiRd <= {{(32 - 1	){1'b0}}, rRamRdy};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule