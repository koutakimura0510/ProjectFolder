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
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h05,
	parameter						pBusAdrsBit		= 16,
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
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// Csr Output
	output	[pRamAdrsWidth-1:0]		oMemAdrs,
	output	[pRamDqWidth-1:0]		oMemWd,
	output							oMemCE,
	output							oMemCmd,
	//
	input 	[pRamDqWidth-1:0]		iMemRd,
    // CLK Reset
    input           				iSysRst,
    input           				iSysClk
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pRamAdrsWidth-1:0]		rMemAdrs;		assign oMemAdrs = rMemAdrs;
reg [pRamDqWidth-1:0]		rMemWd;			assign oMemWd 	= rMemWd;
reg 						rMemCE;			assign oMemCE 	= rMemCE;
reg 						rMemCmd;		assign oMemCmd 	= rMemCmd;
//
reg [pRamDqWidth-1:0]		rMemRd;
//
reg 						qCsrWCke00;
reg 						qCsrWCke04;
reg 						qCsrWCke08;
reg 						qCsrWCke0c;
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rMemAdrs	<= {pRamAdrsWidth{1'b0}};
		rMemWd		<= {pRamDqWidth{1'b0}};
		rMemCE		<= 1'b1;
		rMemCmd		<= 1'b1;
		rMemRd		<= {pRamDqWidth{1'b0}};
	end
	else
	begin
		rMemAdrs		<= qCsrWCke00 ? iSUsiWd[pRamAdrsWidth-1:0] 	: rMemAdrs;
		rMemWd			<= qCsrWCke04 ? iSUsiWd[pRamDqWidth-1:0]	: rMemWd;
		rMemCE			<= qCsrWCke08 ? iSUsiWd[0:0] 				: rMemCE;
		rMemCmd			<= qCsrWCke0c ? iSUsiWd[0:0] 				: rMemCmd;
		//
		rMemRd			<= iMemRd;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
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
			'h0000:		rSUsiRd	<= {{(32 - pRamAdrsWidth){1'b0}}, 	rMemAdrs	};
			'h0004:		rSUsiRd	<= {{(32 - pRamDqWidth){1'b0}}, 	rMemWd		};
			'h0008:		rSUsiRd	<= {{(32 - 1){1'b0}}, 				rMemCE		};
			'h000c:		rSUsiRd	<= {{(32 - 1){1'b0}}, 				rMemCmd		};
			//
			'h0080:		rSUsiRd	<= {{(32 - pRamDqWidth){1'b0}},		rMemRd		};
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