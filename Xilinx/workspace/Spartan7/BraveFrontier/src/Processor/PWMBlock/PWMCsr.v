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
	parameter						pBusAdrsBit		= 'd31,
	parameter 						pPWMDivWidth	= 'd15	// PWM の分解能
)(
    // Internal Port
	// Csr Read
	output	[31:0]			oSUsiRd,
	output 					oSUsiVd,
	// Csr Write
	input	[31:0]			iSUsiWd,	// 書き込みデータ
	input	[pBusAdrsBit:0]	iSUsiAdrs,
	input					iSUsiWCke,	// コマンド有効時 Assert
	// Csr Output
	output 					oPWMEn,
	output 	[15:0]			oPWMDiv,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);



//----------------------------------------------------------
// Regi
//----------------------------------------------------------
// USI/F Write
reg 					rPWMEn;				assign oPWMEn 	= rPWMEn;			// PWM 出力開始
reg [pPWMDivWidth:0]	rPWMDiv;			assign oPWMDiv 	= rPWMDiv;			// PWM CLK Division
//
reg [pBusAdrsBit + 1:0]	qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rPWMEn			<= 1'b0;
		rPWMDiv			<= {(pPWMDivWidth + 1){1'b1}};
	end
	else
	begin
		rPWMEn			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[ 0:0] 			: rPWMEn;
		rPWMDiv			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[pPWMDivWidth:0] 	: rPWMDiv;
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
	end
	else
	begin
		case ({qAdrsComp, iSUsiAdrs[7:0]})
			'h100:		rSUsiRd <= {31'd0, rPWMEn};
			'h104:		rSUsiRd <= {{(31 - pPWMDivWidth){1'b0}}, rPWMDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
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