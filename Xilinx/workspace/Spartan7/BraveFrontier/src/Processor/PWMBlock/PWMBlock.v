//----------------------------------------------------------
// Create 2022/7/31
// Author koutakimura
// -
// PWM の管理を司るブロック
// 
//----------------------------------------------------------
module PWMBlock #(
	parameter 						pBlockAdrsMap 	= 'd8,	// ブロックのアドレス幅を指定
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h02,
	parameter						pBusAdrsBit		= 'd31	// 32bit ならば (32-1)31 を指定
)(
	// External Port
	output					oPwm,
    // Internal Port
	// Bus Slave Read
	output	[31:0]			oSUsiRd,	// アドレス一致 かつ RCmd 発行時データ出力
	output					oSUsiVd,	// アクセス可能時 Assert
	// Bus Slave Write
	input	[31:0]			iSUsiWd,	// Master からの書き込みデータ
	input	[pBusAdrsBit:0]	iSUsiAdrs,	// {31:30} / 0.Cmd 無効, 1. WriteCmd, 2. ReadCmd, 3.WRCmd (*)未実装 / {23:16} Busアドレス / {15:0} Csrアドレス
	input					iSUsiWCke,	// コマンド有効時 Assert
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// Csr ビット幅
//----------------------------------------------------------
localparam lpPWMDivWidth = 7;	// SCL生成の分周値レジスタBit幅


//----------------------------------------------------------
// PWM Unit
//----------------------------------------------------------
wire 						wPWMCsrEn;
wire 	[lpPWMDivWidth:0]	wPWMCsrDiv;
//
reg 	[lpPWMDivWidth:0] rDivCnt;
reg 	rPwm;							assign oPwm = rPwm;
//
reg		qCntCompare;

always @(posedge iSysClk)
begin
	if (iSysRst) 		rDivCnt <= {lpPWMDivWidth{1'b0}};
	else if (wPWMCsrEn)	rDivCnt <= rDivCnt + 1'b1;
	else 				rDivCnt <= {lpPWMDivWidth{1'b0}};

	if (qCntCompare)	rPwm <= 1'b1;
	else 				rPwm <= 1'b0;

end

always @*
begin
	qCntCompare <= (wPWMCsrDiv < rDivCnt);
end


//----------------------------------------------------------
// Csr space
//----------------------------------------------------------
PWMCsr #(
	.pBlockAdrsMap	(pBlockAdrsMap),
	.pAdrsMap		(pAdrsMap),
	.pBusAdrsBit	(pBusAdrsBit),
	.pPWMDivWidth	(lpPWMDivWidth)
) PWM_CSR (
	.oSUsiRd		(oSUsiRd),
	.oSUsiVd		(oSUsiVd),
	.iSUsiWd		(iSUsiWd),
	.iSUsiAdrs		(iSUsiAdrs),
	.iSUsiWCke		(iSUsiWCke),
	.oPWMEn			(wPWMCsrEn),
	.oPWMDiv		(wPWMCsrDiv),
	.iSysClk		(iSysClk),
	.iSysRst		(iSysRst)
);

endmodule