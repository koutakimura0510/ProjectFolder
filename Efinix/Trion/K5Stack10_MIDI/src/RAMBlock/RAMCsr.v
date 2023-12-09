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
	output [pUsiBusWidth-1:0] 	oSUsiRd,	// Read Data
	// Bus Master Write
	input  [pUsiBusWidth-1:0] 	iSUsiWd,	// Write Data
	input  [pUsiBusWidth-1:0] 	iSUsiAdrs,  // R/W Adrs
	// Csr Memory Common
	output 						oRamRst,
	// Csr Device Config
	input  [15:0] 				iHdcCapDq,
	output [15:0] 				oHdcWDq,
	output [47:0] 				oHdcCmdAdrs,
	output						oHdcRwCmd,
	output						oHdcSeqEn,
	input						iHdcDone,
	// Csr Input
	input  [pRamDqWidth-1:0] 	iMemRd,
    // CLK Reset
    input  iSRST,
    input  iSCLK
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg 		rRamRst;				assign oRamRst 		= rRamRst;
reg 		rHdcSeqEn;				assign oHdcSeqEn 	= rHdcSeqEn;
reg 		rHdcRwCmd;				assign oHdcRwCmd 	= rHdcRwCmd;
reg [15:0] 	rHdcWDq;				assign oHdcWDq		= rHdcWDq;
reg [47:0] 	rHdcCmdAdrs;			assign oHdcCmdAdrs	= rHdcCmdAdrs;
//
reg [pRamDqWidth-1:0] 	rMemRd;
reg [15:0]				rHdcCapDq;
//
reg qCsrWCke00, qCsrWCke01, qCsrWCke02, qCsrWCke03, qCsrWCke04;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rHdcSeqEn	<= 1'b0;
		rHdcRwCmd	<= 1'b0;
		rRamRst		<= 1'b1;
		rHdcWDq		<= 16'd0;
		rHdcCmdAdrs	<= 48'd0;
		rMemRd		<= {pRamDqWidth{1'b0}};
		rHdcCapDq	<= 16'd0;
	end
	else
	begin
		rRamRst				<= qCsrWCke00 ? iSUsiWd[ 0:0] : rRamRst;
		rHdcSeqEn			<= iHdcDone	  ? 1'b0 		  : qCsrWCke01 ? iSUsiWd[ 0:0] : rHdcSeqEn;
		rHdcRwCmd			<= qCsrWCke01 ? iSUsiWd[ 4:4] : rHdcRwCmd;
		rHdcWDq				<= qCsrWCke02 ? iSUsiWd[15:0] : rHdcWDq;
		rHdcCmdAdrs[31: 0]	<= qCsrWCke03 ? iSUsiWd[31:0] : rHdcCmdAdrs[31: 0];
		rHdcCmdAdrs[47:32]	<= qCsrWCke04 ? iSUsiWd[15:0] : rHdcCmdAdrs[47:32];
		rMemRd				<= iMemRd;
		rHdcCapDq			<= iHdcDone   ? iHdcCapDq	  : rHdcCapDq;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke01 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0001});
	qCsrWCke02 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0002});
	qCsrWCke03 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0003});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
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
		'h01:	 rSUsiRd <= {{(32 - 2	){1'b0}}, rHdcRwCmd,	rHdcSeqEn};
		'h02:	 rSUsiRd <= {{(32 - 16	){1'b0}}, rHdcWDq};
		'h03:	 rSUsiRd <= {					  rHdcCmdAdrs[31:0]};
		'h04:	 rSUsiRd <= {{(32 - 16	){1'b0}}, rHdcCmdAdrs[47:32]};
		'h40:	 rSUsiRd <= {{(32 - pRamDqWidth	){1'b0}}, iMemRd};
		'h41:	 rSUsiRd <= {{(32 - 16	){1'b0}}, rHdcCapDq};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule