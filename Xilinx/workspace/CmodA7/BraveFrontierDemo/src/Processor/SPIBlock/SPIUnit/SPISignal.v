//----------------------------------------------------------
// Create 2022/8/5
// Author koutakimura
// -
// SPI 通信の Master / Slave の信号生成 モジュール
// Mode0 固定
// -
// 2022-08-27 : ILA を入れて RaspberryPi の SPI 信号をデバッグした
// 				Write のみだったら 10MHz 動作可能だが、Read の場合は 4MHz 程度の動作となった
// 				取り合えず動作はして Unit ととして独立はしているので、
// 				速度改善が必要になったら修正することにする。
// 
//----------------------------------------------------------
module SPISignal (
	// External Port
    inout           ioSpiSck,
    inout           ioSpiMiso,
    inout           ioSpiMosi,
    inout           ioSpiWp,
    inout           ioSpiHold,
    output          oSpiConfigCs,
    inout           ioSpiCs,
    input           iMSSel,
	// Internal Port FPGA Slave Side
	input	[31:0]	iSMiso,
	output 	[31:0]	oSRd,
	output 	[31:0]	oSAdrs,
	output 	[2:0]	oSCmd,
	output 	[15:0]	oSDLen,
	output 			oSREd,
	// Internal Port FPGA Master Side
    input  	[7:0]   iMWd,               // Master Write Data
    output 	[7:0]   oMRd,	            // Master Read Data
    output          oMSpiIntr,          // Master Send/Rev Complete Interrupt
	input 			iMSPICs,
	// Csr
    input           iSPIEn,             // 0. disconnect 1. active
	input 			iDivCke,
	// Master Slave Select
	output 			oMSSel,
	// CLK Reset
    input           iSysClk,
	input 			iSysRst,
	//
	output [3:0]	oTestPort
);


//----------------------------------------------------------
// FPGA Slave
// 4byte Adrs + dummy + Cmd + 2byte Data Length + n32bitData... 
// -
// 最初に 8byte の命令シーケンスを受信する
// Cmd : 0. Non, 1. Csr Write, 2. Csr Read, 3. PSRAM Write, 4. PSRAM Read
// -
// Csr 操作時は 連続アクセスは可能としない、必ず Data Length は 4byte 固定とする
// ※ RAM 操作時は Data Length は最大 4096 byte とする 2022-09-11 時点
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
reg [31:0]	rSMiso;
wire wSWp,  wSHold;
wire wSCs, wSCs2;
//
reg [2:0] 	rSftSScl, rSftCs ;
reg [1:0]	rSftSMosi;
//
//
reg [31:0]	rSRd;					assign oSRd   	= rSRd;
reg [31:0]	rSAdrs;					assign oSAdrs	= rSAdrs;
reg [2:0]	rSCmd;					assign oSCmd	= rSCmd;
reg [15:0]	rSDLen;					assign oSDLen	= rSDLen;
reg 		rSREd;					assign oSREd 	= rSREd;
//
reg [4:0]	rSSckCntNeg;
//
reg qPosScl, qNegScl;
reg qSSckCntNegCke;
reg qSActive;

always @(posedge iSysClk)
begin
	// Master からの Signal をシフトレジスタで受信
	if (iSysRst)		rSftSMosi <= 3'b000;
	else if (qSActive)	rSftSMosi <= {rSftSMosi[0:0], wSMosi};
	else 				rSftSMosi <= 3'b000;

	if (iSysRst)		rSftSScl <= 3'b000;
	else if (qSActive)	rSftSScl <= {rSftSScl[1:0], wSScl};
	else				rSftSScl <= 3'b000;

	if (iSysRst)		rSftCs	<= 3'b111;
	else if (qSActive)	rSftCs	<= {rSftCs[1:0],wSCs};
	else 				rSftCs	<= 3'b111;

	// 受信シーケンス・ステートマシン
	// シーケンス最後の DataGetモードは CS High になるまでデータを受信するだけなので、
	// 処理中には含めず default 扱いとする。
	casex ({rSftCs[2], qSSckCntNegCke, qNegScl, rSState[1:0]})
		5'b1_xx_xx:		rSState	<= lpSAdrsGet;
		5'b0_11_00:		rSState	<= lpSCmdGet;
		5'b0_11_01:		rSState	<= lpSDataGet;
		// 5'b1_11_10:		rSState	<= lpSAdrsGet;
		default:		rSState	<= rSState;
	endcase

	// 4byte 受信カウント
	casex ({rSftCs[2], qNegScl})
		2'b1x:			rSSckCntNeg <= 5'd0;
		2'b01:			rSSckCntNeg <= rSSckCntNeg + 1'b1;
		default:		rSSckCntNeg <= rSSckCntNeg;
	endcase

	// Posedge を検出し Master からの送信データを受信
	if (qPosScl)		rSRd <= {rSRd[30:0], rSftSMosi[1]};
	else 				rSRd <= rSRd;

	// アクセス開始アドレスの取得、PSRAM アクセスの場合のアドレス自動更新
	// SPI は RAMに比べて極めて低速なため、上位モジュールでアドレスの更新を管理する必要はない。
	// そのため、このロジックでアドレスを更新するようにした
	casex ({qSSckCntNegCke, qNegScl, rSState[1:0]})
		4'b11_00:		rSAdrs	<= rSRd;
		4'b11_10:		rSAdrs	<= rSAdrs + 1'b1;
		default:		rSAdrs	<= rSAdrs;
	endcase

	// CMD の取得
	casex ({qSSckCntNegCke, qNegScl, rSState[1:0]})
		4'b11_01:		rSCmd	<= rSRd[18:16];
		4'bxx_10:		rSCmd	<= rSCmd;
		default:		rSCmd	<= 3'd0;
	endcase

	// Data Length の取得
	casex ({qSSckCntNegCke, qNegScl, rSState[1:0]})
		4'b11_01:		rSDLen	<= rSRd[15:0];
		4'bxx_10:		rSDLen	<= rSDLen;
		default:		rSDLen	<= 16'd0;
	endcase

	// Data Byte 受信時の 4byte Assert 信号生成
	casex ({qSSckCntNegCke, qPosScl, rSState[1:0]})
		4'b11_10:		rSREd	<= 1'b1;
		default:		rSREd	<= 1'b0;
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
	case ({rSftCs[2], rSftSScl[2:0]})
		4'b0011:	qPosScl	<= 1'b1;
		default:	qPosScl	<= 1'b0;
	endcase

	// negedge
	case ({rSftCs[2], rSftSScl[2:0]})
		4'b0100:	qNegScl	<= 1'b1;
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
reg [7:0] 	rMRd;					assign oMRd			= rMRd;
reg 		rMSpiIntr;				assign oMSpiIntr	= rMSpiIntr;
//
reg 		rMScl;
reg [7:0] 	rMMosi;
wire 		wMMiso;
//
reg [2:0] 	rMSckNegCnt;
//
reg [2:0] 	rMHoldTime;
reg [0:0]	rMHoldTimeState;
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
		3'b1_11:		rMSckNegCnt	<= rMSckNegCnt + 1'b1;
		default:		rMSckNegCnt	<= rMSckNegCnt;
	endcase

	// Sck negedge 後の Hold time 生成 ステートマシン
	casex ({iSPIEn, qMHoldTimeCke, rMHoldTimeState[0:0], iDivCke, rMScl})
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

	// 1byte データ操作完了の割り込み出力
	case ({qMSckCntCke, iDivCke, rMScl})
		3'b111:			rMSpiIntr <= 1'b1;
		default:		rMSpiIntr <= 1'b0;
	endcase
end

always @*
begin
	qMSckCntCke		<= (rMSckNegCnt == 3'd7);
    qMHoldTimeCke 	<= (rMHoldTime == lpHoldTimeMax);
end


//----------------------------------------------------------
// Master / Slave TriState 設定
// Low FPGA Master / High FPGA Slave
//----------------------------------------------------------
reg [2:0]	rMSSel;						assign oMSSel = rMSSel[2];
reg 		qMSSel;
wire 		wMSSel;
//
always @(posedge iSysClk)
begin
	if (iSysRst)	rMSSel <= 3'b111;
	else 			rMSSel <= {rMSSel[1:0], wMSSel};
end

always @*
begin
	qSActive 	<= rMSSel[2];
	// qMActive <= (rMSSel[2] == 1'b1);
end

//
OBUF  SPI_CONCS	(.O (oSpiConfigCs), .I (1'b1));
IBUF  SPI_MS_SEL(.O (wMSSel), .I (iMSSel));
//
IOBUF SPI_CS 	(.O (wSCs), 	.IO (ioSpiCs), 		.I (iMSPICs),		.T (rMSSel[2])	);	// master output / slave input
IOBUF SPI_SCL 	(.O (wSScl), 	.IO (ioSpiSck), 	.I (rMScl), 		.T (rMSSel[2])	);	// master output / slave input
IOBUF SPI_MISO 	(.O (wMMiso),	.IO (ioSpiMiso), 	.I (rSMiso[31]),	.T (~rMSSel[2])	);	// master input  / slave output
IOBUF SPI_MOSI 	(.O (wSMosi), 	.IO (ioSpiMosi), 	.I (rMMosi[7]), 	.T (rMSSel[2])	);	// master output / slave input
IOBUF SPI_WP 	(.O (wSWp), 	.IO (ioSpiWp),   	.I (1'b1),			.T (rMSSel[2])	);
IOBUF SPI_HOLD 	(.O (wSHold),	.IO (ioSpiHold), 	.I (1'b1),			.T (rMSSel[2])	);
//
OBUF TestPort0	(.O (oTestPort[0]),	.I (iSysRst));
OBUF TestPort1	(.O (oTestPort[1]),	.I (rSMiso[31]));
OBUF TestPort2	(.O (oTestPort[2]),	.I (wSMosi));
OBUF TestPort3	(.O (oTestPort[3]),	.I (wSCs));
endmodule