//----------------------------------------------------------
// Create 2022/8/5
// Author koutakimura
// -
// SPI 通信の Master / Slave の信号生成 モジュール
// Mode0 固定
//----------------------------------------------------------
module SPISignal (
	// External Port
    inout           ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    inout           ioSpiCs1,
    inout           ioSpiCs2,
	// Internal Port FPGA Slave Side
	input	[31:0]	iSMiso,
	output 	[31:0]	oSRd,
	output 	[31:0]	oSAdrs,
	output 	[1:0]	oSCmd,
	output 	[15:0]	oSDLen,
	output 			oSRdVd,
	// Internal Port FPGA Master Side
    input  	[7:0]   iMWd,               // Master Write Data
    output 	[7:0]   oMRd,	            // Master Read Data
    output          oMUsiREd,             // Master Byte Read Assert
	input 			iMSpiCs1,
	input 			iMSpiCs2,
	// Csr
    input           iSPIEn,             // 0. disconnect 1. active
	input 			iDivCke,
	// Master Slave Select
	output 			oMSSel,
	// CLK Reset
    input           iSysClk,
	input 			iSyRst
);


//----------------------------------------------------------
// FPGA Slave
// 4byte Adrs + Cmd + 2byte Data Length + dummy + nData... 
// -
// 最初に 8byte の命令シーケンスを受信する
// Cmd : 0. Non, 1. Csr Write, 2. Csr Read, 3. PSRAM Write
// -
// Csr 操作時は 連続アクセスは可能としない、必ず Data Length は 4byte 固定とする
// PSRAM 操作時は Data Length は最大 2048 byte とする
// 
//----------------------------------------------------------
localparam [1:0]
	lpSAdrsGet 	= 0,
	lpSCmdGet 	= 1,
	lpSDataGet 	= 2;
//
reg [1:0] rSState;	// 受信シーケンス
//
wire wSScl, wSMosi;
reg  rSMiso;
wire wSWp,  wSHold;
wire wSCs1, wSCs2;
//
reg [2:0] 	rSftSScl, rSftSMosi, rSftCs1;
//
reg [31:0]	rSMiso;
//
reg [31:0]	rSRd;					assign oSRd   	= rSRd;
reg [31:0]	rSAdrs;					assign oSAdrs	= rSAdrs;
reg [1:0]	rSCmd;					assign oSCmd	= rSCmd;
reg [15:0]	rSDLen;					assign oSDLen	= rSDLen;
reg 		rSRdVd;					assign oSRdVd 	= rSRdVd;
//
reg [4:0]	rSSckCntNeg;
//
reg qPosScl, qNegScl;
reg qSSckCntNegCke;

always @(posedge iSysClk)
begin
	// Master からの Signal をシフトレジスタで受信
	rSftSMosi	<= {rSftSMosi[1:0], wSMosi};

	if (iSysRst)	rSftSScl <= 3'b000;
	else			rSftSScl <= {rSftSScl[1:0], wSScl};

	if (iSysRst)	rSftCs1	<= 3'b111;
	else 			rSftCs1	<= {rSftCs1[1:0], 	wSCs1};

	// 受信シーケンス・ステートマシン
	// シーケンス最後の DataGetモードは CS High になるまでデータを受信するだけなので、
	// 処理中には含めず default 扱いとする。
	casex ({rSftCs1[2], qSSckCntNegCke, qNegScl, rSState[1:0]})
		5'b1_xx_xx:		rSState	<= lpSAdrsGet;
		5'b0_11_00:		rSState	<= lpSCmdGet;
		5'b0_11_01:		rSState	<= lpSDataGet;
		// 5'b1_11_10:		rSState	<= lpSAdrsGet;
		default:		rSState	<= rSState;
	endcase

	// 4byte 受信カウント
	if (qSSckCntNegCke)	rSSckCntNeg <= 5'd0;
	else if (qNegScl)	rSSckCntNeg <= rSSckCntNeg + 1'b1;
	else				rSSckCntNeg <= rSSckCntNeg;

	// Posedge を検出し Master からの送信データを受信
	if (qPosScl) 		rSRd <= {rSRd[30:0], rSftSMosi[1]};
	else 				rSRd <= rSRd;

	// アクセス開始アドレスの取得、PSRAM アクセスの場合のアドレス自動更新
	// SPI は PSRAMに比べて極めて低速なため、上位モジュールでアドレスの更新を管理する必要はない。
	// そのため、このロジックでアドレスを更新ようにした
	casex ({rSRdVd, rSState[1:0]})
		3'b1_00:		rSAdrs	<= rSRd;
		3'b1_10:		rSAdrs	<= rSAdrs + 1'b1;
		default:		rSAdrs	<= rSAdrs;
	endcase

	// CMD の取得
	casex ({qSSckCntNegCke, qNegScl, rSState[1:0]})
		4'b11_01:		rSCmd	<= rSRd[25:24];
		4'bxx_10:		rSCmd	<= rSCmd;
		default:		rSCmd	<= 2'd0;
	endcase

	// Data Length の取得
	casex ({qSSckCntNegCke, qNegScl, rSState[1:0]})
		4'b11_01:		rSDLen	<= rSRd[23:8];
		4'b11_10:		rSDLen	<= rSDLen;
		default:		rSDLen	<= 16'd0;
	endcase

	// Data Byte 受信時の 4byte Assert 信号生成
	casex ({qSSckCntNegCke, qNegScl, rSState[1:0]})
		4'b11_10:		rSRdVd	<= 1'b1;
		default:		rSRdVd	<= 1'b0;
	endcase

	// CLK の立ち下がりで MISO データ更新 
	casex ({qNegScl, rSState[1:0]})
		3'b0_10:		rSMiso	<= rSMiso;
		3'b1_10:		rSMiso	<= {rSMiso[30:0], 1'b1};
		default:		rSMiso	<= iSMiso;
	endcase
end

always @*
begin
	// posedge
	case (rSftSScl[2:0])
		3'b011:		qPosScl	<= 1'b1;
		default:	qPosScl	<= 1'b0;
	endcase

	// negedge
	case (rSftSScl[2:0])
		3'b100:		qNegScl	<= 1'b1;
		default:	qNegScl	<= 1'b0;
	endcase

	//
	qSSckCntNegCke <= (rSSckCntNeg == 5'd31);	// 4byte cnt
end

//----------------------------------------------------------
// FPGA Master Side
// 1byte 送信のみ対応しており、4byte(32bit)のデータを送受信する場合は、
// 上位モジュールで対応を行う。
// このロジックはあくまで、1byte 送受信を行うだけにとどめる。
//----------------------------------------------------------
localparam [0:0]
    lpHolTimeIdle 		= 0,
    lpHoldTimeActive 	= 1;
localparam [2:0]
	lpHoldTimeMax   	= 2,
	lpHoldTimeClear 	= 0;
//
reg [7:0] 	rMRd;					assign oMRd		= rMRd;
reg 		rMUsiREd;					assign oMUsiREd	= rMUsiREd;
//
reg 		rMScl;
reg [7:0] 	rMMosi;
wire 		wMMiso;
//
reg [2:0] 	rMSckNegCnt;
//
reg [2:0] 	rMHoldTime;
reg 		rMHoldTimeState;
//
reg 		qMSckCntCke;		// Master CLK の立ち下がり最大カウント
reg 		qMHoldTimeCke;		// データ出力の Hold 時間経過
//
always @(posedge iSysClk) 
begin
	// Sck の生成
	if (!iSPIEn)            rMScl <= 1'b0;
	else if (iDivCke)       rMScl <= ~rMScl;
	else                    rMScl <= rMScl;

	// Sck の立ち下がり回数カウント
	casex ({iSPIEn, iDivCke, rMScl})
		3'b0_xx:		rMSckNegCnt	<= 3'd0;
		3'b0_11:		rMSckNegCnt	<= rMSckNegCnt + 1'b1;
		3'b1_00:		rMSckNegCnt	<= rMSckNegCnt;
	endcase

	// 1byteデータ送信完了
	casex ({iSPIEn, qMSckCntCke, iDivCke, rMScl})
		4'b0_xxx:		rWdVd	<= 1'b0;
		4'b0_111:		rWdVd	<= 1'b1;
		4'b1_000:		rWdVd	<= 1'b0;
	endcase

	// Sck negedge 後の Hold time 生成 ステートマシン
	casex ({iSPIEn, qMHoldTimeCke, rMHoldTimeState[0], iDivCke, rMScl})
		5'b0_xx_xx:    	rMHoldTimeState <= lpHolTimeIdle;
		5'b1_00_11:    	rMHoldTimeState <= lpHoldTimeActive;
		5'b1_11_xx:    	rMHoldTimeState <= lpHolTimeIdle;
		default: 		rMHoldTimeState <= rMHoldTimeState;
	endcase

	// Sck Hold Time Generate -> min 15ns lpHoldTimeActive
	// Sck の立下り時に Hold Time Count Start
	case ({qMHoldTimeCke, rMHoldTimeState})
		2'b00:    		rMHoldTime <= lpHoldTimeClear;
		2'b01:    		rMHoldTime <= rMHoldTime + 1'b1;
		default: 		rMHoldTime <= lpHoldTimeClear;
	endcase

	// MOSI 設定 Mode の Hold Time 経過後データ送信
    if (!iSPIEn)			rMMosi <= iMWd;
    else if (qMHoldTimeCke) rMMosi <= {rMMosi[6:0], 1'b1};
    else                    rMMosi <= rMMosi;

	// MISO 設定 Mode の SCK エッジで受信
	case ({rMScl, iDivCke})
		2'b01:    		rMRd <= {rMRd[6:0], wMMiso};
		default: 		rMRd <= rMRd;
	endcase

	case ({qMSckCntCke, iDivCke, rMScl})
		3'b111:			rMUsiREd <= 1'b1;
		default:		rMUsiREd <= 1'b0;
	endcase
end

always @*
begin
	qMSckCntCke		<= (rMSckNegCnt == 3'd7);
    qMHoldTimeCke 	<= (rMHoldTime == lpHoldTimeMax);
end


//----------------------------------------------------------
// Master / Slave TriState 設定
// High FPGA Master / Low FPGA Slave
//----------------------------------------------------------
localparam [3:0]
	lpCsCapCntMax 	= 15,
	lpCsCapCntClear = 0;

reg [2:0] 	rSftCs2;
reg [1:0] 	rTriStateMSet;
reg [1:0] 	rCsCapture;
reg [7:0] 	rCsCaptureCnt;
reg 		rMSSel;						assign oMSSel = rMSSel;
//
reg qCsCaptureCke;

always @(posedge iSysClk)
begin
	// Reset からの キャプチャー時間
	if (iSysRst) 			rCsCaptureCnt <= lpCsCapCntClear;
	else if (qCsCaptureCke)	rCsCaptureCnt <= rCsCaptureCnt;
	else 					rCsCaptureCnt <= rCsCaptureCnt + 1'b1;

	// カウント中にキャプチャーを行う
	if (qCsCaptureCke) 		rSftCs2 <= rSftCs2;
	else 					rSftCs2	<= {rSftCs2[1:0], wSCs2};

	// Master Slave Select
	if (rSftCs2[2])			rCsCapture <= {1'b0, 1'b1};
	else 					rCsCapture <= {1'b1, 1'b0};

	// GPIO TriState 制御
	if (qCsCaptureCke) 		rTriStateMSet <= rCsCapture;
	else 					rTriStateMSet <= 2'b11;

	// Master / Slave 選択
	if (qCsCaptureCke) 		rMSSel <= rMSSel;
	else 					rMSSel <= rSftCs2[2];
end

always @*
begin
	qCsCaptureCke <= (rCsCaptureCnt == lpCsCapCntMax);
end
//
OBUF  SPI_CONCS	(.O (oSpiConfigCs), .I (1'b1));
// 
IOBUF SPI_SCL 	(.O (wSScl), 	.IO (ioSpiSck), 	.I (rMScl), 	.T (rTriStateMSet[1]));	// master output / slave input
IOBUF SPI_MISO 	(.O (wMMiso),	.IO (ioSpiMiso), 	.I (rSMiso[7]),	.T (rTriStateMSet[0]));	// master input  / slave output
IOBUF SPI_MOSI 	(.O (wSMosi), 	.IO (ioSpiMosi), 	.I (rMMosi[7]), .T (rTriStateMSet[1]));	// master output / slave input
IOBUF SPI_WP 	(.O (wSWp), 	.IO (ioSpiWp),   	.I (1'b1),		.T (rTriStateMSet[1]));
IOBUF SPI_HOLD 	(.O (wSHold),	.IO (ioSpiHold), 	.I (1'b1),		.T (rTriStateMSet[1]));
IOBUF SPI_CS1 	(.O (wSCs1), 	.IO (ioSpiCs1), 	.I (iMSPICs1),	.T (rTriStateMSet[1]));	// master output / slave input
IOBUF SPI_CS2 	(.O (wSCs2), 	.IO (ioSpiCs2), 	.I (iMSPICs2),	.T (rTriStateMSet[1]));	// master output / slave input

endmodule