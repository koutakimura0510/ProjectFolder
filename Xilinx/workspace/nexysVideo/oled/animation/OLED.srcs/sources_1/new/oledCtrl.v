/*
 * Create 2021/12/17
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * 評価基板付属のOLED SSD1306コントロールモジュール
 */
module oledCtrl #(
    parameter PDIVCLK = 100000
)(
    // system clk, rst sw
    input           iCLK,
    input           iRST,

    // system oled
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);

reg oled_dc;                assign oOledDC      = oled_dc;
reg oled_res;               assign oOledRes     = oled_res;
reg oled_vbat;              assign oOledVbat    = oled_vbat;
reg oled_vdd;               assign oOledVdd     = oled_vdd;


// 初期化配列と書き込み配列の最大値
localparam INIT_CMDMAX  = 17;
localparam WRITE_CMDMAX = 9;

wire [4:0] init_addr, init_data;
wire [3:0] cmd_addr,  cmd_data;
wire init_enable, cmd_enable;

//----------------------------------------------------------
// oled制御コマンド発行制御
//----------------------------------------------------------
oledRp #(
    .INIT_CMDMAX(INIT_CMDMAX),
    .WRITE_CMDMAX(WRITE_CMDMAX)
) OLED_RP (
    .iCLK(iCLK),
    .iRST(iRST),
    .iEnable(spi_ok),
    .oAddrInit(init_addr),
    .oAddrCmd(cmd_addr),
    .oInitEnable(init_enable),
    .oCmdEnable(cmd_enable)
);

oledInit #(
    .ADDR_WIDTH(INIT_CMDMAX)
) OLED_INIT (
    .iCLK(iCLK),
    .iAddr(init_addr),
    .oData(init_data)
);

oledCmd #(
    .ADDR_WIDTH(WRITE_CMDMAX)
) OLED_CMD (
    .iCLK(iCLK),
    .iAddr(cmd_addr),
    .oData(cmd_data)
);


//----------------------------------------------------------
// Controller for spi conmection to oled
//----------------------------------------------------------
spiCtrl #(
    .SCK_SPEED(250)
) SPI_CTRL (
    .iCLK(iCLK),
    .iRST(iRST),
    .iEnable(spi_start),
    .iSendByte(sendbyte),
    .oSendValid(spi_ok),
    .oOledScl(oOledScl),
    .oOledSda(oOledSda)
);


//----------------------------------------------------------
// Controller Wait Time to oled
//----------------------------------------------------------
oledTime #(
    .PDIVCLK(PDIVCLK)
) OLED_TIME (
    .iCLK(iCLK),
    .iRST(iRST),
    .oEnable(wait_ok)
);

// 送信データの制御
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        sendbyte <= oled_init_rom[init_cmd_rp];
    end else if (init_cmd_rp != INIT_CMDMAX) begin
        sendbyte <= oled_init_rom[init_cmd_rp];
    end else begin
        sendbyte <= oled_cmd_rom[write_cmd_rp];
    end
end

endmodule