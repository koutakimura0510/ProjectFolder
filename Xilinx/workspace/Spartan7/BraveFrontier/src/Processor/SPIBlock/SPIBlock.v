//----------------------------------------------------------
// Create 2022/8/2
// Author koutakimura
// -
// SPI の管理を司るブロック
// ioSpiCs2 GPIO は FPGA SPI の Master / Slave を切り替える役割も持つ
// Reset 終了時の I/O の状態を確認し、High Master / Low Slave とする
// 通常はフラッシュメモリと接続されるが、デバッグ時は RaspberryPi と接続するためこの機能を設けた。
// 
//----------------------------------------------------------
module SPIBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h03,
	parameter						pBusAdrsBit		= 'd32	// 
)(
	// External Port
    inout	          			ioSpiSck,
    inout           			ioSpiMiso,
    inout           			ioSpiMosi,
    inout           			ioSpiWp,
    inout           			ioSpiHold,
    output          			oSpiConfigCs,
    input	          			ioSpiCs1,
    input	          			ioSpiCs2,
    // Internal Port
	// Bus Slave Read
	output	[31:0]				oSUsiRd,	// アドレス一致 かつ RCmd 発行時データ出力
	output						oSUsiVd,	// アクセス可能時 Assert
	// Bus Slave Write
	input	[31:0]				iSUsiWd,	// Master からの書き込みデータ
	input	[pBusAdrsBit-1:0]	iSUsiAdrs,	
	input						iSUsiWCke,	// コマンド有効時 Assert
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpDivClk = 16;	// SCL生成の分周値レジスタBit幅


//----------------------------------------------------------
// I2C Unit
//----------------------------------------------------------
reg 						qSPIEnUnit;
reg 	[lpDivClk-1:0]		qSPIDivUnit;
reg 	[31:0]				qSPIDeviceAdrsUnit;
reg 	[11:0]				qSPINeglengthUnit;

SPIUnit #(
	.pDivClk		(lpDivClk)
) SPI_UNIT (
	.iioSpiSck		(iioSpiSck),
	.ioSpiMiso		(ioSpiMiso),
	.ioSpiMosi		(ioSpiMosi),
	.ioSpiWp		(ioSpiWp),
	.ioSpiHold		(ioSpiHold),
	.oSpiConfigCs	(oSpiConfigCs),
	.ioSpiCs1		(ioSpiCs1),
	.ioSpiCs2		(ioSpiCs2),
	.iSPIEn			(qSPIEnUnit),
	.iSPIDiv		(qSPIDivUnit),
	.iSPIDeviceAdrs	(qSPIDeviceAdrsUnit),
	.iSPINeglength	(qSPINeglengthUnit),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 					wSPIEnCsr;
wire 	[lpDivClk-1:0]	wSPIDivCsr;
wire 	[31:0]			wSPIDeviceAdrsCsr;
wire 	[11:0]			wSPINeglengthCsr;

SPICsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit),
	.pDivClk		(lpDivClk)
) SPI_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiVd		(oSUsiVd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.oSPIEn			(wSPIEnCsr),
	.oSPIDiv		(wSPIDivCsr),
	.oDeviceAdrs	(wSPIDeviceAdrsCsr),
	.oNeglength		(wSPINeglengthCsr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

always @*
begin
	qSPIEnUnit			<= wSPIEnCsr;
	qSPIDivUnit			<= wSPIDivCsr;
	qSPIDeviceAdrsUnit	<= wSPIDeviceAdrsCsr;
	qSPINeglengthUnit	<= wSPINeglengthCsr;
end


endmodule