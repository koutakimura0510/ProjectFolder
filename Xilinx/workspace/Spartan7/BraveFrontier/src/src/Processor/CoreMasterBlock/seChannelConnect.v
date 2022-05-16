//----------------------------------------------------------
// Create 2022/5/02
// Author koutakimura
// -
// Channel 毎に Sound Data を Bram に保存
// 
//----------------------------------------------------------
module seChannelConnect (
    input           iSysClk,            // Top Side: System Clk
    input           iRst,               // Top Side: Active High Sync Reset
    input  [ 7:0]   iSoundRd,           // Fmc Side: Read Data
    input           iSoundRdVd,         // Fmc Side: 有効データ読み込み時 High
    input           iSoundSectorCke,    // Fmc Side: Sound Page Read 時 High
    output [26:0]   oSoundAddr,         // Fmc Side: 26:17 Block - 16:11 Page - 10:0 Column
    output          oSoundCke,          // Fmc Side: Rom 読み込み開始
    output          oSoundCmd,          // Fmc Side: 1.Read 0.Write
    input  [ 4:0]   iAction,            // 現在のゲーム状況 Bit
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
// Data Cmd
//----------------------------------------------------------
assign oSoundCmd = 1'b1;


//----------------------------------------------------------
// Channel Select State
//----------------------------------------------------------
localparam [2:0]
        lpCh0 = 3'd0,
        lpCh1 = 3'd1,
        lpCh2 = 3'd2,
        lpCh3 = 3'd3,
        lpCh4 = 3'd4;

reg [2:0] rSt;

always @(posedge iSysClk)
begin
    case (rSt)
        lpCh0:
        begin
            rSt <= lpCh0;
        end

        // lpCh1:
        // begin
            
        // end

        // lpCh2:
        // begin
            
        // end

        // lpCh3:
        // begin
            
        // end

        // lpCh4:
        // begin
            
        // end

        default:
        begin
            rSt <= lpCh0;
        end
    endcase
end



//----------------------------------------------------------
// 書き込みデータとチャンネル選択
//----------------------------------------------------------
reg  [7:0] rSelWdCh0;
reg  [7:0] rSelWdCh1;
reg  [7:0] rSelWdCh2;
reg  [7:0] rSelWdCh3;
reg  [7:0] rSelWdCh4;
reg  rSelWdVdCh0;
reg  rSelWdVdCh1;
reg  rSelWdVdCh2;
reg  rSelWdVdCh3;
reg  rSelWdVdCh4;
wire wStReCh0;

always @(posedge iSysClk)
begin
    case (rSt)
        lpCh0:
        begin
            rSelWdCh0 <= iSoundRd;
            rSelWdCh1 <= 8'd0;
            rSelWdCh2 <= 8'd0;
            rSelWdCh3 <= 8'd0;
            rSelWdCh4 <= 8'd0;
        end

        lpCh1:
        begin
            rSelWdCh0 <= 8'd0;
            rSelWdCh1 <= iSoundRd;
            rSelWdCh2 <= 8'd0;
            rSelWdCh3 <= 8'd0;
            rSelWdCh4 <= 8'd0;
        end

        lpCh2:
        begin
            rSelWdCh0 <= 8'd0;
            rSelWdCh1 <= 8'd0;
            rSelWdCh2 <= iSoundRd;
            rSelWdCh3 <= 8'd0;
            rSelWdCh4 <= 8'd0;
        end

        lpCh3:
        begin
            rSelWdCh0 <= 8'd0;
            rSelWdCh1 <= 8'd0;
            rSelWdCh2 <= 8'd0;
            rSelWdCh3 <= iSoundRd;
            rSelWdCh4 <= 8'd0;
        end

        lpCh4:
        begin
            rSelWdCh0 <= 8'd0;
            rSelWdCh1 <= 8'd0;
            rSelWdCh2 <= 8'd0;
            rSelWdCh3 <= 8'd0;
            rSelWdCh4 <= iSoundRd;
        end

        default:
        begin
            rSelWdCh0 <= 8'd0;
            rSelWdCh1 <= 8'd0;
            rSelWdCh2 <= 8'd0;
            rSelWdCh3 <= 8'd0;
            rSelWdCh4 <= 8'd0;
        end
    endcase
end

always @ (posedge iSysClk)
begin
    case (rSt)
        lpCh0:
        begin
            rSelWdVdCh0 <= iSoundRdVd;
            rSelWdVdCh1 <= 1'b0;
            rSelWdVdCh2 <= 1'b0;
            rSelWdVdCh3 <= 1'b0;
            rSelWdVdCh4 <= 1'b0;
        end

        lpCh1:
        begin
            rSelWdVdCh0 <= 1'b0;
            rSelWdVdCh1 <= iSoundRdVd;
            rSelWdVdCh2 <= 1'b0;
            rSelWdVdCh3 <= 1'b0;
            rSelWdVdCh4 <= 1'b0;
        end

        lpCh2:
        begin
            rSelWdVdCh0 <= 1'b0;
            rSelWdVdCh1 <= 1'b0;
            rSelWdVdCh2 <= iSoundRdVd;
            rSelWdVdCh3 <= 1'b0;
            rSelWdVdCh4 <= 1'b0;
        end

        lpCh3:
        begin
            rSelWdVdCh0 <= 1'b0;
            rSelWdVdCh1 <= 1'b0;
            rSelWdVdCh2 <= 1'b0;
            rSelWdVdCh3 <= iSoundRdVd;
            rSelWdVdCh4 <= 1'b0;
        end

        lpCh4:
        begin
            rSelWdVdCh0 <= 1'b0;
            rSelWdVdCh1 <= 1'b0;
            rSelWdVdCh2 <= 1'b0;
            rSelWdVdCh3 <= 1'b0;
            rSelWdVdCh4 <= iSoundRdVd;
        end

        default:
        begin
            rSelWdVdCh0 <= 1'b0;
            rSelWdVdCh1 <= 1'b0;
            rSelWdVdCh2 <= 1'b0;
            rSelWdVdCh3 <= 1'b0;
            rSelWdVdCh4 <= 1'b0;
        end
    endcase
end


//----------------------------------------------------------
// address gen
//----------------------------------------------------------
localparam [11:0] lpPageUp = 12'h800;
localparam [3:0] lpChannel = 4'd4;      // Channel数

reg [26:0] rSoundAddr;        assign oSoundAddr = rSoundAddr;
// reg [26:0] rSoundAddr [0:lpChannel];        assign oSoundAddr = rSoundAddr;

always @(posedge iSysClk)
begin
    if (iRst)                   rSoundAddr <= 0;
    else if (iSoundSectorCke)   rSoundAddr <= rSoundAddr + lpPageUp;
    else                        rSoundAddr <= rSoundAddr;
end


//----------------------------------------------------------
// CH0
//----------------------------------------------------------
wire [15:0] wFifoRdCh0;                     assign oSgbSoundCh0 = wFifoRdCh0;
wire wFifoRvdCh0;                           assign oSgbWdVdCh0  = wFifoRvdCh0;

seLoadBram #(
    .pBuffDepth     (4096),
    .pWriteWidth    (8),
    .pBitConvert    ("on"),
    .pReadWidth     (16)
) SE_CH0 (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iWd            (rSelWdCh0),
    .iWe            (rSelWdVdCh0),
    .iChRdy         (iSgbChannelRdy[0]),
    .oRd            (wFifoRdCh0),
    .oRvd           (wFifoRvdCh0)
);
//----------------------------------------------------------
// CH1
//----------------------------------------------------------
wire [15:0] wFifoRdCh1;                     assign oSgbSoundCh1 = wFifoRdCh1;
wire wFifoRvdCh1;                           assign oSgbWdVdCh1  = wFifoRvdCh1;

seLoadBram #(
    .pBuffDepth     (4096),
    .pWriteWidth    (8),
    .pBitConvert    ("on"),
    .pReadWidth     (16)
) SE_Ch1 (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iWd            (rSelWdCh1),
    .iWe            (rSelWdVdCh1),
    .iChRdy         (iSgbChannelRdy[1]),
    .oRd            (wFifoRdCh1),
    .oRvd           (wFifoRvdCh1)
);
//----------------------------------------------------------
// CH2
//----------------------------------------------------------
wire [15:0] wFifoRdCh2;                     assign oSgbSoundCh2 = wFifoRdCh2;
wire wFifoRvdCh2;                           assign oSgbWdVdCh2  = wFifoRvdCh2;

seLoadBram #(
    .pBuffDepth     (4096),
    .pWriteWidth    (8),
    .pBitConvert    ("on"),
    .pReadWidth     (16)
) SE_Ch2 (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iWd            (rSelWdCh2),
    .iWe            (rSelWdVdCh2),
    .iChRdy         (iSgbChannelRdy[2]),
    .oRd            (wFifoRdCh2),
    .oRvd           (wFifoRvdCh2)
);
//----------------------------------------------------------
// CH3
//----------------------------------------------------------
wire [15:0] wFifoRdCh3;                     assign oSgbSoundCh3 = wFifoRdCh3;
wire wFifoRvdCh3;                           assign oSgbWdVdCh3  = wFifoRvdCh3;

seLoadBram #(
    .pBuffDepth     (4096),
    .pWriteWidth    (8),
    .pBitConvert    ("on"),
    .pReadWidth     (16)
) SE_Ch3 (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iWd            (rSelWdCh3),
    .iWe            (rSelWdVdCh3),
    .iChRdy         (iSgbChannelRdy[3]),
    .oRd            (wFifoRdCh3),
    .oRvd           (wFifoRvdCh3)
);
//----------------------------------------------------------
// CH4
//----------------------------------------------------------
wire [15:0] wFifoRdCh4;                     assign oSgbSoundCh4 = wFifoRdCh4;
wire wFifoRvdCh4;                           assign oSgbWdVdCh4  = wFifoRvdCh4;

seLoadBram #(
    .pBuffDepth     (4096),
    .pWriteWidth    (8),
    .pBitConvert    ("on"),
    .pReadWidth     (16)
) SE_Ch4 (
    .iSysClk        (iSysClk),
    .iRst           (iRst),
    .iWd            (rSelWdCh4),
    .iWe            (rSelWdVdCh4),
    .iChRdy         (iSgbChannelRdy[4]),
    .oRd            (wFifoRdCh4),
    .oRvd           (wFifoRvdCh4)
);

endmodule