/*-----------------------------------------------------------------------------
 * Create  2023/09/18
 * Author  Kouta Kimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2023.1.150
 * -
 * 23-09-18 v1.00 : New Release
 * 23-09-18 v1.01 : K5Stack10-V2 対応
 * 24-02-25 v1.02 : K5Stack10-V3 対応
 *-----------------------------------------------------------------------------*/
module JtagFlashLoaderTop (
	// User ROM
	input  	[1:0] iUser_MISO,
	output	[1:0] oUser_MOSI,
	output	[1:0] oUser_SCK,
	output	[1:0] oUser_nCS,	
	output	oMaster_MISO,		// GPIOB P20
	input	iMaster_MOSI,		// GPIOB P18
	input	iMaster_SCK,		// GPIOB P19
	input	[1:0] iMaster_nCS,	// [3]=GPIOR P13, [2]=GPIOB P23, [1]=GPIOB P22, [0]=GPIOB P21
	// Config ROM
	input  iMISO,
	output oSCK,
	output onCS,
	output oMOSI,
	output oWp,
	output oHold,
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
	output [1:0] oLed,
	// Debug Pin
	output [3:0] oUserDebug,	// [3]=GPIOR P9, [2]=GPIOB P8, [1]=GPIOB P7, [0]=GPIOB P6
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
	.wp_n(oWp),
	.hold_n(oHold),
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

// assign oWp = 1'b1;
// assign oHold = 1'b1;

//-----------------------------------------------------------------------------
// SPI Bridge
// SCK,MISO,MOSI が UserDebug Pin に出力されないが、動作確認は完了
//-----------------------------------------------------------------------------
reg rGpioB_P6;
reg rGpioB_P7;
reg rGpioB_P8;
reg rGpioR_P9;
reg [1:0] rCs;
reg qMasterMiso;

always @(posedge iSCLK)
begin
	rGpioB_P6 <=   qMasterMiso;
	rGpioB_P7 <=   iMaster_MOSI;
	rGpioB_P8 <=   iMaster_SCK;
	rGpioR_P9 <= &{iMaster_nCS[1:0]};
	rCs		  <=   iMaster_nCS[1:0];
end

always @*
begin
	case ({rCs})
		'b10: 		qMasterMiso <= iUser_MISO[0];
		'b01:		qMasterMiso <= iUser_MISO[1];
		default: 	qMasterMiso <= 1'b0;
	endcase
end

assign oMaster_MISO		=    qMasterMiso;
assign oUser_MOSI[1:0]	= {2{iMaster_MOSI}};
assign oUser_SCK[1:0] 	= {2{iMaster_SCK}};
assign oUser_nCS[1:0] 	=    iMaster_nCS[1:0];

assign oUserDebug[0] = rGpioB_P6;
assign oUserDebug[1] = rGpioB_P7;
assign oUserDebug[2] = rGpioB_P8;
assign oUserDebug[3] = rGpioR_P9;

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