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
	parameter pUfiDqBusWidth	= 16,
	//
	parameter p_non_variable	= 0
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input  [pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr Output
	output [pUfiDqBusWidth-1:0] 	oRamWd,
	output 							oRamEn,
	// Csr Input
	input 							iRamFull,
	input 							iRamEmp,
	input  [pUfiDqBusWidth-1:0]		iRamRd,
	input 							iRamRdVd,
	// CLK RST
	input iSRST,
	input iSCLK
);

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pUfiDqBusWidth-1:0]	rRamWd;			assign 	oRamWd		= rRamWd;
reg 						rRamEn;			assign 	oRamEn		= rRamEn;
//
reg 						rRamFull;
reg 						rRamEmp;
reg [pUfiDqBusWidth-1:0]	rRamRd;
reg 						rRamRdVd;
//
reg qCsrWCke00;
reg qCsrWCke04;
reg qCsrWCke08;
reg qCsrWCke0C;
reg qCsrWCke48;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rRamWd		<= {pUfiDqBusWidth{1'b0}};
		rRamEn 		<= 1'b0;
		//
		rRamFull	<= 1'b0;
		rRamEmp		<= 1'b0;
		rRamRd		<= {pUfiDqBusWidth{1'b0}};
	end
	else
	begin
		rRamWd		<= qCsrWCke00 ? iSUsiWd[15:0] : rRamWd;
		rRamEn		<= qCsrWCke08 ? iSUsiWd[ 0:0] : rRamEn;
		//
		rRamFull	<= iRamFull;
		rRamEmp		<= iRamEmp;
		rRamRd		<= iRamRd;
		rRamRdVd	<= iRamRdVd ? 1'b1 : qCsrWCke48 ? 1'b0 : rRamRdVd;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0C <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000C});
	qCsrWCke48 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0048});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - pUfiDqBusWidth	){1'b0}}, rRamWd};
		'h08:	 rSUsiRd <= {{(32 - 1	){1'b0}}, rRamEn};
		// 'h0C:	 rSUsiRd <= {{(32 - 1	){1'b0}}, rRamBurstRun};
		'h40:	 rSUsiRd <= {{(32 - 8	){1'b0}}, 3'b000, rRamEmp, 3'b000, rRamFull};
		'h44:	 rSUsiRd <= {{(32 - pUfiDqBusWidth	){1'b0}}, rRamRd};
		'h48:	 rSUsiRd <= {{(32 - 1	){1'b0}}, rRamRdVd};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule