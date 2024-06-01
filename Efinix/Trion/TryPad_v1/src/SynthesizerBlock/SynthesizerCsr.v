//------------------------------------------------------------------------------
// Create 2023/4/15
// Author koutakimura
// -
// Slave コントロール・ステータス・レジスタ
// 
// [Csr 規則]
// 自動レジスタ更新は、上位モジュールからの input port とレジスタを接続する。
// 上位モジュールへの output port は必ずレジスタ経由で出力する。
// 
// v1.00 new release
// v1.01 DMA 関連のレジスタ追加
//------------------------------------------------------------------------------
module SynthesizerCsr #(
	parameter pBlockAdrsWidth 	= 8,
	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h04,
	parameter pUsiBusWidth 		= 32,
	parameter pCsrAdrsWidth		= 8,
	parameter pCsrActiveWidth 	= 8,
	parameter pDmaAdrsWidth 	= 16,
	parameter pMidiChannel		= 4,
	parameter p_non_variable 	= 0
)(
	// Bus Master Read
	output	[pUsiBusWidth-1:0] oSUsiRd,	// Read Data
	// Bus Master Write
	input	[pUsiBusWidth-1:0] iSUsiWd,	// Write Data
	input	[pUsiBusWidth-1:0] iSUsiAdrs,  // R/W Adrs
	// Csr Output
	output 	oI2SModuleRst,
	output	oDmaEnable,
	output	oDmaCycleEnable,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsStart,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsEnd,
	output	[pDmaAdrsWidth-1:0] oDmaAdrsAdd,
	input	iDmaDone,
	output  [7:0] oAudioAmpCh1,
	output  [7:0] oAudioAmpCh2,
	output  [7:0] oAudioAmpCh3,
	output  [7:0] oAudioAmpCh4,
	// Csr Input
	input 	[pMidiChannel-1:0] iAudioPlay,
	input	[(pMidiChannel*7)-1:0] iOnNoteNumber,
	// CLK RST
	input 	iSRST,
	input 	iSCLK
);


//-----------------------------------------------------------------------------
// localparam
//-----------------------------------------------------------------------------
localparam [pDmaAdrsWidth-1:0] lpDmaAdrsEndInit = 44100-1;
localparam [pDmaAdrsWidth-1:0] lpDmaAdrsAddInit = 1;
genvar x;

//----------------------------------------------------------
// レジスタマップ
//----------------------------------------------------------
reg rI2SModuleRst;							assign oI2SModuleRst	= rI2SModuleRst;	// 
reg rDmaEnable;								assign oDmaEnable 		= rDmaEnable;		// DMA Function Enable
reg rDmaCycleEnable;						assign oDmaCycleEnable	= rDmaCycleEnable;	// Dma Auto Cycle Mode
reg [pDmaAdrsWidth-1:0] rDmaAdrsStart;		assign oDmaAdrsStart 	= rDmaAdrsStart;	// Dma Start Adrs
reg [pDmaAdrsWidth-1:0] rDmaAdrsEnd;		assign oDmaAdrsEnd 		= rDmaAdrsEnd;		// Dma End Adrs
reg [pDmaAdrsWidth-1:0] rDmaAdrsAdd;		assign oDmaAdrsAdd 		= rDmaAdrsAdd;		// Dma Add Adrs
reg [7:0] rAudioAmpCh1;						assign oAudioAmpCh1 	= rAudioAmpCh1;		// Amp
reg [7:0] rAudioAmpCh2;						assign oAudioAmpCh2 	= rAudioAmpCh2;
reg [7:0] rAudioAmpCh3;						assign oAudioAmpCh3 	= rAudioAmpCh3;
reg [7:0] rAudioAmpCh4;						assign oAudioAmpCh4 	= rAudioAmpCh4;
//
reg qCsrWCke00;
reg qCsrWCke04;
reg qCsrWCke08;
reg qCsrWCke0C;
reg qCsrWCke10;
reg qCsrWCke14;
reg qCsrWCke60;
//
always @(posedge iSCLK)
begin
	if (iSRST)
	begin
		rI2SModuleRst 	<= 1'b0;
		rDmaEnable 		<= 1'b0;
		rDmaCycleEnable	<= 1'b0;
		rDmaAdrsStart 	<= {pDmaAdrsWidth{1'b0}};
		rDmaAdrsEnd 	<= lpDmaAdrsEndInit;
		rDmaAdrsAdd 	<= lpDmaAdrsAddInit;
		rAudioAmpCh1	<= 8'd255;
		rAudioAmpCh2	<= 8'd255;
		rAudioAmpCh3	<= 8'd255;
		rAudioAmpCh4	<= 8'd255;
	end
	else
	begin
		rI2SModuleRst	<= qCsrWCke00 ? iSUsiWd[0:0] : rI2SModuleRst;
		rDmaEnable		<= iDmaDone	  ? rDmaCycleEnable : qCsrWCke04 ? iSUsiWd[0:0] : rDmaEnable;
		rDmaCycleEnable	<= qCsrWCke08 ? iSUsiWd[0:0] : rDmaCycleEnable;
		rDmaAdrsStart	<= qCsrWCke0C ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsStart;
		rDmaAdrsEnd		<= qCsrWCke10 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsEnd;
		rDmaAdrsAdd		<= qCsrWCke14 ? iSUsiWd[pDmaAdrsWidth-1:0] : rDmaAdrsAdd;
		//
		rAudioAmpCh1	<= qCsrWCke60 ? iSUsiWd[ 7: 0] : rAudioAmpCh1;
		rAudioAmpCh2	<= qCsrWCke60 ? iSUsiWd[15: 8] : rAudioAmpCh2;
		rAudioAmpCh3	<= qCsrWCke60 ? iSUsiWd[23:16] : rAudioAmpCh3;
		rAudioAmpCh4	<= qCsrWCke60 ? iSUsiWd[31:24] : rAudioAmpCh4;
	end
end

always @*
begin
	qCsrWCke00 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0000});
	qCsrWCke04 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0004});
	qCsrWCke08 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0008});
	qCsrWCke0C <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h000C});
	qCsrWCke10 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0010});
	qCsrWCke14 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0014});
	//
	qCsrWCke60 <= iSUsiAdrs[30] & (iSUsiAdrs[pBlockAdrsWidth + pCsrAdrsWidth - 1:0] == {pAdrsMap, 16'h0060});
end


//----------------------------------------------------------
// Csr Read
//----------------------------------------------------------
reg [pUsiBusWidth-1:0] rSUsiRd;			assign oSUsiRd = rSUsiRd;

always @(posedge iSCLK)
begin
	// {{(32 - パラメータ名	){1'b0}}, レジスタ名} -> パラメータ可変に対応し 0 で埋められるように設定
	case (iSUsiAdrs[pCsrActiveWidth-1:0])
		'h00:	 rSUsiRd <= {{(32 - 1			 ){1'b0}}, rI2SModuleRst};
		'h04:	 rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaEnable};
		'h08:	 rSUsiRd <= {{(32 - 1			 ){1'b0}}, rDmaCycleEnable};
		'h0C:	 rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsStart};
		'h10:	 rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsEnd};
		'h14:	 rSUsiRd <= {{(32 - pDmaAdrsWidth){1'b0}}, rDmaAdrsAdd};
		'h60:	 rSUsiRd <= {rAudioAmpCh4, rAudioAmpCh3, rAudioAmpCh2, rAudioAmpCh1};
		// 'h64:	 rSUsiRd <= {rAudioAmpCh8, rAudioAmpCh7, rAudioAmpCh6, rAudioAmpCh5};
		//
		'h84:	 rSUsiRd <= {{(32 - pMidiChannel){1'b0}}, iAudioPlay};
		'hC0:	 rSUsiRd <= {1'b0, iOnNoteNumber[27:21], 1'b0, iOnNoteNumber[20:14], 1'b0, iOnNoteNumber[13:7], 1'b0, iOnNoteNumber[6:0]};
		// 'hC4:	 rSUsiRd <= {2'b00, iOnNoteNumber[55:49], 2'b00, iOnNoteNumber[48:42], 2'b00, iOnNoteNumber[41:35], 2'b00, iOnNoteNumber[34:28]};
		default: rSUsiRd <= iSUsiWd;
	endcase
end

endmodule