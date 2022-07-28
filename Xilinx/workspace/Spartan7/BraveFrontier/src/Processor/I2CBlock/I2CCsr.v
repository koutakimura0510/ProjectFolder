//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module I2CCsr #(
	// variable parameter
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h01,
	parameter						pBusAdrsBit		= 'd31,
	parameter 						pI2CDivClk = 15
)(
    // Internal Port
	// Csr Read
	output	[31:0]			oSUsiRd,
	output 					oSUsiVd,
	// Csr Write
	input	[31:0]			iSUsiWd,	// 書き込みデータ
	input	[pBusAdrsBit:0]	iSUsiAdrs,
	input					iSUsiWCke,	// コマンド有効時 Assert
	// Csr Input
	input 	[15:0]			iI2CGetKeyPad,
	// Csr Output
	output 					oI2cEn,
	output 	[15:0]			oI2cDiv,
	output	[23:0]			oI2CSAdrs,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);



//----------------------------------------------------------
// Regi
//----------------------------------------------------------
// USI/F Write
reg 					rI2CEn;				assign oI2cEn 			= rI2CEn;			// I2C 通信開始, Enable 1 の間、Adrs1 ~ 3 に設定した Slave に順番に繰り返し通信を行う
reg [pI2CDivClk:0]		rI2CDiv;			assign oI2cDiv 		 	= rI2CDiv;			// I2C CLK Division
reg [23:0]				rI2CSAdrs;			assign oI2CSAdrs 	 	= rI2CSAdrs;		// Slave Address [23:16] Sensor / [15:8] Right Controller / [7:0] Left Controller
// Upper module Write
reg [15:0]		rI2CGetKeyPad;		// Slave のコントローラーデータを保存
// reg [23:0]		rI2CGetGyro;	// Slave のジャイロセンサデータを保存
//
reg [pBusAdrsBit + 1:0]	qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin

	end
	else
	begin
		rI2CEn				<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[ 0:0] 			: rI2CEn;
		rI2CDiv				<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[pI2CDivClk:0] 	: rI2CDiv;
		rI2CSAdrs			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h08}) ? iSUsiWd[23:0] 			: rI2CSAdrs;
		rI2CGetKeyPad		<= iI2CGetKeyPad;
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
			'h100:		rSUsiRd <= {31'd0, rI2CEn};
			'h104:		rSUsiRd <= {{(31 - pI2CDivClk){1'b0}}, rI2CDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
			'h108:		rSUsiRd <= { 8'd0, rI2CSAdrs};
			'h180:		rSUsiRd <= {16'd0, rI2CGetKeyPad};
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