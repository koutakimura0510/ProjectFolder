/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの送信データ制御
 */
module oledState
#(
    parameter DISPLAY_WIDTH  = 128, // 横のドット数
    parameter DISPLAY_PAGE   = 4    // OLEDのページ数
)
(
    input 			iCLK,		    // System Clock
    input 			iRST,		    // System Reset

    // 状態制御信号
    input           iInitEnable,    // 初期化完了時High
    input           iCmdEnable,     // コマンド完了時High
    input           iSpiValid,      // 1byteデータ送信時High
    input           iWaitEnable,    // 遅延Enable信号

    // data
    input [7:0]     iInitData,      // 初期化データ
    input [7:0]     iCmdData,       // コマンドデータ
    input [7:0]     iDispData,      // 表示データ
    output [7:0]    oSendData,      // 送信データ

    // ディスプレイ描画時High　コマンド送信時Low
    output          oDrawEnable,
    output          oSpiStart,      // spi送信開始時High

    // oled制御信号
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);

// localparam WIDTH = (DISPLAY_WIDTH - 1);
localparam DISPLAY_SIZE = ((DISPLAY_WIDTH * DISPLAY_PAGE)  - 1);


//----------------------------------------------------------
// 制御データ送信
//----------------------------------------------------------
reg [7:0] senddata;     assign oSendData    = senddata;
reg spi_start  = 0;     assign oSpiStart    = spi_start;
reg draw_start = 0;     assign oDrawEnable  = draw_start;
reg oled_dc    = 0;     assign oOledDC      = oled_dc;
reg oled_res   = 1;     assign oOledRes     = oled_res;
reg oled_vbat  = 1;     assign oOledVbat    = oled_vbat;
reg oled_vdd   = 1;     assign oOledVdd     = oled_vdd;

//----------------------------------------------------------
// 制御信号ステートマシン
//----------------------------------------------------------
localparam [2:0]
    VDD_ON      = 0,
    DISP_OFF    = 1,
    RES_ON      = 2,
    RES_OFF     = 3,
    VBAT_SEND   = 4,
    VBAT_ON     = 5,
    DISP_ON     = 6;

reg [2:0] oled_state = VDD_ON;

//----------------------------------------------------------
// 送信データステートマシン
//----------------------------------------------------------
localparam [2:0]
    IDLE = 0,
    INIT = 1,
    CMD  = 2,
    WAIT = 3,
    DISP = 4;

reg [2:0] state = IDLE;


//----------------------------------------------------------
// 開始ページからの送信回数をカウント
//----------------------------------------------------------
reg [9:0] send_count;


//----------------------------------------------------------
// D/C portのHighLow切り替え時間計測
//----------------------------------------------------------
reg [8:0] wait_time;
reg [3:0] wait_count;


//----------------------------------------------------------
// 制御信号ステートマシン
//
// Turn VDD on (active low), delay 1ms
// Send DisplayOff command
// Turn RES on (active low), delay 1ms
// Turn RES off (active low), delay 1ms
// Send ChargePump Vcom command
// Turn VBAT on (active low), delay 100ms
// Send Display set command
// Send Display On command
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        oled_res <= 1'd1;
        oled_vbat<= 1'd1;
        oled_vdd <= 1'd1;
        spi_start <= 1'b0;
        oled_state <= VDD_ON;
        wait_time <= 0;
    end else begin
        case (oled_state)
            VDD_ON: begin
                oled_vdd   <= 1'b0;
                if (iWaitEnable == 1'b1) begin
                    oled_state <= DISP_OFF;
                    spi_start  <= 1'b1;
                end else begin
                    oled_state <= VDD_ON;
                end
            end

            DISP_OFF: begin
                if (iSpiValid == 1'b1) begin
                    oled_state <= RES_ON;
                    spi_start  <= 1'b0;
                end else begin
                    oled_state <= DISP_OFF;
                end
            end

            RES_ON: begin
                oled_res   <= 1'b0;
                oled_state <= (iWaitEnable == 1'b1) ? RES_OFF : RES_ON;
            end

            RES_OFF: begin
                oled_res <= 1'b1;
                if (iWaitEnable == 1'b1) begin
                    oled_state <= VBAT_SEND;
                    spi_start  <= 1'b1;
                end else begin
                    oled_state <= RES_OFF;
                end
            end

            VBAT_SEND: begin
                if (iSpiValid == 1'b1 && iInitData == 8'h81) begin
                    spi_start  <= 1'b0;
                    oled_state <= VBAT_ON;
                end else begin
                    oled_state <= VBAT_SEND;
                end
            end

            VBAT_ON: begin
                oled_vbat <= 1'b0;
                if (iWaitEnable == 1'b1) begin
                    if (wait_time == 9'd300) begin
                        spi_start  <= 1'b1;
                        oled_state <= DISP_ON;
                    end else begin
                        wait_time  <= wait_time + 1'b1;
                        oled_state <= VBAT_ON;
                    end
                end
            end

            DISP_ON:  begin
                spi_start  <= (state == WAIT && iSpiValid == 1'b1) ? 1'b0 : 1'b1;
            end

            default:  begin
                oled_state <= VDD_ON;
            end
        endcase
    end
end


//----------------------------------------------------------
// 送信データステートマシン
//----------------------------------------------------------
always @(posedge iCLK) begin
    if (iRST == 1'b1) begin
        state       <= IDLE;
        senddata    <= iInitData;
        send_count  <= 0;
        wait_count  <= 0;
        oled_dc     <= 0;
    end else begin
        case (state)
            IDLE: begin
                state    <= INIT;
                senddata <= iInitData;
                draw_start <= 1'b0;
            end

            INIT: begin
                state    <= (iInitEnable == 1'b1) ? CMD : INIT;
                senddata <= iInitData;
            end

            CMD: begin
                if (iCmdEnable == 1'b1) begin
                    state      <= WAIT;
                    senddata   <= iDispData;
                    draw_start <= 1'b1;
                end else begin
                    state      <= CMD;
                    senddata   <= iCmdData;
                    draw_start <= 1'b0;
                end
            end

            WAIT: begin
                if (wait_count == 4'd15) begin
                    if (draw_start == 1'b1) begin
                        state <= DISP;
                        oled_dc <= 1'b1;
                    end else begin
                        state <= CMD;
                        oled_dc <= 1'b0;
                    end
                    wait_count <= 0;
                end else begin
                    wait_count <= wait_count + 1'b1;
                end
            end

            DISP: begin
                if (DISPLAY_SIZE == send_count) begin
                    if (iSpiValid == 1'b1) begin
                        state      <= WAIT;
                        send_count <= 0;
                        draw_start <= 1'b0;
                    end
                    senddata   <= iCmdData;
                end else begin
                    if (iSpiValid == 1'b1) begin
                        send_count <= send_count + 10'd1;
                    end
                    senddata  <= iDispData;
                end
            end

            default: begin
                state    <= IDLE;
                senddata <= iInitData;
            end
        endcase
    end
end

endmodule