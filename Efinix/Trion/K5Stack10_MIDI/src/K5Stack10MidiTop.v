/*-----------------------------------------------------------------------------
 * Create  2023/4/4
 * Author  KoutaKimura
 * Editor  VSCode ver1.73.1
 * Build   Efinity 2022.2.322.1.8
 * Device  K5Stack10 Main Board
 * -
 * 1.00：新規作成、IO Portのみ記載
 * 
 *-----------------------------------------------------------------------------*/	
module K5Stack10MidiTop (
	//
	// GPIOL
	input 	[ 5:0] ioGPIOL_I,
	output 	[ 5:0] ioGPIOL_O,
	output 	[ 5:0] ioGPIOL_OE,
	// GPIOR
	input 	[17:0] ioGPIOR_I,
	output 	[17:0] ioGPIOR_O,
	output 	[17:0] ioGPIOR_OE,
	// GPIOB
	input	[23:0] ioGPIOB_I,
	output 	[23:0] ioGPIOB_O,
	output 	[23:0] ioGPIOB_OE,
	//
	// External IO
	input 	ioCSI_I,
	output 	ioCSI_O,
	output 	ioCSI_OE,
	//
	// SRAM
	input 	[15:0] ioSRAMD_I,
	output 	[15:0] ioSRAMD_O,
	output 	[15:0] ioSRAMD_OE,
	output 	[14:0] oSRAMA,
	output 	oSRAM_CE,
	output 	oSRAM_LB,
	output 	oSRAM_OE,
	output 	oSRAM_UB,
	output 	oSRAM_WE,
	//
	// USB UART
	input 	iUSB_RX,
	output 	oUSB_TX,
	//
	// Flash ROM SPI
	input 	ioMOSI_I,
	output 	ioMOSI_O,
	output 	ioMOSI_OE,
	input 	ioMISO_I,
	output 	ioMISO_O,
	output 	ioMISO_OE,
	input 	ioCCK_I,
	output 	ioCCK_O,
	output 	ioCCK_OE,
	input 	ioSSN_I,
	output 	ioSSN_O,
	output 	ioSSN_OE,
	//
	// External OSC
	input 	iOSC_IN,
	//
	// PLL BR0
	input 	iMCLK,
	output 	PLL_BR0_RSTN,
	input 	PLL_BR0_LOCKED,
	//
	// PLL TL0
	input 	iSCLK,
	output 	PLL_TL0_RSTN,
	input 	PLL_TL0_LOCKED,
);


//-----------------------------------------------------------------------------
// System Reset Gen
//-----------------------------------------------------------------------------
reg rSRST, rnSRST;
reg rMRST, rnMRST;

always @(posedge iMCLK, negedge qlocked)
begin
	if (!qlocked) 	rnMRST <= 1'b0;
	else 			rnMRST <= 1'b1;

	if (!qlocked) 	rMRST <= 1'b1;
	else 			rMRST <= 1'b0;
end

always @(posedge iSCLK, negedge qlocked)
begin
	if (!qlocked) 	rnSRST <= 1'b0;
	else 			rnSRST <= 1'b1;
	
	if (!qlocked) 	rSRST <= 1'b1;
	else 			rSRST <= 1'b0;
end

always @*
begin
	qlocked = &{PLL_BR0_LOCKED, PLL_TL0_LOCKED};
end

assign PLL_BR0_RSTN = 1'b1;
assign PLL_TL0_RSTN = 1'b1;


//-----------------------------------------------------------------------------
// Processor
//-----------------------------------------------------------------------------


//-----------------------------------------------------------------------------
// IO Connect
// Trion,Titanium はユーザーが使用可能な IOプリミティブは無いため、
// 階層を深くせずソースの修正が簡単にすることを目的として Top module に接続する仕様にした
// 
// 使用していない IO は Input 設定にしておく。
//-----------------------------------------------------------------------------
// GPIOL
assign ioGPIOL_O = ioGPIOL_I;
assign ioGPIOL_OE = 6'd0;
// GPIOR
assign ioGPIOR_O = ioGPIOR_I;
assign ioGPIOR_OE = 18'd0;
// GPIOB
assign ioGPIOB_O = ioGPIOB_I;
assign ioGPIOB_OE = 24'd0;
// External IO
assign ioCSI_O = ioCSI_I;
assign ioCSI_OE = 1'b0;
// SRAM
assign ioSRAMD_O = ioSRAMD_I;
assign ioSRAMD_OE = 16'd0;
assign oSRAMA = 15'd0;
assign oSRAM_CE = 1'b1;
assign oSRAM_LB = 1'b1;
assign oSRAM_OE = 1'b1;
assign oSRAM_UB = 1'b1;
assign oSRAM_WE = 1'b1;
// USB UART
assign oUSB_TX = iUSB_RX;
// Flash ROM SPI
assign ioMOSI_O = ioMOSI_I;
assign ioMOSI_OE = 1'b0;
assign ioMISO_O = ioMISO_I;
assign ioMISO_OE = 1'b0;
assign ioCCK_O = ioCCK_I;
assign ioCCK_OE = 1'b0;
assign ioSSN_O = ioSSN_I;
assign ioSSN_OE = 1'b0;

endmodule

