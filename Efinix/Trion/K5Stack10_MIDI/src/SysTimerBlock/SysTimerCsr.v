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
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h08,
	parameter pUsiBusWidth = 32,
	parameter pCsrAdrsWidth	= 8,
	parameter pCsrActiveWidth = 8
)(
	// Bus Master Read
	output [pUsiBusWidth-1:0] oSUsiRd,
	// Bus Master Write
	input  [pUsiBusWidth-1:0] iSUsiWd,
	input  [pUsiBusWidth-1:0] iSUsiAdrs,
	// Csr Input
	input  [31:0] iTimerCnt10ms,
	input  [31:0] iTimerCnt1ms,
	input  [31:0] iTimerCnt1us,
	// CLK Reset
	input  iSRST,
	input  iSCLK
);

//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
reg [31:0]	rTimerCnt10ms;
reg [31:0]	rTimerCnt1ms;
reg [31:0]	rTimerCnt1us;

always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rTimerCnt10ms	<= 32'd0;
		rTimerCnt1ms	<= 32'd0;
		rTimerCnt1us	<= 32'd0;
	end
	else
	begin
		rTimerCnt10ms	<= iTimerCnt10ms;
		rTimerCnt1ms	<= iTimerCnt1ms;
		rTimerCnt1us	<= iTimerCnt1us;
	end
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:		rSUsiRd <= rTimerCnt10ms;
		'h04:		rSUsiRd <= rTimerCnt1ms;
		'h08:		rSUsiRd <= rTimerCnt1us;
		default:  	rSUsiRd <= iSUsiWd;
	endcase
end

endmodule