//----------------------------------------------------------
// Clk Enable信号生成モジュール
// 
// 2022/7/18
// pSysClk のタイミングで pTimeCke 分カウント時 Cke 出力
//----------------------------------------------------------
module CkeGenerator #(
    parameter pSysClk  = 25000000,  // 分周クロックの値を指定
    parameter pTimeCke = 1          // Enable 出力の時間指定
)(
    input   iSysClk, 
    input   iSysRst,
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
reg [lpCtuCNTBits-1:0] rTmpCount;
reg qCke;

always_ff @( posedge iSysClk )
begin
    if (iSysRst)    rTmpCount <= 0;
    else if (qCke)  rTmpCount <= 0;
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
reg qTimeCke;                               assign oCke = qTimeCke;

always_ff @( posedge iSysClk )
begin
    if (iSysRst)        rTimeCkeCnt <= 0;
    else if (qTimeCke)  rTimeCkeCnt <= 0;
    else if (qCke)      rTimeCkeCnt <= rTimeCkeCnt + 1'b1;
    else                rTimeCkeCnt <= rTimeCkeCnt;
end

always_comb
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
