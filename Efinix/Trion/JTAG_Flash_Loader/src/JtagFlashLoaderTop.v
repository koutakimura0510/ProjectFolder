
module JtagFlashLoaderTop (
	input  iMISO,
	output oSCK,
	output onCS,
	output oMOSI,
	// output wp_n,
	// output hold_n,
	output osc_inst1_ENA,
	input  jtag_inst1_CAPTURE,
	input  jtag_inst1_DRCK,
	input  jtag_inst1_RESET,
	input  jtag_inst1_RUNTEST,
	input  jtag_inst1_SEL,
	input  jtag_inst1_SHIFT,
	input  jtag_inst1_TCK,
	input  jtag_inst1_TDI,
	input  jtag_inst1_TMS,
	input  jtag_inst1_UPDATE,
	output jtag_inst1_TDO,
	// User I/F
	output [2:0] oLed,
	// CLK Domain
	input  iPllLocked,
	output oPllnRST,
	input  iSCLK		// JTAG 6MHz の場合は 50Mhz あれば十分である
);


//-----------------------------------------------------------------------------
// RST Gen
//-----------------------------------------------------------------------------
reg  rSRST, rnSRST;

always @(posedge iSCLK, negedge iPllLocked)
begin
	if (!iPllLocked) rSRST  <= 1'b1;
	else 			 rSRST  <= 1'b0;
	//
	if (!iPllLocked) rnSRST <= 1'b0;
	else 			 rnSRST <= 1'b1;
end

assign 	oPllnRST = 1'b1;

//-----------------------------------------------------------------------------
// Flash Loader
//-----------------------------------------------------------------------------
JtagFlashLoader u_JtagFlashLoader(
	.miso(iMISO),
	.sclk(oSCK),
	.nss(onCS),
	.mosi(oMOSI),
	.wp_n(),
	.hold_n(),
	.jtag_inst1_CAPTURE(jtag_inst1_CAPTURE),
	.jtag_inst1_DRCK(jtag_inst1_DRCK),
	.jtag_inst1_RESET(jtag_inst1_RESET),
	.jtag_inst1_RUNTEST(jtag_inst1_RUNTEST),
	.jtag_inst1_SEL(jtag_inst1_SEL),
	.jtag_inst1_SHIFT(jtag_inst1_SHIFT),
	.jtag_inst1_TCK(jtag_inst1_TCK),
	.jtag_inst1_TDI(jtag_inst1_TDI),
	.jtag_inst1_TMS(jtag_inst1_TMS),
	.jtag_inst1_UPDATE(jtag_inst1_UPDATE),
	.jtag_inst1_TDO(jtag_inst1_TDO),
	.osc_inst1_ENA(osc_inst1_ENA),
	.rstn(rnSRST),
	.clkin(iSCLK)
);

//-----------------------------------------------------------------------------
// LED
//-----------------------------------------------------------------------------
localparam lpCntBitWidth = 26;
localparam [lpCntBitWidth-1:0] lpCntMax = 20000000 - 1;

reg  [lpCntBitWidth-1:0] rCnt;
reg  qCntMaxCke;
reg  [2:0] rLed;		assign oLed = rLed;

always @(posedge iSCLK)
begin
	if (rSRST) 				rCnt <= {lpCntBitWidth{1'b0}};
	else if (qCntMaxCke)	rCnt <= {lpCntBitWidth{1'b0}};
	else 					rCnt <= rCnt + 1'b1;

	if (rSRST) 				rLed <= 3'b000;
	else if (qCntMaxCke)	rLed <= rLed + 1'b1;
	else 					rLed <= rLed;
end

always @*
begin
	qCntMaxCke <= rCnt == lpCntMax;
end

endmodule