/*
 * Create 2021/12/18
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * oledの起動シーケンス制御
 */
module oledState
(
    input 			iCLK,		    // System Clock
    input 			iRST,		    // System Reset

    // 状態制御信号
    input           iSpiValid,      // 1byteデータ送信時High
    input           iWaitEnable,    // 遅延Enable信号

    // data
    input [7:0]     iInitData,      // 初期化データ

    // ディスプレイ描画時High　コマンド送信時Low
    output          oSpiStart,      // spi送信開始時High

    // oled初期時制御信号
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd
);


//----------------------------------------------------------
// 制御データ送信
//----------------------------------------------------------
reg spi_start  = 0;     assign oSpiStart    = spi_start;
reg oled_res   = 1;     assign oOledRes     = oled_res;
reg oled_vbat  = 1;     assign oOledVbat    = oled_vbat;
reg oled_vdd   = 1;     assign oOledVdd     = oled_vdd;


//----------------------------------------------------------
// 制御信号ステートマシン
//----------------------------------------------------------
localparam
    VDD_ON      = 0,
    DISP_OFF    = 1,
    RES_ON      = 2,
    RES_OFF     = 3,
    VBAT_SEND   = 4,
    VBAT_ON     = 5,
    DISP_ON     = 6;

reg [2:0] oled_state = VDD_ON;


//----------------------------------------------------------
// D/C portのHighLow切り替え時間計測
//----------------------------------------------------------
reg [8:0] wait_time;


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
                    spi_start  <= 1'b1;
                    oled_state <= DISP_OFF;
                end else begin
                    oled_state <= VDD_ON;
                end
            end

            DISP_OFF: begin
                if (iSpiValid == 1'b1) begin
                    spi_start  <= 1'b0;
                    oled_state <= RES_ON;
                end else begin
                    oled_state <= DISP_OFF;
                end
            end

            RES_ON: begin
                oled_res   <= 1'b0;
                if (iWaitEnable == 1'b1) begin
                    oled_state <= RES_OFF;
                end else begin
                    oled_state <= RES_ON;
                end
            end

            RES_OFF: begin
                oled_res <= 1'b1;
                if (iWaitEnable == 1'b1) begin
                    spi_start  <= 1'b1;
                    oled_state <= VBAT_SEND;
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
                        wait_time  <= 0;
                        oled_state <= DISP_ON;
                    end else begin
                        wait_time  <= wait_time + 1'b1;
                        oled_state <= VBAT_ON;
                    end
                end
            end

            DISP_ON:  begin
                spi_start <= 1'b1;
            end

            default:  begin
                oled_state <= VDD_ON;
            end
        endcase
    end
end

endmodule