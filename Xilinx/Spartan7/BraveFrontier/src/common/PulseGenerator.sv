//----------------------------------------------------------
// Pulse信号生成モジュール
// 
// 2022/7/21
// 指定タイミングで Pulse 信号を出力
//----------------------------------------------------------
module PulseGenerator #(
    parameter 		pSysClk  	= 25000000, // 分周クロックの値を指定
    parameter [7:0]	pTimeCke 	= 8'd1,     // Enable 出力の時間指定
	parameter [0:0] pStartPulse = 1'b1		// 起動時の Pulse の High/Low 指定
)(
    input   iSysClk, 
    input   iSysRst,
    output  oPulse
);


//----------------------------------------------------------
// reg Bit Length
//----------------------------------------------------------
localparam 						lpCtuCNTBits= fBitWidth(pSysClk);
localparam [lpCtuCNTBits-1:0] 	lpSysCnt 	= pSysClk-1'b1;
localparam [lpCtuCNTBits-1:0] 	lpRstCnt 	= 0;


//----------------------------------------------------------
// Cke Counter
//----------------------------------------------------------
reg [lpCtuCNTBits-1:0] rTmpCount;
reg qCke;

always_ff @( posedge iSysClk )
begin
    if (iSysRst)    rTmpCount <= lpRstCnt;
    else if (qCke)  rTmpCount <= lpRstCnt;
    else            rTmpCount <= rTmpCount + 1'b1;
end

always_comb
begin
    qCke = rTmpCount == lpSysCnt;
end

//----------------------------------------------------------
// 指定時間カウント時 Cke 出力
//----------------------------------------------------------
reg [7:0] rTimeCkeCnt;
reg qTimeCke;

always_ff @( posedge iSysClk )
begin
    if (iSysRst)        rTimeCkeCnt <= 8'd0;
    else if (qTimeCke)  rTimeCkeCnt <= 8'd0;
    else if (qCke)      rTimeCkeCnt <= rTimeCkeCnt + 1'b1;
    else                rTimeCkeCnt <= rTimeCkeCnt;
end

always_comb
begin
    qTimeCke <= pTimeCke == rTimeCkeCnt;
end

//----------------------------------------------------------
// Ckeの立ち上がりタイミング で Pulse をトグルさせ出力
//----------------------------------------------------------
reg  rPulse;			assign oPulse = rPulse;

always_ff @(posedge iSysClk)
begin
	if (iSysRst) 		rPulse <= pStartPulse;
	else if (qTimeCke)	rPulse <= ~rPulse;
	else 				rPulse <= rPulse;
end


//----------------------------------------------------------
// msb側の1を検出しbit幅を取得する
//----------------------------------------------------------
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule
