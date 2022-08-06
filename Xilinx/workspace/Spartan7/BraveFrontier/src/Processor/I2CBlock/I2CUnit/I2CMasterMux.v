//----------------------------------------------------------
// Create 2022/7/30
// Author koutakimura
// -
// 下記モジュールのインターコネクトとして動作
// UpperModule 	:取得データを出力 
// I2CMaster	:送信データと GPIO TriState 制御
// --
// Slave KeyPad1,2 は アドレス + 空データ(受信データ) 構成のため、
// データは設定することはなく、アドレスだけ送信する。
// 
// 2022/08/03: Master に対する Enable 制御を、このモジュールが行うように変更
// 
//----------------------------------------------------------
module I2CMasterMux (
	// UpperModule
	output	[15:0]	oI2CGetKeyPad,
	// I2CMaster
	output 			oTriState,		// 0. Sda Send / 1. Sda Hi-z
	output 	[ 7:0]	oI2CSend,		// 送信データ
	output 	[ 7:0]	oI2CBufLen,		// 送信データ配列長 Adrs + Cmd + Data とかなら 3byte指定
	output 			oI2CEn,			// Master に Enable 出力
	input 			iI2CEn,			// Csr Enable 入力
	input			iI2CBufVd,		// 指定配列長送信 Assign
	input			iI2CByteVd,		// 1バイト送受信 .Scl 8CLK nege Delay 後に Assign
	input 	[ 7:0]	iSdaByte,		// Slave からの 1バイトデータ入力
	// Clk Rst
    input           iSysClk,
    input           iSysRst
);


//----------------------------------------------------------
// インターコネクト制御
//----------------------------------------------------------
localparam [7:0] 
	lpKeyPadAdrs1	= 8'h02,		//  Left Key Pad Adrs
	lpKeyPadAdrs2	= 8'h03,		//	Right Key Pad Adrs
	lpGyroAdrs		= 8'h04;		//	Gyro Sensor Adrs
localparam [2:0] 
	lpDeviceStop	= 3'b000,		// 停止中
	lpDeviceKey1	= 3'b001,
	lpDeviceKey2	= 3'b010,
	lpDeviceGyro	= 3'b011,
	lpDeviceComp	= 3'b100;		// Complete I2C シーケンス終了時 Csr Enable Low に切り替わるまで待機
localparam lpByteCntWidth	= 4;
//
reg [15:0] 	rRecData;			assign oI2CGetKeyPad = rRecData;
reg [7:0] 	rSendData;			assign oI2CSend 	 = rSendData;
reg [7:0]	rI2CBufLen;			assign oI2CBufLen 	 = rI2CBufLen;
reg 		rTriState;			assign oTriState	 = rTriState;
reg 		rI2CEn;				assign oI2CEn		 = rI2CEn;
//
reg [2:0] 	rDeviceSel;
//

always @(posedge iSysClk)
begin
	// Device Select
	casex ({iSysRst, iI2CEn, iI2CBufVd, rDeviceSel[2:0]})
		6'b1x_x_xxx:	rDeviceSel <= lpDeviceStop;
		// 6'b00_x_000:	rDeviceSel <= lpDeviceStop;
		6'b01_x_000:	rDeviceSel <= lpDeviceKey1;
		6'b0x_1_001:	rDeviceSel <= lpDeviceKey2;
		6'b0x_1_010:	rDeviceSel <= lpDeviceGyro;
		6'b0x_1_011:	rDeviceSel <= lpDeviceComp;
		6'b00_x_100:	rDeviceSel <= lpDeviceStop;
		default:		rDeviceSel <= rDeviceSel;
	endcase

	// I2C Enable
	casex ({rDeviceSel[2:0]})
		3'b000:		rI2CEn <= 1'b0;
		3'b100:		rI2CEn <= 1'b0;
		default:	rI2CEn <= 1'b1;
	endcase

	// 送信データ設定
	// TODO 後々ジャイロセンサの処理追加
	casex ({rDeviceSel[1:0]})
		2'b01:		rSendData <= lpKeyPadAdrs1;
		2'b10:		rSendData <= lpKeyPadAdrs2;
		2'b11:		rSendData <= lpGyroAdrs;
		default:	rSendData <= rSendData;
	endcase

	// KeyPad は 1Byteは Ack 受信
	// 2Byte は Ack送信
	// TODO ここから下記の処理は 2byte固定のため、後々可変式に対応
	casex ({iI2CEn, iI2CByteVd})
		2'b0_x:		rTriState <= 1'b0;
		2'b1_1:		rTriState <= ~rTriState;
		default:	rTriState <= rTriState;
	endcase

	// KeyPad 受信データ
	if (iSysRst) 		rRecData <= 16'd0;
	else if (iI2CBufVd)	rRecData <= {rRecData[7:0], iSdaByte};
	else				rRecData <= rRecData;

	if (iSysRst) 		rI2CBufLen <= 8'd2;
	else 		 		rI2CBufLen <= 8'd2;
end

endmodule