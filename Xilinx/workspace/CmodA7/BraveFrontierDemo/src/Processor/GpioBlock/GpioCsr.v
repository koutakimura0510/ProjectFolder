//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module GpioCsr #(
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h01,
	parameter						pBusAdrsBit		= 'd32,
	// variable csr bit width
	parameter 						pExLedNumber	= 5,	// 外部 LED の数
	parameter 						pExLedFlashMode	= 2		// モード数の Bit幅
	parameter 						pPWMDutyWidth	= 16,	// PWM の分解能
	parameter 						pIVtimerWidth	= 16,	// インターバルタイマ分周値
)(
    // Internal Port
	// Csr Read
	output	[31:0]					oSUsiRd,	// Read Data
	output							oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]					iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]		iSUsiAdrs,  // R/W Adrs
	input							iSUsiWCke,	// Write Enable
	// Csr Output
	output 	[pExLedNumber-1:0]		oGpioEn,
	output	[pExLedFlashMode-1:0]	oGpioFlashMode,
	output  [pPWMDutyWidth-1:0]		oGpioDuty,
	output  [pIVtimerWidth-1:0]		oGpioIVtimer,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pExLedNumber-1:0]		rGpioEn;			assign 	oGpioEn  		= rGpioEn;			// 汎用 GPIO ON/OFF 制御
reg [pExLedFlashMode-1:0]	rGpioFlashMode;		assign 	oGpioFlashMode	= rGpioFlashMode;	// GPIO の点灯方法
reg [pPWMDutyWidth-1:0]		rGpioDuty;			assign	oGpioDuty		= rGpioDuty;		// 上位ビット, 下位ビット
reg [pIVtimerWidth-1:0]		rGpioIVtimer;		assign	oGpioIVtimer	= rGpioIVtimer;
//
reg [pBusAdrsBit:0]		qCsrAdrs; // CKE + Adrs
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rGpioEn			<= {pExLedNumber{1'b0}};
		rGpioFlashMode 	<= {pExLedFlashMode{1'b0}};
		rGpioDuty		<= {pPWMDutyWidth{1'b0}};
		rGpioIVtimer	<= {pIVtimerWidth{1'b0}};
	end
	else
	begin
		rGpioEn			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[pExLedNumber-1:0] 	: rGpioEn;
		rGpioFlashMode	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[pExLedFlashMode-1:0] : rGpioFlashMode;
		rGpioDuty		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h08}) ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDuty;
		rGpioIVtimer	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h0c}) ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer;
	end
end

always @*
begin
	qCsrAdrs <= {iSUsiWCke, iSUsiAdrs};
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd  = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd <= 'h0;
		rSUsiREd <= 1'b0;
	end
	else
	begin
		// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
		case ({qAdrsComp, iSUsiAdrs[7:0]})
			'h100:		rSUsiRd <= {{(32 - pExLedNumber		){1'b0}}, rGpioEn};
			'h104:		rSUsiRd <= {{(32 - pExLedFlashMode	){1'b0}}, rGpioFlashMode};
			'h108:		rSUsiRd <= {{(32 - pPWMDutyWidth	){1'b0}}, rGpioDuty};
			'h10c:		rSUsiRd <= {{(32 - pIVtimerWidth	){1'b0}}, rGpioIVtimer};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + 3'd7:8] == pAdrsMap};
end

endmodule