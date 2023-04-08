//----------------------------------------------------------
// Create 2022/7/25
// Author koutakimura
// -
// I2CBlock
// 
//----------------------------------------------------------
module I2CBlock #(
	parameter 						pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] 	pAdrsMap	  	= 'h04,
	parameter						pUsiBusWidth		= 16,
	parameter 						pCsrAdrsWidth 	= 8,
	parameter 						pCsrActiveWidth	= 8
)(
	// External Port
	output						oI2CScl,
	inout 						ioI2CSda,
    // Internal Port
	// Bus Slave Read
	output	[31:0]				oSUsiRd,	// Read Data
	output						oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]				iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0]	iSUsiAdrs,  // R/W Adrs
	input						iSUsiWCke,	// Write Enable
    // CLK Reset
    input           			iSCLK,
    input           			iSRST
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpI2CDivClk = 16;	// SCL生成の分周値レジスタBit幅


//----------------------------------------------------------
// I2C Unit
//----------------------------------------------------------
reg 						qI2CEnUnit;
reg 	[lpI2CDivClk-1:0]	qI2CDivUnit;
wire 	[15:0]				wI2CGetKeyPadUnit;
wire 						wI2CSeqCompUnit;

I2CUnit #(
	.pI2CDivClk		(lpI2CDivClk)
) I2C_UNIT (
	.oI2CScl		(oI2CScl),
	.ioI2CSda		(ioI2CSda),
	.iI2CEn			(qI2CEnUnit),
	.iI2CDiv		(qI2CDivUnit),
	.oI2CGetKeyPad	(wI2CGetKeyPadUnit),
	.oI2CSeqComp	(wI2CSeqCompUnit),
	.iSCLK		(iSCLK),
	.iSRST		(iSRST)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 						wI2CEnCsr;
wire 	[lpI2CDivClk-1:0]	wI2CDivCsr;
reg		[15:0]				qI2CGetKeyPadCsr;
reg  						qI2CSeqCompCsr;

I2CCsr #(
	.pBlockAdrsWidth	(pBlockAdrsWidth),
	.pAdrsMap		(pAdrsMap),
	.pUsiBusWidth	(pUsiBusWidth),
	.pCsrAdrsWidth	(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pI2CDivClk		(lpI2CDivClk)
) I2C_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiREd		(oSUsiREd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.iI2CGetKeyPad	(qI2CGetKeyPadCsr),
	.iI2CSeqComp	(qI2CSeqCompCsr),
	.oI2CEn			(wI2CEnCsr),
	.oI2CDiv		(wI2CDivCsr),
	.iSCLK		(iSCLK),
	.iSRST		(iSRST)
);

always @*
begin
	qI2CEnUnit			<= wI2CEnCsr;
	qI2CDivUnit			<= wI2CDivCsr;
	qI2CGetKeyPadCsr	<= wI2CGetKeyPadUnit;
	qI2CSeqCompCsr		<= wI2CSeqCompUnit;
end


endmodule