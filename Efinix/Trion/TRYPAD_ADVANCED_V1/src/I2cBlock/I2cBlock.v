/**-----------------------------------------------------------------------------
 * I2C I/F Block
 * 
 * 23-12-09 v1.00	: new release
 * 					:
 *-----------------------------------------------------------------------------*/
module I2cBlock #(
	parameter 						pBlockAdrsWidth = 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap		= 'h04,
	parameter						pUsiBusWidth	= 16,
	parameter 						pCsrAdrsWidth 	= 8,
	parameter 						pCsrActiveWidth	= 8
)(
	// I2C Sinal Ctrl
	input						iI2cScl,
	output						oI2cScl,
	output						oI2cSclOe,
	input						iI2cSda,
	output						oI2cSda,
	output						oI2cSdaOe,
	// Usi Bus Master Read
	output	[pUsiBusWidth-1:0] 	oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0] 	iSUsiWd,
	input	[pUsiBusWidth-1:0] 	iSUsiAdrs,
	// CLK Rst
	input 	iSRST,
	input 	inSRST,
	input 	iSCLK
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpI2CDivClk = 16;	// SCL生成の分周値レジスタBit幅

//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire		wSlaveCoreRst;
wire [ 7:0] wSlaveRdCsr;
wire		wSlaveVdCsr;

I2cCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pI2CDivClk(lpI2CDivClk)
) I2cCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),		.iSUsiAdrs(iSUsiAdrs),
	// Csr Output
	.oSlaveCoreRst(wSlaveCoreRst),
	// Status
	.iSlaveRd(wSlaveRdCsr),	.iSlaveVd(wSlaveVdCsr),
	// common
	.iSCLK(iSCLK),			.iSRST(iSRST)
);


/**----------------------------------------------------------------------------
 * I2C Slave I/F
 *---------------------------------------------------------------------------*/
I2cSlaveIf I2cSlaveIf(
	// External Port
	.iI2cScl(iI2cScl),		.oI2cScl(oI2cScl),		.oI2cSclOe(oI2cSclOe),
	.iI2cSda(iI2cSda),		.oI2cSda(oI2cSda),		.oI2cSdaOe(oI2cSdaOe),
	// Internal Read Data
	.oDd(wSlaveRdCsr),		.oVd(wSlaveVdCsr),
	// Control / Status
	.iSlaveAdrs(8'd0),
	// common
	.iRST(iSRST),			.inRST(inSRST),		.iCLK(iSCLK)
);

endmodule