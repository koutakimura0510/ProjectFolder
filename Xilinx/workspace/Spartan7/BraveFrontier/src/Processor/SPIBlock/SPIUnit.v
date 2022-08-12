//----------------------------------------------------------
// Create 2022/8/3
// Author koutakimura
// -
// SPI 通信の制御を司るユニット
// 
//----------------------------------------------------------
module SPIUnit #(
	// variable parameter
	parameter					pBusAdrsBit	= 16,
	parameter 					pDivClk 	= 16
)(
	// External Port
    inout	          			ioSpiSck,
    inout           			ioSpiMiso,
    inout           			ioSpiMosi,
    inout           			ioSpiWp,
    inout           			ioSpiHold,
    output          			oSpiConfigCs,
    inout	          			ioSpiCs1,
    inout	          			ioSpiCs2,
    // Internal Port
	// Usi Bus Master to Slave Select
	output 						oMUsiMonopoly,	// 0. Slave として機能 / 1. Master バスを独占
	// Usi Bus Master Read
	input	[31:0]				iMUsiRd,		// Csr Read
	// input	[pBusSlaveConnectWidth:0]	iMUsiREd,	// Slave アクセス可能時 Assert
	// Usi Bus Master Write
	output	[31:0]				oMUsiWd,		// Write Data
	output	[pBusAdrsBit-1:0]	oMUsiAdrs,		// R/W Adrs
	output						oMUsiWEd,		// Write Enable
	// Ufi Bus Master
	output	[31:0]				oMUfiWd,		// Write Data
	output	[31:0]				oMUfiAdrs,		// Write address
	output						oMUfiWEd,		// Write Data Enable
	output 						oMUfiWVd,		// 転送期間中 Assert
	// Csr
	input 						iSPIEn,
	input 	[lpDivClk-1:0]		iSPIDiv,
	input 	[7:0]				iMWd,
	input 						iMSpiCs1,
	input 						iMSpiCs2,
	output	[7:0]				oMRd,
	// Interrupt
	output 						oMUsiREd,
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);

//----------------------------------------------------------
// 指定分周値 の CKE 信号生成
//----------------------------------------------------------
wire wDivCke;

CkeGenerator #(
	.pDivReg		("yes"),
	.pDivWidth		(pDivClk)
) I2C_CKE_GEN (
	.iCke			(iSPIEn),
	.iDiv			(iSPIDiv),
	.oCke			(wDivCke),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// FPGA Slave の際の データ操作
//----------------------------------------------------------
wire	[31:0]		wSMisoMux;
reg 	[31:0]		qSRdMux;
reg 	[31:0]		qSAdrsMux;
reg 	[1:0]		qSCmdMux;
reg 	[15:0]		qSDLenMux;
reg 				qSRdVdMux;

SPISignalMux # (
	.pBusAdrsBit	(pBusAdrsBit)
) SPI_SIGNAL_MUX (
	// Internal Port FPGA Slave Side SPI Module Connect
	.oSMiso			(wSMisoMux),
	.iSRd			(qSRdMux),
	.iSAdrs			(qSAdrsMux),
	.iSCmd			(qSCmdMux),
	.iSDLen			(qSDLenMux),
	.iSRdVd			(qSRdVdMux),
	// Internal Port FPGA Slave Side Upper Module Connect
	.iMUsiRd		(iMUsiRd),
	.oMUsiWd		(oMUsiWd),
	.oMUsiAdrs		(oMUsiAdrs),
	.oMUsiWEd		(oMUsiWEd),
	// Ufi Bus Master Write
	.oMUfiWd		(oMUfiWd),
	.oMUfiAdrs		(oMUfiAdrs),
	.oMUfiWEd		(oMUfiWEd),
	.oMUfiWVd		(oMUfiWVd),
	// CLK Reset
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// SPI 通信信号生成
//----------------------------------------------------------
// FPGA Slave Side
reg		[31:0]	qSMisoSig;
wire 	[31:0]	wSRdSig;
wire 	[31:0]	wSAdrsSig;
wire 	[1:0]	wSCmdSig;
wire 	[15:0]	wSDLenSig;
wire 			wSRdVdSig;

SPISignal SPI_SIGNAL (
	// External Port
	.ioSpiSck		(ioSpiSck),
	.ioSpiMiso		(ioSpiMiso),
	.ioSpiMosi		(ioSpiMosi),
	.ioSpiWp		(ioSpiWp),
	.ioSpiHold		(ioSpiHold),
	.oSpiConfigCs	(oSpiConfigCs),
	.ioSpiCs1		(ioSpiCs1),
	.ioSpiCs2		(ioSpiCs2),
	// Internal Port FPGA Slave Side
	.iSMiso			(qSMisoSig),
	.oSRd			(wSRdSig),
	.oSAdrs			(wSAdrsSig),
	.oSCmd			(wSCmdSig),
	.oSDLen			(wSDLenSig),
	.oSRdVd			(wSRdVdSig),
	// Internal Port FPGA Master Side
	.iSPIEn			(iSPIEn),
	.iDivCke		(wDivCke),
	.iMWd			(iMWd),
	.oMRd			(oMRd),
	.oMUsiREd			(oMUsiREd),
	.iMSpiCs1		(iMSpiCs1),
	.iMSpiCs2		(iMSpiCs2),
	// Master Slave Select
	.oMSSel			(oMUsiMonopoly),
	//
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

always @*
begin
	qSMisoSig	<= wSMisoMux;
	qSRdMux 	<= wSRdSig;
	qSAdrsMux 	<= wSAdrsSig;
	qSCmdMux 	<= wSCmdSig;
	qSDLenMux 	<= wSDLenSig;
	qSRdVdMux 	<= wSRdVdSig;
end

endmodule