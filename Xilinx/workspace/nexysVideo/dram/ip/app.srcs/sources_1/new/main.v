/*
 * Create 2021/12/30
 * Author koutakimura
 * Editor VSCode ver1.62.7
 * Build  Vivado20.2
 * Borad  Nexys Video
 * -
 * MIG IP動作確認プロジェクト Topモジュール
 */
module main(
    input           iCLK,
    input           iRST,
    
    // user btn
    input           iBtnU,
    input           iBtnD,

    // ddr3 port
    inout  [15:0]   ddr3_dq,
    inout  [ 1:0]   ddr3_dqs_n,
    inout  [ 1:0]   ddr3_dqs_p,
    output [14:0]   ddr3_addr,
    output [ 2:0]   ddr3_ba,
    output          ddr3_ras_n,
    output          ddr3_cas_n,
    output          ddr3_we_n,
    output          ddr3_reset_n,
    output [0:0]    ddr3_ck_p,
    output [0:0]    ddr3_ck_n,
    output [0:0]    ddr3_cke,
    output [1:0]    ddr3_dm,
    output [0:0]    ddr3_odt,

    // system oled
    output          oOledScl,
    output          oOledSda,
    output          oOledDC,
    output          oOledRes,
    output          oOledVbat,
    output          oOledVdd,

    // user led
    output [ 7:0]   oLED
);

wire [127:0] oRdData;
wire oRdDataValid;
wire oReady;
wire oWdReady;
wire oInitCalibComplete;
wire oUiCLK;
wire oUiRST;

reg [3:0] state;
reg wenable = 0;
reg renable = 0;
reg [15:0] rd [7:0];
reg [3:0] rp;

assign rst  = ~iRST;
assign oLED = {rp, oReady, oWdReady, oRdDataValid, oInitCalibComplete} & 8'hff;
assign iWEnable = wenable;
assign iREnable = renable;

reg [26:0] tmp_count;
assign enable = (tmp_count == (100000000 - 1)) ? 1'b1 : 1'b0;
// assign enable = (tmp_count == (100 - 1)) ? 1'b1 : 1'b0;



//System CLKの周期でカウント
always @(posedge oUiCLK) begin
    if (oUiRST == 1'b1) begin
        tmp_count <= 27'd0;
    end else if (enable == 1'b1) begin
        tmp_count <= 27'd0;
    end else begin
        tmp_count <= tmp_count + 27'd1;
    end
end

always @(posedge oUiCLK) begin
    if (oUiRST == 1'b1) begin
        state   <= 0;
        wenable <= 0;
        renable <= 0;
        rp      <= 0;
        rd[0]   <= 16'h0000;
        rd[1]   <= 16'h0001;
        rd[2]   <= 16'h0002;
        rd[3]   <= 16'h0003;
        rd[4]   <= 16'h0004;
        rd[5]   <= 16'h0005;
        rd[6]   <= 16'h0006;
        rd[7]   <= 16'h0007;
    end else begin
        case (state)
            0: begin
                if (oInitCalibComplete == 1'b1 && enable == 1'b1) begin
                    state   <= 1;
                end
            end

            1: begin
                if (oReady == 1'b1 && oWdReady == 1'b1) begin
                    state   <= 2;
                    wenable <= 1;
                end
            end

            2: begin
                if (oReady == 1'b1 && oWdReady == 1'b1) begin
                    state   <= 3;
                    wenable <= 0;
                end
            end

            3: begin
                if (oReady == 1'b1 && oWdReady == 1'b1) begin
                    state <= 4;
                    renable <= 1'b1;
                end
            end

            4: begin
                if (oRdDataValid == 1'b1) begin
                    rd[0] <= oRdData[15:0];
                    rd[1] <= oRdData[31:16];
                    rd[2] <= oRdData[47:32];
                    rd[3] <= oRdData[63:48];
                    rd[4] <= oRdData[79:64];
                    rd[5] <= oRdData[95:80];
                    rd[6] <= oRdData[111:96];
                    rd[7] <= oRdData[127:112];
                    state <= 5;
                end
                renable <= 0;
            end

            5: begin
                if (oRdDataValid == 1'b0) begin
                    state <= 6;
                end
            end

            6: begin
                if (enable == 1'b1) begin
                    if (rp == 7) begin
                        rp <= 0;
                    end else begin
                        rp <= rp + 1'b1;
                    end
                end
            end

            default: begin
                state <= 1;
            end
        endcase
    end
end


//----------------------------------------------------------
// DDR3 TOP Module
//----------------------------------------------------------
localparam BANK = 3'b000;
localparam ROW  = 15'b000000011000000;
localparam COL  = 10'b0000000000;

ddr3Controller #(
    .ADDR_WIDTH(29),
    .DATA_WIDTH(128),
    .MASK_WIDTH(16)
) DDR3_CONTROLLER (
    .iCLK               (iCLK),
    .iRST               (rst),
    .ioDDR3_DQ          (ddr3_dq),
    .ioDDR3_DQS_N       (ddr3_dqs_n),
    .ioDDR3_DQS_P       (ddr3_dqs_p),
    .oDDR3_ADDR         (ddr3_addr),
    .oDDR3_BA           (ddr3_ba),
    .oDDR3_RAS          (ddr3_ras_n),
    .oDDR3_CAS          (ddr3_cas_n),
    .oDDR3_WE           (ddr3_we_n),
    .oDDR3_RESET        (ddr3_reset_n),
    .oDDR3_CLK_P        (ddr3_ck_p),
    .oDDR3_CLK_N        (ddr3_ck_n),
    .oDDR3_CKE          (ddr3_cke),
    .oDDR3_DM           (ddr3_dm),
    .oDDR3_ODT          (ddr3_odt),
    .iWEnable           (iWEnable),
    .iREnable           (iREnable),
    .iWdData            (128'h00112233445566778899aabbccddeeff),
    .iAddr              ({1'b0, BANK, ROW, COL}),
    .iMask              (16'h0000),
    .oRdData            (oRdData),
    .oRdDataValid       (oRdDataValid),
    .oReady             (oReady),
    .oWdReady           (oWdReady),
    .oInitCalibComplete (oInitCalibComplete),
    .oUiCLK             (oUiCLK),
    .oUiRST             (oUiRST)
);


// 書き込みに必要なステータス
// アドレス
// データ
// データ長（書き込み・読み込みバイト数）



//----------------------------------------------------------
// DDRメモリのデータをOLEDに表示
//----------------------------------------------------------
oledTop #(
    .PDIVCLK(100000),
    .PDIVSCK(125),
    .DISPLAY_WIDTH(128),
    .DISPLAY_HEIGHT(4)
) OLED_TOP (
    .iCLK           (oUiCLK),
    .iRST           (rst),
    .oOledScl       (oOledScl),
    .oOledSda       (oOledSda),
    .oOledDC        (oOledDC),
    .oOledRes       (oOledRes),
    .oOledVbat      (oOledVbat),
    .oOledVdd       (oOledVdd),
    .iDispData      ({rd[7], rd[6], rd[5], rd[4], rd[3], rd[2], rd[1], rd[0], oRdData})
    // .iDispData      ({rd[7], rd[6], rd[5], rd[4], rd[3], rd[2], rd[1], rd[0], " 2021 - 12 - 22 "})
);

endmodule