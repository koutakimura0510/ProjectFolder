//----------------------------------------------------------
// KEY Bit値
//----------------------------------------------------------
parameter SW_B     = 0; //0x04
parameter SW_DOWN  = 1; //0x02
parameter SW_UP    = 2; //0x01
parameter SW_LEFT  = 3; //0x20
parameter SW_RIGHT = 4; //0x10
parameter SW_A     = 5; //0x08

//----------------------------------------------------------
// 画面サイズ
//----------------------------------------------------------
parameter H_DISPLAY       = 640; // horizontal display width
parameter V_DISPLAY       = 480; // vertical display height
parameter H_CHIP_NUMBER   = (H_DISPLAY >> 5);   // 画面サイズに対して配置できるマップチップの個数
parameter V_CHIP_NUMBER   = (V_DISPLAY >> 5);    
parameter H_DISP_HALF     = (H_DISPLAY >> 1);   // アニメーション用に画面サイズの半分の値を指定
parameter V_DISP_HALF     = (V_DISPLAY >> 1);


parameter H_BACK          =  48; // horizontal left border (back porch)
parameter H_FRONT         =  16; // horizontal right border (front porch)
parameter H_SYNC          =  96; // horizontal sync width
parameter V_TOP           =  31; // vertical top border
parameter V_BOTTOM        =  11; // vertical bottom border
parameter V_SYNC          =   2; // vertical sync # lines
parameter H_SYNC_START    = H_DISPLAY + H_FRONT;
parameter H_SYNC_END      = H_DISPLAY + H_FRONT + H_SYNC - 1;
parameter H_MAX           = H_DISPLAY + H_BACK + H_FRONT + H_SYNC - 1;
parameter V_SYNC_START    = V_DISPLAY + V_BOTTOM;
parameter V_SYNC_END      = V_DISPLAY + V_BOTTOM + V_SYNC - 1;
parameter V_MAX           = V_DISPLAY + V_TOP + V_BOTTOM + V_SYNC - 1;


//----------------------------------------------------------
// 描画ドット参照
// マップチップの大きさが1マス32x32
//----------------------------------------------------------
parameter MAPCHIP_MAX_WIDTH = 6'd32;       // 1チップ最大横幅
parameter MAPCHIP_MAX_SIZE  = 11'd1024;    // 1チップの容量 32 x 32
parameter MAPCHIP_MASK      = (MAPCHIP_MAX_WIDTH-1);
parameter MAPCHIP_ADDR      = MAPCHIP_MAX_WIDTH - 1;

//----------------------------------------------------------
// キャラクターのサイズと移動可能量
//----------------------------------------------------------
parameter MAPCHIP_USER_WIDTH  = 32;
parameter MAPCHIP_USER_HEIGHT = 32;
parameter USER_WIDTH_END      = (H_DISPLAY - MAPCHIP_USER_WIDTH);
parameter USER_HEIGHT_END     = (V_DISPLAY - MAPCHIP_USER_HEIGHT);
parameter USER_X_DIRECT       = (MAPCHIP_USER_WIDTH - 1);
parameter USER_Y_DIRECT       = (MAPCHIP_USER_HEIGHT - 1);