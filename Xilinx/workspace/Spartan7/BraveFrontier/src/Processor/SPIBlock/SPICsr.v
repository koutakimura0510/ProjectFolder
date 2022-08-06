//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module SPICsr #(
	// variable parameter
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap	  	= 'h03,
	parameter						pBusAdrsBit		= 'd32,
	parameter 						pDivClk 		= 'd16
)(
    // Internal Port
	// Csr Read
	output	[31:0]				oSUsiRd,
	output 						oSUsiVd,
	// Csr Write
	input	[31:0]				iSUsiWd,	// 書き込みデータ
	input	[pBusAdrsBit-1:0]	iSUsiAdrs,
	input						iSUsiWCke,	// コマンド有効時 Assert
	// Csr Input
	// input 	[15:0]				iI2CGetKeyPad,
	// Csr Output
	output 						oSPIEn,
	output 	[pDivClk-1:0]		oSPIDiv,
	output	[31:0]				oDeviceAdrs,
	output	[11:0]				oNeglength,
    // CLK Reset
    input           			iSysClk,
    input           			iSysRst
);



//----------------------------------------------------------
// Csr Write
//----------------------------------------------------------
// USI/F Write
reg 					rSPIEn;				assign oSPIEn 		= rSPIEn;			// 通信開始, 一度 clearしなければ 通信を再開始できないようにする
reg [pDivClk-1:0]		rSPIDiv;			assign oSPIDiv 		= rSPIDiv;			// CLK Division
reg [31:0]				rDeviceAdrs;		assign oDeviceAdrs 	= rDeviceAdrs;		// Device のアクセスアドレス
reg [11:0]				rNeglength;			assign oNeglength	= rNeglength;		// 一度に行うネゴシエーションの回数
//
reg [pBusAdrsBit:0]	qCsrAdrs;

always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rSPIEn			<= 1'b0;
		rSPIDiv			<= {pDivClk{1'b1}};
		rI2CGetKeyPad	<= 16'd0;
	end
	else
	begin
		rSPIEn			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? iSUsiWd[ 0:0] 			: rSPIEn;
		rSPIDiv			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? iSUsiWd[pDivClk-1:0] 	: rSPIDiv;
		rDeviceAdrs		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h08}) ? iSUsiWd[31:0]			: rDeviceAdrs;
		rNeglength		<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h0c}) ? iSUsiWd[11:0]		 	: rNeglength;
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
			'h100:		rSUsiRd <= {31'd0, rSPIEn};
			'h104:		rSUsiRd <= {{(32 - pDivClk){1'b0}}, rSPIDiv};	// パラメータ可変なので、可変に対応して0で埋めるようにした
			'h108:		rSUsiRd <= {rDeviceAdrs};
			'h10c:		rSUsiRd <= {20'd0, rNeglength};
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