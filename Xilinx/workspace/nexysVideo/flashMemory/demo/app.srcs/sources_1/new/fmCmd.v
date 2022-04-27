//----------------------------------------------------------
// Create  2022/4/25
// Author  koutakimura
// -
// SPI Rom データ発行
// 
//----------------------------------------------------------
module flashCmd (
    input           iClk,           // system clk
    input           iRst,           // system rst
    input           iCke,           // 0. disconnect 1. active
    input           iCmd,           // 1. Read / 0. Write
    input  [7:0]    iWd,            // 書き込みデータ
    output [7:0]    oRd,            // 読み込みデータ
    output          iWdVd,          // 1byte 書き込み完了時 High
    output          oRdVd           // 読み込みデータ出力時High
);


//---------------------------------------------------------
// Winbond W25N01GV　レジスタマップ
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
    CMD_READ  = 8'h03,      // Read
    CMD_WRDI  = 8'h04,      // Write Disable
    CMD_WREN  = 8'h06,      // Write Enable
    CMD_BE    = 8'hD8,      // Parameter Block Erase
    CMD_PD    = 8'h02,      // Program Data
    CMD_PE    = 8'h10,      // Program Execute
    CMD_RDSR1 = 8'h05,      // Read Status cmd
    ADDR_SR_0 = 8'h00,      // Protection Reg-0
    ADDR_SR_1 = 8'h01,      // Status Reg-1
    ADDR_SR_2 = 8'h02,      // Configration Reg-2
    ADDR_SR_3 = 8'h03;      // Status Reg-3 1bit wel (write enable latch) / 0bit busy

reg [7:0] r;

always @(posedge iSysClk)
begin
    if (iRst) begin
        Q <= D;
    end else begin
        Q <= D;
    end
end

endmodule