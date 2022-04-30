//----------------------------------------------------------
// Create  2022/4/29
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
module fmState #(
    parameter       pSector = 2048,
    parameter       pPage   = 64,
    parameter       pBlock  = 1024
)(
    input           iSysClk,        // system clk
    input           iRst,
    input           iCke,           // Top    Side: 0. disconnect 1. active
    input           iCmd,           // Top    Side: 1. Read / 0. Write
    input  [26:0]   iAddr,          // Top    Side: 26:17 Block - 16:11 Page - 10:0 Column
    input  [7:0]    iWd,            // Top    Side: 書き込みデータ
    output          oWdVd,          // Top    Side: 1byte 書き込み完了時 High
    output [7:0]    oRd,            // Top    Side: Flash Mem からのデータを上位モジュールに渡す
    output          oRdVd,          // Top    Side: 読み込みデータ出力時High
    output          oSectorCke,     // Top    Side: 1page カウント時 High
    output          oWblockCke,     // Top    Side: 1block 書き込み時 High
    output [7:0]    oWd,            // Memory Side: フラッシュメモリの書き込みデータ
    output          iWdVd,          // Memory Side: 1byte 書き込み完了時 High
    input  [7:0]    iRd,            // Memory Side: フラッシュメモリからの読み込みデータ
    input           iRdVd,          // Memory Side: 有効読み込みデータ受信時 High
    output          oCs,            // Memory Side: Chip Select
    output          oCke,           // Memory Side: 0. disconnect 1. active
    output          oCmd            // Memory Side: 1.Read / 0.Write
);


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


//---------------------------------------------------------
// Winbond W25N01GV Register Map
//---------------------------------------------------------
localparam [7:0]
    lpBusyBit   = 8'h01;

localparam [7:0]
    lpDummy     = 8'h00,
    lpCmdWrdi   = 8'h04,     // Write Disable
    lpCmdWren   = 8'h06,     // Write Enable
    lpCmdBe     = 8'hD8,     // Parameter Block Erase
    lpCmdPdl    = 8'h02,     // Program Data Load
    lpCmdPe     = 8'h10,     // Program Execute
    lpCmdRead   = 8'h03,     // Read
    lpCmdPdr    = 8'h13,     // Program Data Read
    lpCmdRdsr1  = 8'h05,     // Read Status cmd
    lpAddrSr0   = 8'h00,     // Protection Reg-0
    lpAddrSr1   = 8'h01,     // Status Reg-1
    lpAddrSr2   = 8'h02,     // Configration Reg-2
    lpAddrSr3   = 8'h03;     // Status Reg-3 1bit wel (write enable latch) / 0bit busy



//----------------------------------------------------------
// Spi ステートマシン制御
//----------------------------------------------------------
localparam [3:0]
    lpIdol      = 4'h0,     // コマンド発行設定
    lpCsLow     = 4'h1,     // CS Low
    lpCsHigh    = 4'h2,     // CS High
    lpWait      = 4'h3,     // CS High Hold Time
    lpBusy      = 4'h4,     // Busy コマンド発行
    lpReady     = 4'h5,     // Busy Bit 確認
    lpWren1     = 4'h6,     // Block 消去時の書き込み有効コマンド
    lpBe        = 4'h7,     // Block 消去コマンド
    lpWren2     = 4'h8,     // 消去後の 空き領域に対する書き込み有効コマンド
    lpPdl       = 4'h9,     // セクタの Column アドレス発行
    lpWrNow     = 4'ha,     // 書き込みバイト数分、書き込み中状態
    lpPe        = 4'hb,     // 書き込みバイトを指定ページに書き込み発行
    lpComp      = 4'hc,     // 128KB 書き込みを行ったか確認する
    lpPdr       = 4'hd,     // 読み込みブロック、ページ指定コマンド発行
    lpRead      = 4'he,     // セクタの Column アドレス発行 基本 0 から開始
    lpReNow     = 4'hf;     // 読み込み中バイト数分、読み込み中

reg rCs;                                    assign oCs = rCs;
reg [3:0] rSt;  
reg [3:0] rStNext;
reg [3:0] rStNext2;
reg rBusy;
reg qCsCke;
reg qCntCke;
reg qPageCke;

always @(posedge iSysClk)
begin
    case (rSt)
        //----------------------------------------------------------
        // IDOL モード
        // Spi 動作 Enable 信号受信し動作開始
        //----------------------------------------------------------
        lpIdol:
        begin
            rSt     <= (iCke) ? lpCsLow : lpIdol;
            rStNext <= (iCmd) ? lpPdr   : lpWren1;
            rCs     <= (iCke) ? 1'b0    : 1'b1; 
        end

        //----------------------------------------------------------
        // CS モード
        // CS Hold Time 経過後 High Low Wait モードを切り替え
        //----------------------------------------------------------
        lpCsLow:
        begin
            rSt     <= (qCsCke) ? rStNext : lpCsLow;
            rCs     <= 1'b0; 
        end

        lpCsHigh:
        begin
            rSt     <= (qCsCke) ? lpWait : lpCsHigh; 
            rCs     <= qCsCke; 
        end

        lpWait:
        begin
            rSt     <= (qCsCke) ? lpCsLow  : lpWait;
        end

        //----------------------------------------------------------
        // Busy Bit Check モード
        // Busy Bit に 1がセットされていれば、直前のモードで設定した次のモードに移行する
        // されていなければ、再度 Busy 信号がセットされるまで Busy コマンドを発行
        //----------------------------------------------------------
        lpBusy:
        begin
            rSt      <= (qCntCke) ? lpCsHigh : lpBusy;
            rStNext  <= lpReady;
        end

        lpReady:
        begin
            rSt      <= (rBusy) ? rStNext2 : lpBusy;
        end

        //----------------------------------------------------------
        // Block Erase モード
        // 書き込み開始前の指定アドレスブロック消去を行う
        //----------------------------------------------------------
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

        //----------------------------------------------------------
        // Page Write モード
        // 指定アドレスブロック消去後に、1page 領域のデータ送信を行う
        // 送信後、書き込みコマンドを発行し、完了確認の Busy モードに移行する
        // Busy Check を行い、1block 領域書き込みを行ったか確認し、
        // 行っていなければ、再度 1page 領域のデータ送信を行う
        //----------------------------------------------------------
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

        //----------------------------------------------------------
        // Page Read モード
        // 指定アドレスページの読み込みコマンド発行後、
        // データが Memory の FIFO にセットされるまで待機する
        // 完了したら SCLK を送信し 1page 領域のデータを読み込む
        //----------------------------------------------------------
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
            rStNext2 <= lpIdol;
            rCs      <= 1'b1;
        end
    endcase
end


//----------------------------------------------------------
// コマンドの送信数設定、カウント
// case の default に 1page の最大バイト数を記述
//----------------------------------------------------------
localparam [11:0] lpMaxSector = pSector;

reg rSectorCke;                                     assign oSectorCke = rSectorCke;
reg [11:0] rCmdMaxCnt;
reg [11:0] rCmdCnt;

always @(posedge iSysClk)
begin
    case (rSt)
        lpWren1:        rCmdMaxCnt <= 12'd1;
        lpBe:           rCmdMaxCnt <= 12'd4;
        lpBusy:         rCmdMaxCnt <= 12'd3;
        lpWren2:        rCmdMaxCnt <= 12'd1;
        lpPdl:          rCmdMaxCnt <= 12'd3;
        lpPe:           rCmdMaxCnt <= 12'd4;
        lpPdr:          rCmdMaxCnt <= 12'd4;
        lpRead:         rCmdMaxCnt <= 12'd4;
        default:        rCmdMaxCnt <= lpMaxSector;
    endcase
end

always @(posedge iSysClk)
begin
    if (iRst)           rCmdCnt <= 12'd0;
    else if (qCntCke)   rCmdCnt <= 12'd0;
    else if (iWdVd)     rCmdCnt <= rCmdCnt + 1'b1;
    else                rCmdCnt <= rCmdCnt;
end

always @(posedge iSysClk)
begin
    rSectorCke <= qCntCke;
end

always @*
begin
    qCntCke <= rCmdCnt == rCmdMaxCnt;
end


//----------------------------------------------------------
// 128KB 送信確認
// 書き込みデータ送信中のみページ数をカウントしておく
//----------------------------------------------------------
localparam [5:0] lpMaxPage = pPage;

reg rWblockCke;                                       assign oWblockCke = rWblockCke;
reg [5:0] rPageCnt;

always @(posedge iSysClk)
begin
    if (iRst) rPageCnt    <= 6'd0;
    else
    begin
        case (rSt)
            lpWrNow: rPageCnt <= qCntCke  ? rPageCnt + 1'b1 : rPageCnt;
            lpComp : rPageCnt <= qPageCke ? 6'd0 : rPageCnt;
            default: rPageCnt <= rPageCnt;
        endcase
    end
end

always @(posedge iSysClk)
begin
    rWblockCke <= qPageCke;
end

always @*
begin
    qPageCke <= rPageCnt == lpMaxPage;
end


//----------------------------------------------------------
// Busy Bit 確認
//----------------------------------------------------------
always @(posedge iSysClk)
begin
    if (iRdVd)  rBusy <= iRd & lpBusyBit;
    else        rBusy <= rBusy;
end


//----------------------------------------------------------
// レジスタ にコマンドデータ設定
//----------------------------------------------------------
reg [7:0] rCmdBuff [0:3];

always @(posedge iSysClk)
begin
    case (rSt)
        lpWren1:
        begin
            rCmdBuff[0] <= lpCmdWren;
            rCmdBuff[1] <= lpDummy;
            rCmdBuff[2] <= lpDummy;
            rCmdBuff[3] <= lpDummy;
        end

        lpBe:
        begin
            rCmdBuff[0] <= lpCmdBe;
            rCmdBuff[1] <= lpDummy;
            rCmdBuff[2] <= iAddr[26:19];
            rCmdBuff[3] <= iAddr[18:11];
        end

        lpBusy:
        begin
            rCmdBuff[0] <= lpCmdRdsr1;
            rCmdBuff[1] <= lpAddrSr3;
            rCmdBuff[2] <= lpDummy;
            rCmdBuff[3] <= lpDummy;
        end

        lpWren2:
        begin
            rCmdBuff[0] <= lpCmdWren;
            rCmdBuff[1] <= lpDummy;
            rCmdBuff[2] <= lpDummy;
            rCmdBuff[3] <= lpDummy;
        end

        lpPdl:
        begin
            rCmdBuff[0] <= lpCmdPdl;
            rCmdBuff[1] <= {5'd0, iAddr[10:8]};
            rCmdBuff[2] <= iAddr[ 7:0];
            rCmdBuff[3] <= lpDummy;
        end

        lpPe:
        begin
            rCmdBuff[0] <= lpCmdPe;
            rCmdBuff[1] <= lpDummy;
            rCmdBuff[2] <= iAddr[26:19];
            rCmdBuff[3] <= iAddr[18:11];
        end

        lpPdr:
        begin
            rCmdBuff[0] <= lpCmdPdr;
            rCmdBuff[1] <= lpDummy;
            rCmdBuff[2] <= iAddr[26:19];
            rCmdBuff[3] <= iAddr[18:11];
            
        end

        lpRead:
        begin
            rCmdBuff[0] <= lpCmdRead;
            rCmdBuff[1] <= {5'd0, iAddr[10:8]};
            rCmdBuff[2] <= iAddr[ 7:0];
            rCmdBuff[3] <= lpDummy;
        end

        default: 
        begin
            rCmdBuff[0] <= lpDummy;
            rCmdBuff[1] <= lpDummy;
            rCmdBuff[2] <= lpDummy;
            rCmdBuff[3] <= lpDummy;
        end
    endcase
end


//----------------------------------------------------------
// Top Module から受信するデータを送信
// Cmd Data 送信中は 内部 Module のコマンドデータ送信
// Cmd Data 送信完了の iWdVd は Top Module には不要なため、
// Write Data 送信中のみ、iWdVd を送信するようにした
//----------------------------------------------------------
reg rWdVd;                                  assign oWdVd = rWdVd;
reg [7:0] rWd;                              assign oWd   = rWd;
reg [1:0] rWp;

always @(posedge iSysClk)
begin
    if (iRst)           rWp <= 3'd0;
    else if (qCntCke)   rWp <= 3'd0;
    else if (iWdVd)     rWp <= rWp + 1'b1;
    else                rWp <= rWp;
end

always @(posedge iSysClk)
begin
    case (rSt)
        lpWrNow:        rWd <= iWd;
        lpReNow:        rWd <= 8'haa;
        default:        rWd <= rCmdBuff[rWp];
    endcase
end

always @(posedge iSysClk)
begin
    case (rSt)
        lpWrNow:        rWdVd <= iWdVd;
        default:        rWdVd <= 1'b0;
    endcase
end


//----------------------------------------------------------
// Memory Side に制御信号出力
// ステートマシンとのタイミングを合わせるため、遅延用 FF で出力
// CS Toggle 中は CKE を Disable し、下位 module にリセットをかけておく
// 
// ※ Simlation の結果で、最低 4ff 必要だったので 4段にしている
//----------------------------------------------------------
reg [3:0] rCke;                                   assign oCke = rCke[3];
reg [3:0] rCmd;                                   assign oCmd = rCmd[3];

always @(posedge iSysClk)
begin
    case (rSt)
        lpCsLow : rCke <= 3'd0;
        lpCsHigh: rCke <= 3'd0;
        lpWait  : rCke <= 3'd0;
        default : rCke <= (iWdVd) ? 3'd0 : {rCke[2:0], iCke};
    endcase
end

always @(posedge iSysClk)
begin
    rCmd <= {rCmd[2:0], iCmd};
end


//----------------------------------------------------------
// Top Module に Read データ送信
// Top Module は Busy Bit などの ステータス・レジスタ データは不要なため、
// 読み込みデータのみ Top Module に送信するようにしている
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
            rRd     <= 8'd0;
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
    qCsCke <= rCsCnt == 5'd8;
end

endmodule