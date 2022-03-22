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
// 
// 2022/03/18
// MIGの制御方法について誤解していたため、コントローラ部分の修正を行う
// 
// 2022/03/20
// アプリケーション回路とDDR回路の切り離し、アプリ側の周波数をDDR側より高くする
// 
// CLK -------------------> | <---------- CLK
// Application ----------- FIFO --------- DDR
// Pixel -----------------> |------------> |
// Addr  -----------------> |------------> |
//                                         |
// Pixel <----------------- | <------------|
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
    output                      oUiCLK,
    output                      oUiRST,

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

    // Appcation side write data addr side
    input  [pBitWidth-1:0]      iWD,                // WriteData
    input  [pBitWidth-1:0]      iWA,                // Write Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input  [pDramMaskWidth-1:0] iMask,              // write mask 1を立てることでその範囲は書き込まないようにできる 基本0
    input                       iWvalid,            // write enable信号
    output                      oWready,            // write ready Active High

    // Appcation side read addr side
    input  [pBitWidth-1:0]      iRA,                // Read Addr [28]:0固定 / [27-25]:Bank / [24-10]:Row / [9-3]:Col / [2:0]:0固定
    input                       iRvalid,            // read addr enable
    output                      oRready,            // read ready Active High

    // async data output
    output [pBitWidth-1:0]      oAppRD,             // Pixel Read Data
    output                      oAppRVD,            // 有効データ出力時High Read Valid Data
    input                       iAppFull
);

////////////////////////////////////////////////////////////
// User Interface clk
wire   ui_clk, ui_clk_sync_rst, wCal;

// ddr3Bridgeと上位モジュールで使用するクロック、リセット
wire   wUiCLK = ui_clk;
wire   wUiRST = ui_clk_sync_rst & (~wCal);
// assign oUiCLK = wMigRefClk;
// assign oUiRST = wUiRST;
assign oUiCLK = wUiCLK;
assign oUiRST = wUiRST;

//----------------------------------------------------------
//----------------------------------------------------------
localparam lpSendCntSize = 8;
localparam [lpSendCntSize-1:0] lpSendCntMax  = 8;
localparam [lpSendCntSize-1:0] lpSendCntNull = 0;

localparam lpStateSize = 4;
localparam [lpStateSize-1:0]
    lpWriteCmd      = 0,
    lpWritePass     = 1,
    lpWriteActive   = 2,
    lpReadCmd       = 3,
    lpReadPass      = 4,
    lpReadActive    = 5;

wire wAready, wWready;  // Active ready when Write ready signal for ddr
reg  [pBitWidth-1:0] rRA, rWD, rWA;
reg  rDdrAppEn, rDdrReadEn, rDdrWriteEn;        assign {oRready, oWready} = {rDdrReadEn, rDdrWriteEn};
reg  [lpStateSize-1:0]   rDdrState;
reg  [lpSendCntSize-1:0] rDdrSendCnt;

always @(posedge wUiCLK)
begin
    if (wUiRST)
    begin
        rDdrState   <= lpWriteCmd;
        rDdrAppEn   <= 1'b0;
        rDdrReadEn  <= 1'b0;
        rDdrWriteEn <= 1'b0;
        rDdrSendCnt <= lpSendCntNull;
    end
    else
    begin
        case (rDdrState)
        lpWriteCmd:
        begin
            rDdrState   <= lpWritePass;
            rDdrAppEn   <= 1'b1;
            rDdrReadEn  <= 1'b0;
            rDdrWriteEn <= 1'b0;
            rDdrSendCnt <= rDdrSendCnt;
        end

        lpWritePass:
        begin
            rDdrState   <= lpWriteActive;
            rDdrAppEn   <= 1'b1;
            rDdrReadEn  <= 1'b0;
            rDdrWriteEn <= 1'b1;
            rDdrSendCnt <= rDdrSendCnt;
            rWD         <= iWD;
            rWA         <= iWA;
        end

        lpWriteActive:
        begin
            if (wAready)
            begin
                if (rDdrSendCnt == lpSendCntMax)
                begin
                    rDdrState   <= lpReadCmd;
                    rDdrAppEn   <= 1'b0;
                    rDdrReadEn  <= 1'b0;
                    rDdrWriteEn <= 1'b0;
                    rDdrSendCnt <= lpSendCntNull;
                end
                else
                begin
                    rDdrState   <= lpWriteActive;
                    rDdrAppEn   <= 1'b1;
                    rDdrReadEn  <= 1'b0;
                    rDdrWriteEn <= 1'b1;
                    rDdrSendCnt <= rDdrSendCnt + 1'b1;
                    rWD         <= iWD;
                    rWA         <= iWA;
                end
            end
            else
            begin
                rDdrState   <= lpWriteCmd;
                rDdrAppEn   <= 1'b0;
                rDdrReadEn  <= 1'b0;
                rDdrWriteEn <= 1'b0;
                rDdrSendCnt <= rDdrSendCnt;
            end
        end

        lpReadCmd:
        begin
            rDdrState   <= lpReadPass;
            rDdrAppEn   <= wAppFull;
            rDdrReadEn  <= 1'b0;
            rDdrWriteEn <= 1'b0;
            rDdrSendCnt <= rDdrSendCnt;
        end

        lpReadPass:
        begin
            rDdrState   <= lpReadActive;
            rDdrAppEn   <= wAppFull;
            rDdrReadEn  <= wAppFull;
            rDdrWriteEn <= 1'b0;
            rDdrSendCnt <= rDdrSendCnt;
            rRA         <= iRA;
        end

        lpReadActive:
        begin
            if (wAready)
            begin
                if (rDdrSendCnt == lpSendCntMax)
                begin
                    rDdrState   <= lpWriteCmd;
                    rDdrAppEn   <= 1'b0;
                    rDdrReadEn  <= 1'b0;
                    rDdrWriteEn <= 1'b0;
                    rDdrSendCnt <= lpSendCntNull;
                end
                else
                begin
                    rDdrState   <= lpReadActive;
                    rDdrAppEn   <= wAppFull;
                    rDdrReadEn  <= wAppFull;
                    rDdrWriteEn <= 1'b0;
                    rDdrSendCnt <= rDdrSendCnt + 1'b1;
                    rRA         <= iRA;
                end
            end
            else
            begin
                rDdrState   <= lpReadCmd;
                rDdrAppEn   <= 1'b0;
                rDdrReadEn  <= 1'b0;
                rDdrWriteEn <= 1'b0;
                rDdrSendCnt <= rDdrSendCnt;
            end
        end

        default:
        begin
            rDdrState   <= lpWriteCmd;
            rDdrAppEn   <= 1'b0;
            rDdrReadEn  <= 1'b0;
            rDdrWriteEn <= 1'b0;
            rDdrSendCnt <= lpSendCntNull;
        end

        endcase
    end
end

////////////////////////////////////////////////////////////
//----------------------------------------------------------
// 上位モジュールからの、書き込みデータ・アドレスと読み込みアドレスを保存するFIFO
// 
//----------------------------------------------------------
// wire [pBitWidth-1:0] rRA, wWD, wWA;
// wire wRFLL, wWFLL;                              assign {oRready, oWready} = {~wRFLL, ~wWFLL};
// wire wWEMP, wREMP;
// wire wFWVD, wFRVD;
// wire wDualFll;
// reg  [pBitWidth-1:0] rDdrData, rDdrAddr;
// reg  qDdrWE, qDdrCmd, qDdrAppEn;
// reg  qFROE,  qFWOE;

// ddr3Fifo #(
//     .pBuffDepth     (pBuffDepth),
//     .pBitWidth      (pBitWidth)
// ) DDR3_FIFO (
//     // input App side
//     .iCLK           (wUiCLK),       .iRST       (wUiRST),
//     .iWD            (iWD),          .iWA        (iWA),
//     .iWDE           (iWvalid),      
//     .iRA            (iRA),          .iRDE       (iRvalid),

//     // output App side
//     .oRFLL          (wRFLL),        .oWFLL      (wWFLL),

//     // input Ui side
//     .iRRE           (qFROE),        .iWRE       (qFWOE),

//     // output Ui side
//     .oWD            (wWD),          .oWA        (wWA),
//     .oWVD           (wFWVD),
//     .oRA            (rRA),          .oRVD       (wFRVD),
//     .oWEMP          (wWEMP),        .oREMP      (wREMP)
// );

// always @*
// begin
//     qFWOE      <= (~wWEMP) & wAready  & wWready & rDdrWriteEn;
//     qFROE      <= (~wREMP) & (~iAppFull) & wAready & rDdrReadEn;
//     qDdrAppEn  <= rDdrAppEn | wFWVD | wFRVD;
//     {qDdrWE, qDdrCmd}    <= {wFWVD, wFRVD};
//     {rDdrData, rDdrAddr} <= wFWVD ? {wWD, wWA} : {32'd0, rRA};
// end

//----------------------------------------------------------
// DDR sync FIFO
//----------------------------------------------------------
wire [pBitWidth-1:0] wDdrRD;    assign oAppRD  = wDdrRD[31:0];
wire wDdrRVD;                   assign oAppRVD = wDdrRVD;

// fifoController #(
//     .pBuffDepth (pBuffDepth),
//     .pBitWidth  (pBitWidth)
// ) APP_DDR_BRIDGE (
//     // write side           read side
//     .iCLK   (wUiCLK),       .oRD    (oAppRD),
//     .iRST   (wUiRST),       .iRE    (iAppRE),
//     .iWD    (wDdrRD),       .oRVD   (oAppRVD),
//     .iWE    (wDdrRVD),      .oEMP   (oAppEmp),
//     .oFLL   (wDualFll)
// );

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
wire wMigRefClk, wMigInputClk, locked;
wire wMigRST = (~locked);

clk_wiz_1 DDR3_CLK (
    .clk_out1   (wMigRefClk),   .clk_out2   (wMigInputClk),
    .reset      (iRST),         .locked     (locked),
    .clk_in1    (iCLK)
);

//---------------------------------------------------------------------------
// MIG 動作
//---------------------------------------------------------------------------
reg  qDdrWE, qDdrCmd, qDdrAppEn;
reg  [pBitWidth-1:0] qDdrAddr, qDdrWD;

always @*
begin
    qDdrWE    <= rDdrWriteEn;
    qDdrCmd   <= rDdrReadEn;
    qDdrAppEn <= rDdrAppEn;
    qDdrAddr  <= rDdrReadEn ? rRA : rWA;
    qDdrWD    <= rWD;
end

generate
    if (pDramDebug == "on")
        migDemo MIG_DEMO (
            .iData                  ({96'd0, qDdrWD}),
            .oData                  (wDdrRD),            .oCal          (wCal),
            .iAppEN                 (qDdrAppEn),         .iWE           (qDdrWE),
            .iReadCmd               (qDdrCmd),
            .oWready                (wWready),           .oRVD          (wDdrRVD),
            .oAready                (wAready),
            .iCLK                   (wMigInputClk),      .iRST          (wMigRST),
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
            .app_addr               (qDdrAddr[28:0]),       // input [28:0]		addr[28:3] / Bank[2:0]
            .app_cmd                (qDdrCmd),              // input [2:0]		Write 000 / Read 001
            .app_en                 (qDdrAppEn),            // input			ユーザー側がapp_cmd有効時にHighにする
            .app_wdf_data           ({96'd0, qDdrWD}),      // input [127:0]	書き込みデータ 16bit x 8byte
            .app_wdf_end            (qDdrWE),               // input			下記のwrite enable信号と同期させる
            .app_wdf_wren           (qDdrWE),               // input			write enable
            .app_wdf_rdy            (wWready),              // output			データ書き込み可能時High
            .app_wdf_mask           (iMask),                // input [15:0]		各bitに1が立っていたら対応したbyteは書き込まれない
            .app_rd_data            (wDdrRD),               // output [127:0]	読み込みデータ 16bit x 8byte
            .app_rd_data_end        (),                     // output			最後のデータ出力時High
            .app_rd_data_valid      (wDdrRVD),              // output			読み込みデータ出力開始時High
            .app_rdy                (wAready),              // output			DDR 動作可能時High
            .app_sr_req             (1'b0),                 // input			
            .app_ref_req            (1'b0),                 // input			
            .app_zq_req             (1'b0),                 // input			
            .app_sr_active          (),                     // output			
            .app_ref_ack            (),                     // output			
            .app_zq_ack             (),                     // output			
            .ui_clk                 (ui_clk),               // output			MIGと同期のユーザーインターフェースCLK
            .ui_clk_sync_rst        (ui_clk_sync_rst),      // output			ユーザーインターフェースリセット信号
            .device_temp            (),
            .sys_clk_i              (wMigInputClk),
            .clk_ref_i              (wMigRefClk),
            .sys_rst                (wMigRST)               // input sys_rst
        );
endgenerate

endmodule