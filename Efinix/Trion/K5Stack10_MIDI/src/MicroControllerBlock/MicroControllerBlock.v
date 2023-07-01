//----------------------------------------------------------
// Create 2023/7/1
// Author koutakimura
// -
// RISC-V IP Soc(CPU) を搭載しシステムの管理を行う。
//----------------------------------------------------------
module MicroControllerBlock #(
	parameter pUsiBusWidth 		  = 32,
	parameter pUfiDqBusWidth 	  = 16,
	parameter pUfiAdrsBusWidth 	= 32,
	parameter pUfiEnableBit 	  = 32
)(
	// Usi Bus Master Read
	input  [pUsiBusWidth-1:0] iMUsiRd,
	// Usi Bus Master Write
	output [pUsiBusWidth-1:0] oMUsiWd,
	output [pUsiBusWidth-1:0] oMUsiAdrs,
	// Ufi Bus Master Read
	input  [pUfiDqBusWidth-1:0] iMUfiRd,
	input  [pUfiAdrsBusWidth-1:0] iMUfiAdrs,
	// Ufi Bus Master Write
	output [pUfiDqBusWidth-1:0] oMUfiWd,
	output [pUfiAdrsBusWidth-1:0] oMUfiAdrs,
	input  iMUfiRdy,
  // UART
  output oTxd,
  input  iRxd,
  // Soc RST
  output oSocRST,
	// common
  input  iSRST,
  input  iSCLK,
  // JTAG
  input   jtag_inst1_TCK,
  output  jtag_inst1_TDO,
  input   jtag_inst1_TDI,
  input   jtag_inst1_TMS,
  input   jtag_inst1_RUNTEST,
  input   jtag_inst1_SEL,
  input   jtag_inst1_CAPTURE,
  input   jtag_inst1_SHIFT,
  input   jtag_inst1_UPDATE,
  input   jtag_inst1_RESET
);


//-----------------------------------------------------------------------------
// 未使用 pin
//-----------------------------------------------------------------------------
assign oMUfiWd		= {pUfiDqBusWidth{1'b0}};
assign oMUfiAdrs	= {pUfiAdrsBusWidth{1'b0}};


//---------------------------------------------------------------------------
// Soc IP
//---------------------------------------------------------------------------
reg  [31:0] rMUsiWd, rMUsiAdrs;
wire [15:0] wGpioWriteMsb, wGpioWriteLsb;
wire [15:0] wGpioReadMsb, wGpioReadLsb;
wire [15:0] wGpioDataEn;
wire [15:0] wGpioAdrsEn;

SapphireSoc soc_inst (
  // SPI 0
  .system_spi_0_io_sclk_write(),
  .system_spi_0_io_data_0_writeEnable(),
  .system_spi_0_io_data_0_read(),
  .system_spi_0_io_data_0_write(),
  .system_spi_0_io_ss(),
  // SPI 1,2
  .system_spi_0_io_data_1_writeEnable(),
  .system_spi_0_io_data_1_read(),
  .system_spi_0_io_data_1_write(),
  .system_spi_0_io_data_2_writeEnable(),
  .system_spi_0_io_data_2_read(),
  .system_spi_0_io_data_2_write(),
  .system_spi_0_io_data_3_writeEnable(),
  .system_spi_0_io_data_3_read(),
  .system_spi_0_io_data_3_write(),
  // GPIO
  .system_gpio_0_io_writeEnable(wGpioDataEn),
  .system_gpio_1_io_writeEnable(wGpioAdrsEn),
  .system_gpio_0_io_write(wGpioWriteLsb),
  .system_gpio_1_io_write(wGpioWriteMsb),
  .system_gpio_0_io_read(wGpioReadLsb),
  .system_gpio_1_io_read(wGpioReadMsb),
  // UART
  .system_uart_0_io_txd(oTxd),
  .system_uart_0_io_rxd(iRxd),
  // common
  .io_systemClk(iSCLK),
  .io_asyncReset(iSRST),
  .io_systemReset(oSocRST),
  // Jtag
  .jtagCtrl_tck(jtag_inst1_TCK),
  .jtagCtrl_tdi(jtag_inst1_TDI),
  .jtagCtrl_tdo(jtag_inst1_TDO),
  .jtagCtrl_enable(jtag_inst1_SEL),
  .jtagCtrl_capture(jtag_inst1_CAPTURE),
  .jtagCtrl_shift(jtag_inst1_SHIFT),
  .jtagCtrl_update(jtag_inst1_UPDATE),
  .jtagCtrl_reset(jtag_inst1_RESET)
);

always @(posedge iSCLK)
begin
    if (iSRST)                rMUsiWd <= 32'd0;
    else if (wGpioDataEn[0])  rMUsiWd <= {wGpioWriteMsb,wGpioWriteLsb};
    else                      rMUsiWd <= rMUsiWd;

    if (iSRST)                rMUsiAdrs <= 32'd0;
    else if (wGpioAdrsEn[0])  rMUsiAdrs <= {wGpioWriteMsb,wGpioWriteLsb};
    else                      rMUsiAdrs <= 32'd0;
end

assign wGpioReadLsb = iMUsiRd[15:0];
assign wGpioReadMsb = iMUsiRd[31:16];
assign oMUsiWd      = rMUsiWd;
assign oMUsiAdrs    = rMUsiAdrs;

//-----------------------------------------------------------------------------
// CSR
//-----------------------------------------------------------------------------
// MicroControllerCsr #(
// 	.pBlockConnectNum		(pBlockConnectNum),
// 	.pBlockAdrsWidth			(pBlockAdrsWidth),
// 	.pAdrsMap				(pAdrsMap),
// 	.pUsiBusWidth			(pUsiBusWidth),
// 	.pCsrAdrsWidth			(pCsrAdrsWidth),
// 	.pCsrActiveWidth		(pCsrActiveWidth),
// 	.pMemAdrsWidth			(pMemAdrsWidth)
// ) MICRO_CONTROLLER_CSR (
// 	// Slave Output Side
// 	.iWd					(wMcbCsrWd),
// 	.iAdrs					(wMcbCsrAdrs),
// 	.iWCke					(wMcbCsrCke),
// 	.oRd					(wMcbManualRd),
// 	.oMUsiWd				(oMUsiWd),
// 	.oMUsiAdrs				(oMUsiAdrs),
// 	.oMUsiWEd				(oMUsiWEd),
// 	// Slave Input Side
// 	// Csr に 書き込んでレジスタ経由で出力し直す
// 	.iMUsiRd				(iMUsiRd),
// 	.iMUsiREd				(iMUsiREd),
// 	.oMUsiRd				(wMUsiRd),
// 	.oMUsiREd				(wMUsiREd),
// 	//
// 	.iSRST				(iSRST),
// 	.iSCLK				(iSCLK)
// );

endmodule