module TFT_INIT (
    input CLK, RESET,
    input ENABLE_10ms,
	 output [7:0] TFT_BYTE,
    output reg WRX, RD, DCX,
    output DRAW_ON,
    output [9:0] LEDR
);

/**------------------------------------------
 * TFTLCD
 *------------------------------------------*/
parameter TFT_DISPLAY_WIDTH  = 240;		// 最大横幅
parameter TFT_DISPLAY_HEIGHT = 320;		// 最大縦幅


/**------------------------------------------
 * インターフェース設定
 *------------------------------------------*/
parameter SYSTEM_INTERFACE  = 8'h00;
parameter RGB_INTERFACE     = 8'h06;
parameter RGB_16bit_MODE    = 8'h55;
parameter RGB_18bit_MODE    = 8'h66;
parameter RGB_SELECT        = 8'h40;
parameter INIT_SIZE = 71;

parameter DRAW_MODE_INIT    = RGB_INTERFACE;
parameter DRAW_BIT_INIT     = RGB_18bit_MODE;
parameter DRAW_SELECT       = RGB_SELECT;

/**------------------------------------------
 * コマンド・データID
 *------------------------------------------*/
parameter TFT_CMD_BYTE	            = 0;
parameter TFT_DATA_BYTE	            = 1;

/**------------------------------------------
 * レジスタ名 データシートの並び順で定義
 *------------------------------------------*/
parameter SOFTWARE_RESET            = 8'h01;
parameter READ_DISPLAY_IDEN         = 8'h04;
parameter READ_DISPLAY_STATUS       = 8'h09;
parameter READ_DISPLAY_POWER        = 8'h0a;
parameter READ_DISPLAY_MADCTL       = 8'h0b;
parameter READ_DISPLAY_PIXEL_FORMAT = 8'h0c;
parameter READ_DISPLAY_IMAGE        = 8'h0d;
parameter READ_DISPLAY_SIGNAL       = 8'h0e;
parameter READ_DISPLAY_SELF         = 8'h0f;
parameter ENTER_SLEEP_MODE          = 8'h10;
parameter SLEEP_MODE                = 8'h11;
parameter PARTIAL_MODE_ON           = 8'h12;
parameter DISPLAY_MODE_ON           = 8'h13;
parameter DISPLAY_INVER_OFF         = 8'h20;
parameter DISPLAY_INVER_ON          = 8'h21;
parameter GAMMA_SET                 = 8'h26;
parameter TFT_DISPLAY_OFF           = 8'h28;
parameter TFT_DISPLAY_ON            = 8'h29;
parameter COLUMN_ADDRESS_SET        = 8'h2A;
parameter PAGE_ADDRESS_SET          = 8'h2B;
parameter MEMORY_WRITE              = 8'h2C;
parameter COLOR_SET                 = 8'h2D;
parameter MEMORY_READ               = 8'h2E;
parameter PARTIAL_AREA              = 8'h30;
parameter SCROLLING_DEFINTION       = 8'h33;
parameter EFFECT_LINE_OFF           = 8'h34;
parameter EFFECT_LINE_ON            = 8'h35;
parameter MEMORY_ACCESS_CONTROL     = 8'h36;
parameter TFT_VERTICAL_SCROLL       = 8'h37;
parameter IDLE_MODE_OFF             = 8'h38;
parameter IDLE_MODE_ON              = 8'h39;
parameter PIXEL_FORMAT_SET          = 8'h3A;
parameter WRITE_MEMORY_CONTINUE     = 8'h3C;
parameter READ_MEMORY_CONTINUE      = 8'h3E;
parameter SET_TEAR_SCANLINE         = 8'h44;
parameter GET_SCANLINE              = 8'h45;
parameter WRITE_DISPLAY_BRIGHTNESS  = 8'h51;
parameter READ_DISPLAY_BRIGHTNESS   = 8'h52;
parameter WRITE_CTRL_DISPLAY        = 8'h53;
parameter READ_CTRL_DISPLAY         = 8'h54;
parameter WRITE_CONTENT_ADAPIVE     = 8'h55;
parameter READ_CONTENT_ADAPIVE      = 8'h56;
parameter READ_ID1                  = 8'hDA;
parameter READ_ID2                  = 8'hDB;
parameter READ_ID3                  = 8'hDC;
parameter RGB_INTERFACE_SINGLE_CON  = 8'hB0;
parameter FRAME_CONTROL_NORMAL      = 8'hB1;
parameter FRAME_CONTROL_IDLE        = 8'hB2;
parameter FRAME_CONTROL_PARTIAL	    = 8'hB3;
parameter DISPLAY_INVERSION_CONTROL	= 8'hB4;
parameter BLANKING_PORCH_CONTROL    = 8'hB5;
parameter DISPALY_FUNCTION_CONTROL  = 8'hB6;
parameter ENTRY_MODE_SET            = 8'hB7;
parameter BACKLIGHT_CONTROL_1		= 8'hB8;
parameter BACKLIGHT_CONTROL_2		= 8'hB9;
parameter BACKLIGHT_CONTROL_3		= 8'hBA;
parameter BACKLIGHT_CONTROL_4		= 8'hBB;
parameter BACKLIGHT_CONTROL_5		= 8'hBC;
parameter BACKLIGHT_CONTROL_7		= 8'hBE;
parameter BACKLIGHT_CONTROL_8		= 8'hBF;
parameter POWER_CONTROL_1			= 8'hC0;
parameter POWER_CONTROL_2			= 8'hC1;
parameter VCOM_CONTROL_1			= 8'hC5;
parameter VCOM_CONTROL_2			= 8'hC7;
parameter NV_MEMORY_WRITE			= 8'hD0;
parameter NV_MEMORY_KEY				= 8'hD1;
parameter NV_MEMORY_READ			= 8'hD2;
parameter READ_ID4					= 8'hD3;
parameter POSITIVE_GAMMA			= 8'hE0;
parameter NEGATIVE_GAMMA			= 8'hE1;
parameter DIGITAL_GAMMA_CONTROL_1	= 8'hE2;
parameter DIGITAL_GAMMA_CONTROL_2	= 8'hE3;
parameter INTERFACE_CONTROL			= 8'hF6;


/**------------------------------------------
 * reg・wire宣言
 *------------------------------------------*/
reg enable;
reg [1:0] state;
reg [6:0] cnt;
reg [8:0] tft_init[0:INIT_SIZE-1];


/**------------------------------------------
 * 初期化
 *------------------------------------------*/
initial begin
    tft_init[0] = {TFT_CMD_BYTE,  SOFTWARE_RESET};
    tft_init[1] = {TFT_CMD_BYTE,  TFT_DISPLAY_OFF};
    tft_init[2] = {TFT_CMD_BYTE,  PIXEL_FORMAT_SET};
    tft_init[3] = {TFT_DATA_BYTE, DRAW_BIT_INIT};
    tft_init[4] = {TFT_CMD_BYTE,  POWER_CONTROL_1};
    tft_init[5] = {TFT_DATA_BYTE, 8'h01};
    tft_init[6] = {TFT_CMD_BYTE,  POWER_CONTROL_2};
    tft_init[7] = {TFT_DATA_BYTE, 8'h00};
    tft_init[8] = {TFT_CMD_BYTE,  VCOM_CONTROL_1};
    tft_init[9] = {TFT_DATA_BYTE, 8'h3e};
    tft_init[10] = {TFT_DATA_BYTE, 8'h28};
    tft_init[11] = {TFT_CMD_BYTE,  VCOM_CONTROL_2};
    tft_init[12] = {TFT_DATA_BYTE, 8'h86};
    tft_init[13] = {TFT_CMD_BYTE,  MEMORY_ACCESS_CONTROL};
    tft_init[14] = {TFT_DATA_BYTE, 8'h14};
    tft_init[15] = {TFT_CMD_BYTE,  FRAME_CONTROL_NORMAL};
    tft_init[16] = {TFT_DATA_BYTE, 8'h00};
    tft_init[17] = {TFT_DATA_BYTE, 8'h1f};
    tft_init[18] = {TFT_CMD_BYTE,  DISPALY_FUNCTION_CONTROL};
    tft_init[19] = {TFT_DATA_BYTE, 8'h0a};
    tft_init[20] = {TFT_DATA_BYTE, 8'ha2};
    tft_init[21] = {TFT_DATA_BYTE, 8'h27};
    tft_init[22] = {TFT_DATA_BYTE, 8'h04};
    tft_init[23] = {TFT_CMD_BYTE,  GAMMA_SET};
    tft_init[24] = {TFT_DATA_BYTE, 8'h01};
    tft_init[25] = {TFT_CMD_BYTE,  POSITIVE_GAMMA};
    tft_init[26] = {TFT_DATA_BYTE, 8'h0f};
    tft_init[27] = {TFT_DATA_BYTE, 8'h31};
    tft_init[28] = {TFT_DATA_BYTE, 8'h2b};
    tft_init[29] = {TFT_DATA_BYTE, 8'h0c};
    tft_init[30] = {TFT_DATA_BYTE, 8'h0e};
    tft_init[31] = {TFT_DATA_BYTE, 8'h10};
    tft_init[32] = {TFT_DATA_BYTE, 8'h03};
    tft_init[33] = {TFT_DATA_BYTE, 8'h0e};
    tft_init[34] = {TFT_DATA_BYTE, 8'h09};
    tft_init[35] = {TFT_DATA_BYTE, 8'h00};
    tft_init[36] = {TFT_CMD_BYTE,  NEGATIVE_GAMMA};
    tft_init[37] = {TFT_DATA_BYTE, 8'h00};
    tft_init[38] = {TFT_DATA_BYTE, 8'h0e};
    tft_init[39] = {TFT_DATA_BYTE, 8'h14};
    tft_init[40] = {TFT_DATA_BYTE, 8'h03};
    tft_init[41] = {TFT_DATA_BYTE, 8'h11};
    tft_init[42] = {TFT_DATA_BYTE, 8'h0f};
    tft_init[43] = {TFT_DATA_BYTE, 8'h0c};
    tft_init[44] = {TFT_DATA_BYTE, 8'h31};
    tft_init[45] = {TFT_DATA_BYTE, 8'h36};
    tft_init[46] = {TFT_DATA_BYTE, 8'h0f};
    tft_init[47] = {TFT_CMD_BYTE,  INTERFACE_CONTROL};
    tft_init[48] = {TFT_DATA_BYTE, 8'h01};
    tft_init[49] = {TFT_DATA_BYTE, 8'h10};
    tft_init[50] = {TFT_DATA_BYTE, DRAW_MODE_INIT};
    tft_init[51] = {TFT_CMD_BYTE,  RGB_INTERFACE_SINGLE_CON};
    tft_init[52] = {TFT_DATA_BYTE, DRAW_SELECT};
    tft_init[53] = {TFT_CMD_BYTE,  BLANKING_PORCH_CONTROL};
    tft_init[54] = {TFT_DATA_BYTE, 8'h04};  //VFP
    tft_init[55] = {TFT_DATA_BYTE, 8'h02};  //VBP
    tft_init[56] = {TFT_DATA_BYTE, 8'h10};  //HFP
    tft_init[57] = {TFT_DATA_BYTE, 8'h18};  //HBP
    tft_init[58] = {TFT_CMD_BYTE,  COLUMN_ADDRESS_SET};
    tft_init[59] = {TFT_DATA_BYTE, 8'h00};
    tft_init[60] = {TFT_DATA_BYTE, 8'h00};
    tft_init[61] = {TFT_DATA_BYTE, 8'h00};
    tft_init[62] = {TFT_DATA_BYTE, TFT_DISPLAY_WIDTH};
    tft_init[63] = {TFT_CMD_BYTE,  PAGE_ADDRESS_SET};
    tft_init[64] = {TFT_DATA_BYTE, 8'h00};
    tft_init[65] = {TFT_DATA_BYTE, 8'h00};
    tft_init[66] = {TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT >> 8};
    tft_init[67] = {TFT_DATA_BYTE, TFT_DISPLAY_HEIGHT & 8'hff};
    //tft_init[68] = {TFT_CMD_BYTE, DISPLAY_INVER_ON};
    tft_init[INIT_SIZE - 3] = {TFT_CMD_BYTE,  SLEEP_MODE};
    tft_init[INIT_SIZE - 2] = {TFT_CMD_BYTE,  TFT_DISPLAY_ON};
    tft_init[INIT_SIZE - 1] = {TFT_CMD_BYTE,  MEMORY_WRITE};
end


/**-------------------------------------------------
 * TFTモジュール初期設定
 * -------------------------------------------------*/
always @(posedge CLK or negedge RESET) begin
    if (RESET == 1'b0) begin
        WRX <= 1'b0;
        RD  <= 1'b0;
        DCX <= 1'b0;
        cnt <= 7'b0;
        enable <= 1'b0;
        state  <= 1'b0;
	end else if (INIT_SIZE == cnt) begin
        enable <= 1'b0;
		RD  <= 1'b0;
		DCX <= 1'b0;
        WRX <= 1'b0;
    end else if (tft_init[cnt][8] == 1'b0 && enable == 1'b0) begin    // コマンドバイト
		WRX <= 1'b1;  // WRX High
		RD  <= 1'b1;  // RD  High
		DCX <= 1'b0;  // DCX Low
        enable <= 1'b1;
	end else if (tft_init[cnt][8] == 1'b1 && enable == 1'b0) begin    //データバイト
		WRX <= 1'b1;  // WRX High
		RD  <= 1'b1;  // RD  High
		DCX <= 1'b1;  // DCX High
        enable <= 1'b1;
    end else if (enable == 1'b1 && INIT_SIZE != cnt) begin
        if (state == 2'b0) begin
            WRX <= 1'b0;
            state <= state + 2'b1;
        end else if (state == 2'b1) begin
            WRX <= 1'b1;
            state <= state + 2'b1;
        end else if (ENABLE_10ms == 1'b1) begin
            cnt <= cnt + 7'b1;
            enable <= 1'b0;
            state  <= 2'b0;
        end
    end
end

assign DRAW_ON  = (INIT_SIZE == cnt) ? 1'b1  : 1'b0;
assign TFT_BYTE = (INIT_SIZE == cnt) ? 8'h00 : tft_init[cnt][7:0];
assign LEDR = cnt;

endmodule