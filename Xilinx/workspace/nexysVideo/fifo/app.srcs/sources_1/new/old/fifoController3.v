//----------------------------------------------------------
// Create 2022/02/05
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// FIFOコントロールモジュール
// この回路を使用する上位モジュールでは下記の内容でデータのやり取りを行う
// 1.書き込み時はoFLLのみ確認すれば良い
// 2.読み込み時はoEMPとoRDVを確認すれば良い
//
// 2022/02/26
// 処理の流れが分かりにくいため、全体をパイプライン処理に更新
// RE Active時 3CLK後に RVD Assert データが出力される
// 
// 2022/03/21
// レイテンシ3のFIFOのため、Enable中に接続先がNon Active状態になっても出力状態を維持してしまう
// そのため、接続先からのready信号を個別に受け付けるように変更し、VDがHigh中にreadyがLowになった場合
// アドレスの位置を調整し出力を中断するようにした
//----------------------------------------------------------
module fifoController #(
    parameter pBuffDepth  = 256,    // FIFO BRAMのサイズ指定
    parameter pBitWidth   = 32      // bitサイズ
)(
    input                       iCLK,
    input                       iRST,   // Active High
    input   [pBitWidth-1:0]     iWD,    // write data
    input                       iWE,    // write enable 有効データ書き込み
    output                      oFLL,   // 最大書き込み時High
    output  [pBitWidth-1:0]     oRD,    // read data
    input                       iRE,    // read enable
    output                      oRVD,   // 有効データ出力
    output                      oEMP,   // バッファ空時High
    input                       iReady  // 接続先のReady信号
);

//----------------------------------------------------------
// buffer sizeによってアドレスレジスタのサイズを自動変換するため、
// bit幅を取得し指定する
//----------------------------------------------------------
localparam pAddrWidth  = fBitWidth(pBuffDepth);
localparam pAddrMax    = pBuffDepth - 1;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// write read アドレス更新
// アドレスの位置に応じてハンド・シェイク信号生成
// 
// oFLL 書き込みアドレスが一周して読み込みアドレスを超えそうだった場合High
// oEMP 書き込みと読み込みのアドレスが一致している、または超えそうな場合High
// oRVD Empty状態ではなく読み込みEnable信号を受信した場合High
//----------------------------------------------------------
reg rFLL, rEMP, rRVD;    assign {oFLL, oEMP, oRVD} = {rFLL, rEMP, rRVD};
reg qFLL, qEMP, qRVD;
reg [pAddrWidth-1:0] qWAb, qWAb2;
reg [pAddrWidth-1:0] qRAb [3:0];
reg [pAddrWidth-1:0] rWA, rRA, rOWP, rORP;
reg rWE, rRE;
reg qWE, qRE, qRst;
reg qVDStop;


////////////////////////////////////////////////////////////
// write pointer
always @(posedge iCLK)
begin
    case ({qRst, qVDStop, rWE})
    'b000:      rWA <= rWA;
    'b001:      rWA <= rWA + 1'b1;
    'b010:      rWA <= rOWP;
    'b011:      rWA <= rWA;
    default:    rWA <= 0;
    endcase
end

always @(posedge iCLK)
begin
    if (qRst)           rOWP <= 0;
    else if (qVDStop)   rOWP <= rOWP;
    else                rOWP <= rWA;
end

////////////////////////////////////////////////////////////
// read pointer
always @(posedge iCLK)
begin
    case ({qRst, qVDStop, rRE})
    'b000:      rRA <= rRA;
    'b001:      rRA <= rRA + 1'b1;
    'b010:      rRA <= rORP;
    default:    rRA <= 0;
    endcase
end

// 前回のrpが更新されていたら新規データを出力できる状態と判断する
always @(posedge iCLK)
begin
    if (qRst)           rORP <= 0;
    else if (qVDStop)   rORP <= rORP;
    else                rORP <= rRA;
end

////////////////////////////////////////////////////////////
// Hnad Shake信号、タイミング結合のためDFFに一度通す
always @(posedge iCLK)
begin
    if (qRst)       {rFLL, rEMP, rRVD} <= {1'b1, 1'b1, 1'b0};
    else            {rFLL, rEMP, rRVD} <= {qFLL, qEMP, qRVD};
end

always @(posedge iCLK)
begin
    if (qRst)       {rWE, rRE}  <= {1'b0, 1'b0};
    else            {rWE, rRE}  <= {qWE, qRE};
end

integer i;

// DFFの段数により3clk遅延するため、3clk分のraポインタを先取りして計算しておく
always @*
begin
    for (i = 1; i < 5; i = i + 1)
    begin
        qRAb[i-1] <= rRA - i;
    end

    qWAb    <= rWA - 1'b1;
    qWAb2   <= rWA - 2'd2;
    qRst    <= iRST;
    qFLL    <= (rWA == qRAb[0] || rWA == qRAb[1] || rWA == qRAb[2] || rWA == qRAb[3]);
    qEMP    <= (rWA == rRA || qWAb2 == rRA || qWAb == rRA) ? 1'b1 : 1'b0;
    qRVD    <= (rRA != rORP);
    // qRVD    <= (rRA != rORP) ? iReady : 1'b0;
    qVDStop <= rRVD & iReady;
    qWE     <= iWE;
    qRE     <= iRE;
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// FIFO動作
// 上記のハンドシェイク信号のタイミングを合わせるためDFFに入力を行う
//----------------------------------------------------------
reg  [pBitWidth-1:0] rWD, rRD;      assign oRD = rRD;
wire [pBitWidth-1:0] wRD;

userFifo #(
    .pBuffDepth    (pBuffDepth),
    .pBitWidth     (pBitWidth),
    .pAddrWidth    (pAddrWidth)
) USER_FIFO (
    // write side       read side
    .iCLK   (iCLK),
    .iWD    (rWD),      .oRD    (wRD),
    .iWA    (rWA),      .iRA    (rRA),
    .iWE    (rWE)
);

always @(posedge iCLK)
begin
    if (qRst)       rRD  <= 0;
    else            rRD  <= wRD;
end

always @(posedge iCLK)
begin
    if (qRst)       rWD  <= 0;
    else            rWD  <= iWD;
end

////////////////////////////////////////////////////////////
// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    // fBitWidth = 1;
        for (i = 0; i < 32; i = i+1 )
        begin
            if (iVAL[i]) 
            begin
                fBitWidth = i+1;
            end
        end

        if (fBitWidth != 1)
        begin
            fBitWidth = fBitWidth - 1;
        end
    end
endfunction
////////////////////////////////////////////////////////////
endmodule