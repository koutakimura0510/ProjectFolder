#ifndef fpga_func_h   /* prevent circular inclusions */
#define fpga_func_h   /* by using protection macros */

#include "mapchip_macro.h"
#include "vdma_macro.h"


/* 初期化関数 */
bool fpga_mapchip_init(void);
bool vdma_init(void);

/*
 * mapchip.c
 */
bool fpga_mapchip_init(void);
void put_mapchip(GameWrapper *const game);
void png_mapchip(GameWrapper *const game);
void color_mapchip(GameWrapper *const game);
void background_loop(int ddr_copy, int ddr_update, int width, int height, int frame_size);
void framebuffer_copy(int ddr_copy, int ddr_update, int width, int height, int video_width);
void patblt(int dstout, int xpos, int ypos, int width, int height, int color);
void affine_scale(GameWrapper *const game);
void affine_roulette(GameWrapper *const game);


/*
 * vdma.c
 */
bool vdma_init(void);
int8_t vdma_channel(uint8_t ch);
uint8_t vdma_circular(void);
bool vdma_IsChannel(void);
bool hvsync_state(void);

#endif
