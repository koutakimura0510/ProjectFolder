//----------------------------------------------------------
// Create  2022/8/17
// Author  KoutaKimura
// -
// File Process to Comment
// 
//----------------------------------------------------------
//----------------------------------------------------------
// Create  2022/8/17
// Author  KOutaKimura
// Editor  VSCode ver1.62.7
// Build   Vivado22.1
// Borad   Cmod A7
// -
// FPGA 内臓 XADC の温度センサを ILA で確認するプロジェクト
// LED は出力を設定しないと合成でエラーになるため、取り合えず指定している
// 
//----------------------------------------------------------
module XadcTop(
	input 			iOscSysClk,
	output [1:0] 	oLed
);

assign oLed = 2'b11;
wire [15:0] DO;
wire DRDY;
wire [4:0]	CH;

XADC XADC_inst (
	// ALARMS: 8-bit (each) output: ALM, OT
	.ALM(),
	// 8-bit output: Output alarm for temp, Vccint, Vccaux and Vccbram
	.OT(),
	// 1-bit output: Over-Temperature alarm
	// Dynamic Reconfiguration Port (DRP): 16-bit (each) output: Dynamic Reconfiguration Ports
	.DO(DO),
	// 16-bit output: DRP output data bus
	.DRDY(DRDY),
	// 1-bit output: DRP data ready
	// STATUS: 1-bit (each) output: XADC status ports
	.BUSY(),
	// 1-bit output: ADC busy output
	.CHANNEL(CH),
	// 5-bit output: Channel selection outputs
	.EOC(),
	// 1-bit output: End of Conversion
	.EOS(),
	// 1-bit output: End of Sequence
	.JTAGBUSY(),
	// 1-bit output: JTAG DRP transaction in progress output
	.JTAGLOCKED(),
	// 1-bit output: JTAG requested DRP port lock
	.JTAGMODIFIED(), // 1-bit output: JTAG Write to the DRP has occurred
	.MUXADDR(),
	// 5-bit output: External MUX channel decode
	// Auxiliary Analog-Input Pairs: 16-bit (each) input: VAUXP[15:0], VAUXN[15:0]
	.VAUXN(16'd0),
	// 16-bit input: N-side auxiliary analog input
	.VAUXP(16'd0),
	// 16-bit input: P-side auxiliary analog input
	// CONTROL and CLOCK: 1-bit (each) input: Reset, conversion start and clock inputs
	.CONVST(1'b0),
	// 1-bit input: Convert start input
	.CONVSTCLK(1'b0),
	// 1-bit input: Convert start input
	.RESET(1'b0),
	// 1-bit input: Active-high reset
	// Dedicated Analog Input Pair: 1-bit (each) input: VP/VN
	.VN(1'b0),
	// 1-bit input: N-side analog input
	.VP(1'b0),
	// 1-bit input: P-side analog input
	// Dynamic Reconfiguration Port (DRP): 7-bit (each) input: Dynamic Reconfiguration Ports
	.DADDR(7'd0),
	// 7-bit input: DRP address bus
	.DCLK(iOscSysClk),
	// 1-bit input: DRP clock
	.DEN(1'b1),
	// 1-bit input: DRP enable signal
	.DI(16'd0),
	// 16-bit input: DRP input data bus
	.DWE(1'b1)
	// 1-bit input: DRP write enable
);

XadcIla ila (
	.clk	(iOscSysClk),
	.probe0	(DO),
	.probe1 (DRDY)
);

endmodule
