//----------------------------------------------------------
// Create 2021/02/05
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// FIFOコントロールモジュール
// このモジュールを使用する上位モジュールとのやりとりを簡易的なものにする目的がある
//----------------------------------------------------------
module fifoController #(
    parameter BUFF_SIZE   = 256,    // FIFO BRAMのサイズ指定
    parameter BIT_WIDTH   = 32      // bitサイズ
)(
    input                       iCLK,
    input                       iRST,
    input   [BIT_WIDTH-1:0]     iWD,    // write data
    input                       iWE,    // write enable
    output                      oFLL,   // 最大書き込み時High
    output  [BIT_WIDTH-1:0]     oRD,    // read data
    output                      oRVD,   // 有効データ出力
    output                      oEMP    // バッファ空時High
);

// buffer sizeによってアドレスレジスタのサイズを自動変換するため、
// bit幅を取得し指定する
localparam ADDR_LENGTH = fBitWidth(BUFF_SIZE);
localparam ADDR_MASK   = BUFF_SIZE - 1;

reg [ADDR_LENGTH-1:0] waddr;
reg [ADDR_LENGTH-1:0] raddr;

always @(posedge iCLK)
begin
    if (iRST) waddr <= 0;
    else if (ADDR_MASK == waddr) waddr <= waddr + 1'b1;
end

userFifo #(
    .BUFF_SIZE      (BUFF_SIZE),
    .BIT_WIDTH      (BIT_WIDTH),
    .ADDR_LENGTH    (ADDR_LENGTH)
) USER_FIFO (
    // write side       read side
    .iCLK   (iCLK),
    .iWD    (iWD),      .oRD    (oRD),
    .iWA    (waddr),    .iRA    (raddr),
    .iWE    (iWE)
);

// msb側の1を検出しbit幅を取得する
function[  7:0]	fBitWidth;
    input [31:0] iVAL;
    integer			i;

    begin
    fBitWidth = 1;
    for (i = 0; i < 32; i = i+1 )
        if (iVAL[i]) begin
            fBitWidth = i+1;
        end
    end
endfunction

endmodule