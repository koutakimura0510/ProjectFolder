//----------------------------------------------------------
// Create 2021/3/6
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// Micro Blaze MCS サンプル動作
// 外部割り込み機能を使用して、ボード付属のLEDを点灯させる
//----------------------------------------------------------

module main #(
    parameter pMB = "on"
)(
    input           iCLK,
    input           iRST,
    output          oUartTx,
    output [7:0]    oLED
);


//----------------------------------------------------------
// Reset Active High、付属SWがプルダウンのため反転
//----------------------------------------------------------
wire rst = ~iRST;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 1秒単位で割り込み信号を生成
//----------------------------------------------------------
wire wEn;

enGen # (
    .pSysClk    (100000000)
) EN (
    .iCLK       (iCLK),
    .iRST       (rst),
    .oEnable    (wEn)
);

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// Micro Blaze mcs
// Interrput Port に立ち上がりエッジを入力すると、割り込み処理開始としてIRQ PortがHighになる
// ソフトウェア側で ACK レジスタをクリアし IRQ Port をLowにする
// GPIO Portは直接 外部IOを駆動しているわけではなく、指定bit幅でデータのやり取りを行っているだけなので、
// CPU 側の計算結果を RTLで受け取り、外部ハードウェアを動作させる記述にしなければならない。
//----------------------------------------------------------
wire [7:0] wLed;
wire wIrq;

generate
    if (pMB == "on")
    begin
        microblaze_mcs_0 MB (
            .Clk            (iCLK),
            .Reset          (rst),
            .INTC_IRQ       (wIrq),
            .INTC_Interrupt (wEn),
            .UART_txd       (oUartTx),
            .GPIO1_tri_o    (wLed)
        );
    end
endgenerate


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// LED 駆動
//----------------------------------------------------------
reg rMsbLed;
reg [7:0] rLed;             assign oLED = {rMsbLed, rLed[6:0]};

// 割り込み処理開始 port 受信
// 8bit目のledを点滅させる
always @(posedge iCLK)
begin
    if (rst )       rMsbLed <= 1'b0;
    else if (wIrq)  rMsbLed <= ~rMsbLed;
    else            rMsbLed <= rMsbLed;
end

// CPUの計算結果を受信し LEDに描画
always @(posedge iCLK)
begin
    if (rst)    rLed <= 8'hff;
    else        rLed <= wLed;
end

endmodule
