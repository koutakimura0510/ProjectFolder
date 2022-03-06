//----------------------------------------------------------
// Enable信号生成モジュール
//----------------------------------------------------------
module enGen #(
    parameter pSysClk = 25000000  // 分周クロックの値を指定
)(
    input   iCLK, 
    input   iRST,
    output  oEnable
);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// pSysClk: Enable信号をDFFに入力するため1CLK遅れて出力される。
//           そのため定数より1clk早くEnable信号が立つように計算で調整を行う
//----------------------------------------------------------
localparam lpCtuCNTBits	= fBitWidth(pSysClk);
localparam lpSysClk     = pSysClk - 2;


////////////////////////////////////////////////////////////
reg [lpCtuCNTBits-1:0] rCnt;
reg rEn;                                assign oEnable = rEn;
reg qEn;

always @(posedge iCLK) begin
    if (iRST)       rCnt <= 0;
    else if (rEn)   rCnt <= 0;
    else            rCnt <= rCnt + 1'b1;
end

always @(posedge iCLK)
begin
    if (iRST)   rEn <= 1'b0;
    else        rEn <= qEn;
end

always @*
begin
    qEn <= (rCnt == lpSysClk);
end

////////////////////////////////////////////////////////////
// msb側の1を検出しbit幅を取得する
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
