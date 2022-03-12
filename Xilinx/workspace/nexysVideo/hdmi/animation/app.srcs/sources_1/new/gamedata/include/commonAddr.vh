//----------------------------------------------------------
// Create 2021/2/19
// Author koutakimura
// Editor VSCode ver1.62.7
// Build  Vivado20.2
// Borad  Nexys Video
// -
// 共有するDDRメモリアドレスマッピング
//----------------------------------------------------------
localparam [1:0] 
    IDOL        = 0,
    FBUF_AREA_1 = 1,
    FBUF_AREA_2 = 2,
    FBUF_AREA_3 = 3;


//----------------------------------------------------------
// カラーコード
//----------------------------------------------------------
parameter COLOR_RED         = ~('hffff4500);
parameter COLOR_GREEN       = ~('hff008000);
parameter COLOR_BLUE        = ~('hff4169e1);


//----------------------------------------------------------
// フレームバッファ領域
//----------------------------------------------------------
// parameter DDR_FBUF_SIZE     = (640 * 480);
parameter DDR_ADDR_FBUF_1   = 2457600;
parameter DDR_ADDR_FBUF_2   = 2457600 * 2;
parameter DDR_ADDR_FBUF_3   = 2457600 * 3;