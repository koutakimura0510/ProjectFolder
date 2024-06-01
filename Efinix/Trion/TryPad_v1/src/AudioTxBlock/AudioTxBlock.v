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
  	parameter pBlockAdrsWidth 	= 8,
  	parameter [pBlockAdrsWidth-1:0] pAdrsMap = 'h03,
  	parameter pUsiBusWidth 		= 32,
  	parameter pCsrAdrsWidth 	= 8,
  	parameter pCsrActiveWidth 	= 8,
	parameter pSfmNum 			= 3
)(
	// I2S Audio Dac
	output	oI2S_MCLK,
	output	oI2S_BCLK,
	output	oI2S_LRCLK,
	output	oI2S_SDATA,
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

wire [pSfmNum-1:0] 					wSfmIoHizCsr;				//assign oSfmIoHiz = wSfmIoHizCsr;
wire [pSfmNum-1:0] 					wSfmEnCsr;
wire [pSfmNum-1:0] 					wSfmCycleEnCsr;
wire [pSfmNum*8-1:0] 				wSfmDivCsr;
wire [pSfmNum*8-1:0] 				wSfmCsHoldTimeCsr;
wire [pSfmNum*lpSfmPageWidth-1:0] 	wSfmStartAdrsCsr;
wire [pSfmNum*lpSfmPageWidth-1:0] 	wSfmEndAdrsCsr;
wire [pSfmNum*8-1:0] 				wSfmCpuWdCsr;
wire [pSfmNum-1:0] 					wSfmCpuEnCsr;
wire [pSfmNum-1:0] 					wSfmCpuCsCtrlCsr;
wire [pSfmNum-1:0] 					wSfmCpuValidCsr;
wire [pSfmNum*8-1:0] 				wSfmCpuRdCsr;
wire [pSfmNum-1:0] 					wSfmCpuDoneCsr;
wire [pSfmNum-1:0] 					wSfmDoneCsr;
wire [pSfmNum*lpSfmPageWidth-1:0] 	wSfmAdrsAddCsr;
//
wire [15:0] 			wAacCpuWdCsr;
wire 	 				wAacCpuWeCsr;
wire 					wAacAlertCsr;

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
	.oSfmEn(wSfmEnCsr),
	.oSfmCycleEn(wSfmCycleEnCsr),
	.oSfmDiv(wSfmDivCsr),
	.oSfmCsHoldTime(wSfmCsHoldTimeCsr),
	.oSfmStartAdrs(wSfmStartAdrsCsr),
	.oSfmEndAdrs(wSfmEndAdrsCsr),
	.oSfmIoHiz(wSfmIoHizCsr),
	.oSfmCpuWd(wSfmCpuWdCsr),
	.oSfmCpuEn(wSfmCpuEnCsr),
	.oSfmCpuCsCtrl(wSfmCpuCsCtrlCsr),
	.oSfmCpuValid(wSfmCpuValidCsr),
	.oAacCpuWd(wAacCpuWdCsr),
	.oAacCpuWe(wAacCpuWeCsr),
	// Csr Input
	.iSfmCpuRd(wSfmCpuRdCsr),
	.iSfmCpuDone(wSfmCpuDoneCsr),
	.iSfmDone(wSfmDoneCsr),
	.iSfmAdrsAdd(wSfmAdrsAddCsr),
	.iAacAlert(wAacAlertCsr),
    // common
	.iSRST(iSRST),		.iSCLK(iSCLK)
);

//-----------------------------------------------------------------------------
// Sfc Part
//-----------------------------------------------------------------------------
wire [lpAudioBitDepth-1:0] wArrRd [0:pSfmNum-1];
reg  [lpAudioBitDepth-1:0] qArrRd [0:pSfmNum-1];
wire [pSfmNum-1:0] wArrRvd;
wire [pSfmNum-1:0] wArrEmp;
reg  [pSfmNum-1:0] qArrRe;

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
			.oRd(wArrRd[x]),			.oRvd(wArrRvd[x]),
			.oEmp(wArrEmp[x]),			.iRe(qArrRe[x]),
			// Logic Sfm Control
			.iSfmEn(wSfmEnCsr[x]),
			.iSfmCycleEn(wSfmCycleEnCsr[x]),
			.iSfmDiv(wSfmDivCsr[(x+1)*8-1:(x*8)]),
			.iSfmCsHoldTime(wSfmCsHoldTimeCsr[(x+1)*8-1:(x*8)]),
			.iSfmStartAdrs(wSfmStartAdrsCsr[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			.iSfmEndAdrs(wSfmEndAdrsCsr[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			.oSfmDone(wSfmDoneCsr[x]),
			.oSfmAdrsAdd(wSfmAdrsAddCsr[(x+1)*lpSfmPageWidth-1:(x*lpSfmPageWidth)]),
			// Cpu Sfm Control
			.iSfmCpuWd(wSfmCpuWdCsr[(x+1)*8-1:(x*8)]),
			.iSfmCpuEn(wSfmCpuEnCsr[x]),
			.iSfmCpuCsCtrl(wSfmCpuCsCtrlCsr[x]),
			.iSfmCpuValid(wSfmCpuValidCsr[x]),
			.oSfmCpuRd(wSfmCpuRdCsr[(x+1)*8-1:(x*8)]),
			.oSfmCpuDone(wSfmCpuDoneCsr[x]),
			// common
			.iSRST(iSRST),	.inSRST(inSRST),	.iSCLK(iSCLK)
		);
	end
endgenerate


//-----------------------------------------------------------------------------
// Audio Async Fifo (Aac)
//-----------------------------------------------------------------------------
localparam lpFifoDepth				= 256;
localparam lpFifoBitWidth			= 32;
localparam lpFifoRemaingCntBorder 	= 256 - 16;

reg  [lpFifoBitWidth-1:0] 	qAacWd;
reg  						qAacWe;
wire 						wAacFull;
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
	.oFull(wAacFull),	.oRemaingCntAlert(wAacRemaingCntAlert),
	// common
	.inARST(inSRST),	.iWCLK(iSCLK),		.iRCLK(iMCLK)
);

assign wAacAlertCsr = wAacRemaingCntAlert;

//-----------------------------------------------------------------------------
// 後々に再生音源ごとの、振幅調整や終了時点のノイズ軽減 移動平均処理を入れる。
// CPU からのレジスタ設定により動作
//-----------------------------------------------------------------------------
reg rGlueWe, qGluwWeCke;
reg rGlueWeSel;

always @(posedge iSCLK)
begin
	if (iSRST)				rGlueWe <= 1'd0;
	else if (qGluwWeCke)	rGlueWe <= 1'b1;
	else 					rGlueWe <= 1'd0;

	if (iSRST)				rGlueWeSel <= 1'd0;
	else if (wAacCpuWeCsr)	rGlueWeSel <= 1'b1;
	else 					rGlueWeSel <= 1'd0;
end

always @*
begin
	qArrRd[0] 	<=   wArrRvd[0] ? wArrRd[0] : 16'd0;
	qArrRd[1] 	<=   wArrRvd[1] ? wArrRd[1] : 16'd0;
	// qAacWd		<=   {16'd0,qArrRd[2]};
	// qAacWd		<=   {16'd0,wAacCpuWdCsr};
	qAacWd		<=   qArrRd[0]  + qArrRd[1];
	qAacWe		<= |{wArrRvd};
	// qAacWe		<= 	 wArrRvd[2];
	// qAacWe		<=  rGlueWe;
	qArrRe		<=  {pSfmNum{~wAacRemaingCntAlert}};

	casex ( {rGlueWeSel,rGlueWe,wAacCpuWeCsr} )
		'b001:	qGluwWeCke <= 1'b1;
		'bx1x:	qGluwWeCke <= 1'b0;
		default	qGluwWeCke <= 1'b0;
	endcase
end


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