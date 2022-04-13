/*
 * Create 2021/12/17
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * OLED Debug Block
 * 評価基板付属のOLED SSD1306コントロールモジュール
 */
module odbWrapper
#(
    parameter PDIVCLK        = 100000,  // 1msのEnable信号生成分周クロック値
    parameter PDIVSCK        = 250,     // SPI信号の分周クロック値
    parameter DISPLAY_WIDTH  = 128,     // oledの横幅
    parameter DISPLAY_HEIGHT = 4,       // oledのページ数
    parameter BIT_LENGTH     = 95       // Line表示データのbit数
)(
    // system clk, rst sw
    input                   iCLK,
    input                   iRST,
    output                  oOledScl,
    output                  oOledSda,
    output                  oOledDC,
    output                  oOledRes,
    output                  oOledVbat,
    output                  oOledVdd,
    input [BIT_LENGTH:0]    iDispLine1,
    input [BIT_LENGTH:0]    iDispLine2,
    input [BIT_LENGTH:0]    iDispLine3,
    input [BIT_LENGTH:0]    iDispLine4
);


//----------------------------------------------------------
// アドレス参照制御信号
//----------------------------------------------------------
// 初期化配列と書き込み配列の最大値
localparam INIT_CMDMAX  = 17;
localparam WRITE_CMDMAX = 9;

wire [4:0] init_addr;   // 初期化配列参照
wire [3:0] cmd_addr;    // コマンド配列参照
wire [7:0] init_data;   // 初期化送信データ
wire [7:0] cmd_data;    // コマンド送信データ
wire init_enable;       // 初期化完了時High
wire cmd_enable;        // コマンド送信時High


//----------------------------------------------------------
// 描画データ
//----------------------------------------------------------
wire [7:0] disp_data;


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
// oled制御コマンド発行制御
//----------------------------------------------------------
oledRp #(
    .INIT_CMDMAX(INIT_CMDMAX),
    .WRITE_CMDMAX(WRITE_CMDMAX)
) OLED_RP (
    .iCLK(iCLK),
    .iRST(iRST),
    .iEnable(addr_ok),
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
    .ADDR_WIDTH(WRITE_CMDMAX),
    .PAGE(3)
) OLED_CMD (
    .iCLK(iCLK),
    .iAddr(cmd_addr),
    .oData(cmd_data)
);

oledDisp #(
    .DISPLAY_WIDTH  (DISPLAY_WIDTH),
    .DISPLAY_HEIGHT (DISPLAY_HEIGHT),
    .BIT_LENGTH     (BIT_LENGTH)
) OLED_DISP (
    .iCLK           (iCLK),
    .iRST           (iRST),
    .iSpiValid      (spi_ok),
    .iInitEnable    (init_enable),
    .iCmdEnable     (cmd_enable),
    .iDispLine1     (iDispLine1),
    .iDispLine2     (iDispLine2),
    .iDispLine3     (iDispLine3),
    .iDispLine4     (iDispLine4),
    .oData          (disp_data)
);


//----------------------------------------------------------
// OLEDの起動シーケンスに必要な遅延時間の生成
//----------------------------------------------------------
oledTime #(
    .PDIVCLK(PDIVCLK)
) OLED_TIME (
    .iCLK(iCLK),
    .iRST(iRST),
    .oEnable(wait_ok)
);


//----------------------------------------------------------
// OLEDの起動シーケンス制御
//----------------------------------------------------------
oledState OLED_STATE
(
    .iCLK(iCLK),
    .iRST(iRST),
    .iSpiValid(spi_ok),
    .iWaitEnable(wait_ok),
    .iInitData(init_data),
    .oSpiStart(spi_start),
    .oOledRes(oOledRes),
    .oOledVbat(oOledVbat),
    .oOledVdd(oOledVdd)
);


//----------------------------------------------------------
// OLEDの送信データコントロール
//----------------------------------------------------------
oledSend OLED_SEND
(
    .iCLK(iCLK),
    .iRST(iRST),
    .iInitEnable(init_enable),
    .iCmdEnable(cmd_enable),
    .iInitData(init_data),
    .iCmdData(cmd_data),
    .iDispData(disp_data),
    .oSendData(senddata)
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
    .iDrawStart(cmd_enable),
    .iSendByte(senddata),
    .oAddrValid(addr_ok),
    .oSpiValid(spi_ok),
    .oOledScl(oOledScl),
    .oOledSda(oOledSda),
    .oOledDC(oOledDC)
);


endmodule