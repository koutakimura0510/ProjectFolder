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
	parameter 						pBlockAdrsMap 	= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h01,
	parameter						pBusAdrsBit		= 16,
	parameter 						pCsrAdrsWidth	= 8,
	parameter						pCsrActiveWidth = 8,
	// variable csr bit width
	parameter 						pExLedNumber	= 5,	// 外部 LED の数
	parameter 						pExLedFlashMode	= 2,	// モード数の Bit幅
	parameter 						pPWMDutyWidth	= 8,
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
	output  [pPWMDutyWidth-1:0]		oGpioDutyRatio0,
	output  [pPWMDutyWidth-1:0]		oGpioDutyRatio1,
	output  [pPWMDutyWidth-1:0]		oGpioDutyRatio2,
	output  [pPWMDutyWidth-1:0]		oGpioDutyRatio3,
	output  [pPWMDutyWidth-1:0]		oGpioDutyRatio4,
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
reg [pExLedFlashMode-1:0]	rGpioFlashMode;		assign 	oGpioFlashMode	= rGpioFlashMode;	// 汎用 GPIO の点灯方法
reg [pPWMDutyWidth-1:0]		rGpioDutyRatio0;	assign	oGpioDutyRatio0	= rGpioDutyRatio0;	// Duty 比率 0
reg [pPWMDutyWidth-1:0]		rGpioDutyRatio1;	assign	oGpioDutyRatio1	= rGpioDutyRatio1;	// Duty 比率 1
reg [pPWMDutyWidth-1:0]		rGpioDutyRatio2;	assign	oGpioDutyRatio2	= rGpioDutyRatio2;	// Duty 比率 2
reg [pPWMDutyWidth-1:0]		rGpioDutyRatio3;	assign	oGpioDutyRatio3	= rGpioDutyRatio3;	// Duty 比率 3
reg [pPWMDutyWidth-1:0]		rGpioDutyRatio4;	assign	oGpioDutyRatio4	= rGpioDutyRatio4;	// Duty 比率 4

reg [pIVtimerWidth-1:0]		rGpioIVtimer0;		assign	oGpioIVtimer0	= rGpioIVtimer0;	// インターバルタイマ0 分周器
reg [pIVtimerWidth-1:0]		rGpioIVtimer1;		assign	oGpioIVtimer1	= rGpioIVtimer1;	// インターバルタイマ1 分周器
reg [pIVtimerWidth-1:0]		rGpioIVtimer2;		assign	oGpioIVtimer2	= rGpioIVtimer2;	// インターバルタイマ2 分周器
reg [pIVtimerWidth-1:0]		rGpioIVtimer3;		assign	oGpioIVtimer3	= rGpioIVtimer3;	// インターバルタイマ3 分周器
reg [pIVtimerWidth-1:0]		rGpioIVtimer4;		assign	oGpioIVtimer4	= rGpioIVtimer4;	// インターバルタイマ4 分周器
//
reg 						qCsrWCke00;
reg 						qCsrWCke04;
reg 						qCsrWCke08;
reg 						qCsrWCke0c;
reg 						qCsrWCke10;
reg 						qCsrWCke14;
reg 						qCsrWCke18;
reg 						qCsrWCke1c;
reg 						qCsrWCke20;
reg 						qCsrWCke24;
reg 						qCsrWCke28;
reg 						qCsrWCke2c;
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rGpioEn			<= {pExLedNumber{1'b0}};
		rGpioFlashMode 	<= {pExLedFlashMode{1'b0}};
		rGpioDutyRatio0 <= {pPWMDutyWidth{1'b0}};
		rGpioDutyRatio1 <= {pPWMDutyWidth{1'b0}};
		rGpioDutyRatio2 <= {pPWMDutyWidth{1'b0}};
		rGpioDutyRatio3 <= {pPWMDutyWidth{1'b0}};
		rGpioDutyRatio4 <= {pPWMDutyWidth{1'b0}};
		rGpioIVtimer0	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer1	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer2	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer3	<= {pIVtimerWidth{1'b1}};
		rGpioIVtimer4	<= {pIVtimerWidth{1'b1}};
	end
	else
	begin
		rGpioEn			<= qCsrWCke00 ? iSUsiWd[pExLedNumber-1:0] 	: rGpioEn;
		rGpioFlashMode	<= qCsrWCke04 ? iSUsiWd[pExLedFlashMode-1:0] : rGpioFlashMode;
		rGpioDutyRatio0	<= qCsrWCke08 ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDutyRatio0;
		rGpioDutyRatio1	<= qCsrWCke0c ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDutyRatio1;
		rGpioDutyRatio2	<= qCsrWCke10 ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDutyRatio2;
		rGpioDutyRatio3	<= qCsrWCke14 ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDutyRatio3;
		rGpioDutyRatio4	<= qCsrWCke18 ? iSUsiWd[pPWMDutyWidth-1:0] 	: rGpioDutyRatio4;
		rGpioIVtimer0	<= qCsrWCke1c ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer0;
		rGpioIVtimer1	<= qCsrWCke20 ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer1;
		rGpioIVtimer2	<= qCsrWCke24 ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer2;
		rGpioIVtimer3	<= qCsrWCke28 ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer3;
		rGpioIVtimer4	<= qCsrWCke2c ? iSUsiWd[pIVtimerWidth-1:0] 	: rGpioIVtimer4;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
	qCsrWCke10 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke14 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke18 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke1c <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke20 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke24 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke28 <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke2c <= iSUsiWCke & (iSUsiAdrs[pAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
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
		case (iSUsiAdrs[pCsrActiveWidth-1:0])
			'h00:		rSUsiRd <= {{(32 - pExLedNumber		){1'b0}}, rGpioEn};
			'h04:		rSUsiRd <= {{(32 - pExLedFlashMode	){1'b0}}, rGpioFlashMode};
			'h08:		rSUsiRd <= {{(32 - pPWMDutyWidth	){1'b0}}, rGpioDutyRatio0};
			'h0c:		rSUsiRd <= {{(32 - pPWMDutyWidth	){1'b0}}, rGpioDutyRatio1};
			'h10:		rSUsiRd <= {{(32 - pPWMDutyWidth	){1'b0}}, rGpioDutyRatio2};
			'h14:		rSUsiRd <= {{(32 - pPWMDutyWidth	){1'b0}}, rGpioDutyRatio3};
			'h18:		rSUsiRd <= {{(32 - pPWMDutyWidth	){1'b0}}, rGpioDutyRatio4};
			'h1c:		rSUsiRd <= {rGpioIVtimer0};
			'h20:		rSUsiRd <= {rGpioIVtimer1};
			'h24:		rSUsiRd <= {rGpioIVtimer2};
			'h28:		rSUsiRd <= {rGpioIVtimer3};
			'h2c:		rSUsiRd <= {rGpioIVtimer4};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1 : pCsrAdrsWidth] == pAdrsMap};
end

endmodule