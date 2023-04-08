/*-----------------------------------------------------------------------------
 * Create  2023/4/5
 * Author  KoutaKimura
 * -
 * 
 *-----------------------------------------------------------------------------*/
module Processor #(
    parameter       pHdisplay     = 480,
    parameter       pHfront       =   8,
    parameter       pHback        =  43,
    parameter       pHpulse       =  30,
    parameter       pVdisplay     = 272,
    parameter       pVfront       =  12,
    parameter       pVback        =   4,
    parameter       pVpulse       =  10,
    parameter       pPixelDebug   = "yes",
    parameter       pBuffDepth    = 1024,
    parameter       pDebug        = "off"
)(
	// SCLK Part
	input 			iSRST,
	input 			inSRST,
	input			iSCLK,
	// MCLK Part
	input 			iMRST,
	input 			inMRST,
	input			iMCLK
);


//-----------------------------------------------------------------------------
// TestPort の使用・不使用
//-----------------------------------------------------------------------------
localparam lpTestPortNum	= 4;
localparam lpTestPortSpi 	= "no";
localparam lpTestPortVideo 	= "no";
localparam lpTestPortAudio 	= "yes";

wire [lpTestPortNum-1:0] wTestPortGpio;
wire [lpTestPortNum-1:0] wTestPortI2c;
wire [lpTestPortNum-1:0] wTestPortSpi;
wire [lpTestPortNum-1:0] wTestPortVideo;
wire [lpTestPortNum-1:0] wTestPortAudio;
wire [lpTestPortNum-1:0] wTestPortRam;


//------------------------------------------------------------------------------
// USI/F BUS
//------------------------------------------------------------------------------
localparam lpUsiBusWidth = 32;		// USIB Width
localparam lpBlockConnectNum = 2;	// 現在接続している ブロックの個数
localparam lpBlockAdrsWidth = func_getwidth(lpBlockConnectNum);
localparam lpCsrAdrsWidth = 16;		// 各ブロック共通の基本CSR幅
localparam lpSUsiBusWidth = (lpUsiBusWidth * lpBlockConnectNum);
localparam [lpBlockAdrsWidth-1:0] 	// ブロックアドレスマッピング ※プロジェクトの Readme.md 参照
	lpGpioAdrsMap	= 'h1,
	lpSPIAdrsMap	= 'h2,

// ブロック内 Csr のアドレス幅
// 基本となる lpCsrAdrsWidth のアドレス幅で Csr を利用しない場合は、
// ロジック削減のため各ブロックで有効なアドレス幅のパラメータを設定する
// 下記パラメータに関しては、USI I/F Bus のアドレス幅を個々に対応して変更するのが難しいと感じたため用意した。
localparam 
	lpGpioCsrActiveWidth = 8,
	lpSPICsrActiveWidth  = 8,
	lpNullActiveWidth	 = 8;	// 使用しない、ソースの追加がやりやすいように
	// lpI2CCsrActiveWidth  = 8,
	// lpVTBCsrActiveWidth  = 16,
	// lpATBCsrActiveWidth  = 8,
	// lpRAMCsrActiveWidth  = 8;

// Bus Master Read
wire [lpUsiBusWidth-1:0] wMUsiRd, wSUsiRd[lpBlockConnectNum-1:0];
reg  [lpSUsiBusWidth-1:0] qSUsiRd;	// 二次元配列で取得した Slave Readデータを一次元に結合
// Bus Master Write
reg  [lpUsiBusWidth-1:0] qMUsiWd,	qMUsiAdrs;
wire [lpUsiBusWidth-1:0] wSUsiWd,	wSUsiAdrs;

USIB #(
	.pBlockConnectNum(lpBlockConnectNum),
	.pUsiBusWidth(lpUsiBusWidth),
	.pCsrAdrsWidth(lpCsrAdrsWidth)
) USIB (
	// Bus Master Read
	.oMUsiRd(wMUsiRd),	.iSUsiRd(qSUsiRd),
	// Bus Master Write
	.iMUsiWd(qMUsiWd),	.iMUsiAdrs(qMUsiAdrs),
	.oSUsiWd(wSUsiWd),	.oSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(iSRST),		.iSCLK(iSCLK)
);

always @*
begin
	qMUsiRdSpi	<= wMUsiRd;
	qMUsiWd		<= wMUsiSel ? wMUsiWdSpi   : wMUsiWdMcb;
	qMUsiAdrs	<= wMUsiSel ? wMUsiAdrsSpi : wMUsiAdrsMcb;
end

generate
	for (x = 0; x < lpBlockConnectNum; x = x + 1)
	begin
		always @*
		begin
			qSUsiRd[((x+1)*lpUfiBusWidth)-1:x*lpUfiBusWidth] <= wSUsiRd[x];
		end
	end
endgenerate

//----------------------------------------------------------
// USIF 
//----------------------------------------------------------
localparam 	lpRamAdrsWidth		= 19;
localparam 	lpRamDqWidth		= 8;
localparam  lpUfiBusWidth		= 8;
localparam	lpUfiIdNumber		= 3;


//----------------------------------------------------------
// GPIO Block
//----------------------------------------------------------
// Bus Master Read
wire [lpUsiBusWidth-1:0]	wSUsiRdGpio;
// Bus Master Write
reg  [lpUsiBusWidth-1:0]	qSUsiWdGpio;
reg  [lpUsiBusWidth-1:0]	qSUsiAdrsGpio;

GpioBlock #(
	.pBlockAdrsWidth(lpBlockAdrsWidth),		.pAdrsMap(lpGpioAdrsMap),
	.pUsiBusWidth(lpUsiBusWidth),			.pCsrAdrsWidth(lpCsrAdrsWidth),
	.pCsrActiveWidth(lpGpioCsrActiveWidth)
) GpioBlock (
	// External Port
	.oLed(oLed),
	// Bus Master Read
	.oSUsiRd(wSUsiRd[lpGpioAdrsMap]),
	// Bus Master Write
	.iSUsiWd(wSUsiWd),	.iSUsiAdrs(wSUsiAdrs),
	// CLK, RST
	.iSRST(iSRST),		.iSCLK(iSCLK)
);


//----------------------------------------------------------
// External CPU Master SPI Block or Slave SPI Block
//----------------------------------------------------------
// Slave -> Master
reg  [31:0] 					qMUsiRdSpi;
reg  [lpBlockConnectNum-1:0]	qMUsiREdSpi;
wire [31:0] 					wSUsiRdSpi;
wire 							wSUsiREdSpi;
// Master -> Slave
wire [31:0] 					wMUsiWdSpi;
wire [lpUsiBusWidth-1:0]			wMUsiAdrsSpi;
wire 							wMUsiWCkeSpi;
reg  [31:0] 					qSUsiWdSpi;
reg  [lpUsiBusWidth-1:0]			qSUsiAdrsSpi;
reg  							qSUsiWCkeSpi;
// 
wire [lpUfiBusWidth-1:0]		wMUfiWdSpi;
wire [lpUsiBusWidth-1:0]			wMUfiAdrsSpi;
wire 							wMUfiEdSpi;
wire 							wMUfiVdSpi;
wire 							wMUfiCmdSpi;
// Master Select
wire 							wMUsiSel;
// Interrupt
wire 							wMSpiIntr;

SPIBlock #(
	.pBlockAdrsWidth				(lpBlockAdrsWidth),
	.pAdrsMap	 				(lpSPIAdrsMap),
	.pUsiBusWidth				(lpUsiBusWidth),
	.pCsrAdrsWidth				(lpCsrAdrsWidth),
	.pCsrActiveWidth			(lpSPICsrActiveWidth),
	.pBusBlockConnect			(lpBlockConnectNum),
	.pUfiBusWidth				(lpUfiBusWidth),
	.pTestPortUsed 				(lpTestPortSpi),
	.pTestPortNum				(lpTestPortNum)
) SPIBlock (
	// External Port
	.ioSpiSck					(ioSpiSck),
	.ioSpiMiso					(ioSpiMiso),
	.ioSpiMosi					(ioSpiMosi),
	.ioSpiWp					(ioSpiWp),
	.ioSpiHold					(ioSpiHold),
	.oSpiConfigCs				(oSpiConfigCs),
	.ioSpiCs					(ioSpiCs),
	.iMSSel						(iMSSel),
	// Slave -> Master
	.iMUsiRd					(qMUsiRdSpi),
	.iMUsiREd					(qMUsiREdSpi),
	// Master -> Slave
	.oMUsiWd					(wMUsiWdSpi),
	.oMUsiAdrs					(wMUsiAdrsSpi),
	.oMUsiWEd					(wMUsiWCkeSpi),
	// Slave -> Master
	.oSUsiRd					(wSUsiRdSpi),
	.oSUsiREd					(wSUsiREdSpi),
	// Master -> Slave
	.iSUsiWd					(qSUsiWdSpi),
	.iSUsiAdrs					(qSUsiAdrsSpi),
	.iSUsiWCke					(qSUsiWCkeSpi),
	// Master -> Slave
	.oMUfiWd					(wMUfiWdSpi),
	.oMUfiAdrs					(wMUfiAdrsSpi),
	.oMUfiEd					(wMUfiEdSpi),
	.oMUfiVd					(wMUfiVdSpi),
	.oMUfiCmd					(wMUfiCmdSpi),
	// MUsi 制御信号
	.oMUsiSel					(wMUsiSel),
	.oMSpiIntr					(wMSpiIntr),
	//
	.iSCLK					(iSCLK),
	.iSRST					(iSRST),
	//
	.oTestPort					(wTestPortSpi)
);


//----------------------------------------------------------
// UFI/F BUS
//----------------------------------------------------------
// wire [lpUfiBusWidth-1:0]wMUfiRd;
// wire 					wMUfiEddMcs;
// wire 					wMUfiEddVtb;
// wire 					wMUfiEddAtb;
// wire					wMUfiRdy;
// //
// wire [lpUfiBusWidth-1:0]wSUfiWdRam;
// wire [lpUsiBusWidth-1:0]	wSUfiAdrsRam;
// wire 					wSUfiWEdRam;
// wire 					wSUfiREdRamO;
// wire 					wSUfiCmd;
// wire 					wMUfiRdyVtb;
// wire 					wMUfiRdyAtb;

// UltraFastInterface #(
// 	.pUfiBusWidth	(lpUfiBusWidth),
// 	.pUsiBusWidth	(lpUsiBusWidth),
// 	.pUfiIdNumber	(lpUfiIdNumber)
// ) UfiBus (
// 	.iMUfiWdMcs		(wMUfiWdMcs),
// 	.iMUfiAdrsMcs	(wMUfiAdrsMcs),
// 	.iMUfiWEdMcs	(wMUfiWEdMcs),
// 	.iMUfiREdMcs	(wMUfiREdMcs),
// 	.iMUfiVdMcs		(wMUfiVdMcs),
// 	.iMUfiCmdMcs	(wMUfiCmdMcs),
// 	//
// 	.iMUfiWdSpi		(wMUfiWdSpi),
// 	.iMUfiAdrsSpi	(wMUfiAdrsSpi),
// 	.iMUfiEdSpi		(wMUfiEdSpi),
// 	.iMUfiVdSpi		(wMUfiVdSpi),
// 	.iMUfiCmdSpi	(wMUfiCmdSpi),
// 	//
// 	.iMUfiWdVtb		(wMUfiWdVtb),
// 	.iMUfiAdrsVtb	(wMUfiAdrsVtb),
// 	.iMUfiWEdVtb	(wMUfiWEdVtb),
// 	.iMUfiREdVtb	(wMUfiREdVtb),
// 	.iMUfiVdVtb		(wMUfiVdVtb),
// 	.iMUfiCmdVtb	(wMUfiCmdVtb),
// 	.oMUfiRdyVtb	(wMUfiRdyVtb),
// 	//
// 	.oSUfiWdVtb		(wSUfiWdVtb),
// 	.oSUfiAdrsVtb	(wSUfiAdrsVtb),
// 	.oSUfiWEdVtb	(wSUfiWEdVtb),
// 	//
// 	.iMUfiAdrsAtb	(wMUfiAdrsAtb),
// 	.iMUfiWEdAtb	(wMUfiWEdAtb),
// 	.iMUfiREdAtb	(wMUfiREdAtb),
// 	.iMUfiVdAtb		(wMUfiVdAtb),
// 	.oMUfiRdyAtb	(wMUfiRdyAtb),
// 	//
// 	.oMUfiRd		(wMUfiRd),
// 	.oMUfiEddMcs	(wMUfiEddMcs),
// 	.oMUfiEddVtb	(wMUfiEddVtb),
// 	.oMUfiEddAtb	(wMUfiEddAtb),
// 	.oMUfiRdy		(wMUfiRdy),
// 	//
// 	.iMUfiIdI		(wMUfiIdO),
// 	.oMUfiIdO		(wMUfiIdI),
// 	//
// 	.oSUfiWdRam		(wSUfiWdRam),
// 	.oSUfiAdrsRam	(wSUfiAdrsRam),
// 	.oSUfiWEdRam	(wSUfiWEdRam),
// 	.oSUfiREdRam	(wSUfiREdRamO),
// 	.oSUfiCmd		(wSUfiCmd),
// 	//
// 	.iSUfiRdRam		(wSUfiRdRam),
// 	.iSUfiREdRam	(wSUfiREdRamI),
// 	.iSUfiRdyRam	(wSUfiRdy),
// 	//
// 	.iUfiRST		(iSRST),
// 	.iUfiCLK		(iUfibClk)
// );

// always @*
// begin
// 	qSUfiWdRam	<= wSUfiWdRam;
// 	qSUfiAdrsRam<= wSUfiAdrsRam;
// 	qSUfiWEdRam	<= wSUfiWEdRam;
// 	qSUfiREdRam	<= wSUfiREdRamO;
// 	qSUfiCmd	<= wSUfiCmd;
// 	//
// 	qMUfiRdMcs 	<= wMUfiRd;
// 	qMUfiREdMcs <= wMUfiEddMcs;
// 	qMUfiRdyMcs <= wMUfiRdy;
// 	//
// 	qMUfiRdVtb 	<= wMUfiRd;
// 	qMUfiREdVtb <= wMUfiEddVtb;
// 	qMUfiRdyVtb <= &{wMUfiRdyVtb,wMUfiRdy};
// 	//
// 	qMUfiRdAtb	<= wMUfiRd;
// 	qMUfiREdAtb	<= wMUfiEddAtb;
// 	qMUfiRdyAtb <= &{wMUfiRdyAtb,wMUfiRdy};
// end


//---------------------------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//---------------------------------------------------------------------------
function[  7:0]	func_getwidth;
    input [31:0] iVAL;
    integer			i;

    begin
    func_getwidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            func_getwidth = i+1;
        end
    end
endfunction


endmodule