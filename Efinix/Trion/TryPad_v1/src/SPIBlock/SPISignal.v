//----------------------------------------------------------
// Create 2022/8/5
// Author koutakimura
// -
// SPI 通信の Master / Slave の信号生成 モジュール
// CPOL/CPHA 0 固定
// -
// 2022-08-27 : ILA を入れて RaspberryPi の SPI 信号をデバッグした
// 				Write のみだったら 10MHz 動作可能だが、Read の場合は 4MHz 程度の動作となった
// 				取り合えず動作はして Unit ととして独立はしているので、
// 				速度改善が必要になったら修正することにする。
// 
// V1.1 USIB 更新版に対応
// V1.2 Slave mode の動作切り替えを rSpiDir から rnSpiDir に変更
//----------------------------------------------------------
module SPISignal (
	// External Port
	input 			iSlaveSck,
	input 			iSlaveMosi,
	output 			oSlaveMiso,
	input 			iSlaveCs,
	output 			oMasterSck,
	output 			oMasterMosi,
	input 			iMasterMiso,
	output 			oMasterCs,
	input 			iSpiDir,
	// Internal Port FPGA Slave Side
	input	[31:0]	iMUsiRd,
	output 	[31:0]	oSpiRd,
	output 	[31:0]	oSpiAdrs,
	output 			oSpiREd,
	// Internal Port FPGA Master Side
    input  	[7:0]   iMWd,               // Master Write Data
    output 	[7:0]   oMRd,	            // Master Read Data
    output          oMSpiIntr,          // Master Send/Rev Complete Interrupt
	input 			iMSPICs,
	// Csr
    input           iSPIEn,             // 0. disconnect 1. active
	input 			iDivCke,
	// Master Slave Select
	output 			oSpiDir,
	output 			onSpiDir,
	// CLK Reset
	input 			iSRST,
    input           iSCLK
);


//----------------------------------------------------------
// Master / Slave TriState 設定
// Low FPGA Master / High FPGA Slave
//----------------------------------------------------------
reg [2:0] 	rSpiDir;		assign oSpiDir  = rSpiDir[2];
reg 		rnSpiDir;		assign onSpiDir = rnSpiDir;

always @(posedge iSCLK)
begin
	if (iSRST)	rSpiDir <= 3'b111;
	else 		rSpiDir <= {rSpiDir[1:0], iSpiDir};

	rnSpiDir <= ~rSpiDir[1];
end

//----------------------------------------------------------
// FPGA Slave
// Adrs -> Data の順番で 4byte 受信する
//----------------------------------------------------------
reg [31:0]	rSlaveMiso;				assign oSlaveMiso = rSlaveMiso[31];
reg [2:0] 	rSlaveSck, 		rSlaveCs;
reg [1:0]	rSlaveMosi;
reg [31:0]	rSRd;					assign oSpiRd  	= rSRd;
reg [31:0]	rSAdrs;					assign oSpiAdrs	= {rSAdrs[31],rRwCmd,rSAdrs[29:0]};
reg			rRwCmd;
									assign oSpiREd 	= 1'b0;
reg [4:0]	rSSckCntNeg;
reg [7:0]	rGetDataSel;
reg 		qGetDataSelCke;
reg 		qPedgeSck, 		qNedgeSck;
reg 		qSSckCntNegCke;

always @(posedge iSCLK)
begin
	if (rnSpiDir)		rSlaveMosi	<= {rSlaveMosi[0:0], iSlaveMosi};
	else 				rSlaveMosi	<= 2'b00;

	if (rnSpiDir)		rSlaveSck	<= {rSlaveSck[1:0], iSlaveSck};
	else				rSlaveSck	<= 3'b000;

	if (rnSpiDir)		rSlaveCs	<= {rSlaveCs[1:0],iSlaveCs};
	else 				rSlaveCs	<= 3'b111;

	if (rSlaveCs[2])		 	rGetDataSel[0] <= 1'd0;
	else if (qGetDataSelCke) 	rGetDataSel[0] <= 1'b1;
	else 					 	rGetDataSel[0] <= rGetDataSel[0];
	
	if (rSlaveCs[2])		 	rGetDataSel[7:1] <= 7'd0;
	else 					 	rGetDataSel[7:1] <= {rGetDataSel[6:1],rGetDataSel[0]};

	if (rSlaveCs[2])			rSSckCntNeg <= 5'd0;
	else if (qNedgeSck)			rSSckCntNeg <= rSSckCntNeg + 1'b1;
	else 						rSSckCntNeg <= rSSckCntNeg;

	if (qPedgeSck) 				rSRd <= {rSRd[30:0], rSlaveMosi[1]};
	else 		 				rSRd <= rSRd;

	casex ({rSlaveCs[2], qSSckCntNegCke, qNedgeSck, rGetDataSel[0]})
		'b0110:	 rSAdrs	<= rSRd;
		'b1xxx:	 rSAdrs	<= 32'd0;
		default: rSAdrs	<= rSAdrs;
	endcase
	
	case ({rSAdrs[30], qSSckCntNegCke, qNedgeSck, rGetDataSel[0]})
		'b1111:	 rRwCmd	<= 1'b1;	// write cmd enable
		default: rRwCmd	<= 1'b0;
	endcase

	case ({qNedgeSck, rGetDataSel[7]})
		'b01:	 rSlaveMiso	<= rSlaveMiso;
		'b11:	 rSlaveMiso	<= {rSlaveMiso[30:0], 1'b1};
		default: rSlaveMiso	<= iMUsiRd;
	endcase
end

always @*
begin
	case ({rSlaveCs[2], rSlaveSck[2:0]})
		4'b0011: qPedgeSck	<= 1'b1;
		default: qPedgeSck	<= 1'b0;
	endcase

	case ({rSlaveCs[2], rSlaveSck[2:0]})
		4'b0100: qNedgeSck	<= 1'b1;
		default: qNedgeSck	<= 1'b0;
	endcase

	qSSckCntNegCke <=  (rSSckCntNeg == 5'd31);
	qGetDataSelCke <= &{qSSckCntNegCke,qNedgeSck};
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

reg [7:0] 	rMRd;
reg 		rMSpiIntr;
reg 		rMScl;
reg [7:0] 	rMMosi;
reg [2:0] 	rMSckNegCnt;
reg [2:0] 	rMHoldTime;
reg [0:0]	rMHoldTimeState;
reg 		qMSckCntCke;		// Master CLK の立ち下がり最大カウント
reg 		qMHoldTimeCke;		// データ出力の Hold 時間経過

always @(posedge iSCLK) 
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
		2'b01:    		rMRd <= {rMRd[6:0], iMasterMiso};
		default: 		rMRd <= rMRd;
	endcase

	// 1byte データ操作完了の割り込み出力
	// Assert されると、CSR 空間の SpiEn がクリアされる。
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

assign oMRd		= rMRd;
assign oMSpiIntr= rMSpiIntr;
assign oMasterSck	= rMScl;
assign oMasterMosi	= rMMosi[7];
assign oMasterCs	= iMSPICs;


endmodule