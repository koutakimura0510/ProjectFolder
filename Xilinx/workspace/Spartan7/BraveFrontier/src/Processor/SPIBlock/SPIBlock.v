//----------------------------------------------------------
// Create 2022/8/2
// Author koutakimura
// -
// SPI の管理を司るブロック
// 
//----------------------------------------------------------
module SPIBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h03,
	parameter						pBusAdrsBit		= 'd32	// 32bit ならば (32-1)31 を指定
)(
	// External Port
    output          			ioSpiSck,
    inout           			ioSpiMiso,
    inout           			ioSpiMosi,
    inout           			ioSpiWp,
    inout           			ioSpiHold,
    output          			oSpiConfigCs,
    output          			oSpiCs1,
    output          			oSpiCs2,
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
localparam lpI2CDivClk = 16;	// SCL生成の分周値レジスタBit幅


//----------------------------------------------------------
// I2C Unit
//----------------------------------------------------------
reg 					qI2CUnitEn;
reg [lpI2CDivClk-1:0]	qI2CUnitDiv;
wire [15:0]				wI2CGetKeyPad;

I2CUnit #(
	.pI2CDivClk		(lpI2CDivClk)
) I2C_UNIT (
	.oI2CScl		(oI2CScl),
	.ioI2CSda		(ioI2CSda),
	.iI2CEn			(qI2CUnitEn),
	.iI2CDiv		(qI2CUnitDiv),
	.oI2CGetKeyPad	(wI2CGetKeyPad),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 						wI2CCsrEn;
wire 	[lpI2CDivClk-1:0]	wI2CCsrDiv;
reg		[15:0]				qI2CGetKeyPad;

SPICsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit),
	.pI2CDivClk		(lpI2CDivClk)
) SPI_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiVd		(oSUsiVd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.iI2CGetKeyPad	(qI2CGetKeyPad),
	.oI2CEn			(wI2CCsrEn),
	.oI2CDiv		(wI2CCsrDiv),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

always @*
begin
	qI2CUnitEn		<= wI2CCsrEn;
	qI2CUnitDiv		<= wI2CCsrDiv;
	qI2CGetKeyPad	<= wI2CGetKeyPad;
end


endmodule