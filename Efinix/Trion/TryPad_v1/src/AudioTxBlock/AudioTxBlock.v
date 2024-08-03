/*-----------------------------------------------------------------------------
 * SPI ROM から音源データを読み出し、I2Sで出力する
 * リソースの観点からFPGA内部で音源を生成しようと試みたが、聞くに耐えない音質だったのでPCM音源再生に変更。 
 *
 * SPI ROM1 = BGM
 * SPI ROM2 = 効果音1
 * SPI ROM3 = 効果音2
 * SPI ROM を複数個使用し、専用に割り当てることで、複数音源再生時の Read 遅延を無くすようにした。
 * ※SPI ROM は 100[MHz]と高速で動作するがシステムクロックが 50[Mhz] 以下なので上記構成にした。
 *
 * 23-09-02 v1.00 : new release
 * 24-07-17 v2.00 : Sfm を Spi Block に統合に伴い、大幅に更新
 *-----------------------------------------------------------------------------*/
module AudioTxBlock #(
	// USI
  	parameter pBlockAdrsWidth 	= 8,
  	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
  	parameter pUsiBusWidth 		= 32,
  	parameter pCsrAdrsWidth 	= 8,
  	parameter pCsrActiveWidth 	= 8,
	parameter pSfmNum 			= 3
)(
	// I2S Audio Dac
	output						oI2S_MCLK,
	output						oI2S_BCLK,
	output						oI2S_LRCLK,
	output						oI2S_SDATA,
	// Dual Port Strem Data
	input	[31:0]				iDQ,
	input	[ 1:0]				iVD,
	output	[ 1:0]				oFLL,
	// Usi Bus Master Read
	output	[pUsiBusWidth-1:0] 	oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0] 	iSUsiWd,
	input	[pUsiBusWidth-1:0] 	iSUsiAdrs,
	// Control / Status
	// CLK Reset
	input						iMRST,
	input						iSRST,
	input						inSRST,
	input						iMCLK,
	input						iSCLK
);


//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
AudioTxCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth)
) AudioTxCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// Csr Output
	// Csr Input
    // common
	.iSRST(iSRST),		.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Audio Async Fifo (Aac)
//-----------------------------------------------------------------------------
localparam lpFifoDepth				= 256;
localparam lpFifoBitWidth			= 32;
localparam lpFifoRemaingCntBorder 	= 256 - 16;

reg  [15:0] 				qArrRd[0:1];
reg  [lpFifoBitWidth-1:0] 	qAacWd;
reg  						qAacWe;
wire 						wAacRemaingCntAlert;
wire [lpFifoBitWidth-1:0] 	wAacRd;
reg  						qAacRe;
wire 						wAacEmp;
wire 						wAacRvd;

ASyncFifoController #(
	.pFifoDepth(lpFifoDepth),
	.pFifoBitWidth(lpFifoBitWidth),
	.pFifoRemaingCntBorder(lpFifoRemaingCntBorder)
) AudioAsyncFifo (
	// read side
	.oRd(wAacRd),		.iRe(qAacRe),
	.oRvd(wAacRvd),		.oEmp(wAacEmp),
	// write side
	.iWd(qAacWd),		.iWe(qAacWe),
	.oFull(),			.oRemaingCntAlert(wAacRemaingCntAlert),
	// common
	.inARST(inSRST),	.iWCLK(iSCLK),		.iRCLK(iMCLK)
);

always @*
begin
	qArrRd[0] 	<=   iVD[0] ? iDQ[15: 0] : 16'd0;
	qArrRd[1] 	<=   iVD[1] ? iDQ[31:16] : 16'd0;
	qAacWd		<=   qArrRd[0] + qArrRd[1];
	qAacWe		<= |{iVD[1:0]};
end

assign oFLL = {pSfmNum{~wAacRemaingCntAlert}};


//-----------------------------------------------------------------------------
// I2S Encorder Part
//-----------------------------------------------------------------------------
reg  [31:0] qAudioData;
wire wI2SRdy;

AudioTxI2S AudioTxI2S (
	// I2S Output Ctrl
	.oI2S_MCLK(oI2S_MCLK),
	.oI2S_BCLK(oI2S_BCLK),
	.oI2S_LRCLK(oI2S_LRCLK),
	.oI2S_SDATA(oI2S_SDATA),
	// Control and Data
	.iAudioData(qAudioData),
	.oAudioDataRdy(wI2SRdy),
	// CLK RST
	.iMRST(iMRST),	.iMCLK(iMCLK)
);

always @*
begin
	qAudioData[31:0] 	<= {wAacRd[19:0],12'd0};
  	qAacRe				<= &{wI2SRdy,~wAacEmp};
end


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------



endmodule