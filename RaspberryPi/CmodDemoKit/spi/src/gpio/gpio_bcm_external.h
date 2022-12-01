//----------------------------------------------------------
// Create  2022/08/27
// Author  KoutaKimura
// -
// bcm2835ライブラリを利用した RaspberryPi GPIO の操作を行う
// 関数をまとめたヘッダファイル
// 
//----------------------------------------------------------
#ifndef gpio_bcm_external_h   /* prevent circular inclusions */
#define gpio_bcm_external_h   /* by using protection macros */


/**----------------------------------------------------------
 * gpio_bcm.c でのみ bcm2835.h ライブラリを使用するための裏テク
 * 下記の分岐分けをすることで、サブディレクトリが複数構造になっても
 * include ディレクトリ内の Wrapperヘッダファイルで管理することが可能 
 * 
 *---------------------------------------------------------*/
#ifdef BCM_LIB_INCLUDE
	#include <bcm2835.h>
#endif


/**----------------------------------------------------------
 * 定数読み込み
 *---------------------------------------------------------*/
#include "gpio_bcm_macro.h"


/**----------------------------------------------------------
 * 関数宣言
 *---------------------------------------------------------*/
bool gpio_init(uint16_t spi_div);
bool gpio_close(void);
uint8_t gpio_spi_transfer(uint8_t send_data);
void gpio_spi_transfernb(char *wbuff, char *rbuff, uint32_t len);
void gpio_spi_transfern(char *wbuff, uint32_t len);
void gpio_spi_clkdiv(uint16_t spi_div);

#endif