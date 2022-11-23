//----------------------------------------------------------
// Create  2022/08/27
// Author  KoutaKimura
// -
// bcm2835ライブラリを利用した RaspberryPi GPIO の操作を行う
// 関数をまとめたヘッダファイル
// 
//----------------------------------------------------------
#ifndef gpio_bcm_macro_h   /* prevent circular inclusions */
#define gpio_bcm_macro_h   /* by using protection macros */


/**----------------------------------------------------------
 * SPI 設定マクロ定数
 * ヘッダ・及び自前の定数で管理することで設定を変更しやすくする目的
 *---------------------------------------------------------*/
#define GPIO_25_MASTER_SLAVE_SELECT (25)
#define GPIO_HIGH					(0x01)
#define GPIO_LOW					(0x00)


//
#define SPI_CLK_31_250_000_Hz		(8)
#define SPI_CLK_15_625_000_Hz		(16)
#define SPI_CLK_7_812_500_Hz		(32)
#define SPI_CLK_6_250_000_Hz		(40)
#define SPI_CLK_3_906_250_Hz		(64)
#define SPI_CLK_3_125_000_Hz		(80)
#define SPI_CLK_1_953_125_Hz		(128)
#define SPI_CLK_1_562_500_Hz		(160)
#define SPI_CLK_1_250_000_Hz		(200)
#define SPI_CLK_781_250_Hz			(320)
#define SPI_CLK_625_000_Hz			(400)


//
#endif