//----------------------------------------------------------
// Create 2022/7/24
// Author koutakimura
// -
// 外部シフトレジスタに接続されている GPIO ポートを制御
// 
//----------------------------------------------------------
module LedSftReg (
	// Internal Port
	output [1:0] 			oSftEdge,
	output 					oSftClk,
	input  [7:0]			iGpioLed,
	input  [7:0]			iGpioDiv,
    // CLK Reset
    input           		iSysClk,
    input           		iSysRst
);


//----------------------------------------------------------
// 分周値に応じてカウントし CLK 生成
//----------------------------------------------------------
reg rSftClk;
reg [7:0] rGpioDivCnt;
reg qGpioDivEn;

always @(posedge iSysClk)
begin
	if (iSysRst)			rGpioDivCnt <= 8'd0;
	else if (qGpioDivEn)	rGpioDivCnt <= 8'd0;
	else					rGpioDivCnt <= rGpioDivCnt + 1'b1;

	if (iSysRst)			rSftClk <= 1'd0;
	else if (qGpioDivEn) 	rSftClk <= ~rSftClk;
	else					rSftClk <= rSftClk;
end

always @*
begin
	qGpioDivEn <= (iGpioDiv == rGpioDivCnt);
end

//----------------------------------------------------------
// 分周回路の Enable は クロックの pose/nege で Assign されるため、
// nege の Enable で次の Edge データに更新を行う
// 
// ボード付属の LED が 8つなので、rGpioBitSftCnt は 3bit(0〜7)容量とする。
// 7 の Carry は自動的に 0 に戻るので、カウントの最大値を気にする必要がなくなる。
//----------------------------------------------------------
reg rSftEdge;
reg qGpioBitSftEn;
reg [1:0] rGpioLedCnt;
reg [2:0] rGpioBitSftCnt;

always @(posedge iSysClk)
begin
	if (iSysRst)			rGpioLedCnt <= 2'd0;
	else if (qGpioBitSftEn)	rGpioLedCnt <= 2'd0;
	else if (qGpioDivEn) 	rGpioLedCnt <= rGpioLedCnt + 1'b1;
	else					rGpioLedCnt <= rGpioLedCnt;

	if (iSysRst)			rGpioBitSftCnt <= 3'd0;
	else if (qGpioBitSftEn)	rGpioBitSftCnt <= rGpioBitSftCnt + 1'b1;
	else 					rGpioBitSftCnt <= rGpioBitSftCnt;

	rSftEdge <= iGpioLed[~rGpioBitSftCnt];
end

always @*
begin
	qGpioBitSftEn <= (rGpioLedCnt == 2'd2);
end


//----------------------------------------------------------
// ポート接続
//----------------------------------------------------------
OBUF GPIO_SFT_CLK 	(.O (oSftClk),		.I (rSftClk));
OBUF GPIO_SFT_AND1 	(.O (oSftEdge[0]),  .I (rSftEdge));
OBUF GPIO_SFT_AND2 	(.O (oSftEdge[1]),  .I (rSftEdge));


endmodule