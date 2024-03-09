/*-----------------------------------------------------------------------------
 * UFIB の バス・トランザクション解析 & ステータスを後段へ転送
 * [47:32] Burst Length				Min 1〜, "0" NG
 * [31:31] Enable Bit				"1" Enable,   	"1" Disable
 * [30:30] R/W Select Bit			"1" WriteCmd,	"0" ReadCmd
 * [29:29] NC
 * [28: 0] Memory R/W Start Adrs	Max 512[MB]
 *
 * 24-03-03 v1.00: new release
 *-----------------------------------------------------------------------------*/
module UfibCoreUnit #(
	parameter	pUfiBusWidth 		= 48,
	parameter	pTransWaitEnable	= "no"		// Ufib Core が前段とのタイミング調整を行う必要がある場合 "yes", 最速転送の場合 "no"
)(
	// Ufi Bus Master Read
	output [pUfiBusWidth-1:0] 		oSUfiRd,
	output 							oSUfiVd,
	// Ufi Bus Master Write
	input  [pUfiBusWidth-1:0] 		iSUfiWd,
	output							oSUfiRdy,
	// External Memory Access Control / Status
	output [15:0]					oMemBurstLen,
	output 							oMemRwSel,
	output [28:0]					oMemAdrs,
	output							oMemVd,
	input							iMemRe,
	// External Memory Access Read Dq
	input  [pUfiBusWidth-1:0]		iMemRd,
	input							iMemRvd,
	// CLK Reset
	input							iRST,
	input							inARST,
	input							iCLK 
);


/**----------------------------------------------------------------------------
 * Master to Slave side
 *---------------------------------------------------------------------------*/
wire [47:0] wUwfRd;
wire		wUwfRvd;
wire 		wUwfFull;
reg			qUwfRe;

SyncFifoController #(
	.pFifoDepth(256),
	.pFifoBitWidth(pUfiBusWidth),
	.pFifoRemaingCntBorder(256-16),
	.pFifoRemaingCntUsed("yes")
) UfiWriteFifo (
	// write side
	.iWd(iSUfiWd),		.iWe(iSUfiWd[31]),
	.oFull(),			.oRemaingCntAlert(wUwfFull),
	// read side
	.oRd(wUwfRd),		.iRe(qUwfRe),
	.oRvd(wUwfRvd),		.oEmp(),
	// CLK Reset
	.inARST(inARST),	.iCLK(iCLK)
);

assign oSUfiRdy		= ~wUwfFull;
assign oMemBurstLen	= wUwfRd[47:32];
assign oMemRwSel	= wUwfRd[30];
assign oMemAdrs		= wUwfRd[28:0];
assign oMemVd		= wUwfRvd;

generate
	if (pTransWaitEnable == "yes")
	begin
		reg [1:0] 	rWaitCnt = 2'b00;
		reg			qWaitCntMax;
		
		always @(posedge iCLK)
		begin
			if (qWaitCntMax)	rWaitCnt <= 2'd0;
			else 				rWaitCnt <= rWaitCnt + 1'b1;
		end
		
		always @*
		begin
			qWaitCntMax <= &{rWaitCnt[1:0]};
			qUwfRe		<= &{iMemRe,qWaitCntMax};
		end
	end
	else
	begin
		always @*
		begin
			qUwfRe <= iMemRe;
		end
	end
endgenerate

/**----------------------------------------------------------------------------
 * Slave to Master side
 *---------------------------------------------------------------------------*/
assign oSUfiRd = iMemRd;	// ※ 24-03-04 ひとまず reg 経由にせず thru で出力
assign oSUfiVd = iMemRvd;

endmodule