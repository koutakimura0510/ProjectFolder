//----------------------------------------------------------
// Create 2022/8/3
// Author koutakimura
// -
// SPI 通信の制御を司るユニット
// 
//----------------------------------------------------------
module SPIUnit #(
	// variable parameter
	parameter					pUsiBusWidth		= 16,
	parameter 					pDivClk 		= 16,
	parameter					pUfiBusWidth	= 16,
	parameter					pTestPortUsed 	= "no",
	parameter					pTestPortNum	= 4
)(
	// External Port
    inout	          			ioSpiSck,
    inout           			ioSpiMiso,
    inout           			ioSpiMosi,
    inout           			ioSpiWp,
    inout           			ioSpiHold,
    output          			oSpiConfigCs,
    inout	          			ioSpiCs,
    input	          			iMSSel,
    // Internal Port
	// Usi Bus Master to Slave Select
	output 						oMUsiSel,	// 0. Slave として機能 / 1. Master バスを独占
	// Usi Bus Master Read
	input	[31:0]				iMUsiRd,		// Csr Read
	// input	[pBusBlockConnectWidth:0]	iMUsiREd,	// Slave アクセス可能時 Assert
	// Usi Bus Master Write
	output	[31:0]				oMUsiWd,		// Write Data
	output	[pUsiBusWidth-1:0]	oMUsiAdrs,		// R/W Adrs
	output						oMUsiWEd,		// Write Enable
	// Ufi Bus Master
	output	[pUfiBusWidth-1:0]	oMUfiWd,		// Write Data
	output	[31:0]				oMUfiAdrs,		// Write address
	output						oMUfiEd,		// Write Data Enable
	output 						oMUfiVd,		// 転送期間中 Assert
	output 						oMUfiCmd,
	// Csr
	input 						iSPIEn,
	input 	[pDivClk-1:0]		iSPIDiv,
	input 	[7:0]				iMWd,
	input 						iMSPICs,
	output	[7:0]				oMRd,
	// Interrupt
	output 						oMSpiIntr,
    // CLK Reset
    input           			iSCLK,
    input           			iSRST,
	//
	output [pTestPortNum-1:0]	oTestPort
);

//----------------------------------------------------------
// 指定分周値 の CKE 信号生成
//----------------------------------------------------------
wire wDivCke;

CkeGenerator #(
	.pDivReg		("yes"),
	.pDivWidth		(pDivClk)
) SpiCkeGen (
	.iCke			(iSPIEn),
	.iDiv			(iSPIDiv),
	.oCke			(wDivCke),
	.iCLK			(iSCLK),
	.iRST			(iSRST)
);


//----------------------------------------------------------
// FPGA Slave の際の データ操作
//----------------------------------------------------------
wire	[31:0]		wSMisoMux;
reg 	[31:0]		qSRdMux;
reg 	[31:0]		qSAdrsMux;
reg 	[2:0]		qSCmdMux;
reg 	[15:0]		qSDLenMux;
reg 				qSREdMux;

SPISignalMux # (
	.pUsiBusWidth	(pUsiBusWidth),
	.pUfiBusWidth	(pUfiBusWidth)
) SPISignalMux (
	// Internal Port FPGA Slave Side SPI Module Connect
	.oSMiso			(wSMisoMux),
	.iSRd			(qSRdMux),
	.iSAdrs			(qSAdrsMux),
	.iSCmd			(qSCmdMux),
	.iSDLen			(qSDLenMux),
	.iSREd			(qSREdMux),
	// Internal Port FPGA Slave Side Upper Module Connect
	.iMUsiRd		(iMUsiRd),
	.oMUsiWd		(oMUsiWd),
	.oMUsiAdrs		(oMUsiAdrs),
	.oMUsiWEd		(oMUsiWEd),
	// Ufi Bus Master Write
	.oMUfiWd		(oMUfiWd),
	.oMUfiAdrs		(oMUfiAdrs),
	.oMUfiEd		(oMUfiEd),
	.oMUfiVd		(oMUfiVd),
	.oMUfiCmd		(oMUfiCmd),
	// CLK Reset
	.iSCLK		(iSCLK),
	.iSRST		(iSRST)
);


//----------------------------------------------------------
// SPI 通信信号生成
//----------------------------------------------------------
// FPGA Slave Side
reg		[31:0]	qSMisoSig;
wire 	[31:0]	wSRdSig;
wire 	[31:0]	wSAdrsSig;
wire 	[2:0]	wSCmdSig;
wire 	[15:0]	wSDLenSig;
wire 			wSREdSig;

SPISignal # (
	.pTestPortUsed	(pTestPortUsed),
	.pTestPortNum	(pTestPortNum)
) SPISignal (
	// External Port
	.ioSpiSck		(ioSpiSck),
	.ioSpiMiso		(ioSpiMiso),
	.ioSpiMosi		(ioSpiMosi),
	.ioSpiWp		(ioSpiWp),
	.ioSpiHold		(ioSpiHold),
	.oSpiConfigCs	(oSpiConfigCs),
	.ioSpiCs		(ioSpiCs),
	.iMSSel			(iMSSel),
	// Internal Port FPGA Slave Side
	.iSMiso			(qSMisoSig),
	.oSRd			(wSRdSig),
	.oSAdrs			(wSAdrsSig),
	.oSCmd			(wSCmdSig),
	.oSDLen			(wSDLenSig),
	.oSREd			(wSREdSig),
	// Internal Port FPGA Master Side
	.iSPIEn			(iSPIEn),
	.iDivCke		(wDivCke),
	.iMWd			(iMWd),
	.oMRd			(oMRd),
	.oMSpiIntr		(oMSpiIntr),
	.iMSPICs		(iMSPICs),
	// Master Slave Select
	.oMSSel			(oMUsiSel),
	//
	.iSCLK		(iSCLK),
	.iSRST		(iSRST),
	//
	.oTestPort		(oTestPort)
);

always @*
begin
	qSMisoSig	<= wSMisoMux;
	qSRdMux 	<= wSRdSig;
	qSAdrsMux 	<= wSAdrsSig;
	qSCmdMux 	<= wSCmdSig;
	qSDLenMux 	<= wSDLenSig;
	qSREdMux 	<= wSREdSig;
end

endmodule