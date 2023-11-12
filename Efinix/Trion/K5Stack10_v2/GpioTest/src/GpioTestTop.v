/*-----------------------------------------------------------------------------
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2023.1.500.1.8
 * Device  K5Stack10 v2 Main Board
 * -
 * 23-11-12 v1.00: new release
 * 
 * GPIO のレジスタ Option を使用すると、どんな動作になるか検証する。
 * レジスタ Option の場合、想像通りに 1clk 遅れて信号が出力されていた。
 * Inv Register と合わせて DDR 出力に使えそう。
 *-----------------------------------------------------------------------------*/  
module GpioTestTop(
	// GPIOL
	output oGpioBP00,	// Option : Thru
	output oGpioBP01,	// Option : Register 
	output oGpioBP03,	// Option : Inv Register
	output [2:0] oLed,
	// USB UART
	input	iUSB_RX,
	output	oUSB_TX,
	// External OSC
	input	iOSC_IN,
	// PLL BR0
	input	iSCLK,
	input	iXCLK,
	output	PLL_BR0_RSTN,
	input	PLL_BR0_LOCKED,
	// JTAG
	input	jtag_inst1_TCK,
	output	jtag_inst1_TDO,
	input	jtag_inst1_TDI,
	input	jtag_inst1_TMS,
	input	jtag_inst1_RUNTEST,
	input	jtag_inst1_SEL,
	input	jtag_inst1_CAPTURE,
	input	jtag_inst1_SHIFT,
	input	jtag_inst1_UPDATE,
	input	jtag_inst1_RESET
);


/**----------------------------------------------------------------------------
 * System Reset Gen
 *---------------------------------------------------------------------------*/
genvar x;  // Top内で共通変数として使用する
//
reg 	rSRST, rnSRST;
wire 	wSRST, wnSRST;
reg  	qnARST;
reg  	qlocked;

always @(posedge iSCLK, negedge qnARST)
begin
	if (!qnARST)	rnSRST <= 1'b0;
	else			rnSRST <= 1'b1;
  
	if (!qnARST)	rSRST <= 1'b1;
	else			rSRST <= 1'b0;
end

always @*
begin
  qlocked <= &{PLL_BR0_LOCKED};
  qnARST  <= qlocked;
end

assign wSRST		= rSRST;			assign wnSRST   = rnSRST;
assign PLL_BR0_RSTN = 1'b1;


/**----------------------------------------------------------------------------
 * GPIO Option Debug
 *---------------------------------------------------------------------------*/
reg rOut = 1'b0;

always @( posedge iXCLK )
begin
	rOut <= ~rOut;
end

assign oGpioBP00 = rOut;
assign oGpioBP01 = rOut;
assign oGpioBP03 = rOut;


/**----------------------------------------------------------------------------
 * LED User Debug
 *---------------------------------------------------------------------------*/
localparam lpSclkCntMax = 25000000;
localparam lpXclkCntMax = 500000;
wire wPulseSCLK,wPulseXMCLK;

PulseGenerator #(.pDivClk(lpSclkCntMax)) SclkPulseGenerator (.oPulse(wPulseSCLK), .iRST(wSRST), .iCLK(iSCLK));
PulseGenerator #(.pDivClk(lpXclkCntMax)) XclkPulseGenerator (.oPulse(wPulseXCLK), .iRST(wSRST), .iCLK(iXCLK));

assign oLed[0] = qlocked;
assign oLed[1] = wPulseSCLK;
assign oLed[2] = wPulseXCLK;


endmodule