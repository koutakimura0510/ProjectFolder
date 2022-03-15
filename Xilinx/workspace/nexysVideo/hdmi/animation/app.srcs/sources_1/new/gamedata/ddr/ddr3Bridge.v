//----------------------------------------------------------
// Create 2021/2/5
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// User Interface module <-> DDR3 Memory Controller Bridge module
// 
// ユーザーインタフェースとDDR3メモリの送受信データの管理を行う。
// RW sideはそれぞれ独立していて、RWのHand.Shakeを利用し、上位モジュールがこのモジュールの動作を管理する
// RWアドレスを指定するiWAとiRAは本来であればpDramAddrWidthのサイズだが、
// モジュール内で確保しているFIFOのBitsizeが32bitなため、32bitで定義している
//
// 2022/03/06 
// FIFO形式でアドレスと書き込みデータの一時保存を行っていたが、動作が非常に分かりにくくなってしまったため、
// データ単体を操作するようにし、ddrコントローラから受信するready,valid信号でread/writeの制御を行うように変更
//----------------------------------------------------------
module ddr3Bridge #(
    parameter pDramAddrWidth    = 29,
    parameter pDramDataWidth    = 128,
    parameter pDramMaskWidth    = 16,
    parameter pBuffDepth        = 16,          // bram length
    parameter pBitWidth         = 32,          // data bit
    parameter pDramDebug        = "off"
)(
    input                       iCLK,           // system clk
    input                       iRST,           // reset High

    // DDRメモリ制御GPIO
    inout  [15:0]               ioDDR3_DQ,      // ddr portはtopモジュールから接続
    inout  [ 1:0]               ioDDR3_DQS_N,
    inout  [ 1:0]               ioDDR3_DQS_P,
    output [14:0]               oDDR3_ADDR,
    output [ 2:0]               oDDR3_BA,
    output                      oDDR3_RAS,
    output                      oDDR3_CAS,
    output                      oDDR3_WE,
    output                      oDDR3_RESET,
    output                      oDDR3_CLK_P,
    output                      oDDR3_CLK_N,
    output                      oDDR3_CKE,
    output [ 1:0]               oDDR3_DM,
    output                      oDDR3_ODT,

    // インターフェース制御信号一覧
    // write side
    input  [pBitWidth-1:0]      iWD,                // WriteData
    input  [pBitWidth-1:0]      iWA,                // Write Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input  [pDramMaskWidth-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    input                       iWvalid,            // write enable信号
    input                       iWFLL,              // dual buffer fifo full signal
    output                      oWready,            // write ready Active High

    // read data side
    output [pBitWidth-1:0]      oRD,                // Pixel Read Data
    output                      oRVD,               // 有効データ出力時High Read Valid Data
    input  [pBitWidth-1:0]      iRA,                // Read Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input                       iRvalid,            // read addr enable
    output                      oRready,            // read ready Active High

    // user clk
    output                      oUiCLK,             // user clk 100mhz
    output                      oUiRST              // user rst Active High
);

////////////////////////////////////////////////////////////
// User Interface clk
wire   ui_clk, ui_clk_sync_rst, wCal;

// ddr3Bridgeと上位モジュールで使用するクロック、リセット
wire   wUiCLK = ui_clk;
wire   wUiRST = ui_clk_sync_rst & (~wCal);
assign oUiRST = wUiRST;
assign oUiCLK = wUiCLK;


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// read / write 切り替えステートマシン
// 
// migから ready信号が来るはずなので、ready信号の状態に合わせてステートマシン動作させたい
// migが動作可能だった場合に後段の fifo wr output enableをONにし、3clk経過後 valid dataがONになるはず
// ステートマシン中は wvd・rvdそれぞれが Highに変化した時に次のステートに遷移するようになっているが、
// fifoの状況によっては output enableがONにならないため、自身で 3clk以上カウントし規定カウント以上経過したら、
// 強制的に次のステートに遷移するようにした。
// これで動いてくれ。
//----------------------------------------------------------
localparam lpStateCntMax = 3;
localparam lpStateSize   = 3;
localparam [lpStateSize-1:0] 
    lpStateWcmd  = 0,
    lpStateWwait = 1,
    lpStateRcmd  = 2,
    lpStateRwait = 3;

wire wRready, wWready;  // ddr side ready signal
wire oWEMP,   oREMP;    // fifo empty signal
wire oFRVD,   oFWVD;    // Fifo Read/Write Valid Data
reg  rFROE,   rFWOE;    // Fifo Read/Write Output Enable
reg  qRemp,   qWemp, qReady;
reg  [lpStateSize-1:0] rState;
reg  [2:0] rSCnt;

always @( posedge wUiCLK )
begin
    if (wUiRST) 
    begin
        rSCnt <= 0;
    end
    else
    begin
        case (rState)
            lpStateWcmd:    rSCnt <= 0;
            lpStateWwait:   rSCnt <= rSCnt + 1'b1;
            lpStateRcmd:    rSCnt <= 0;
            lpStateRwait:   rSCnt <= rSCnt + 1'b1;
            default:        rSCnt <= 0;
        endcase
    end
end

always @(posedge wUiCLK)
begin
    if (wUiRST)
    begin
        rFROE  <= 1'b0
        rFWOE  <= 1'b0;
        rState <= lpStateWcmd;
        rSCnt  <= 0;
    end
    else
    begin
        case (rState)
            lpStateWcmd:
            begin
                rFROE  <= 1'b0;
                rFWOE  <= qReady ? qWemp : 1'b0;
                rState <= qReady ? lpStateWwait : lpStateWcmd;
            end

            lpStateWwait:
            begin
                rFROE  <= 1'b0;
                rFWOE  <= 1'b0;
                rState <= (oFWVD || (rSCnt == lpStateCntMax)) ? lpStateRcmd : lpStateWwait;
            end

            lpStateRcmd:
            begin
                rFROE  <= wRready ? qRemp : 1'b0;
                rFWOE  <= 1'b0;
                rState <= wRready ? lpStateRwait : lpStateRcmd;
            end

            lpStateRwait:
            begin
                rFROE  <= 1'b0;
                rFWOE  <= 1'b0;
                rState <= (oFRVD || (rSCnt == lpStateCntMax)) ? lpStateWcmd : lpStateRwait;
            end

            default:
            begin
                rFROE  <= 1'b0;
                rFWOE  <= 1'b0;
                rState <= lpStateWcmd;
            end
        endcase
    end
end

always @*
begin
    qReady <= wWready & wRready;
    qWemp  <= (~oWEMP);
    qRemp  <= (~iWFLL) & (~oREMP);
    // qRemp  <= (~iWFLL);
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 上位モジュールからの、書き込みデータと読み込みアドレスを保存するFIFO
//----------------------------------------------------------
wire oRFLL, oWFLL;                  assign {oRready, oWready} = {~oRFLL, ~oWFLL};
wire [pBitWidth-1:0] oRA, oWD, oWA;

ddr3Fifo #(
    .pBuffDepth     (pBuffDepth),
    .pBitWidth      (pBitWidth)
) DDR3_FIFO (
    // input side
    .iCLK           (wUiCLK),       .iRST       (wUiRST),
    .iWD            (iWD),          .iWA        (iWA),
    .iWDE           (iWvalid),      .iWRE       (rFWOE),
    .iRA            (iRA),          .iRDE       (iRvalid),
    .iRRE           (rFROE),

    // output side
    .oWD            (oWD),          .oWA        (oWA),
    .oWVD           (oFWVD),        .oWFLL      (oWFLL),
    .oWEMP          (oWEMP),        .oREMP      (oREMP),
    .oRA            (oRA),          .oRVD       (oFRVD),
    .oRFLL          (oRFLL)
);


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 出力制御信号のvalidで判定を行い、DDR3の送信データを変更する
//----------------------------------------------------------
reg [pBitWidth-1:0] rData, rAddr;
reg rDdrWE, rDdrRE;

always @(posedge wUiCLK)
begin
    if (wUiRST)     {rData, rAddr} <= {32'd0, 32'd0};
    else            {rData, rAddr} <= (oFWVD) ? {oWD, oWA} : {32'd0, oRA};
end

always @(posedge wUiCLK)
begin
    if (wUiRST)     {rDdrWE, rDdrRE} <= 2'b00;
    else            {rDdrWE, rDdrRE} <= {oFWVD, oFRVD};
end


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// アドレスアクセスデバッグ用に MicroBlaze mcsを作成
// Vitis上でデバッグ
//----------------------------------------------------------
// microblaze_mcs_0 MB (
//     .Clk             (wUiCLK),
//     .Reset           (wUiRST),
//     .GPIO1_tri_i     ({oFWVD, oWA[30:0]}),
//     .GPIO1_tri_o     (),
//     .GPIO2_tri_i     ({oFRVD, oRA[30:0]}),
//     .GPIO2_tri_o     ()
// );


////////////////////////////////////////////////////////////
//----------------------------------------------------------
// MIG 設定の動作周波数の生成
//----------------------------------------------------------
wire wMig200MHz, wMig100MHz, locked;
wire wMigRST = iRST & (~locked);

clk_wiz_1 DDR3_CLK (
    .clk_out1   (wMig200MHz),   .clk_out2   (wMig100MHz),
    .reset      (iRST),         .locked     (locked),
    .clk_in1    (iCLK)
);

//---------------------------------------------------------------------------
// MIG 動作
//---------------------------------------------------------------------------
generate
    if (pDramDebug == "on")
        migDemo MIG_DEMO (
            .iData                  ({96'd0, rData}),
            .oData                  (oRD),               .oCal          (wCal),
            .iAppEN                 (rDdrRE | rDdrWE),   .iWE           (rDdrWE),
            .oWready                (wWready),           .oRVD          (oRVD),
            .oRready                (wRready),
            .iCLK                   (wMig100MHz),        .iRST          (wMigRST),
            .oUiCLK                 (ui_clk),            .oUiRST        (ui_clk_sync_rst)
        );
    else
        mig_7series_0 MIG (
            //DDR3 port
            .ddr3_addr              (oDDR3_ADDR),       .ddr3_ba        (oDDR3_BA),
            .ddr3_cas_n             (oDDR3_CAS),        .ddr3_ck_n      (oDDR3_CLK_N),
            .ddr3_ck_p              (oDDR3_CLK_P),      .ddr3_cke       (oDDR3_CKE),
            .ddr3_ras_n             (oDDR3_RAS),        .ddr3_reset_n   (oDDR3_RESET),
            .ddr3_we_n              (oDDR3_WE),         .ddr3_dq        (ioDDR3_DQ),
            .ddr3_dqs_n             (ioDDR3_DQS_N),     .ddr3_dqs_p     (ioDDR3_DQS_P),
            .ddr3_dm                (oDDR3_DM),         .ddr3_odt       (oDDR3_ODT),
            .init_calib_complete    (wCal),

            // Application interface ports
            .app_addr               (rAddr[28:0]),          // input [28:0]		addr[28:3] / Bank[2:0]
            .app_cmd                (rDdrRE),               // input [2:0]		Write 000 / Read 001
            .app_en                 (rDdrRE | rDdrWE),      // input			ユーザー側がapp_cmd有効時にHighにする
            .app_wdf_data           ({96'd0, rData}),       // input [127:0]	書き込みデータ 16bit x 8byte
            .app_wdf_end            (rDdrWE),               // input			下記のwrite enable信号と同期させる
            .app_wdf_wren           (rDdrWE),               // input			write enable
            .app_wdf_rdy            (wWready),              // output			データ書き込み可能時High
            .app_wdf_mask           (iMask),                // input [15:0]		各bitに1が立っていたら対応したbyteは書き込まれない
            .app_rd_data            (oRD),                  // output [127:0]	読み込みデータ 16bit x 8byte
            .app_rd_data_end        (),                     // output			最後のデータ出力時High
            .app_rd_data_valid      (oRVD),                 // output			読み込みデータ出力開始時High
            .app_rdy                (wRready),              // output			DDR 動作可能時High
            .app_sr_req             (1'b0),                 // input			
            .app_ref_req            (1'b0),                 // input			
            .app_zq_req             (1'b0),                 // input			
            .app_sr_active          (),                     // output			
            .app_ref_ack            (),                     // output			
            .app_zq_ack             (),                     // output			
            .ui_clk                 (ui_clk),               // output			MIGと同期のユーザーインターフェースCLK
            .ui_clk_sync_rst        (ui_clk_sync_rst),      // output			ユーザーインターフェースリセット信号
            .device_temp            (),
            .sys_clk_i              (wMig100MHz),
            .clk_ref_i              (wMig200MHz),
            .sys_rst                (wMigRST)               // input sys_rst
        );
endgenerate

endmodule