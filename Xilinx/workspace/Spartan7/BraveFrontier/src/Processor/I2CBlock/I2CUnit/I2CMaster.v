//----------------------------------------------------------
// Create 2022/7/26
// Author koutakimura
// -
// I2C 通信 Master 処理 -> 参考 HDL Arty-50S の シリアルプロジェクト
// 最大 255 Byte 連続送信可能、送信データは 1Byte(8bit) 固定
// I2CMaster モジュールの 上位モジュールが VD シグナルに応じて データ変更
// このモジュールの役割は データを送信するだけ
//----------------------------------------------------------
module I2CMaster (
	// Enternal Port
	output 			oI2cScl,
	inout  			ioI2CSda,
	// Internal Port
	input 			iDivCke,		// 100 / 400 / 800khz enable信号
	input			iI2CEn,			// 0. Discon / 1. Start
	input 			iTriState,		// 0. Sda Send / 1. Sda Hi-z
	input [ 7:0]	iI2CSend,		// 送信データ
	input [ 7:0]	iI2CBufLen,		// 送信データ配列長 Adrs + Cmd + Data とかなら 3byte指定
	output			oI2CBufVd,		// 指定配列長送信完了信号
	output			oI2CByteVd,		// 1バイト送信完了信号
	// Slave
	output [ 7:0]	oSdaByte,		// Slave からの 1バイトデータ
	output 			oSdaVd,			// Slave からの 1バイトデータ出力時 Assign
	// Clk Rst
    input           iSysClk,
    input           iSysRst
);


//----------------------------------------------------------
// I2C Master 制御
//----------------------------------------------------------
localparam [2:0] 
	lpDisConnect 		= 3'd0,		// Master の SCL が High の間に SDA を LOW で Start シーケンス
	lpStartCondition 	= 3'd1,		// SCL が High の間に SDA を High で Stop シーケンス
	lpStopCondition 	= 3'd2;		// SCL, SDA が両方 High で 停止中
localparam [3:0] 
	lpSclCntNull 		= 4'd0,
	lpSclCntMax			= 4'd8,
localparam [5:0]
	lpDelayCntClear		= 6'd0,
	lpDelayCntMax		= 6'd35; 	// 100MHz = 35clk -> 300ns
//
reg rI2CScl;					assign oI2cScl 		= rI2CScl;
reg rI2CSda;					assign ioI2CSda		= rI2CSda;
reg rBufVd;						assign oI2CBufVd	= rBufVd;
reg rByteVd;					assign oI2CByteVd	= rByteVd;

OBUF I2C_SCL 	(.O (oI2cScl), .I (rSftClk));
IOBUF I2C_SDA 	(.O (oSftClk),	.IO (ioI2CSda), .I (rI2CSda), .T (iTriState));
//
reg [2:0] 	rI2CState;
reg [3:0] 	rSclPoseCnt;	// SCL 立ち上がり回数カウント
reg [31:0] 	rBufLenCnt;		// 1byte送信回数カウント
reg [5:0]  	rSdaDelayCnt;	// 遅延時間カウント
reg [2:0] 	rSdaRp;			// sda送信データ参照rp
//
reg 		qStartRdy, qStopRdy, qDisconRdy;	// ステートマシン制御
reg 		qSclPosCke,	qSclCntMax;				// SCL posedge Cnt 制御
reg 		qSdaDelCke;

always @(posedge iSysClk)
begin
	// I2C 規格 ステートマシン
	casex ({iSysRst, iI2CEn, qDisconRdy, qStopRdy, qStartRdy, rI2CState})
		8'b1_x_xxx_xxx:		rI2CState <= lpDisConnect;
		8'bx_0_xxx_xxx:		rI2CState <= lpDisConnect;
		8'b0_1_xx1_000:		rI2CState <= lpStartCondition;
		8'b0_1_x1x_001: 	rI2CState <= lpStopCondition;
		8'b0_1_1xx_010: 	rI2CState <= lpDisConnect;
		default:	 		rI2CState <= rI2CState;
	endcase

	// Start Condition 発行後の SCL 立ち上がり回数カウント
	casex ({iSysRst, iI2CEn, qSclPosCke, qSclCntMax, rI2CState})
		7'b1_x_x_x_xxx:		rSclPoseCnt <= lpSclCntNull;
		7'bx_0_x_x_xxx:		rSclPoseCnt <= lpSclCntNull;
		7'b0_1_1_x_xx0:		rSclPoseCnt <= lpSclCntNull;	// Discon, Stop 検出
		7'b0_1_1_0_001: 	rSclPoseCnt <= rSclPoseCnt + 1'b1;
		7'b0_1_1_1_001: 	rSclPoseCnt <= lpSclCntNull;
		default:	 		rSclPoseCnt <= rSclPoseCnt;
	endcase

	// Start から Stop までの 1byte 送信回数カウント
	casex ({iSysRst, iI2CEn, qSclPosCke, qSclCntMax, rI2CState})
		7'b1_x_x_x_xxx:		rBufLenCnt <= 8'd0;
		7'bx_0_x_x_xxx:		rBufLenCnt <= 8'd0;
		7'b0_1_1_x_xx0:		rBufLenCnt <= 8'd0;
		7'b0_1_1_1_001: 	rBufLenCnt <= rBufLenCnt + 1'd1;
		default:	 		rBufLenCnt <= rBufLenCnt;
	endcase

	// SCL 生成
	casex ({iSysRst, iI2CEn, iDivCke, rI2CSda, rI2CState})
		7'b1_x_x_x_xxx:		rI2CScl <= 1'b1;
		7'bx_0_x_x_xxx:		rI2CScl <= 1'b1;
		7'b0_1_1_0_000:		rI2CScl <= 1'b0;	// SDA Low に遷移後 SCL Low
		7'b0_1_1_x_001: 	rI2CScl <= ~rI2CScl;
		7'b0_1_1_x_010: 	rI2CScl <= 1'b1;
		default:	 		rI2CScl <= rI2CScl;
	endcase

	// sda 生成
	// 0 ~ 7clkは通常の1byteデータ送信
	// 8clkはACK受信のためハイ・インピーダンスにする
	casex ({iSysRst, iI2CEn, qSclPosCke, qSclCntMax, qStopRdy, qSdaDelCke, rI2CState})
		9'b1_x_x_xxx_xxx:	rI2CSda <= 1'b1;
		9'bx_0_x_xxx_xxx:	rI2CSda <= 1'b1;
		9'b0_1_x_xxx_000:	rI2CSda <= 1'b0;	// Start Condition
		9'b0_1_x_011_001: 	rI2CSda <= 1'b0;	// 指定バイト送信時、Stop Condition に備える
		9'b0_1_x_101_001: 	rI2CSda <= 1'bz;
		9'b0_1_x_001_001: 	rI2CSda <= iI2CSend[rSdaRp];
		9'b0_1_1_xxx_010: 	rI2CSda <= 1'b1;	// Stop Condition
		default:	 		rI2CSda <= rI2CSda;
	endcase

	// Rp 更新
	casex ({iSysRst, iI2CEn, qSclPosCke, rI2CState})
		6'b1_x_x_xxx:		rSdaRp <= 3'd7;
		6'bx_0_x_xxx:		rSdaRp <= 3'd7;
		6'b0_1_1_xx0:		rSdaRp <= 3'd7;
		6'b0_1_1_001:	 	rSdaRp <= rSdaRp - 1'b1;
		default:	 		rSdaRp <= rSdaRp;
	endcase

	// sda 送信データの変化遅延タイミング生成回路
	// scl の立下りから最低300ns Sdaの状態を保持する必要があるため遅延用カウンタを設ける
	if (iSysRst) 		rSdaDelayCnt <= lpDelayCntClear;
	else if (!rI2CScl) 	rSdaDelayCnt <= rSdaDelayCnt + 1'b1;
	else 				rSdaDelayCnt <= lpDelayCntClear;

	// 全バイトデータ送信時にenable信号を出力
	if (iSysRst) 		rBufVd <= 1'b0;
	else if (qStopRdy)	rBufVd <= 1'b1;
	else 				rBufVd <= 1'b0;

	// 1byteデータ送信時にenable信号を出力
	casex ({iSysRst, qSclCntMax, iDivCke, rI2CScl})
		4'b1_xxx:		rByteVd <= 1'b0;
		4'b0_110:	 	rByteVd <= 1'b1;
		default: 		rByteVd <= 1'b0;
	endcase
end

always @*
begin
	qStartRdy 	<= !(rI2CScl | rI2CSda);		// Start Condition
	qStopRdy	<= (iI2CBufLen == rBufLenCnt);	// Stop Condition
	qDisconRdy	<= (rI2CScl & rI2CSda);			// Disconnect
	//
	qSclPosCke	<= (iDivCke & rI2CScl);
	qSclCntMax	<= (rSclPoseCnt == lpSclCntMax);
	//
	qSdaDelCke	<= (rSdaDelayCnt == lpDelayCntMax);
end

endmodule