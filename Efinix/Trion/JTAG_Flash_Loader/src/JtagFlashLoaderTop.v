/*-----------------------------------------------------------------------------
 * Create  2023/09/18
 * Author  Kouta Kimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2023.1.150
 * -
 * 23-09-18 v1.00 : New Release
 * 23-09-18 v1.01 : K5Stack10-V2 対応
 *-----------------------------------------------------------------------------*/
module JtagFlashLoaderTop (
	// User ROM
	input  	[3:0] iUser_MISO,
	output	[3:0] oUser_MOSI,
	output	[3:0] oUser_SCK,
	output	[3:0] oUser_nCS,
	output	oMaster_MISO,
	input	iMaster_MOSI,
	input	iMaster_SCK,
	input	[3:0] iMaster_nCS,
	// Config ROM
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
	// Debug Pin
	output [3:0] oUserDebug,
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
JtagFlashLoader JtagFlashLoader(
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
// SPI Bridge
//-----------------------------------------------------------------------------
reg qMasterMiso;

always @*
begin
	case ({iMaster_nCS[3:0]})
		4'b1110: qMasterMiso <= iUser_MISO[0];
		4'b1101: qMasterMiso <= iUser_MISO[1];
		4'b1011: qMasterMiso <= iUser_MISO[2];
		4'b0111: qMasterMiso <= iUser_MISO[3];
		default: qMasterMiso <= 1'b0;
	endcase
end

assign oMaster_MISO		= iUser_MISO;
assign oUser_MOSI[3:0]	= {4{iMaster_MOSI}};
assign oUser_SCK[3:0] 	= {4{iMaster_SCK}};
assign oUser_nCS[3:0] 	= iMaster_nCS[3:0];

assign oUserDebug[0] = qMasterMiso;
assign oUserDebug[1] = iMaster_MOSI;
assign oUserDebug[2] = iMaster_SCK;
assign oUserDebug[3] = &{iMaster_nCS[3:0]};

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