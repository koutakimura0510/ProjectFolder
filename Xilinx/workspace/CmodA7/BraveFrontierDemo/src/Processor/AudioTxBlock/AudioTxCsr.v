//----------------------------------------------------------
// Create 2022/9/8
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
//----------------------------------------------------------
module AudioTxCsr #(
	parameter 						pBlockAdrsMap 		= 8,
	parameter [pBlockAdrsMap-1:0] 	pAdrsMap  			= 'h05,
	parameter						pBusAdrsBit			= 16,
	parameter 						pCsrAdrsWidth   	= 16,
	parameter						pCsrActiveWidth 	= 8,
	//
    parameter       				pAudioSamplingRate 	= 8,
	parameter						pMemBitWidth		= 19
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
	output							oAudioCke,
	output	[ 6:0]					oAudioTone,
	output 							oAudioSel,
	output 	[ 7:0]					oAudioDuty,
	output 	[ pMemBitWidth-1:0]		oAudioDmaAdrs,
	output 	[ pMemBitWidth-1:0]		oAudioDmaLen,
	output 		 					oAudioDmaEn,
    // CLK Reset
    input           				iSysRst,
    input           				iSysClk
);


//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg 					rAudioCke;		assign oAudioCke		= rAudioCke;		// 音源出力
reg [ 6:0]				rAudioTone;		assign oAudioTone 		= rAudioTone;		// Tone については pwm_piano.Excel 参照
reg 					rAudioSel;		assign oAudioSel		= rAudioSel;		// 1.Debug mode, 2.Wave Mode
reg [ 7:0]				rAudioDuty;		assign oAudioDuty		= rAudioDuty;		// Debug 用 Duty比
reg [pMemBitWidth-1:0]	rAudioDmaAdrs;	assign oAudioDmaAdrs 	= rAudioDmaAdrs;	// DMA 開始アドレス
reg [pMemBitWidth-1:0]	rAudioDmaLen;	assign oAudioDmaLen 	= rAudioDmaLen;		// DMA 読み込みサイズ
reg 					rAudioDmaEn;	assign oAudioDmaEn 		= rAudioDmaEn;		// DMA Enable
//
reg 					qCsrWCke00;
reg 					qCsrWCke04;
reg 					qCsrWCke08;
reg 					qCsrWCke0c;
reg 					qCsrWCke10;
reg 					qCsrWCke14;
reg 					qCsrWCke18;
//
always @(posedge iSysClk)
begin
	if (iSysRst)
	begin
		rAudioCke		<= 1'b0;		// Active High
		rAudioTone		<= 7'd69;		// 基本 440Hz のラ音
		rAudioSel		<= 1'b0;
		rAudioDuty		<= 8'd127;
		rAudioDmaAdrs	<= {pMemBitWidth{1'b0}};
		rAudioDmaLen	<= {pMemBitWidth{1'b0}};
		rAudioDmaEn		<= 1'b0;
	end
	else
	begin
		rAudioCke		<= qCsrWCke00 ? iSUsiWd[ 0:0] 				: rAudioCke;
		rAudioTone		<= qCsrWCke04 ? iSUsiWd[ 6:0] 				: rAudioTone;
		rAudioSel		<= qCsrWCke08 ? iSUsiWd[ 0:0] 				: rAudioSel;
		rAudioDuty		<= qCsrWCke0c ? iSUsiWd[ 7:0] 				: rAudioDuty;
		rAudioDmaAdrs	<= qCsrWCke10 ? iSUsiWd[pMemBitWidth-1:0] 	: rAudioDmaAdrs;
		rAudioDmaLen	<= qCsrWCke14 ? iSUsiWd[pMemBitWidth-1:0] 	: rAudioDmaLen;
		rAudioDmaEn		<= qCsrWCke18 ? iSUsiWd[ 0:0] 				: rAudioDmaEn;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0c <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000c});
	qCsrWCke10 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke14 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	qCsrWCke18 <= iSUsiWCke & (iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0018});
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
		case (iSUsiAdrs[pCsrActiveWidth - 1:0])
			'h00:		rSUsiRd	<= {{(32 - 1){1'b0}},				rAudioCke		};
			'h04:		rSUsiRd	<= {{(32 - 7){1'b0}},				rAudioTone		};
			'h08:		rSUsiRd	<= {{(32 - 1){1'b0}},				rAudioSel		};
			'h0c:		rSUsiRd	<= {{(32 - 8){1'b0}},				rAudioDuty		};
			'h10:		rSUsiRd	<= {{(32 - pMemBitWidth){1'b0}},	rAudioDmaAdrs	};
			'h14:		rSUsiRd	<= {{(32 - pMemBitWidth){1'b0}},	rAudioDmaLen	};
			'h18:		rSUsiRd	<= {{(32 - 1){1'b0}},				rAudioDmaEn		};
			default: 	rSUsiRd <= iSUsiWd;
		endcase
	end

	if (iSysRst)		rSUsiREd <= 1'b0;
	else if (qAdrsComp)	rSUsiREd <= 1'b1;
	else				rSUsiREd <= 1'b0;
end

always @*
begin
	qAdrsComp <= {iSUsiAdrs[pBlockAdrsMap + pCsrAdrsWidth - 1:pCsrAdrsWidth] == pAdrsMap};
end

endmodule