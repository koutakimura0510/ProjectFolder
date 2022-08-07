//----------------------------------------------------------
// Create 2022/8/3
// Author koutakimura
// -
// SPI 通信の制御を司るユニット
// 
//----------------------------------------------------------
module SPIUnit #(
	// variable parameter
	parameter				pBusAdrsBit	= 16,
	parameter 				pDivClk 	= 16
)(
	// External Port
    inout	          		ioSpiSck,
    inout           		ioSpiMiso,
    inout           		ioSpiMosi,
    inout           		ioSpiWp,
    inout           		ioSpiHold,
    output          		oSpiConfigCs,
    input	          		ioSpiCs1,
    input	          		ioSpiCs2,
    // Internal Port
	// Usi Bus Master to Slave Select
	output 								oMUsiMonopoly,	// 0. Slave として機能 / 1. Master バスを独占
	// Usi Bus Master Read
	input	[31:0]						iMUsiRd,	// RCmd 発行時に各ブロックのCSR値が入力される
	// input	[pBusSlaveConnectWidth:0]	iMUsiVd,	// Slave アクセス可能時 Assert
	// Usi Bus Master Write
	output	[31:0]						oMUsiWd,	// 書き込みデータ
	output	[pBusAdrsBit-1:0]			oMUsiAdrs,	// 書き込み元のアドレス指定
	output								oMUsiWCke,	// コマンド有効時 Assert
	// Ufi Bus Master Write

	// Ufi Bus Master Read

	// Csr
	input 								iSPIEn;
	input 	[lpDivClk-1:0]				iSPIDiv;
	input 	[31:0]						iSPIDeviceAdrs;
	input 	[11:0]						iSPINeglength;
    // CLK Reset
    input           					iSysClk,
    input           					iSysRst
);

//----------------------------------------------------------
// 指定分周値 の CKE 信号生成
//----------------------------------------------------------
wire wDivCke;

CkeGenerator #(
	.pDivReg	("yes"),
	.pDivWidth	(pDivClk)
) I2C_CKE_GEN (
	.iCke		(iSPIEn),
	.iDiv		(iSPIDiv),
	.oCke		(wDivCke),
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst)
);


//----------------------------------------------------------
// 
//----------------------------------------------------------
wire 		wTriState;
wire [7:0]	wSend;
wire [7:0]	wBufLen;
wire 		wBufVd;
wire 		wByteVd;
wire [7:0] 	wSdaByte;

SPISignalMux SPI_SIGNAL_MUX (
	.iSMiso			(iSMiso),
	.oSRd			(oSRd),
	.oSAdrs			(oSAdrs),
	.oSCmd			(oSCmd),
	.oSDLen			(oSDLen),
	.oSRdVd			(oSRdVd),
	.iSPIEn			(iSPIEn),
	.iDivCke		(wDivCke),
	.iMWd			(iMWd),
	.oMRd			(oMRd),
	.oMRdVd			(oMRdVd),
	.iMSpiCs1		(iMSpiCs1),
	.iMSpiCs2		(iMSpiCs2),
	.oMSSel			(oMSSel),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// SPI 通信信号生成
//----------------------------------------------------------
// Slave Side
reg		[31:0]	qSMiso;
wire 	[31:0]	wSRd;
wire 	[31:0]	wSAdrs;
wire 	[1:0]	wSCmd;
wire 	[15:0]	wSDLen;
wire 			wSRdVd;
// Master Side
reg 	[7:0]	qMWd;
wire 	[7:0]	wMRd;
wire 			wMRdVd;
reg 			qMSpiCs1;
reg 			qMSpiCs2;
// Master Slave Select
wire 			wMSSel;

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
	// Internal Port Slave Side
	.iSMiso			(qSMiso),
	.oSRd			(wSRd),
	.oSAdrs			(wSAdrs),
	.oSCmd			(wSCmd),
	.oSDLen			(wSDLen),
	.oSRdVd			(wSRdVd),
	// Internal Port Master Side
	.iSPIEn			(iSPIEn),
	.iDivCke		(wDivCke),
	.iMWd			(qMWd),
	.oMRd			(wMRd),
	.oMRdVd			(wMRdVd),
	.iMSpiCs1		(qMSpiCs1),
	.iMSpiCs2		(qMSpiCs2),
	// Master Slave Select
	.oMSSel			(wMSSel),
	//
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

always @*
begin
	// qSMiso
	// qMWd
	// qMSpiCs1
	// qMSpiCs2
end

endmodule