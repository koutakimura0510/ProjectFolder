//------------------------------------------------------
// Create 2022/4/30
// Author koutakimura
// -
// システムのアップデートデータの管理を行うブロック
// 
//------------------------------------------------------
module usbWrapper #(
    parameter [ 9:0]        pClkDiv = 868,  // 100MHz / 115200bps
    parameter               pBitLen = 8,    // 送信ビット長
    parameter               pDebug  = "off" 
)(
    input                   iSysClk,        // Top Side: System Clk
    input                   iRst,           // Top Side: Active High
    input                   iUartRx,        // Top Side: 受信 bit
    output                  oUartTx,        // Top Side: 送信 bit
    input                   iWdVd,          // fmc side: 上位モジュールが 有効データ使用完了時 High
    input                   iSectorCke,     // fmc side: 1Page  書き込み完了時 High
    input                   iBlockCke,      // fmc side: 1Block 書き込み完了時 High
    input                   iPdCmdCke,      // fmc side: Program Data Cmd 完了時 High
    output [26:0]           oAddr,          // fmc side: 26:17 Block - 16:11 Page - 10:0 Column
    output [pBitLen-1:0]    oPixelUpdate,   // fmc side: ピクセル更新データ
    output                  oPixelCke,      // fmc side: 有効読み込みデータ出力時 High
    output [pBitLen-1:0]    oSoundUpdate,   // fmc side: サウンド更新データ
    output                  oSoundCke,      // fmc side: 有効読み込みデータ出力時 High
    output                  oCmd,           // fmc side: 1.Read Cmd, 0.Write Cmd
    output                  oUpdateCke      // fmc side: 1.Update Enable, 0.Update Disable
);


//----------------------------------------------------------
// Update Data Cmd
//----------------------------------------------------------
assign oCmd = 1'b0;


//----------------------------------------------------------
// 応答時間計測
//----------------------------------------------------------
reg  qEnRdVd;
reg  qEnRst;
wire wEnTimeOut;

enGen #(
    .pSysClk    (100000000),
    .pTimeCke   (5)
) EN_GEN (
    .iSysClk    (iSysClk),
    .iRst       (qEnRst),
    .oCke       (wEnTimeOut)
);

always @*
begin
    qEnRst <= qEnRdVd | iRst;
end


//----------------------------------------------------------
// Update Data Select ステートマシン
// ※5秒経過後更新データが受信されなければ IDOL に戻る
//----------------------------------------------------------
localparam [1:0] 
        lpIdol  = 2'd0,
        lpPiUp  = 2'd1,
        lpSoUp  = 2'd2;

reg  [1:0] rSt = lpIdol;
reg  qStRdVd;
reg  [pBitLen-1:0] qStUpDa;

always @(posedge iSysClk)
begin
    case (rSt)
        //----------------------------------------------------------
        // Start のデータを受信したら Update 開始
        //----------------------------------------------------------
        lpIdol:
        begin
            case ({qStRdVd, qStUpDa})
                9'h100:     rSt <= lpPiUp;
                9'h101:     rSt <= lpSoUp;
                default:    rSt <= lpIdol;
            endcase
        end

        //----------------------------------------------------------
        // Pixel Data 
        //----------------------------------------------------------
        lpPiUp:
        begin
            rSt <= wEnTimeOut ? lpIdol : lpPiUp;
        end

        //----------------------------------------------------------
        // Sound Data
        //----------------------------------------------------------
        lpSoUp:
        begin
            rSt <= wEnTimeOut ? lpIdol : lpSoUp;
        end

        default:
        begin
            rSt <= lpIdol;
        end
    endcase
end


//----------------------------------------------------------
// Update Data 生成
//----------------------------------------------------------
reg  [pBitLen-1:0] rStPiUp, rStSoUp;               assign {oPixelUpdate, oSoundUpdate} = {rStPiUp, rStSoUp};

always @(posedge iSysClk)
begin
    case (rSt)
        lpIdol:     {rStPiUp, rStSoUp} <= 16'd0;
        lpPiUp:     {rStPiUp, rStSoUp} <= {qStUpDa, 8'd0};
        lpSoUp:     {rStPiUp, rStSoUp} <= {8'd0, qStUpDa};
        default:    {rStPiUp, rStSoUp} <= 16'd0;
    endcase
end


//----------------------------------------------------------
// Address Data 生成
// Column Area は必ず 0 ~ xxxx の全アドレスに書き込みを行う
// 仕様にしているため、1 Page ずつアドレスを更新するようにしている
//----------------------------------------------------------
localparam [16:0] lpPageUp = 17'h00800;
reg [26:0] rStAddr;                               assign oAddr = rStAddr;

always @(posedge iSysClk)
begin
    case (rSt)
        lpIdol:     rStAddr <= 0;
        lpPiUp:     rStAddr <= iPdCmdCke ? rStAddr + lpPageUp : rStAddr;
        lpSoUp:     rStAddr <= iPdCmdCke ? rStAddr + lpPageUp : rStAddr;
        default:    rStAddr <= 0;
    endcase
end


//----------------------------------------------------------
// 制御信号 生成
// iWdVd 受信後一度リセットを行うため Cke Disable にする
//----------------------------------------------------------
reg  rStPiCke, rStSoCke;                            assign {oPixelCke, oSoundCke} = {rStPiCke, rStSoCke};
reg  rUpdateCke;                                    assign oUpdateCke = rUpdateCke;

always @(posedge iSysClk)
begin
    case ({iWdVd, rSt})
        lpIdol:     {rStPiCke, rStSoCke} <= 2'd0;
        lpPiUp:     {rStPiCke, rStSoCke} <= qStRdVd ? 2'b10 : {rStPiCke, rStSoCke};
        lpSoUp:     {rStPiCke, rStSoCke} <= qStRdVd ? 2'b01 : {rStPiCke, rStSoCke};
        default:    {rStPiCke, rStSoCke} <= 2'd0;
    endcase
end

always @(posedge iSysClk)
begin
    case (rSt)
        lpIdol:     rUpdateCke <= 1'b0;
        lpPiUp:     rUpdateCke <= 1'b1;
        lpSoUp:     rUpdateCke <= 1'b1;
        default:    rUpdateCke <= 1'b0;
    endcase
end


//----------------------------------------------------------
// 更新データの再送信
// FPGA システムが正しくデータを受信できたか確認するため受信データを再送信する
//----------------------------------------------------------
reg  [pBitLen-1:0] rSendDa;
reg  [pBitLen-1:0] qTxUpDa;
reg  qTxRdVd;

uartTx # (
    .pClkDiv        (pClkDiv),
    .pBitLen        (pBitLen),
    .pDec           ("dec")
) UART_TX (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iCke           (iWdVd),
    .iSendData      (rSendDa),
    .oUartTx        (oUartTx),
    .oReady         (oReady)
);

always @(posedge iSysClk)
begin
    if (iRst)   rSendDa <= 8'd0;
    else        rSendDa <= qTxRdVd ? qTxUpDa : rSendDa;
end


//----------------------------------------------------------
// 更新データの受信
//----------------------------------------------------------
wire [pBitLen-1:0] wRxUpDa;
wire wRxRdVd;

generate
    if (pDebug == "on")
    begin
        uartRxDebug # (
            .pClkDiv        (10),
            .pBitLen        (pBitLen)
        ) UART_RX (
            .iSysClk        (iSysClk),
            .iRst           (iRst),
            .iWdVd          (iWdVd),
            .oUpdateData    (wRxUpDa),
            .oRdVd          (wRxRdVd)
        );
    end
    else
    begin
        uartRx # (
            .pClkDiv        (pClkDiv),
            .pBitLen        (pBitLen)
        ) UART_RX (
            .iSysClk        (iSysClk),
            .iRst           (iRst),
            .iUartRx        (iUartRx),
            .oUpdateData    (wRxUpDa),
            .oRdVd          (wRxRdVd)
        );
    end
endgenerate

always @*
begin
    qStUpDa <= wRxUpDa;
    qTxUpDa <= wRxUpDa;
    qEnRdVd <= wRxRdVd;
    qStRdVd <= wRxRdVd;
    qTxRdVd <= wRxRdVd;
end

endmodule