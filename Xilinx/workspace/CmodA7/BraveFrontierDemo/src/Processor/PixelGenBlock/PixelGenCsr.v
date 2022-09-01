//----------------------------------------------------------
// Create 2022/8/28
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module PixelGenCsr #(
	parameter 						pBlockAdrsMap 	= 'd8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  		= 'h05,
	parameter						pBusAdrsBit		= 'd16,
	//
    parameter       				pHdisplay		= 480,
    parameter       				pHfront			= 8,
    parameter       				pHback			= 43,
    parameter       				pHpulse			= 30,
    parameter       				pVdisplay		= 272,
    parameter       				pVfront			= 12,
    parameter       				pVback			= 4,
    parameter       				pVpulse			= 10,
	//
    parameter       				pHdisplayWidth	= 11,
    parameter       				pHbackWidth		= 7,
    parameter       				pHfrontWidth	= 7,
    parameter       				pHpulseWidth	= 7,
    parameter       				pVdisplayWidth	= 11,
    parameter       				pVfrontWidth	= 5,
    parameter       				pVbackWidth		= 5,
    parameter       				pVpulseWidth	= 5
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
	output 	[pHdisplayWidth-1:0]	oHdisplay,
	output 	[pVdisplayWidth-1:0]	oVdisplay,
	output	[pHdisplayWidth:0]		oHSyncStart,
	output	[pHdisplayWidth:0]		oHSyncEnd,
	output	[pHdisplayWidth:0]		oHSyncMax,
	output	[pVdisplayWidth:0]		oVSyncStart,
	output	[pVdisplayWidth:0]		oVSyncEnd,
	output	[pVdisplayWidth:0]		oVSyncMax,
	//
	output  						oDisplayRst,
	output	[7:0]					oBlDutyRatio,
    // CLK Reset
    input           				iSysClk,
    input           				iSysRst
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg [pHdisplayWidth-1:0] 	rHdisplay;			assign oHdisplay 	= rHdisplay;		// 水平モニタ横幅
reg [pHfrontWidth-1:0] 		rHfront;													// 水平フロントポーチ
reg [pHbackWidth-1:0] 		rHback;														// 水平バックポーチ
reg [pHpulseWidth-1:0] 		rHpulse;													// 水平同期信号幅
reg [pVdisplayWidth-1:0] 	rVdisplay;			assign oVdisplay 	= rVdisplay;		// 垂直モニタ縦幅
reg [pVfrontWidth-1:0] 		rVfront;													// 垂直フロントポーチ
reg [pVbackWidth-1:0] 		rVback;														// 垂直バックポーチ
reg [pVpulseWidth-1:0] 		rVpulse;													// 垂直同期信号幅
reg 						r
reg 						r
reg 						rDisplayRst;		assign oDisplayRst	= rDisplayRst;		// ディスプレイのリセット信号
reg [7:0]					rBlDutyRatio;		assign oBlDutyRatio = rBlDutyRatio;		// ディスプレイバックライトの調光
//
reg [pHdisplayWidth:0]		rHSyncStart;		assign oHSyncStart 	= rHSyncStart;		// アクティブエリア から 同期信号まで
reg [pHdisplayWidth:0]		rHSyncEnd;			assign oHSyncEnd 	= rHSyncEnd;		// 同期信号 から バックポーチまで
reg [pHdisplayWidth:0]		rHSyncMax;			assign oHSyncMax 	= rHSyncMax;		// アクティブエリア + 非表示エリア
reg [pVdisplayWidth:0]		rVSyncStart;		assign oVSyncStart 	= rVSyncStart;		// アクティブエリア から 同期信号まで
reg [pVdisplayWidth:0]		rVSyncEnd;			assign oVSyncEnd 	= rVSyncEnd;		// 同期信号 から バックポーチまで
reg [pVdisplayWidth:0]		rVSyncMax;			assign oVSyncMax 	= rVSyncMax;		// アクティブエリア + 非表示エリア
//
reg [pBusAdrsBit:0]		qCsrAdrs; // CKE + Adrs
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rHdisplay		<= pHdisplay;
		rHfront			<= pHfront;
		rHback			<= pHback;
		rHpulse			<= pHpulse;
		rVdisplay		<= pVdisplay;
		rVfront			<= pVfront;
		rVback			<= pVback;
		rVpulse			<= pVpulse;
		rHSyncStart		<= pHdisplay + pHfront;
		rHSyncEnd		<= pHdisplay + pHfront + pHpulse - 1'b1;
		rHSyncMax		<= pHdisplay + pHfront + pHpulse + pHback - 1'b1;
		rVSyncStart		<= pVdisplay + pVfront;
		rVSyncEnd		<= pVdisplay + pVfront + pVpulse - 1'b1;
		rVSyncMax		<= pVdisplay + pVfront + pVpulse + pVback - 1'b1;
		rDisplayRst		<= 1'b0;
		rBlDutyRatio	<= 8'd0;
	end
	else
	begin
		{rVdisplay,rHdisplay}	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h00}) ? {iSUsiWd[pVdisplayWidth-1:0],iSUsiWd[pHdisplayWidth-1:0]	} 	: {rVdisplay,rHdisplay};
		{rVback,rHback		}	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h04}) ? {iSUsiWd[pVbackWidth-1:0],	iSUsiWd[pHbackWidth-1:0]}		: {rVback,rHback};
		{rVfront,rHfront	}	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h08}) ? {iSUsiWd[pVfrontWidth-1:0],	iSUsiWd[pHfrontWidth-1:0]} 		: {rVfront,rHfront};
		{rVpulse,rHpulse	}	<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h0c}) ? {iSUsiWd[pVpulseWidth-1:0],	iSUsiWd[pHpulseWidth-1:0]}		: {rVpulse,rHpulse};
		rDisplayRst				<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h10}) ? iSUsiWd[0:0]	: rDisplayRst;
		rBlDutyRatio			<= (qCsrAdrs == {1'b1, pAdrsMap, 8'h14}) ? iSUsiWd[7:0] : rBlDutyRatio;
		//
		rHSyncStart 	<= rHdisplay + rHfront;
		rHSyncEnd		<= rHdisplay + rHfront + rHpulse - 1'b1;
		rHSyncMax		<= rHdisplay + rHfront + rHpulse + rHback - 1'b1;
		rVSyncStart 	<= rVdisplay + rVfront;
		rVSyncEnd		<= rVdisplay + rVfront + rVpulse - 1'b1;
		rVSyncMax		<= rVdisplay + rVfront + rVpulse + rVback - 1'b1;
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
			'h100:		rSUsiRd	<= {{(16 - pVdisplayWidth	){1'b0}}, rVdisplay, 	{(16 - pHdisplayWidth	){1'b0}}, rHdisplay		};
			'h104:		rSUsiRd	<= {{(16 - pVbackWidth		){1'b0}}, rVback,		{(16 - pHbackWidth		){1'b0}}, rHback		};
			'h108:		rSUsiRd	<= {{(16 - pVfrontWidth		){1'b0}}, rVfront,		{(16 - pHfrontWidth		){1'b0}}, rHfront		};
			'h10c:		rSUsiRd	<= {{(16 - pVpulseWidth		){1'b0}}, rVpulse,		{(16 - pHpulseWidth		){1'b0}}, rHpulse		};
			'h110:		rSUsiRd	<= {{(32 - 1				){1'b0}}, rDisplayRst	};
			'h114:		rSUsiRd	<= {{(32 - 8				){1'b0}}, rBlDutyRatio	};
			//
			'h180:		rSUsiRd	<= {{(16 - pVdisplayWidth +1){1'b0}}, rVSyncStart,	{(16 - pHdisplayWidth +1){1'b0}}, rHSyncStart	};
			'h184:		rSUsiRd	<= {{(16 - pVdisplayWidth +1){1'b0}}, rVSyncEnd,	{(16 - pHdisplayWidth +1){1'b0}}, rHSyncEnd		};
			'h188:		rSUsiRd	<= {{(16 - pVdisplayWidth +1){1'b0}}, rVSyncMax,	{(16 - pHdisplayWidth +1){1'b0}}, rHSyncMax		};
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