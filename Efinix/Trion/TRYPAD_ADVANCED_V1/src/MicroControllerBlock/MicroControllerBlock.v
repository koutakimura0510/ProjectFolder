//----------------------------------------------------------
// Create 2023/7/1
// Author koutakimura
// -
// RISC-V IP Soc(CPU) を搭載しシステムの管理を行う。
//----------------------------------------------------------
module MicroControllerBlock #(
	parameter						pBlockAdrsWidth		= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap			= 'h01,
	parameter 						pUsiBusWidth 		= 32,
	parameter 						pCsrAdrsWidth 		= 8,
	parameter 						pCsrActiveWidth 	= 8,
	parameter 						pUfiBusWidth 		= 32,
	parameter [3:0] 				pUfiAdrsMap			= 'h0,
	parameter 						pSimlation 			= "no",
	parameter 						pOnChipMcu 			= "yes"
)(
	// Usi Bus Master Read
	input	[pUsiBusWidth-1:0] 		iMUsiRd,
	output	[pUsiBusWidth-1:0] 		oSUsiRd,	// ※1
	// Usi Bus Master Write
	output	[pUsiBusWidth-1:0]		oMUsiWd,
	output	[pUsiBusWidth-1:0]		oMUsiAdrs,
	input	[pUsiBusWidth-1:0]		iSUsiWd,	// ※1
	input	[pUsiBusWidth-1:0]		iSUsiAdrs,	// ※1
	// Ufi Bus Master Read
	input	[pUfiBusWidth-1:0] 		iMUfiRd,
	input							iMUfiVd,
	// Ufi Bus Master Write
	output	[pUfiBusWidth-1:0] 		oMUfiWd,
	input							iMUfiRdy,
	// UART
	output							oTxd,
	input							iRxd,
	// Control / Status
	input [15:0]					iSystemVersion,
	input [15:0]					iCustomCode,
	// common
	input							iSRST,
	input							inSRST,
	input							iSCLK,
	output							oSocRST,
	// JTAG
	input							jtag_inst1_TCK,
	output							jtag_inst1_TDO,
	input							jtag_inst1_TDI,
	input							jtag_inst1_TMS,
	input							jtag_inst1_RUNTEST,
	input							jtag_inst1_SEL,
	input							jtag_inst1_CAPTURE,
	input							jtag_inst1_SHIFT,
	input							jtag_inst1_UPDATE,
	input							jtag_inst1_RESET
);
// ※1 MCB 自体が持つ CSR アクセスする


//-----------------------------------------------------------------------------
// CSR
//-----------------------------------------------------------------------------
wire [pUfiBusWidth-1:0] 	wRamWdCsr;
wire 						wRamEnCsr;
reg 						qRamFullCsr, qRamEmpCsr;
reg  [pUfiBusWidth-1:0] 	qUfiRdCsr;
reg 						qRamRdVdCsr;

MicroControllerCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth)
) MicroControllerCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// CSR
	.oRamWd(wRamWdCsr),
	.oRamEn(wRamEnCsr),
	.iRamFull(qRamFullCsr),	.iRamEmp(qRamEmpCsr),
	.iRamRd(qUfiRdCsr),
	.iRamRdVd(qRamRdVdCsr),
	//
	.iSystemVersion(iSystemVersion),
	.iCustomCode(iCustomCode),
	// CLK RST
	.iSRST(iSRST),			.iSCLK(iSCLK)
);


//---------------------------------------------------------------------------
// Soc IP
//---------------------------------------------------------------------------
wire [15:0] wGpioWriteMsb, wGpioWriteLsb;
wire [15:0] wGpioReadMsb, wGpioReadLsb;
wire [15:0] wGpioDataEn;
wire [15:0] wGpioAdrsEn;

generate
	if (pSimlation == "yes" || pOnChipMcu == "no")
	begin
		assign wGpioWriteMsb    = 16'd0;
		assign wGpioWriteLsb    = 16'd0;
		assign wGpioDataEn		= 16'd0;
		assign wGpioAdrsEn  	= 16'd0;
	end
	else
	begin
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
	end

	//-----------------------------------------------------------------------------
	// USI Bus
	//-----------------------------------------------------------------------------
	reg  [31:0] rMBusWd, rMBusAdrs;

	always @(posedge iSCLK)
	begin
		if (iSRST)                rMBusWd <= 32'd0;
		else if (wGpioDataEn[0])  rMBusWd <= {wGpioWriteMsb,wGpioWriteLsb};
		else                      rMBusWd <= rMBusWd;

		if (iSRST)                rMBusAdrs <= 32'd0;
		else if (wGpioAdrsEn[0])  rMBusAdrs <= {wGpioWriteMsb,wGpioWriteLsb};
		else                      rMBusAdrs <= 32'd0;
	end

	assign wGpioReadLsb 	= iMUsiRd[15:0];
	assign wGpioReadMsb 	= iMUsiRd[31:16];
	//
	assign oMUsiWd			= rMBusWd;
	assign oMUsiAdrs		= rMBusAdrs;
endgenerate



/**----------------------------------------------------------------------------
 * not used
 *---------------------------------------------------------------------------*/
assign oMUfiWd = 32'd0;

// //-----------------------------------------------------------------------------
// // Mcb Cache Memory
// // SPI Rom から読み込んだデータを RAM に格納する目的で使用する。
// // Write Enable は Csr で制御しており Enable Assert -> Dissert にしなければ、
// // 次の書き込みが行われないようにした。
// //-----------------------------------------------------------------------------
// localparam lpMcmDepth 		= 512;
// localparam lpMcmBitWidth 	= 48;

// reg  [lpMcmBitWidth-1:0] 	qMcmWd;
// reg 						qMcmWe;
// wire [lpMcmBitWidth-1:0] 	wMcmRd;
// reg  qMcmRe;
// wire wMcmFull, wMcmEmp;
// wire wMcmRvd;
// //
// reg  rMcmWeOneShot;

// SyncFifoController #(
//     .pFifoDepth(lpMcmDepth),
//     .pFifoBitWidth(lpMcmBitWidth)
// ) McbCacheMemory (
//     .iWd(qMcmWd),
//     .iWe(qMcmWe),
//     .oFull(wMcmFull),
// 	.oRemaingCntAlert(),
//     .oRd(wMcmRd),
//     .iRe(qMcmRe),
//     .oRvd(wMcmRvd),
//     .oEmp(wMcmEmp),
//     .inARST(inSRST),
// 	.iCLK(iSCLK)
// );

// always @(posedge iSCLK)
// begin
// 	if (iSRST) 			rMcmWeOneShot <= 1'b0;
// 	else if (wRamEnCsr)	rMcmWeOneShot <= 1'b0;
// 	else 				rMcmWeOneShot <= 1'b1;
// end

// always @*
// begin
// 	qMcmWd		<=  {wRamAdrsCsr,wRamWdCsr};
// 	qMcmWe		<= &{~wMcmFull,wRamEnCsr,rMcmWeOneShot};
// 	qMcmRe		<= &{iMUfiRdy,~wMcmEmp};
// 	qRamFullCsr	<=   wMcmFull;
// 	qRamEmpCsr	<=   wMcmEmp;
// end

// assign oMUfiWd			= wMcmRd[15:0];
// assign oMUfiAdrs[30:0]	= wMcmRd[46:16];
// assign oMUfiAdrs[31]	= wMcmRvd;


// //-----------------------------------------------------------------------------
// // UFI Read
// //-----------------------------------------------------------------------------
// reg [pUfiBusWidth-1:0] 	rUfiRd;
// reg 						qUfiRdCke;

// initial
// begin
// 	rUfiRd <= {pUfiBusWidth{1'b0}};
// end

// always @(posedge iSCLK)
// begin
// 	if (qUfiRdCke)	rUfiRd <= iMUfiRd;
// 	else			rUfiRd <= rUfiRd;
// end

// always @*
// begin
// 	qUfiRdCke 	<= &{iMUfiAdrs[31], (iMUfiAdrs[28:25] == pUfiAdrsMap)};
// 	qRamRdVdCsr <= qUfiRdCke;
// 	qUfiRdCsr 	<= rUfiRd;
// end

endmodule