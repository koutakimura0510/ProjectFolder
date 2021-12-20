/*
 * Create 2021/12/17
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * 評価基板付属のOLED SSD1306コントロールモジュール
 */
module oledTop
#(
    parameter PDIVCLK       = 100000,
    parameter PDIVSCK       = 250,
    parameter DISPLAY_WIDTH = 128,
    parameter DISPLAY_PAGE  = 4
)(
    // system clk, rst sw
    input           iCLK,
    input           iRST,

    // system oled port
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd,

    // oled enable
    output [1:0]    oSetEnable
);



//----------------------------------------------------------
// アドレス参照制御信号
//----------------------------------------------------------
// 初期化配列と書き込み配列の最大値
localparam INIT_CMDMAX  = 17;
localparam WRITE_CMDMAX = 9;

wire [4:0] init_addr;   // 初期化配列参照
wire [7:0] init_data;   // 初期化送信データ
wire [3:0] cmd_addr;    // コマンド配列参照
wire [7:0] cmd_data;    // コマンド送信データ
wire init_enable;       // 初期化完了時High
wire cmd_enable;        // コマンド送信時High
wire draw_start;        // ディスプレイ描画開始

//----------------------------------------------------------
// spi通信制御信号
//----------------------------------------------------------
wire spi_start;         // spi通信の開始時High
wire spi_ok;            // 1byteデータ送信時High
wire addr_ok;           // 初期化・コマンドrom参照のrp更新信号
wire [7:0] senddata;    // 送信1byteデータ


//----------------------------------------------------------
// oled制御用時間管理信号
//----------------------------------------------------------
wire wait_ok;           // 指定時間経過時High


//----------------------------------------------------------
// 動作確認用にLEDに接続
//----------------------------------------------------------
assign oSetEnable[0] = init_enable;
assign oSetEnable[1] = cmd_enable;


//----------------------------------------------------------
// oled制御コマンド発行制御
//----------------------------------------------------------
oledRp #(
    .INIT_CMDMAX(INIT_CMDMAX),
    .WRITE_CMDMAX(WRITE_CMDMAX)
) OLED_RP (
    .iCLK(iCLK),
    .iRST(iRST),
    .iEnable(addr_ok),
    .iDrawStart(draw_start),
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
// OLEDの制御に必要な遅延時間の生成
//----------------------------------------------------------
oledTime #(
    .PDIVCLK(PDIVCLK)
) OLED_TIME (
    .iCLK(iCLK),
    .iRST(iRST),
    .oEnable(wait_ok)
);


//----------------------------------------------------------
// OLEDの送信データコントロール
//----------------------------------------------------------
oledState #(
    .DISPLAY_WIDTH(DISPLAY_WIDTH),
    .DISPLAY_PAGE(DISPLAY_PAGE)
) OLED_STATE (
    .iCLK(iCLK),
    .iRST(iRST),
    .iInitEnable(init_enable),
    .iCmdEnable(cmd_enable),
    .iSpiValid(spi_ok),
    .iWaitEnable(wait_ok),
    .iInitData(init_data),
    .iCmdData(cmd_data),
    .iDispData(8'hff),
    .oSendData(senddata),
    .oDrawEnable(draw_start),
    .oSpiStart(spi_start),
    .oOledRes(oOledRes),
    .oOledVbat(oOledVbat),
    .oOledVdd(oOledVdd)
);


//----------------------------------------------------------
// SPIデータ送信
//----------------------------------------------------------
spiCtrl #(
    .PDIVSCK(PDIVSCK)
) SPI_CTRL (
    .iCLK(iCLK),
    .iRST(iRST),
    .iEnable(spi_start),
    .iDrawStart(draw_start),
    .iSendByte(senddata),
    .oAddrValid(addr_ok),
    .oSpiValid(spi_ok),
    .oOledScl(oOledScl),
    .oOledSda(oOledSda),
    .oOledDC(oOledDC)
);


endmodule