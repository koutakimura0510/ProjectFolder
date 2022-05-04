//----------------------------------------------------------
// Create 2022/5/02
// Author koutakimura
// -
// Channel 毎に Sound Data を Bram に保存
// 
//----------------------------------------------------------
module seLoadBram (
    input           iSysClk,            // Top Side: System Clk
    input           iRst,               // Top Side: Active High Sync Reset
    input  [ 7:0]   iSoundRd,           // Fmc Side: Read Data
    input           iSoundRdVd,         // Fmc Side: 有効データ読み込み時 High
    input           iSoundSectorCke,    // Fmc Side: Sound Page Read 時 High
    output [26:0]   oSoundAddr,         // Fmc Side: 26:17 Block - 16:11 Page - 10:0 Column
    output          oSoundCke,          // Fmc Side: Rom 読み込み開始
    output          oSoundCmd,          // Fmc Side: 1.Read 0.Write
    input  [ 7:0]   iSlaveRd,           // Usi Bus : 各Slave Module の Csr から読み込むデータ
    input           iSlaveRdVd,         // Usi Bus : 読み込みデータ入力時 High
    output [15:0]   oSgbSoundCh0,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh1,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh2,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh3,       // Sgb Side: 書き込みデータ
    output [15:0]   oSgbSoundCh4,       // Sgb Side: 書き込みデータ
    input  [ 4:0]   iSgbChannelRdy,     // Sgb Side: 書き込み可能 Channel 1.
    output          oSgbWdVdCh0,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh1,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh2,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh3,        // Sgb Side: 有効データ書き込み時 High
    output          oSgbWdVdCh4         // Sgb Side: 有効データ書き込み時 High
);


//----------------------------------------------------------
// Channel Select State
//----------------------------------------------------------
localparam [2:0]
        lpCh0,
        lpCh1,
        lpCh2,
        lpCh3,
        lpCh4;

reg [2:0] rSt;

always @(posedge iSysClk)
begin
    case (rSt)
        lpCh0:
        begin
            
        end

        lpCh1:
        begin
            
        end

        lpCh2:
        begin
            
        end

        lpCh3:
        begin
            
        end

        lpCh4:
        begin
            
        end

        default:
        begin
            rSt <= lpIdol;
        end
    endcase
end


//----------------------------------------------------------
// 書き込みデータとチャンネル選択
//----------------------------------------------------------
reg  qSelWdCh0;
reg  qSelWdCh1;
reg  qSelWdCh2;
reg  qSelWdCh3;
reg  qSelWdCh4;
reg  qSelWdVdCh0;
reg  qSelWdVdCh1;
reg  qSelWdVdCh2;
reg  qSelWdVdCh3;
reg  qSelWdVdCh4;
wire wStReCh0;

always @*
begin
    case (rSt)
        lpCh0:      qSelWdCh0 <= iSoundRd;
        lpCh1:      qSelWdCh1 <= iSoundRd;
        lpCh2:      qSelWdCh2 <= iSoundRd;
        lpCh3:      qSelWdCh3 <= iSoundRd;
        lpCh4:      qSelWdCh4 <= iSoundRd;
        default:
        begin
                    qSelWdCh0 <= 8'd0;
                    qSelWdCh1 <= 8'd0;
                    qSelWdCh2 <= 8'd0;
                    qSelWdCh3 <= 8'd0;
                    qSelWdCh4 <= 8'd0;
        end
    endcase
end

always @*
begin
    case (rSt)
        lpCh0:      qSelWdVdCh0 <= iSoundRdVd;
        lpCh1:      qSelWdVdCh1 <= iSoundRdVd;
        lpCh2:      qSelWdVdCh2 <= iSoundRdVd;
        lpCh3:      qSelWdVdCh3 <= iSoundRdVd;
        lpCh4:      qSelWdVdCh4 <= iSoundRdVd;
        default:
        begin
                    qSelWdVdCh0 <= 1'b0;
                    qSelWdVdCh1 <= 1'b0;
                    qSelWdVdCh2 <= 1'b0;
                    qSelWdVdCh3 <= 1'b0;
                    qSelWdVdCh4 <= 1'b0;
        end
    endcase
end


//----------------------------------------------------------
// address gen
//----------------------------------------------------------
localparam [3:0] lpChannel = 4'd4;      // Channel数

reg [26:0] rSoundAddr [0:lpChannel];                   assign oSoundAddr = rSoundAddr;

always @(posedge iSysClk)
begin
    if (iRst)                   rSoundAddr <= 0;
    else if (iSoundSectorCke)   rSoundAddr <= rSoundAddr + lpPageUp;
    else                        rSoundAddr <= rSoundAddr;
end


//----------------------------------------------------------
// CH0
//----------------------------------------------------------
reg  [7:0] qFifoWdCh0;
reg  qFifoWeCh0;
reg  qFifoReCh0;
wire wFifoFullCh0;
wire [7:0] wFifoRdCh0;
wire wFifoRvdCh0;
wire wFifoEmpCh0;

fifoController # (
    .pBuffDepth (4096),
    .pBitWidth  (8)
) SE_CH0 (
    .iClk       (iSysClk),
    .iRst       (iRst),
    .iWd        (qFifoWdCh0),
    .iWe        (qFifoWeCh0),
    .oFull      (wFifoFullCh0),
    .iRe        (qFifoReCh0),
    .oRd        (wFifoRdCh0),
    .oRvd       (wFifoRvdCh0),
    .oEmp       (wFifoEmpCh0)
);

always @*
begin
    qStRdCh0    <= wFifoRdCh0;
    qFifoWdCh0  <= qSelWdCh0;
    qFifoWeCh0  <= qSelWdVdCh0;
    qFifoReCh0  <= ;
end



endmodule