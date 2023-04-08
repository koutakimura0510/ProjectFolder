//----------------------------------------------------------
// Enable信号生成モジュール
// 
// 2022/05/01
// コード規則変更に伴い全体修正
// 例：pSysClk のタイミングで pTimeCke 分カウント時 Cke 出力
//----------------------------------------------------------
module enGen #(
    parameter pSysClk  = 25000000,  // 分周クロックの値を指定
    parameter pTimeCke = 1          // Enable 出力の時間指定
)(
    input   iSCLK, 
    input   iRst,
    output  oCke
);


//----------------------------------------------------------
// reg Bit Length
//----------------------------------------------------------
localparam lpCtuCNTBits	= fBitWidth(pSysClk);
localparam [lpCtuCNTBits-1:0] lpSysCnt = pSysClk-1'b1;


//----------------------------------------------------------
// Cke Counter
//----------------------------------------------------------
reg [lpCtuCNTBits-1:0] tmp_count;
reg qCke;

always @(posedge iSCLK) 
begin
    if (iRst)       tmp_count <= 0;
    else if (qCke)  tmp_count <= 0;
    else            tmp_count <= tmp_count + 1'b1;
end

always @*
begin
    qCke = tmp_count == lpSysCnt;
end


//----------------------------------------------------------
// 指定時間カウント時 Cke 出力
//----------------------------------------------------------
reg [7:0] rTimeCkeCnt;
reg qTimeCke;                               assign oCke = qTimeCke;

always @(posedge iSCLK)
begin
    if (iRst)           rTimeCkeCnt <= 0;
    else if (qTimeCke)  rTimeCkeCnt <= 0;
    else if (qCke)      rTimeCkeCnt <= rTimeCkeCnt + 1'b1;
    else                rTimeCkeCnt <= rTimeCkeCnt;
end

always @*
begin
    qTimeCke <= pTimeCke == rTimeCkeCnt;
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
