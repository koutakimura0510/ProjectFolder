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
	parameter 						pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] 	pAdrsMap  		= 'h06,
	parameter						pUsiBusWidth		= 16,
	parameter 						pCsrAdrsWidth   = 16,
	parameter						pCsrActiveWidth = 8,
	//
	parameter						pRamAdrsWidth	= 19,
	parameter						pRamDqWidth		= 8
)(
    // Internal Port
	// Csr Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// Csr Output
	output 							oRamDualFifoSrcRst,
	output 							oRamDualFifoDstRst,
	//
	input 	[pRamDqWidth-1:0]		iMemRd,
    // CLK Reset
    input           				iSRST,
    input           				iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg 						rRamDualFifoSrcRst;				assign oRamDualFifoSrcRst = rRamDualFifoSrcRst;
reg 						rRamDualFifoDstRst;				assign oRamDualFifoDstRst = rRamDualFifoDstRst;
//
reg [pRamDqWidth-1:0]		rMemRd;
//
reg 						qCsrWCke00;
// reg 						qCsrWCke04;
// reg 						qCsrWCke08;
// reg 						qCsrWCke0c;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rRamDualFifoSrcRst	<= 1'b1;
		rRamDualFifoDstRst	<= 1'b1;
		rMemRd				<= {pRamDqWidth{1'b0}};
	end
	else
	begin
		rRamDualFifoSrcRst	<= qCsrWCke00 ? iSUsiWd[0:0] : rRamDualFifoSrcRst;
		rRamDualFifoDstRst	<= qCsrWCke00 ? iSUsiWd[1:1] : rRamDualFifoDstRst;
		rMemRd				<= iMemRd;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	// qCsrWCke04 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	// qCsrWCke08 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	// qCsrWCke0c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd  = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rSUsiRd <= 'h0;
		rSUsiREd <= 1'b0;
	end
	else
	begin
		// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
		case (iSUsiAdrs[pCsrActiveWidth - 1:0])
			//
			'h0000:		rSUsiRd	<= {{(32 - 2){1'b0}}, rRamDualFifoDstRst, rRamDualFifoSrcRst};
			'h0080:		rSUsiRd	<= {{(32 - pRamDqWidth){1'b0}},		rMemRd		};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSRST)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:pCsrAdrsWidth] == pAdrsMap};
end

endmodule