/*------------------------------------------------------------------------------
 * Create 2024/07/12
 * Author Kouta Kimura
 * 
 * USB データ通信で行うこと一覧
 * Flash ROM アップデート & ベリファイ
 * FPGA レジスタ R/W
 *-----------------------------------------------------------------------------*/
#include "trypad.h"
#include "class/cdc/cdc_device.h"	// Tyny USB の送受信関数を利用
#include <stdio.h>

/**-----------------------------------------------------------------------------
 * ファイル内 グローバル変数
 *-----------------------------------------------------------------------------*/
uint8_t g_usb_rbuff[256] = {0};
uint8_t g_usb_wbuff[256] = {0};

/**-----------------------------------------------------------------------------
 * ファイル内 プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void usb_byte_write(uint32_t wd);

/**-----------------------------------------------------------------------------
 * USER MACRO / 
 *-----------------------------------------------------------------------------*/
#define USB_CMD_USI_READ	(0xef)
#define USB_CMD_USI_WRITE	(0x88)

/**-----------------------------------------------------------------------------
 * USB ホストがデバイスを認識し接続したかチェック
 * return : true 接続中, false 未接続
 *-----------------------------------------------------------------------------*/
bool usb_connected(void)
{
	return tud_cdc_connected();
}

/**-----------------------------------------------------------------------------
 * ホストから発行されたコマンドを取得し、FPGA のレジスタを R/W する
 *-----------------------------------------------------------------------------*/
void usb_transaction(void)
{
	uint32_t queue_size;
	uint8_t usb_cmd_byte;
	uint32_t usi_adrs;
	uint32_t usi_data;

	// usb_byte_write(0x8080FEFE);
	
	if (false == usb_connected()) {
		return;
	}

	queue_size = tud_cdc_available();

	if (queue_size == 0) {
		return;
	}

	tud_cdc_read(&usb_cmd_byte, 1);

	if (usb_cmd_byte == USB_CMD_USI_READ) {		// read
		tud_cdc_read(g_usb_rbuff, 4);			// adrs 4byte
		usi_adrs = (g_usb_rbuff[0] << 24) | (g_usb_rbuff[1] << 16) | (g_usb_rbuff[2] << 8) | g_usb_rbuff[3];
		usi_data = usi_read(usi_adrs);
		usb_byte_write(usi_data);
		return;
	}

	if (usb_cmd_byte == USB_CMD_USI_WRITE) {	// write
		tud_cdc_read(g_usb_rbuff, 8);			// adrs + wdata = 8byte
		usi_adrs = (g_usb_rbuff[0] << 24) | (g_usb_rbuff[1] << 16) | (g_usb_rbuff[2] << 8) | g_usb_rbuff[3];
		usi_data = (g_usb_rbuff[4] << 24) | (g_usb_rbuff[5] << 16) | (g_usb_rbuff[6] << 8) | g_usb_rbuff[7];
		usi_write(usi_adrs, usi_data);
		usb_byte_write(usi_adrs);
		usb_byte_write(usi_data);
		return;
	}

	// アップデート
	// tud_cdc_read_char(); 	// 1文字受信
}

/**-----------------------------------------------------------------------------
 * USB byte Write
 *-----------------------------------------------------------------------------*/
static void usb_byte_write(uint32_t wd)
{
	uint8_t wbuff[4]; 

	wbuff[0] = (wd >> 24);
	wbuff[1] = (wd >> 16);
	wbuff[2] = (wd >> 8);
	wbuff[3] = (wd & 0xff);
	tud_cdc_write(wbuff, 4);
	tud_cdc_write_flush();
}