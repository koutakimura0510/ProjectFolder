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
//----------------------------------------------------------
module I2CMasterMux (
	// UpperModule
	output	[15:0]	oI2CGetKeyPad,
	// I2CMaster
	output 			oTriState,		// 0. Sda Send / 1. Sda Hi-z
	output 	[ 7:0]	oI2CSend,		// 送信データ
	output 	[ 7:0]	oI2CBufLen,		// 送信データ配列長 Adrs + Cmd + Data とかなら 3byte指定
	input			iI2CBufVd,		// 指定配列長送信 Assign
	input			iI2CByteVd,		// 1バイト送受信 .Scl 8CLK nege Delay 後に Assign
	input 	[ 7:0]	iSdaByte,		// Slave からの 1バイトデータ入力
	// Clk Rst
    input           iSysClk,
    input           iSysRst
);


//----------------------------------------------------------
// 
//----------------------------------------------------------
localparam [7:0] 
	lpKeyPadAdrs1	= 'h02,		//  Left Key Pad Adrs
	lpKeyPadAdrs2	= 'h03,		//	Right Key Pad Adrs
	lpGyroAdrs		= 'h04;		//	Gyro Sensor Adrs
localparam [1:0] 
	lpDeviceKey1	= 'b01,
	lpDeviceKey2	= 'b10,
	lpDeviceGyro	= 'b11;
localparam lpByteCntWidth	= 4;
//
reg [15:0] 	rRecData;			assign oI2CGetKeyPad = rRecData;
reg [7:0] 	rSendData;			assign oI2CSend 	= rSendData;
reg [7:0]	rI2CBufLen;			assign oI2CBufLen 	= rI2CBufLen;
reg 		rTriState;			assign oTriState	= rTriState;
//
reg [1:0] 	rDeviceSel;
//

always @(posedge iSysClk)
begin
	// Device Select
	casex ({iSysRst, iI2CBufVd, rDeviceSel[1:0]})
		4'b1xxx:	rDeviceSel <= lpDeviceKey1;
		4'b0101:	rDeviceSel <= lpDeviceKey2;
		4'b0110:	rDeviceSel <= lpDeviceGyro;
		4'b0111:	rDeviceSel <= lpDeviceKey1;
		default:	rDeviceSel <= rDeviceSel;
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
	casex ({iSysRst, iI2CByteVd})
		2'b1_x:		rTriState <= 1'b0;
		2'b0_1:		rTriState <= ~rTriState;
	endcase

	// KeyPad 受信データ
	if (iSysRst) 		rRecData <= 16'd0;
	else if (iI2CBufVd)	rRecData <= {rRecData[7:0], iSdaByte};
	else				rRecData <= rRecData;

	if (iSysRst) 		rI2CBufLen <= 8'd2;
	else 		 		rI2CBufLen <= 8'd2;
end

endmodule