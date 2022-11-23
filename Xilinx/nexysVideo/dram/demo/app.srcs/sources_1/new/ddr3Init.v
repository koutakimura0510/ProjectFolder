/*
 * Create 2021/12/25
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * DDR3メモリ、初期設定データステートマシン
 */
module ddr3Init (
    input           iCLK,
    input           iRST,           // syste rst
    input           iEnable1us,     // 起動シーケンスに使用するenable信号
    output          oInitEnable,    // 初期化完了enable信号、完了時High
    output [19:0]   oDDR3_InitAddr, // 上位5bit {RST CKE RAS# CAS# WE#} {残り15bit A14 ~ A0}
    output [2:0]    oDDR3_InitBank  // バンクセレクト出力
);

//----------------------------------------------------------
// MR0 モードレジスタ
// A1 A0   BL
// 0  0 -> 8 (固定)
// 0  1 -> 4 or 8 (動的に指定)
// 1  0 -> 4 (固定)
// 1  1 -> Reserved
// 
// A6 A5 A4 A2    CAS レイテンシ
// 0  0  0  0  -> Reserved
// 0  0  1  0  -> 5
// 0  1  0  0  -> 6
// 0  1  1  0  -> 7
// 1  0  0  0  -> 8
// 1  0  1  0  -> 9
// 1  1  0  0  -> 10
// 1  1  1  0  -> 11 (Reserve)
// 
// A11 A10 A9     ライトリカバリサイクル数(WR)
// 0   0   0   -> Reserved
// 0   0   1   -> 5
// 0   1   0   -> 6
// 0   1   1   -> 7
// 1   0   0   -> 8
// 1   0   1   -> 10
// 1   1   0   -> 12
// 1   1   1   -> Reserved
//----------------------------------------------------------
localparam MR0_BL   = 2'b00;        // バースト長8
localparam MR0_CL1  = 1'b0;         // CASレイテンシA2
localparam MR0_BT   = 1'b0;         // バーストタイプ・シーケンシャル
localparam MR0_CL2  = 3'b000;       // CASレイテンシA4~A6 遅延サイクル5で設定
localparam MR0_TM   = 1'b0;         // テストモード、0で固定設定できない
localparam MR0_DLL  = 1'b1;         // 起動時にHighでDLLをRST、自動的にLowに戻る
localparam MR0_WR   = 3'b000;       // Write Recovery 遅延サイクル数5で設定
localparam MR0_PD   = 1'b0;         // プリチャージパワーダウン後にDLLを保持するモードで設定
localparam MR0_NON  = 2'b00;        // A13,14 設定できない
localparam MR0_CMD  = 3'b000;
localparam MR0_BANK = 3'b000;       // Bank Select
localparam [17:0] DEVICE_MR0_SET  = {MR0_CMD, MR0_NON, MR0_PD, MR0_WR, MR0_DLL, MR0_TM, MR0_CL2, MR0_BT, MR0_CL1, MR0_BL};
localparam [2:0]  DEVICE_MR0_BANK = MR0_BANK;


//----------------------------------------------------------
// MR1 モードレジスタ
// 
// A5 A1    DIC 出力インピーダンス値
// 0  0  -> Reserved for RZQ/6
// 0  1  -> RZQ/7
// 1  0  -> RZQ/TBD
// 1  1  -> RZQ/TBD
// 
// A9 A6 A2    RTT_Nom
// 0  0  0  -> ODT disabled
// 0  0  1  -> RZQ/4
// 0  1  0  -> RZQ/2
// 0  1  1  -> RZQ/6
// 1  0  0  -> RZQ/12
// 1  0  1  -> RZQ/8
// 
// A4 A3   AL アディティブレイテンシ
// 0  0 -> 0 (AL disabled)
// 0  1 -> CL-1
// 1  0 -> CL-2
//----------------------------------------------------------
localparam MR1_DLL     = 1'b0;         // 0.DLL有効 1.無効 基本は有効を維持
localparam MR1_DIC1    = 1'b0;         // 出力抵抗設定 DIC1 DIC2 = 00でRZQ/6
localparam MR1_RTT1    = 1'b1;         // 通常時の終端抵抗値 RTT1 RTT2 RTT3 011 RZQ/6
localparam MR1_AL      = 2'b00;        // Additive Latency 00 disable, 01 CL-1, 10 CL-2
localparam MR1_DIC2    = 1'b0;         // 01 RZQ/7, 10 11 RZQ/TBD
localparam MR1_RTT2    = 1'b1;         // 000 ODT disable 001 RZQ/4 010 RZQ/2
localparam MR1_LEVEL   = 1'b1;         // Write Leveling Enable
localparam MR1_NULL1   = 1'b0;
localparam MR1_RTT3    = 1'b0;         // 100 RZQ/12 101 RZQ/8
localparam MR1_NULL2   = 1'b0;
localparam MR1_TDQS    = 1'b0;         // 基本0で固定、8bitと4bit長のDRAMが混在しているような時に使用する
localparam MR1_QOFF    = 1'b0;         // 出力禁止レジスタ DQ DQS DQS# Active、基本0で固定
localparam MR1_NON     = 2'b00;        // A13,14 設定できない
localparam MR1_CMD     = 3'b000;
localparam MR1_BANK    = 3'b001;       // Bank Select
localparam [17:0] DEVICE_MR1_SET  = {MR1_CMD, MR1_NON, MR1_QOFF, MR1_TDQS, MR1_NULL2, MR1_RTT3, MR1_NULL1, MR1_LEVEL, MR1_RTT2, MR1_DIC2, MR1_AL, MR1_RTT1, MR1_DIC1, MR1_DLL};
localparam [2:0]  DEVICE_MR1_BANK = MR1_BANK;


//----------------------------------------------------------
// MR2 モードレジスタ
//
// CLKの速度に対応したCWLの設定表
// 0 0 0 -> 5 ( tCK≧2.500ns)  2.5ns = 400MHz
// 0 0 1 -> 6 (2.500ns>tCK≧1.875ns)
// 0 1 0 -> 7 (1.875ns>tCK≧1.500ns)
// 0 1 1 -> 8 (1.500ns>tCK≧1.250ns)
//
//A10 A9  RTT_WR
// 0  0 -> ダイナミックODT (Dynamic ODT) オフ
// 0  1 -> RZQ/4
// 1  0 -> RZQ/2
// 1  1 -> Reserved
//----------------------------------------------------------
localparam MR2_PASR     = 3'b000;       // 今回のSDRAMには搭載されていないため0で固定
localparam MR2_CWL      = 3'b000;       // CAS Write Latency 遅延サイクル5で設定
localparam MR2_ASR      = 1'b0;         // Auto Self Refresh 無効
localparam MR2_SRT      = 1'b0;         // 通常温度範囲でセフルリフレッシュを行う
localparam MR2_NULL     = 1'b0;
localparam MR2_RTTWR    = 2'b01;        // Dynamic ODT設定 
localparam MR2_NON      = 4'b0000;      // A11,12,13,14 設定できない
localparam MR2_CMD      = 3'b000;
localparam MR2_BANK     = 3'b010;       // Bank Select
localparam [17:0] DEVICE_MR2_SET  = {MR2_CMD, MR2_NON, MR2_RTTWR, MR2_NULL, MR2_SRT, MR2_ASR, MR2_CWL, MR2_PASR};
localparam [2:0]  DEVICE_MR2_BANK = MR2_BANK;


//----------------------------------------------------------
// MR3モードレジスタ
//----------------------------------------------------------
localparam MR3_MPRLOC   = 2'b00;            // Multi Purpose Reg location 00で固定
localparam MR3_MPR      = 1'b0;             // Multi Purpose Reg 基本0で固定
localparam MR3_ODTS     = 1'b0;             // オプション機能 0で固定 
localparam MR3_NON      = 11'b00000000000;  // A4,5,6,7,8,9,10,11,12,13,14 設定できない
localparam MR3_CMD      = 3'b000;
localparam MR3_BANK     = 3'b011;           // Bank Select
localparam [17:0] DEVICE_MR3_SET  = {MR3_CMD, MR3_NON, MR3_ODTS, MR3_MPR, MR3_MPRLOC};
localparam [2:0]  DEVICE_MR3_BANK = MR3_BANK;


//----------------------------------------------------------
// ZQキャリブレーション
//----------------------------------------------------------
localparam ZQ_AP   = 14'b00001000000000;
localparam ZQ_CMD  = 3'b110;
localparam [17:0] DEVICE_ZQ_SET = {ZQ_CMD, ZQ_AP};


//----------------------------------------------------------
// DDR3初期化ステートマシン
//----------------------------------------------------------
localparam [3:0]
    DDR3_IDLE       = 0,
    DDR3_RST        = 1,
    DDR3_CKE        = 2,
    DDR3_TXPR       = 3,
    DDR3_MR2        = 4,
    DDR3_MR3        = 5,
    DDR3_MR1        = 6,
    DDR3_MR0        = 7,
    DDR3_ZQCL       = 8,
    DDR3_COMPLETE   = 9;


//----------------------------------------------------------
// 初期化に伴う待機時間のパラメータ
//----------------------------------------------------------
localparam [9:0]
    DDR3_IDLE_TIME = 0, //300
    DDR3_RST_TIME  = 0, //600
    DDR3_CKE_TIME  = 0, //200
    DDR3_TXPR_TIME = 0, //6
    DDR3_MR2_TIME  = 0, //6
    DDR3_MR3_TIME  = 0, //6
    DDR3_MR1_TIME  = 0, //14
    DDR3_MR0_TIME  = 0, //512
    DDR3_ZQCL_TIME = 0; //0


//----------------------------------------------------------
// DDR3メモリ初期設定制御変数
//----------------------------------------------------------
reg rst = 0;
reg cke = 0;
reg init_enable = 0;        assign oInitEnable   = init_enable;
reg [17:0] ddr3_init_addr;  assign oDDR3_InitAddr = {rst, cke, ddr3_init_addr};
reg [2:0] ddr3_bank_addr;   assign oDDR3_InitBank = ddr3_bank_addr;
reg [9:0] wait_count = 0;
reg [9:0] wait_time  = 0;
reg [3:0] init_state = DDR3_IDLE;


//----------------------------------------------------------
// 待機時間カウントモジュール
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        wait_count <= 0;
    end else if (enable == 1'b1) begin
        wait_count <= 0;
    end else if (iEnable1us == 1'b1) begin
        wait_count <= wait_count + 1'b1;
    end
end

assign enable = (wait_time == wait_count) ? 1'b1 : 1'b0;


//----------------------------------------------------------
// 初期設定ステートマシン、初期設定完了時Enable信号をHighにする
// 規定のデータ送信時やPortのHigh.Low処理の待機時間完了時に、次の状態の設定を行う
// 
// state                min wait time
// IDLE -> RESET Low    200us
// RST  -> RESET High   500us
// CKE  -> CKE High     100us
// TXPR -> MR2 data     clk 4cycle
// MR3  -> MR1 data     clk 4cycle
// MR1  -> MR0 data     clk 4cycle
// MR0  -> ZQ  data     clk 12cycle
// ZQ   -> comp         clk 512cycle
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        init_state  <= DDR3_IDLE;
    end else begin
        case (init_state)
            DDR3_IDLE: begin
                init_state <= DDR3_RST;
                wait_time  <= DDR3_IDLE_TIME;
                rst <= 1'b0;
                cke <= 1'b0;
                init_enable    <= 1'b0;
                ddr3_init_addr <= 0;
                ddr3_bank_addr <= 0;
            end

            DDR3_RST: begin
                if (enable == 1'b1) begin
                    init_state <= DDR3_CKE;
                    rst <= 1'b1;
                    wait_time <= DDR3_RST_TIME;
                end else begin
                    init_state <= DDR3_RST;
                    rst <= 1'b0;
                end
            end

            DDR3_CKE: begin
                if (enable == 1'b1) begin
                    init_state <= DDR3_TXPR;
                    cke <= 1'b1;
                    wait_time <= DDR3_CKE_TIME;
                end else begin
                    init_state <= DDR3_CKE;
                    cke <= 1'b0;
                end
            end

            DDR3_TXPR: begin
                if (enable == 1'b1) begin
                    init_state     <= DDR3_MR2;
                    ddr3_init_addr <= DEVICE_MR2_SET;
                    ddr3_bank_addr <= DEVICE_MR2_BANK;
                    wait_time      <= DDR3_TXPR_TIME;
                end else begin
                    init_state <= DDR3_TXPR;
                end
            end

            DDR3_MR2: begin
                if (enable == 1'b1) begin
                    init_state     <= DDR3_MR3;
                    ddr3_init_addr <= DEVICE_MR3_SET;
                    ddr3_bank_addr <= DEVICE_MR3_BANK;
                    wait_time      <= DDR3_MR2_TIME;
                end else begin
                    init_state <= DDR3_MR2;
                end
            end

            DDR3_MR3: begin
                if (enable == 1'b1) begin
                    init_state     <= DDR3_MR1;
                    ddr3_init_addr <= DEVICE_MR1_SET;
                    ddr3_bank_addr <= DEVICE_MR1_BANK;
                    wait_time      <= DDR3_MR3_TIME;
                end else begin
                    init_state <= DDR3_MR3;
                end
            end

            DDR3_MR1: begin
                if (enable == 1'b1) begin
                    init_state     <= DDR3_MR0;
                    ddr3_init_addr <= DEVICE_MR0_SET;
                    ddr3_bank_addr <= DEVICE_MR0_BANK;
                    wait_time      <= DDR3_MR1_TIME;
                end else begin
                    init_state <= DDR3_MR1;
                end
            end

            DDR3_MR0: begin
                if (enable == 1'b1) begin
                    init_state     <= DDR3_ZQCL;
                    ddr3_init_addr <= DEVICE_ZQ_SET;
                    wait_time      <= DDR3_MR0_TIME;
                end else begin
                    init_state <= DDR3_MR0;
                end
            end

            DDR3_ZQCL: begin
                if (enable == 1'b1) begin
                    init_state <= DDR3_COMPLETE;
                    wait_time  <= DDR3_ZQCL_TIME;
                end else begin
                    init_state <= DDR3_ZQCL;
                end
            end

            DDR3_COMPLETE: begin
                init_state <= DDR3_COMPLETE;
                init_enable <= 1'b1;
            end

            default: begin
                init_state <= DDR3_IDLE;
            end
        endcase
    end
end

endmodule
