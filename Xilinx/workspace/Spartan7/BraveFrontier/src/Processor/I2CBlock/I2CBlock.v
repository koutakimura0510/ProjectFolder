//----------------------------------------------------------
// Create 2022/7/25
// Author koutakimura
// -
// I2C の管理を司るブロック
// 
//----------------------------------------------------------
module I2CBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h04,	
	parameter						pBusAdrsBit		= 'd32	// 32bit ならば (32-1)31 を指定
)(
	// External Port
	output						oI2CScl,
	inout 						ioI2CSda,
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
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
wire 						wI2CEnCsr;
wire 	[lpI2CDivClk-1:0]	wI2CDivCsr;
reg		[15:0]				qI2CGetKeyPadCsr;
reg  						qI2CSeqCompCsr;

I2CCsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit),
	.pI2CDivClk		(lpI2CDivClk)
) I2C_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiVd		(oSUsiVd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.iI2CGetKeyPad	(qI2CGetKeyPadCsr),
	.iI2CSeqComp	(qI2CSeqCompCsr),
	.oI2CEn			(wI2CEnCsr),
	.oI2CDiv		(wI2CDivCsr),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

always @*
begin
	qI2CEnUnit			<= wI2CEnCsr;
	qI2CDivUnit			<= wI2CDivCsr;
	qI2CGetKeyPadCsr	<= wI2CGetKeyPadUnit;
	qI2CSeqCompCsr		<= wI2CSeqCompUnit;
end


endmodule