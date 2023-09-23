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
 *-----------------------------------------------------------------------------*/
module AudioTxBlock #(
	// USI
  	parameter pBlockAdrsWidth = 8,
  	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
  	parameter pUsiBusWidth = 32,
  	parameter pCsrAdrsWidth = 8,
  	parameter pCsrActiveWidth = 8,
	parameter pSfmNum = 3
)(
	// I2S Audio Dac
	output	oI2sMclk,
	output	oI2sBclk,
	output	oI2sLrclk,
	output	oI2sSdata,
	// Serial Flash Memory
	output	[pSfmNum-1:0] oSfmSck,
	output	[pSfmNum-1:0] oSfmMosi,
	input	[pSfmNum-1:0] iSfmMiso,
	output	[pSfmNum-1:0] oSfmCs,
	// Usi Bus Master Read
	output	[pUsiBusWidth-1:0] oSUsiRd,
	// Usi Bus Master Write
	input	[pUsiBusWidth-1:0] iSUsiWd,
	input	[pUsiBusWidth-1:0] iSUsiAdrs,
	// Control / Status
	// CLK Reset
	input	iMRST,
	input	iSRST,
	input	inSRST,
	input	iMCLK,
	input	iSCLK
);

//---------------------------------------------------------------------------
localparam lpAudioBitDepth = 16;
genvar x;

//-----------------------------------------------------------------------------
// Csr Space
//-----------------------------------------------------------------------------
localparam lpSfmPageWidth = 16;	// 16bit = 65535 page

wire [pSfmNum-1:0] wSfmIoHiz;				//assign oSfmIoHiz = wSfmIoHiz;
wire [pSfmNum-1:0] wSfmEn;
wire [pSfmNum-1:0] wSfmCycleEn;
wire [pSfmNum*8-1:0] wSfmDiv;
wire [pSfmNum*8-1:0] wSfmCsHoldTime;
wire [pSfmNum*lpSfmPageWidth-1:0] wSfmStartAdrs;
wire [pSfmNum*lpSfmPageWidth-1:0] wSfmEndAdrs;
wire [pSfmNum*8-1:0] wSfmCpuWd;
wire [pSfmNum-1:0] wSfmCpuEn;
wire [pSfmNum-1:0] wSfmCpuCsCtrl;
wire [pSfmNum-1:0] wSfmCpuValid;
wire [pSfmNum*8-1:0] wSfmCpuRd;
wire [pSfmNum-1:0] wSfmCpuDone;
wire [pSfmNum-1:0] wSfmDone;

AudioTxCsr #(
	.pBlockAdrsWidth(pBlockAdrsWidth),
	.pAdrsMap(pAdrsMap),
	.pUsiBusWidth(pUsiBusWidth),
	.pCsrAdrsWidth(pCsrAdrsWidth),
	.pCsrActiveWidth(pCsrActiveWidth),
	.pSfmNum(pSfmNum),
	.pSfmPageWidth(lpSfmPageWidth)
) AudioTxCsr (
	// Bus Master Read
	.oSUsiRd(oSUsiRd),
	// Bus Master Write
	.iSUsiWd(iSUsiWd),	.iSUsiAdrs(iSUsiAdrs),
	// Csr Output
	.oSfmEn(wSfmEn),
	.oSfmCycleEn(wSfmCycleEn),
	.oSfmDiv(wSfmDiv),
	.oSfmCsHoldTime(wSfmCsHoldTime),
	.oSfmStartAdrs(wSfmStartAdrs),
	.oSfmEndAdrs(wSfmEndAdrs),
	.oSfmIoHiz(wSfmIoHiz),
	.oSfmCpuWd(wSfmCpuWd),
	.oSfmCpuEn(wSfmCpuEn),
	.oSfmCpuCsCtrl(wSfmCpuCsCtrl),
	.oSfmCpuValid(wSfmCpuValid),
	// Csr Input
	.iSfmCpuRd(wSfmCpuRd),
	.iSfmCpuDone(wSfmCpuDone),
	.iSfmDone(wSfmDone),
    // common
	.iSRST(iSRST),		.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Sfc Part
//-----------------------------------------------------------------------------
wire [lpAudioBitDepth:0] wAudioData [0:pSfmNum-1];
wire [pSfmNum-1:0]	wAudioVd;

generate
	for (x = 0; x < pSfmNum; x = x + 1)
	begin : AudioRomRead
		AudioRomRead #(
			.pSfmNum(pSfmNum),
			.pSfmPageWidth(lpSfmPageWidth)
		) AudioRomRead (
			// Serial Flash Memory
			.oSfmSck(oSfmSck[x]),		.oSfmMosi(oSfmMosi[x]),
			.iSfmMiso(iSfmMiso[x]),		.oSfmCs(oSfmCs[x]),
			// Audio Data
			.oAudioData(wAudioData[x]),	.oAudioVd(wAudioVd[x]),
			// Control Status
			.iSfmEn(wSfmEn[x]),
			.iSfmCycleEn(wSfmCycleEn[x]),
			.iSfmDiv(wSfmDiv[(x+1)*8-1:(x*8)]),
			.iSfmCsHoldTime(wSfmCsHoldTime[(x+1)*8-1:(x*8)]),
			.iSfmStartAdrs(wSfmStartAdrs[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			.iSfmEndAdrs(wSfmEndAdrs[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			.iSfmCpuWd(wSfmCpuWd[(x+1)*8-1:(x*8)]),
			.iSfmCpuEn(wSfmCpuEn[x]),
			.iSfmCpuCsCtrl(wSfmCpuCsCtrl[x]),
			.iSfmCpuValid(wSfmCpuValid[x]),
			.oSfmCpuRd(wSfmCpuRd[(x+1)*8-1:(x*8)]),
			.oSfmCpuDone(wSfmCpuDone[x]),
			.oSfmDone(wSfmDone[x]),
			// common
			.iSRST(iSRST),	.inSRST(inSRST),	.iSCLK(iSCLK)
		);
	end
endgenerate

//-----------------------------------------------------------------------------
// I2S Encorder Part
//-----------------------------------------------------------------------------
reg  [31:0] qAudioData;
wire wI2SRdy;

AudioTxI2S AudioTxI2S (
	// I2S Output Ctrl
	.oI2sMclk(oI2sMclk),
	.oI2sBclk(oI2sBclk),
	.oI2sLrclk(oI2sLrclk),
	.oI2sSdata(oI2sSdata),
	// Control and Data
	.iAudioData(0),
	.oAudioDataRdy(wI2SRdy),
	// CLK RST
	.iMRST(iMRST),	.iMCLK(iMCLK)
);

// always @*
// begin
// 	// qAudioData[31:0] 	<= {wDmaRdAdd[23:0],8'h00};
//   	// qDmaRe				<= wI2SRdy;
// 	// qDmaRdChRst			<= |{iMRST,wI2SRdy};
// 	qAudioData[31:0] 	<= {wDdrRd[23:0],8'h00};
//   	qDdrRe				<= wI2SRdy;
// 	qDmaRdChRst			<= |{iMRST,wI2SRdy};
// end


//-----------------------------------------------------------------------------
// function
//-----------------------------------------------------------------------------



endmodule