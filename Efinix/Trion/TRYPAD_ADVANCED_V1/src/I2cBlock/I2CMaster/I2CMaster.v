//----------------------------------------------------------
// Create 2022/7/26
// Author koutakimura
// -
// I2C 通信 Master 処理 -> 参考 HDL Arty-50S の シリアルプロジェクト
// 
// クロックストレッチ未対応
// 最大 255 Byte 連続送信可能、送信データは 1Byte(8bit) 固定
// I2CMaster モジュールの 上位モジュールが 各VD に応じて処理の工夫を行う
// 
//----------------------------------------------------------
module I2CMaster (
	// Enternal Port
	output 			oI2CScl,
	inout  			ioI2CSda,
	// Internal Port
	input 			iDivCke,		// 100 / 400 / 800khz enable信号
	input			iI2CEn,			// 0. Discon / 1. Start
	input 			iTriState,		// 0. Sda Send / 1. Sda Hi-z
	input [ 7:0]	iI2CSend,		// 送信データ
	input [ 7:0]	iI2CBufLen,		// 送信データ配列長 Adrs + Cmd + Data とかなら 3byte指定
	output			oI2CBufVd,		// 指定配列長送信 Assign
	output			oI2CByteVd,		// 1バイト送受信 .Scl 8CLK nege Delay 後に Assign
	output [7:0]	oSdaByte,		// Slave からの 1バイトデータ出力
	// Clk Rst
    input           iSCLK,
    input           iSRST
);


//----------------------------------------------------------
// I2C Master 制御
//----------------------------------------------------------
localparam [2:0] 
	lpDisConnect 		= 3'd0,		// Master の SCL が High の間に SDA を LOW で Start シーケンス
	lpStartCondition 	= 3'd1,		// SCL が High の間に SDA を High で Stop シーケンス
	lpStopCondition 	= 3'd2,		// SCL, SDA が両方 High で 停止中
	lpStoplssue		 	= 3'd6;		// StopCondition を一定時間保持
localparam [3:0] 
	lpSclCntNull 		= 4'd0,
	lpSclCntMax			= 4'd8;		// 1byte + Ack
localparam [7:0]
	lpStoplssueCntMax	= 250;	// StopCondition 保持時間
localparam [5:0]
	lpDelayCntClear		= 6'd0,
	lpDelayCntStart		= 6'd1,
	lpDelayCntMax		= 6'd60; 	// 100MHz = 35clk -> 350ns
//
reg [7:0] 	rSdaByte;			assign oSdaByte		= rSdaByte;
reg 		rBufVd;				assign oI2CBufVd	= rBufVd;
reg 		rByteVd;			assign oI2CByteVd	= rByteVd;
//
reg  rScl, rOSda;
wire wISda;
//
reg [2:0] 	rI2CState;
reg [7:0]	rStoplssueCnt;	// Stop Condition 保持時間
reg [3:0] 	rSclPoseCnt;	// SCL 立ち上がり回数カウント
reg [7:0] 	rBufLenCnt;		// 1byte送信回数カウント
reg [5:0]  	rSdaDelayCnt;	// 遅延時間カウント
reg [2:0] 	rSdaRp;			// sda送信データ参照rp
//
reg 		qStartRdy, qStopRdy, qDisconRdy;	// ステートマシン制御
reg 		qSclPosCke,	qSclCntMax;				// SCL posedge Cnt 制御
reg 		qSdaDelCke, qDelCntStart;			// SDA Delay 制御
reg 		qStoplssueCke;						// Stop Condition 保持
//
OBUF  I2C_SCL 	(.O (oI2CScl), .I (rScl));
IOBUF I2C_SDA 	(.O (wISda), .IO (ioI2CSda), .I (rOSda), .T (iTriState));

always @(posedge iSCLK)
begin
	// I2C ステートマシン
	casex ({iI2CEn, qStoplssueCke, qDisconRdy, qStopRdy, qStartRdy, rI2CState})
		8'b0_xxxx_xxx:		rI2CState <= lpDisConnect;
		8'b1_xxx1_000:		rI2CState <= lpStartCondition;
		8'b1_xx1x_001: 		rI2CState <= lpStopCondition;
		8'b1_x1xx_010:	 	rI2CState <= lpStoplssue;
		8'b1_1xxx_110:	 	rI2CState <= lpDisConnect;
		default:	 		rI2CState <= rI2CState;
	endcase

	// Stop Condition 保持時間生成
	casex ({rI2CState})
		'b110:	 	rStoplssueCnt <= rStoplssueCnt + 1'b1;
		default:	rStoplssueCnt <= 8'd0;
	endcase

	// Start Condition + Device アクセス中の SCL 立ち下がり回数カウント
	casex ({iI2CEn, qSclPosCke, qSclCntMax, rI2CState[0]})
		4'b0_xx_x:		rSclPoseCnt <= lpSclCntNull;
		4'b1_1x_0:		rSclPoseCnt <= lpSclCntNull;		// Discon, Stop 検出
		4'b1_10_1:	 	rSclPoseCnt <= rSclPoseCnt + 1'b1;
		4'b1_11_1:		rSclPoseCnt <= lpSclCntNull;
		default:		rSclPoseCnt <= rSclPoseCnt;
	endcase

	// Start から Stop までの 1byte 送信回数カウント
	casex ({iI2CEn, qSclPosCke, qSclCntMax, rI2CState[0]})
		4'b0_xx_x:		rBufLenCnt <= 8'd0;
		4'b1_1x_0:		rBufLenCnt <= 8'd0;
		4'b1_11_1:	 	rBufLenCnt <= rBufLenCnt + 1'd1;
		default:		rBufLenCnt <= rBufLenCnt;
	endcase

	// SCL 生成
	casex ({iI2CEn, iDivCke, rOSda, rI2CState[1:0]})
		5'b0_xx_xx:		rScl <= 1'b1;
		5'b1_10_00:		rScl <= 1'b0;	// SDA Low に遷移後 SCL Low
		5'b1_1x_01:		rScl <= ~rScl;
		5'b1_1x_10:	 	rScl <= 1'b1;	// Stop Condition
		default:		rScl <= rScl;
	endcase

	// SDA 生成
	// 0 ~ 7clkは通常の1byteデータ送信
	// 8clkは Slave ACK送信のため 0 にする
	casex ({iI2CEn, qSclPosCke, qSclCntMax, qStopRdy, qSdaDelCke, rI2CState[1:0]})
		7'b0x_xxx_xx:		rOSda <= 1'b1;
		7'b1x_xxx_00:		rOSda <= 1'b0;	// Start Condition
		7'b1x_011_01:	 	rOSda <= 1'b0;	// 指定バイト送信時、Stop Condition に備える
		7'b1x_101_01: 		rOSda <= 1'b0;	// 受信時の Slave への Ack応答
		7'b1x_001_01: 		rOSda <= iI2CSend[rSdaRp];
		7'b11_xxx_10: 		rOSda <= 1'b1;	// Stop Condition
		default:	 		rOSda <= rOSda;
	endcase

	// Rp 更新
	casex ({iI2CEn, qSclPosCke, rI2CState[0]})
		3'b0_x_x:		rSdaRp <= 3'd7;
		3'b1_1_0:		rSdaRp <= 3'd7;
		3'b1_1_1:	 	rSdaRp <= rSdaRp - 1'b1;
		default: 		rSdaRp <= rSdaRp;
	endcase

	// sda 送信データの変化遅延タイミング生成回路
	// scl の立下りから最低300ns Sdaの状態を保持する必要があるため遅延用カウンタを設ける
	casex ({iI2CEn, qSdaDelCke, qSclPosCke, qDelCntStart})
		4'b0_xx_x: 	rSdaDelayCnt <= lpDelayCntClear;
		4'b1_01_x: 	rSdaDelayCnt <= lpDelayCntStart;
		4'b1_10_1: 	rSdaDelayCnt <= lpDelayCntClear;
		4'b1_0x_1: 	rSdaDelayCnt <= rSdaDelayCnt + 1'b1;
		default: 	rSdaDelayCnt <= rSdaDelayCnt;
	endcase

	// 全バイトデータ送信時 Assign
	casex ({qSclPosCke, qStopRdy})
		2'b11:	 	rBufVd <= 1'b1;
		default:	rBufVd <= 1'b0;
	endcase

	// 1byteデータ送受信時 Assign
	casex ({qSclCntMax, qSdaDelCke})
		2'b11:	 	rByteVd <= 1'b1;
		default:	rByteVd <= 1'b0;
	endcase

	// Sda Input Data
	casex ({iI2CEn, iTriState, qSclPosCke})
		3'b0_xx:	rSdaByte <= 8'd0;
		3'b1_11:	rSdaByte <= {rSdaByte[6:0], wISda};
		default: 	rSdaByte <= rSdaByte;
	endcase
end

always @*
begin
	qStartRdy 		<= !(rScl | rOSda);				// Start Condition
	qStopRdy		<= (iI2CBufLen == rBufLenCnt);	// Stop Condition
	qDisconRdy		<= (rScl & rOSda);				// Disconnect
	//
	qSclPosCke		<= (iDivCke & rScl);
	qSclCntMax		<= (rSclPoseCnt == lpSclCntMax);
	//
	qSdaDelCke		<= (rSdaDelayCnt == lpDelayCntMax);
	qDelCntStart 	<= (rSdaDelayCnt != lpDelayCntClear);
	qStoplssueCke	<= (rStoplssueCnt == lpStoplssueCntMax);
end

endmodule