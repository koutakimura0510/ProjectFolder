//----------------------------------------------------------
// Create 2022/8/14
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module PSRAMCsr #(
	// variable parameter
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h08,
	parameter						pBusAdrsBit		= 32
)(
    // Internal Port
	// Csr Read
	output	[31:0]					oSUsiRd,
	output 							oSUsiREd,
	// Csr Write
	input	[31:0]					iSUsiWd,
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,
	input							iSUsiWCke,
	// Csr Output
	output 							oRamRst,
	// Csr Input
	input  							iRamInit,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);



//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
// USI/F Write
reg 	rRamRst;				assign oRamRst 		= rRamRst;			// 通信開始
//
reg 	rRamInit;		// RAM 初期化完了時 1, 初期化中 0
//
reg [pBusAdrsBit:0]	qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rRamRst			<= 1'b1;
		rRamInit		<= 1'b0;
	end
	else
	begin
		rRamRst			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[0:0] 			: rRamRst;
		rRamInit		<= iRamInit;
	end
end

always @*
begin
	qCsrAdrs <= {iSUsiWCke, iSUsiAdrs};
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd <= 'h0;
	end
	else
	begin
		case ({qAdrsComp, iSUsiAdrs[7:0]})
			'h100:		rSUsiRd <= {31'd0, rRamRst};
			'h180:		rSUsiRd <= {31'd0, rRamInit};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + 3'd7:8] == pAdrsMap};
end

endmodule