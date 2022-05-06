//----------------------------------------------------------
// Create 2022/5/02
// Author koutakimura
// -
// Channel 毎に Sound Data を Bram に保存
// 
//----------------------------------------------------------
module seLoadBram #(
    parameter pBuffDepth        = 256,      // FIFO BRAMのサイズ指定
    parameter pWriteWidth       = 8,        // bitサイズ
    parameter pBitConvert       = "off",    // on の場合 出力データの Bit 結合を行う
    parameter pReadWidth        = 8         // on の場合 WriteWidth と Bit 幅を合わせる
)(
    input                       iSysClk,    // Top Side: System Clk
    input                       iRst,       // Top Side: Active High Sync Reset
    input   [pWriteWidth-1:0]   iWd,        // write data
    input                       iWe,        // write enable 有効データ書き込み
    input                       iChRdy,     // ch ready
    output  [pReadWidth-1:0]    oRd,        // read data
    output                      oRvd,       // 有効データ出力
    output                      oRaWaAbs    // RW Address の絶対値
);


//----------------------------------------------------------
// Fifo Controll
//----------------------------------------------------------
wire [pReadWidth-1:0] wRd;           assign oRd  = wRd;
wire wRvd;                           assign oRvd = wRvd;
wire wFull;
wire wEmp;
reg  qRe;

fifoController # (
    .pBuffDepth     (pBuffDepth),
    .pWriteWidth    (pWriteWidth),
    .pBitConvert    (pBitConvert),
    .pReadWidth     (pReadWidth)
) SE_CH0 (
    .iClk           (iSysClk),
    .iRst           (iRst),
    .iWd            (iWd),
    .iWe            (iWe),
    .oFull          (wFull),
    .iRe            (qRe),
    .oRd            (wRd),
    .oRvd           (wRvd),
    .oEmp           (wEmp)
);


//----------------------------------------------------------
// write と read の差分出力
//----------------------------------------------------------
reg [11:0] rWeCnt;
reg [11:0] rRvdCnt;
reg [11:0] rCntAbs;
reg qRaWaAbs;                               assign oRaWaAbs = qRaWaAbs;

always @(posedge iSysClk)
begin
    if (iRst)       rWeCnt <= 12'd0;
    else if (iWe)   rWeCnt <= rWeCnt + 1'b1;
    else            rWeCnt <= rWeCnt;
end

always @(posedge iSysClk)
begin
    if (iRst)       rRvdCnt <= 12'd0;
    else if (wRvd)  rRvdCnt <= rRvdCnt + 2'd2;
    else            rRvdCnt <= rRvdCnt;
end

always @(posedge iSysClk)
begin
    rCntAbs <= rWeCnt - rRvdCnt;
end

always @*
begin
    qRaWaAbs <= rCntAbs < 2048  ;
end


//----------------------------------------------------------
// ステートマシン
//----------------------------------------------------------
localparam [1:0] 
    lpStIdol = 2'd0,
    lpStMsb  = 2'd1,
    lpStLsb  = 2'd2,
    lpStOut  = 2'd3;

reg [1:0] rSt;
reg rRe;

always @(posedge iSysClk)
begin
    case (rSt)
        lpStIdol:
        begin
            rRe <= 1'b0;
            rSt <= ~wEmp ? lpStMsb : lpStIdol;
        end

        lpStMsb:
        begin
            rRe <= iChRdy;
            rSt <= iChRdy ? lpStLsb : lpStMsb;
        end

        lpStLsb:
        begin
            rRe <= 1'b1;
            rSt <= lpStOut;
        end

        lpStOut:
        begin
            rRe <= 1'b0;
            rSt <= wRvd ? lpStIdol : lpStOut;
        end

        default:
        begin
            rRe <= 1'b0;
            rSt <= lpStIdol;
        end
    endcase
end

always @*
begin
    qRe  <= rRe;
end


//----------------------------------------------------------
// 読み込み状況出力
//----------------------------------------------------------

always @(posedge iSysClk)
begin
    if (iRst) Q <= D;
    else Q <= D;
end


endmodule