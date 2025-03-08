//----------------------------------------------------------
/*-----------------------------------------------------------------------------
 * Create  2023/7/2
 * Author  Kouta Kimura
 * -
 * [Csr 規則]
 * 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
 * 上位モジュールへの output port は必ずレジスタ経由で出力する。
 * 
 *-----------------------------------------------------------------------------*/
module SysTimerCsr #(
	// variable parameter
	parameter pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth	= 8,
	parameter pCsrActiveWidth = 8,
	parameter pSystickTimerBitWidth = 32,
	parameter pSystickTimerNum = 3
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
	// Csr Output
	output [pSystickTimerBitWidth-1:0] oSystickTimerDiv1,
	output [pSystickTimerBitWidth-1:0] oSystickTimerDiv2,
	output [pSystickTimerBitWidth-1:0] oSystickTimerDiv3,
	output [pSystickTimerNum-1:0] oSystickTimerEn,
	// Csr Input
	input [pSystickTimerBitWidth-1:0] iSystickTimerCnt1,
	input [pSystickTimerBitWidth-1:0] iSystickTimerCnt2,
	input [pSystickTimerBitWidth-1:0] iSystickTimerCnt3,
	// CLK Reset
	input  iSRST,
	input  iSCLK
);

//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
reg [pSystickTimerBitWidth-1:0]	rSystickTimerDiv1;				assign oSystickTimerDiv1 = rSystickTimerDiv1;
reg [pSystickTimerBitWidth-1:0]	rSystickTimerDiv2;				assign oSystickTimerDiv2 = rSystickTimerDiv2;
reg [pSystickTimerBitWidth-1:0]	rSystickTimerDiv3;				assign oSystickTimerDiv3 = rSystickTimerDiv3;
reg [pSystickTimerNum-1:0] rSystickTimerEn;						assign oSystickTimerEn   = rSystickTimerEn;
reg [pSystickTimerBitWidth-1:0]	rSystickTimerCnt1;
reg [pSystickTimerBitWidth-1:0]	rSystickTimerCnt2;
reg [pSystickTimerBitWidth-1:0]	rSystickTimerCnt3;
//
reg 	qCsrWCke00;
reg 	qCsrWCke04;
reg 	qCsrWCke08;
reg 	qCsrWCke0c;

always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rSystickTimerDiv1	<= {pSystickTimerBitWidth{1'b1}};
		rSystickTimerDiv2	<= {pSystickTimerBitWidth{1'b1}};
		rSystickTimerDiv3	<= {pSystickTimerBitWidth{1'b1}};
		rSystickTimerEn		<= {pSystickTimerNum{1'b0}};
		rSystickTimerCnt1	<= {pSystickTimerBitWidth{1'b0}};
		rSystickTimerCnt2	<= {pSystickTimerBitWidth{1'b0}};
		rSystickTimerCnt3	<= {pSystickTimerBitWidth{1'b0}};
	end
	else
	begin
		rSystickTimerDiv1	<= qCsrWCke00 ? iSUsiWd[pSystickTimerBitWidth-1:0] : rSystickTimerDiv1;
		rSystickTimerDiv2	<= qCsrWCke04 ? iSUsiWd[pSystickTimerBitWidth-1:0] : rSystickTimerDiv2;
		rSystickTimerDiv3	<= qCsrWCke08 ? iSUsiWd[pSystickTimerBitWidth-1:0] : rSystickTimerDiv3;
		rSystickTimerEn		<= qCsrWCke0c ? iSUsiWd[pSystickTimerNum-1:0] : rSystickTimerEn;
		rSystickTimerCnt1	<= iSystickTimerCnt1;
		rSystickTimerCnt2	<= iSystickTimerCnt2;
		rSystickTimerCnt3	<= iSystickTimerCnt3;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000C});
end


//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:		rSUsiRd <= rSystickTimerDiv1;
		'h04:		rSUsiRd <= rSystickTimerDiv2;
		'h08:		rSUsiRd <= rSystickTimerDiv3;
		'h0C:		rSUsiRd <= {{(32 - pSystickTimerNum){1'b0}}, rSystickTimerEn};
		'h40:		rSUsiRd <= rSystickTimerCnt1;
		'h44:		rSUsiRd <= rSystickTimerCnt2;
		'h48:		rSUsiRd <= rSystickTimerCnt3;
		default:  	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule