//----------------------------------------------------------
// Create 2022/8/14
// Author koutakimura
// -
// 外部 PSRAM の管理を司るブロック
// バースト長 8
// 
//----------------------------------------------------------
module PSRAMBlock #(
	// variable parameter
	parameter 							pBlockAdrsMap 		= 8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 		pAdrsMap	  		= 'h08,
	parameter							pBusAdrsBit			= 16,
	parameter							pUfiBusWidth		= 16
)(
	// External Port
	inout	[15:0]						ioSramDq,
	inout	[1:0]						ioSramDqs,
	output 								oSramClk,
	output 								oSramCs,
    // Internal Port
	// Usi Bus Slave Read
	output	[31:0]						oSUsiRd,		// Read Data
	output								oSUsiREd,		// Read Data Enable
	// Usi Bus Slave Write
	input	[31:0]						iSUsiWd,		// Master Write Data
	input	[pBusAdrsBit-1:0]			iSUsiAdrs,		// Csr Access Adrs
	input								iSUsiWCke,		// Data Enable
	// Ufi Bus Master Write
	output	[pUfiBusWidth-1:0]			oSUfiRd,		// Read Data
	output	[31:0]						oSUfiAdrs,		// Read address
	output								oSUfiREd,		// Read Data Enable
	output 								oSUfiRVd,		// 転送期間中 Assert
	// Ufi Bus Master Read
	input	[pUfiBusWidth-1:0]			iSUfiWd,		// Write Data
	input	[31:0]						iSUfiAdrs,		// Write address
	input								iSUfiWEd,		// Write Data Enable
    // CLK Reset
    input           					iSysClk,
    input           					iSysRst
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpDivClk = 16;	// SCL生成の分周値レジスタBit幅


//----------------------------------------------------------
// PSRAM Unit
//----------------------------------------------------------
//
wire 					qRamRstUnit;
//
reg 					wRamInitUnit;
//
PSRAMUnit PSRAM_UNIT (
	.ioSramDq			(ioSramDq),
	.ioSramDqs			(ioSramDqs),
	.oSramClk			(oSramClk),
	.oSramCs			(oSramCs),
	//

	// Csr
	.oRamInitUnit		(wRamInitUnit),
	// CLK Reset
	.iSysClk			(iSysClk),
	.iSysRst			(qRamRstUnit)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 					wRamRstCsr;
//
reg 					qRamInitCsr;
//
PSRAMCsr #(
	.pBlockAdrsMap		(pBlockAdrsMap),
	.pAdrsMap			(pAdrsMap),
	.pBusAdrsBit		(pBusAdrsBit)
) PSRAM_CSR (
	// Usi Bus Slave
	.oSUsiRd			(oSUsiRd),
	.oSUsiREd			(oSUsiREd),
	.iSUsiWd			(iSUsiWd),
	.iSUsiAdrs			(iSUsiAdrs),
	.iSUsiWCke			(iSUsiWCke),
	// Csr Output
	.oRamRst			(wRamRstCsr),
	// Csr Input
	.iRamInit			(qRamInitCsr),
	// CLK Reset
	.iSysClk			(iSysClk),
	.iSysRst			(iSysRst)
);

always @*
begin
	qRamRstUnit			<= wRamRstCsr;
	qRamInitCsr			<= wRamInitUnit;
end

endmodule