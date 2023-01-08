//----------------------------------------------------------
// Pulse信号生成モジュール
// 
// 2022/7/21
// 指定タイミングで Pulse 信号を出力
//----------------------------------------------------------
module MPulseGenerator #(
    parameter 		pCntMax  	= 25000000, // 分周クロックの値を指定
	parameter [0:0] pStartPulse = 1'b1		// 起動時の Pulse の High/Low 指定
)(
	output			oPulse,
	input			iSampling,
	input			iRST,
	input			iCLK
);


//----------------------------------------------------------
// reg Bit Length
//----------------------------------------------------------
localparam 						lpCtuCNTBits= fBitWidth(pCntMax);
localparam [lpCtuCNTBits-1:0] 	lpCntMax 	= pCntMax-1'b1;
localparam [lpCtuCNTBits-1:0] 	lpRstCnt 	= {lpCtuCNTBits{1'b0}};


//----------------------------------------------------------
// Cke Counter
//----------------------------------------------------------
reg [2:0] 	rSft;
reg 		qEdge;

always @( posedge iCLK )
begin
    if (iRST)		rSft <= 3'b000;
    else            rSft <= {rSft[1:0], iSampling};
end

always @*
begin
    qEdge = (rSft == 3'b011);	// posedge 検出
end

//----------------------------------------------------------
// Cke Counter
//----------------------------------------------------------
reg [lpCtuCNTBits-1:0] rTmpCount;
reg qCke;

always @( posedge iCLK )
begin
    if (qCke)  		rTmpCount <= lpRstCnt;
    else if (qEdge)	rTmpCount <= rTmpCount + 1'b1;
	else 			rTmpCount <= rTmpCount;
end

always @*
begin
    qCke = (rTmpCount == lpCntMax);
end

//----------------------------------------------------------
// Ckeの立ち上がりタイミング で Pulse をトグルさせ出力
//----------------------------------------------------------
reg  rPulse;			assign oPulse = rPulse;

always @(posedge iCLK)
begin
	if (iRST) 		rPulse <= pStartPulse;
	else if (qCke)	rPulse <= ~rPulse;
	else 			rPulse <=  rPulse;
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
