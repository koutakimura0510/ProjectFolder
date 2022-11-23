//----------------------------------------------------------
// Create  2022/4/25
// Author  koutakimura
// -
// Spi Rom ステートマシン
// 
// 「W25N01GV」
// ※ デバイスが 128KB 単位の Block Erase しかできないため、下記の注意が必要
// ※ 書き込みを行う場合は必ず 128KB 単位で行う
// ※ 各データ (データベース) は必ず 128KB 単位で管理を行う
// 
//----------------------------------------------------------
module flashCmd (
    input           iSysClk,        // system clk
    input           iCke,           // Top    Side: 0. disconnect 1. active
    input           iCmd,           // Top    Side: 1. Read / 0. Write
    input  [26:0]   iAddr,          // Top    Side: 26:17 Block - 16:11 Page - 10:0 Column
    input  [7:0]    iWd,            // Top    Side: 書き込みデータ
    output          qWdVd,          
    output [7:0]    oRd,            // Top    Side: Flash Mem からのデータを上位モジュールに渡す
    output          oRdVd,          // Top    Side: 読み込みデータ出力時High
    output [7:0]    oWd,            // Memory Side: フラッシュメモリの書き込みデータ
    output          iWdVd,          // Memory Side: 1byte 書き込み完了時 High
    input  [7:0]    iRd,            // Memory Side: フラッシュメモリからの読み込みデータ
    input           iRdVd,          // Memory Side: 有効読み込みデータ受信時 High
    output          oCs,            // Memory Side: Chip Select
    output          oCke,           // Memory Side: 0. disconnect 1. active
    output          oCmd            // Memory Side: 1.Read / 0.Write
);


//---------------------------------------------------------
// Winbond W25N01GV Register Map
//---------------------------------------------------------
// localparam CMD_REMS  = 8'h90;   // デバイスのIDを取得、Cmd + Null24bit address + 2byte Null data
// localparam CMD_RDID  = 8'h9f;   // JEDEC Manufacturer ID and JEDEC CF1
// localparam CMD_READ  = 8'h03;   // Read 3 byte address -> Cmd + ColAddr + Dummy + Data(MOSI は0でよい)
// localparam CMD_4READ = 8'h13;   // Read 4 byte address -> Cmd + Addr + Data(MOSI は0でよい)
// localparam CMD_WREN  = 8'h06;   // Write Enable  -> Cmd
// localparam CMD_WRDI  = 8'h04;   // Write Disable -> Cmd
// localparam CMD_P4E   = 8'h20;   // Parameter Sector Erase 3byte Address -> Cmd + Addr
// localparam CMD_4P4E  = 8'h21;   // Parameter Sector Erase 4byte Address -> Cmd + Addr
// localparam CMD_BE    = 8'hD8;   // Parameter Block Erase -> Cmd + 1byte Dummy + 16bit page Addr
// localparam CMD_4BE   = 8'hDC;   // Parameter Block Erase 4byte Address -> Cmd + Dummy + 16bit page Addr
// localparam CMD_P8E   = 8'h40;   // 全消去 
// localparam CMD_BE    = 8'h60;   // Bulk Erase
// localparam CMD_PP    = 8'h02;   // Page Program 3byte Address -> Cmd + Addr + Data
// localparam CMD_4PP   = 8'h12;   // Page Program 4byte Address -> Cmd + Addr + Data
// localparam CMD_RDSR1 = 8'h05;   // Read Status Register-1 WIPの確認用0x01 -> Cmd + Dummy Clk

localparam [7:0]
    lpBusyBit  = 8'h01;

localparam [7:0]
    lpDummy    = 8'h00,
    lpCmdWrdi  = 8'h04,     // Write Disable
    lpCmdWren  = 8'h06,     // Write Enable
    lpCmdBe    = 8'hD8,     // Parameter Block Erase
    lpCmdPdl   = 8'h02,     // Program Data Load
    lpCmdPe    = 8'h10,     // Program Execute
    lpCmdRead  = 8'h03,     // Read
    lpCmdPdr   = 8'h13,     // Program Data Read
    lpCmdRdsr1 = 8'h05,     // Read Status cmd
    lpAddrSr0  = 8'h00,     // Protection Reg-0
    lpAddrSr1  = 8'h01,     // Status Reg-1
    lpAddrSr2  = 8'h02,     // Configration Reg-2
    lpAddrSr3  = 8'h03;     // Status Reg-3 1bit wel (write enable latch) / 0bit busy


localparam [3:0]
    lpIdol      = 4'd0,     // コマンド発行設定
    lpCsLow     = 4'd1,     // CS Low
    lpCsHigh    = 4'd2,     // CS High
    lpWait      = 4'd3,     // CS High Hold Time
    lpBusy      = 4'd4,     // Busy コマンド発行
    lpReady     = 4'd5,     // Busy Bit 確認
    lpWren1     = 4'd6,     // Block 消去時の書き込み有効コマンド
    lpBe        = 4'd7,     // Block 消去コマンド
    lpWren2     = 4'd8,     // 消去後の 空き領域に対する書き込み有効コマンド
    lpPdl       = 4'd9,     // セクタの Column アドレス発行
    lpWrNow     = 4'd10,    // 書き込みバイト数分、書き込み中状態
    lpPe        = 4'd11,    // 書き込みバイトを指定ページに書き込み発行
    lpComp      = 4'd12,    // 128KB 書き込みを行ったか確認する
    lpPdr       = 4'd13,    // 読み込みブロック、ページ指定コマンド発行
    lpRead      = 4'd14,    // セクタの Column アドレス発行 基本 0 から開始
    lpReNow     = 4'd15;    // 読み込み中バイト数分、読み込み中



//----------------------------------------------------------
// Spi ステートマシン制御
//----------------------------------------------------------
reg rCs;                        assign oCs = rCs;

// State Status
reg [3:0] rSt;
reg [3:0] rStNext, rStNext2;

// enable
reg qCsCke;
reg qCntCke, qPageCke;

always @(posedge iSysClk)
begin
    case (rSt)
        lpIdol:
        begin
            rSt     <= (iCke) ? lpCslow : lpIdol;
            rStNext <= (iCmd) ? lpPdr   : lpWren1;
            rCs     <= (iCke) ? 1'b0    : 1'b1; 
        end

        lpCslow:
        begin
            rSt     <= (qCsCke) ? rStNext : lpCslow;
            rCs     <= 1'b0; 
        end

        lpCsHigh:
        begin
            rSt     <= (qCsCke) ? lpWait : lpCsHigh; 
            rCs     <= qCsCke; 
        end

        lpWait:
        begin
            rSt     <= (qCsCke) ? lpCslow  : lpWait;
        end

        lpBusy:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpBusy;
            rStNext  <= lpReady;
        end

        lpReady:
        begin
            rSt      <= (rBusy) ? rStNext2 : lpBusy;
        end

        lpWren1:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpWren1;
            rStNext  <= lpBe;
        end

        lpBe:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpBe;
            rStNext  <= lpBusy;
            rStNext2 <= lpWren2;
        end

        lpWren2:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpWren2;
            rStNext  <= lpPdl;
        end

        lpPdl:
        begin
            rSt      <= (qCntCke) ? lpWrNow : lpPdl;
        end

        lpWrNow:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpWrNow;
            rStNext  <= lpPe;
        end

        lpPe:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpPe;
            rStNext  <= lpBusy;
            rStNext2 <= lpComp;
        end

        lpComp:
        begin
            rSt      <= (qPageCke) ? lpIdol : lpWait;
            rStNext  <= lpWren2;
        end

        lpPdr:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpPdr;
            rStNext  <= lpBusy;
            rStNext2 <= lpRead;
        end

        lpRead:
        begin
            rSt      <= (qCntCke) ? lpReNow : lpRead;
        end

        lpReNow:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpReNow;
            rStNext  <= lpIdol;
        end

        default: 
        begin
            rSt      <= lpIdol;
            rStNext  <= lpIdol;
            rCs      <= 1'b1;
        end
    endcase
end


//----------------------------------------------------------
// RAM コマンドの送信数設定、カウント
//----------------------------------------------------------
reg [10:0] rCmdMaxCnt;
reg [10:0] rCmdCnt;

always @(posedge iSysClk)
begin
    case (rSt)
        lpWren1:        rCmdMaxCnt <= 11'd1;
        lpBe:           rCmdMaxCnt <= 11'd4;
        lpBusy:         rCmdMaxCnt <= 11'd3;
        lpWren2:        rCmdMaxCnt <= 11'd1;
        lpPdl:          rCmdMaxCnt <= 11'd3;
        lpPe:           rCmdMaxCnt <= 11'd4;
        lpPdr:          rCmdMaxCnt <= 11'd4;
        lpRead:         rCmdMaxCnt <= 11'd4;
        default:        rCmdMaxCnt <= 11'd2047;
    endcase
end

always @(posedge iSysClk)
begin
    if (qCntCke)        rCmdCnt <= 11'd0;
    else if (iWdVd)     rCmdCnt <= rCmdCnt + 1'b1;
    else                rCmdCnt <= rCmdCnt;
end

always @*
begin
    qCntCke <= rCmdCnt == rCmdMaxCnt;
end


//----------------------------------------------------------
// 128KB 送信確認
//----------------------------------------------------------
reg [5:0] rPageCnt;

always @(posedge iSysClk)
begin
    case (rSt)
        lpWrNow: rPageCnt <= qCntCke  ? rPageCnt + 1'b1 : rPageCnt;
        lpComp : rPageCnt <= qPageCke ? 6'd0 : rPageCnt;
        default: rPageCnt <= rPageCnt;
    endcase
end

always @*
begin
    qPageCke <= rPageCnt == 6'd63;
end


//----------------------------------------------------------
// Busy Bit 確認
//----------------------------------------------------------
reg rBusy;

always @(posedge iSysClk)
begin
    if (iRdVd)          rBusy <= iRd & lpBusyBit;
    else
    begin
        case (rSt)
            lpBusy :    rBusy <= rBusy;
            lpReady:    rBusy <= rBusy;
            default:    rBusy <= 1'b0;
        endcase
    end
end


//----------------------------------------------------------
// RAM にコマンドデータ設定
//----------------------------------------------------------
reg [7:0] qCmd [0:3];

always @*
begin
    case (rSt)
        lpWren1:
        begin
            qCmd[0] <= lpCmdWren;
        end

        lpBe:
        begin
            qCmd[0] <= lpCmdBe;
            qCmd[1] <= lpDummy;
            qCmd[2] <= iAddr[26:19];
            qCmd[3] <= iAddr[18:11];
        end

        lpBusy:
        begin
            qCmd[0] <= lpCmdRdsr1;
            qCmd[1] <= lpAddrSr3;
            qCmd[2] <= lpDummy;
        end

        lpWren2:
        begin
            qCmd[0] <= lpCmdWren;
        end

        lpPdl:
        begin
            qCmd[0] <= lpCmdPdl;
            qCmd[1] <= {5'd0, iAddr[10:8]};
            qCmd[2] <= iAddr[ 7:0];
        end

        lpPe:
        begin
            qCmd[0] <= lpCmdPe;
            qCmd[1] <= lpDummy;
            qCmd[2] <= iAddr[26:19];
            qCmd[3] <= iAddr[18:11];
        end

        lpCmdPdr:
        begin
            qCmd[0] <= lpCmdPdr;
            qCmd[1] <= lpDummy;
            qCmd[2] <= iAddr[26:19];
            qCmd[3] <= iAddr[18:11];
            
        end

        lpCmdRead:
        begin
            qCmd[0] <= lpCmdRead;
            qCmd[1] <= {5'd0, iAddr[10:8]};
            qCmd[2] <= iAddr[ 7:0];
            qCmd[3] <= lpDummy;
        end

        default: 
        begin
            qCmd[0] <= lpCmdWren;
        end
    endcase
end


//----------------------------------------------------------
// Send Data
//----------------------------------------------------------
reg [7:0] rWd;                              assign oWd = rWd;
reg [2:0] rWp;

always @(posedge iSysClk)
begin
    if (qCntCke)        rWp <= 3'd0;
    else if (iWdVd)     rWp <= rWp + 1'b1;
    else                rWp <= rWp;
end

always @(posedge iSysClk)
begin
    case (rSt)
        lpWrNow:        rWd <= iWd;
        default:        rWd <= qCmd[rWp];
    endcase
end


//----------------------------------------------------------
// Memory Side に制御信号出力
//----------------------------------------------------------
reg rCke;                                   assign oCke = rCke;
reg rCmd;                                   assign oCmd = rCmd;

always @(posedge iSysClk)
begin
    rCke <= iCke;
    rCmd <= iCmd;
end


//----------------------------------------------------------
// Cmd 判定を行い、Top Module に Read データ送信
//----------------------------------------------------------
reg [7:0] rRd;                              assign oRd   = rRd;
reg rRdVd;                                  assign oRdVd = rRdVd;

always @(posedge iSysClk)
begin
    case (rSt)
        lpReNow: 
        begin
            rRd     <= iRd;
            rRdVd   <= iRdVd;
        end

        default:  
        begin
            rRd     <= rRd;
            rRdVd   <= 1'b0;
        end
    endcase
end


//----------------------------------------------------------
// CS Hold Time Counter
//----------------------------------------------------------
reg [4:0] rCsCnt;

always @(posedge iSysClk)
begin
    case ({qCsCke, rSt})
        lpCsLow:    rCsCnt <= rCsCnt + 1'b1;
        lpCsHigh:   rCsCnt <= rCsCnt + 1'b1;
        lpWait:     rCsCnt <= rCsCnt + 1'b1;
        default:    rCsCnt <= 5'd0;
    endcase
end

always @*
begin
    qCsCke <= rCsCnt == 5'd10;
end

endmodule