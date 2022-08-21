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
	parameter 						pPWMDutyWidth	= 'd16,	// PWM の分解能
	parameter 						pIVtimerWidth	= 'd16	// インターバルタイマ分周値
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
	output 	[7:0]					oGpioEn,
	output	[3:0]					oGpioFlashMode,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [ 7:0]					rGpioEn;			assign 	oGpioEn  		= rGpioEn;			// 汎用 GPIO ON/OFF 制御
reg [ 3:0]					rGpioFlashMode;		assign 	oGpioFlashMode	= rGpioFlashMode;	// GPIO の点灯方法
reg [(pPWMDutyWidth*2)-1:0] rGpioDuty;			assign	oGpioDuty		= rGpioDuty;
reg [(pIVtimerWidth*2)-1:0] rGpioIVtimer;		assign	oGpioIVtimer	= rGpioIVtimer;
//
reg [pBusAdrsBit:0]		qCsrAdrs;
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rGpioEn		<= 8'hff;
		rGpioFlashMode 	<= 4'd0;
	end
	else
	begin
		rGpioEn			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[7:0] : rGpioEn;
		rGpioFlashMode	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[3:0] : rGpioFlashMode;
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
		case ({qAdrsComp, iSUsiAdrs[7:0]})
			'h100:		rSUsiRd <= {24'd0, rGpioEn};
			'h104:		rSUsiRd <= {28'd0, rGpioFlashMode};
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