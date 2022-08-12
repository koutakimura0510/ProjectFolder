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
	parameter						pBusAdrsBit		= 'd32
)(
    // Internal Port
	// Csr Read
	output	[31:0]				oSUsiRd,	// Read Data
	output						oSUsiVd,	// Read Valid Assert
	// Bus Slave Write
	input	[31:0]				iSUsiWd,	// Write Data
	input	[pBusAdrsBit-1:0]	iSUsiAdrs,  // R/W Adrs
	input						iSUsiWCke,	// Write Enable
	// Csr Output
	output 	[7:0]				oGpioLed,
	output 	[7:0]				oGpioDiv,
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [ 7:0]		rGpioLed;		assign oGpioLed  = rGpioLed;	// 汎用 GPIO ON/OFF 制御
reg [ 7:0]		rGpioDiv;		assign oGpioDiv = rGpioDiv;	// 汎用 GPIO 動作周波数
//
reg [pBusAdrsBit:0]		qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rGpioLed	<= 8'hff;
		rGpioDiv	<= 8'h5;	// default 50MHz / 5 = 10MHz
	end
	else
	begin
		// {rGpioDiv, rGpioLed}	<= (qCsrAdrs == 33'h1_0000_0100) ? iSUsiWd[15:0] : {rGpioDiv, rGpioLed};
		{rGpioDiv, rGpioLed}	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[15:0] : {rGpioDiv, rGpioLed};
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
reg 			rSUsiVd;		assign oSUsiVd = rSUsiVd;
reg 			qAdrsComp;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSUsiRd <= 'h0;
		rSUsiVd <= 1'b0;
	end
	else
	begin
		case ({qAdrsComp, iSUsiAdrs[7:0]})
			'h100:		rSUsiRd <= {16'd0, rGpioDiv, rGpioLed};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiVd <= 1'b0;
	else if (qAdrsComp)	rSUsiVd <= 1'b1;
	else				rSUsiVd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + 3'd7:8] == pAdrsMap};
end

endmodule