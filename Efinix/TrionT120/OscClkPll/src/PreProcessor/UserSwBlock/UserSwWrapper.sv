//----------------------------------------------------------
// ユーザースイッチの非同期信号をシステムクロックで同期信号に変換
//----------------------------------------------------------
module UserSwWrapper (
    input           iSysClk, 
    input           iSysRst,
	input	[3:0]	iUserDipSw,
	input	[3:0]	iUserPushSw,
	output 	[3:0]	oUserSlideSw,
	output	[3:0]	oUserPushSw
);


//----------------------------------------------------------
// チャタリング用enable信号
//----------------------------------------------------------
logic wCke;

CkeGenerator #(
	.pSysClk	(125000),
	.pTimeCke	(1)
) SW_CKE_GEN (
	.iSysClk	(iSysClk),
	.iSysRst	(iSysRst),
	.oCke		(wCke)
);


//----------------------------------------------------------
// 各Sw の同期信号取得
//----------------------------------------------------------
genvar i;

generate
	for (i = 0; i < 4; i = i + 1)
	begin
		SwAsyncGen SW_PUSH (
			.iSysClk	(iSysClk),
			.iCke		(wCke),
			.iUserSw	(iUserPushSw[i]),
			.oUserSw	(oUserPushSw[i])
		);

		SwAsyncGen SW_SLIDE (
			.iSysClk	(iSysClk),
			.iCke		(wCke),
			.iUserSw	(iUserDipSw[i]),
			.oUserSw	(oUserSlideSw[i])
		);
	end
endgenerate

endmodule