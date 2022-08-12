//----------------------------------------------------------
// Create 2022/7/31
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module PWMCsr #(
	// variable parameter
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h02,
	parameter						pBusAdrsBit		= 'd32,
	parameter 						pPWMDutyWidth	= 'd16,	// PWM の分解能
	parameter 						pIVtimerWidth	= 'd16	// インターバルタイマ分周値
)(
    // Internal Port
	// Csr Read
	output	[31:0]				oSUsiRd,	// Read Data
	output						oSUsiREd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]				iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]	iSUsiAdrs,  // R/W Adrs
	input						iSUsiWCke,	// Write Enable
	// Csr Output
	output 						oPWMEn,
	output 	[pPWMDutyWidth-1:0]	oPWMDuty,
	output	[pIVtimerWidth-1:0]	oIVtimer,
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);



//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
// USI/F Write
reg 					rPWMEn;				assign oPWMEn 	= rPWMEn;			// PWM 出力開始
reg [pPWMDutyWidth-1:0]	rPWMDuty;			assign oPWMDuty	= rPWMDuty;			// PWM CLK Division
reg [pIVtimerWidth-1:0]	rIVtimer;			assign oIVtimer	= rIVtimer;			// PWM CLK Division
//
reg [pBusAdrsBit:0]	qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rPWMEn			<= 1'b0;
		rPWMDuty		<= {pPWMDutyWidth{1'b1}};
		rIVtimer		<= {pIVtimerWidth{1'b1}};
	end
	else
	begin
		rPWMEn			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[ 0:0] 		      : rPWMEn;
		rPWMDuty		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[pPWMDutyWidth-1:0] : rPWMDuty;
		rIVtimer		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h08}) ? iSUsiWd[pIVtimerWidth-1:0] : rIVtimer;
	end
end

always @*
begin
	qCsrAdrs <= {iSUsiWCke, iSUsiAdrs};
end

//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [31:0]		rSUsiRd;		assign oSUsiRd = rSUsiRd;
reg 			rSUsiREd;		assign oSUsiREd = rSUsiREd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd <= 'h0;
	end
	else
	begin
		case ({qAdrsComp, iSUsiAdrs[7:0]})
			'h100:		rSUsiRd <= {31'd0, rPWMEn};
			'h104:		rSUsiRd <= {{(32 - pPWMDutyWidth){1'b0}}, rPWMDuty};	// パラメータ可変なので、可変に対応して0で埋めるようにした
			'h108:		rSUsiRd <= {{(32 - pIVtimerWidth){1'b0}}, rIVtimer};	// パラメータ可変なので、可変に対応して0で埋めるようにした
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