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
	parameter 						pExLedFlashMode	= 2,	// モード数の Bit幅
	parameter 						pPWMDutyWidth	= 16,	// PWM の分解能
	parameter 						pIVtimerWidth	= 16	// インターバルタイマ分周値
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
	output  [pPWMDutyWidth-1:0]		oGpioDuty0,
	output  [pPWMDutyWidth-1:0]		oGpioDuty1,
	output  [pPWMDutyWidth-1:0]		oGpioDuty2,
	output  [pPWMDutyWidth-1:0]		oGpioDuty3,
	output  [pPWMDutyWidth-1:0]		oGpioDuty4,
	output  [pIVtimerWidth-1:0]		oGpioIVtimer0,
	output  [pIVtimerWidth-1:0]		oGpioIVtimer1,
	output  [pIVtimerWidth-1:0]		oGpioIVtimer2,
	output  [pIVtimerWidth-1:0]		oGpioIVtimer3,
	output  [pIVtimerWidth-1:0]		oGpioIVtimer4,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pExLedNumber-1:0]		rGpioEn;			assign 	oGpioEn  		= rGpioEn;			// 汎用 GPIO ON/OFF 制御
reg [pExLedFlashMode-1:0]	rGpioFlashMode;		assign 	oGpioFlashMode	= rGpioFlashMode;	// GPIO の点灯方法
reg [pPWMDutyWidth-1:0]		rGpioDuty0;			assign	oGpioDuty0		= rGpioDuty0;		// Duty比
reg [pPWMDutyWidth-1:0]		rGpioDuty1;			assign	oGpioDuty1		= rGpioDuty1;
reg [pPWMDutyWidth-1:0]		rGpioDuty2;			assign	oGpioDuty2		= rGpioDuty2;
reg [pPWMDutyWidth-1:0]		rGpioDuty3;			assign	oGpioDuty3		= rGpioDuty3;
reg [pPWMDutyWidth-1:0]		rGpioDuty4;			assign	oGpioDuty4		= rGpioDuty4;
reg [pIVtimerWidth-1:0]		rGpioIVtimer0;		assign	oGpioIVtimer0	= rGpioIVtimer0;	// インターバルタイマ 分周器
reg [pIVtimerWidth-1:0]		rGpioIVtimer1;		assign	oGpioIVtimer1	= rGpioIVtimer1;
reg [pIVtimerWidth-1:0]		rGpioIVtimer2;		assign	oGpioIVtimer2	= rGpioIVtimer2;
reg [pIVtimerWidth-1:0]		rGpioIVtimer3;		assign	oGpioIVtimer3	= rGpioIVtimer3;
reg [pIVtimerWidth-1:0]		rGpioIVtimer4;		assign	oGpioIVtimer4	= rGpioIVtimer4;
//
reg [pBusAdrsBit:0]		qCsrAdrs; // CKE + Adrs
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rGpioEn			<= {pExLedNumber{1'b0}};
		rGpioFlashMode 	<= {pExLedFlashMode{1'b0}};
		rGpioDuty0		<= {pPWMDutyWidth{1'b0}};
		rGpioDuty1		<= {pPWMDutyWidth{1'b0}};
		rGpioDuty2		<= {pPWMDutyWidth{1'b0}};
		rGpioDuty3		<= {pPWMDutyWidth{1'b0}};
		rGpioDuty4		<= {pPWMDutyWidth{1'b0}};
		rGpioIVtimer0	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer1	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer2	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer3	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer4	<= {pIVtimerWidth{1'b1}};
	end
	else
	begin
		rGpioEn			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[pExLedNumber-1:0] 	: rGpioEn;
		rGpioFlashMode	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[pExLedFlashMode-1:0] : rGpioFlashMode;
		rGpioDuty0		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h08}) ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDuty0;
		rGpioDuty1		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h0c}) ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDuty1;
		rGpioDuty2		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h10}) ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDuty2;
		rGpioDuty3		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h14}) ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDuty3;
		rGpioDuty4		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h18}) ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDuty4;
		rGpioIVtimer0	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h1c}) ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer0;
		rGpioIVtimer1	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h20}) ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer1;
		rGpioIVtimer2	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h24}) ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer2;
		rGpioIVtimer3	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h28}) ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer3;
		rGpioIVtimer4	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h2c}) ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer4;
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
			'h108:		rSUsiRd <= {{(32 - pPWMDutyWidth	){1'b0}}, rGpioDuty0};
			'h10c:		rSUsiRd <= {rGpioDuty1};
			'h110:		rSUsiRd <= {rGpioDuty2};
			'h114:		rSUsiRd <= {rGpioDuty3};
			'h118:		rSUsiRd <= {rGpioDuty4};
			'h11c:		rSUsiRd <= {rGpioIVtimer0};
			'h120:		rSUsiRd <= {rGpioIVtimer1};
			'h124:		rSUsiRd <= {rGpioIVtimer2};
			'h128:		rSUsiRd <= {rGpioIVtimer3};
			'h12c:		rSUsiRd <= {rGpioIVtimer4};
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