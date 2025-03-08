/*------------------------------------------------------------------------------
 * Create 2024/07/12
 * Author Kouta Kimura
 * 
 * USB データ通信で行うこと一覧
 * Flash ROM アップデート & ベリファイ
 * FPGA レジスタ R/W
 * 
 * Pico USB でアップデート処理を実現したかったが USB1.1 12Mbps では、あまりにも遅かったので断念。
 * 外部から直接 ROMM アップデートすることとした。
 * Max12Mbps, APIバッファMax 256byte, かなりボトルネック
 *-----------------------------------------------------------------------------*/
#include <stdio.h>
#include "class/cdc/cdc_device.h"	// Tyny USB の送受信関数を利用
#include "trypad.h"

/**-----------------------------------------------------------------------------
 * USER MACRO / 
 *-----------------------------------------------------------------------------*/
// 有効コマンド
#define USB_UPDATE_MODE_ACTIVE		(0)		// "1" 有効、"0"無効
// USB 受信コマンド
#define USB_REC_CMD_USI_READ		(0xef)
#define USB_REC_CMD_USI_WRITE		(0x88)
#define USB_REC_CMD_ROM_READ		(0x99)
#define USB_REC_CMD_ROM_WRITE		(0x55)
// 
#define USB_SEND_CMD_READ_ACK		(0x01)	// 受信完了通知
// used update mode
#define USB_MAX_TRANSACTION_SIZE	(256)
#define USB_MAX_PAGE_SIZE			(2048)
#define USB_MAX_PAGE_SIZE_MASK		(USB_MAX_PAGE_SIZE-1)

typedef enum {
	UPDATE_MODE_IDLE = 0,
	UPDATE_MODE_ROM_ERASE,
	UPDATE_MODE_DATA_RECEIVE,
	UPDATE_MODE_ROM_WRITE,
	UPDATE_MODE_DONE_DETECTED,
	UPDATE_MODE_ADRS_UPDATE,
	UPDATE_MODE_DONE,
	UPDATE_MODE_TOTAL_NUMVER,
} UpdateModeMacro;

/**-----------------------------------------------------------------------------
 * ファイル内 グローバル変数
 *-----------------------------------------------------------------------------*/
uint8_t g_usb_rbuff[USB_MAX_TRANSACTION_SIZE] = {0};
uint8_t g_usb_wbuff[USB_MAX_TRANSACTION_SIZE] = {0};

/**-----------------------------------------------------------------------------
 * ファイル内 プロトタイプ宣言
 *-----------------------------------------------------------------------------*/
static void usb_device_transfer(void);
static void usb_device_receiver(void);
static void usb_device_rom_read(void);
static void usb_device_rom_write(void);
static void usb_byte_write(uint32_t wd);
static bool usb_freez_timeout(uint32_t *time);

/**-----------------------------------------------------------------------------
 * USB ホストがデバイスを認識し接続したかチェック
 * return : true 接続中, false 未接続
 *-----------------------------------------------------------------------------*/
bool usb_connected(void)
{
	return tud_cdc_connected();
}

/**-----------------------------------------------------------------------------
 * ホストから発行されたコマンドを取得し、コマンドに応じて FPGA レジスタ R/W, SPI ROM の R/W　を行う。
 *-----------------------------------------------------------------------------*/
void usb_transaction(void)
{
	uint32_t queue_size;
	uint8_t usb_cmd_byte;

	if (false == usb_connected()) {
		return;
	}

	queue_size = tud_cdc_available();

	if (queue_size == 0) {
		return;
	}

	tud_cdc_read(&usb_cmd_byte, 1);	// cmd byte 取得

	switch (usb_cmd_byte)
	{
		case USB_REC_CMD_USI_READ:
			usb_device_transfer();
			break;

		case USB_REC_CMD_USI_WRITE:
			usb_device_receiver();
			break;

		case USB_REC_CMD_ROM_READ:
			usb_device_rom_read();
			break;

#ifndef USB_UPDATE_MODE_ACTIVE
		case USB_REC_CMD_ROM_WRITE:
			usb_device_rom_write();
			break;
#endif
	
		default:
			break;
	}
}


/**-----------------------------------------------------------------------------
 * USB Transfer
 * こちらはデバイス側なので、Host にデータを送信する
 *-----------------------------------------------------------------------------*/
static void usb_device_transfer(void)
{
	uint32_t usi_adrs, usi_data;

	led_blink(LED_B, 2);
	tud_cdc_read(g_usb_rbuff, 4);	// adrs 4byte
	usi_adrs = (g_usb_rbuff[0] << 24) | (g_usb_rbuff[1] << 16) | (g_usb_rbuff[2] << 8) | g_usb_rbuff[3];
	usi_data = usi_read(usi_adrs);
	usb_byte_write(usi_data);
}

/**-----------------------------------------------------------------------------
 * USB Receiver
 * こちらはデバイス側なので、Host からデータを受信する
 *-----------------------------------------------------------------------------*/
static void usb_device_receiver(void)
{
	uint32_t usi_adrs, usi_data;

	led_blink(LED_G, 2);
	tud_cdc_read(g_usb_rbuff, 8);	// adrs + wdata = 8byte
	usi_adrs = (g_usb_rbuff[0] << 24) | (g_usb_rbuff[1] << 16) | (g_usb_rbuff[2] << 8) | g_usb_rbuff[3];
	usi_data = (g_usb_rbuff[4] << 24) | (g_usb_rbuff[5] << 16) | (g_usb_rbuff[6] << 8) | g_usb_rbuff[7];
	usi_write(usi_adrs, usi_data);
	// usb_byte_write(usi_adrs);
	// usb_byte_write(usi_data);
}


/**-----------------------------------------------------------------------------
 * USB Spi Rom Read
 * 
 *-----------------------------------------------------------------------------*/
static void usb_device_rom_read(void)
{
	uint8_t rbuff[USB_MAX_TRANSACTION_SIZE];
	uint8_t rom_id;
	uint16_t col_adrs;
	uint16_t page_adrs;

	led_blink(LED_G, 2);
	tud_cdc_read(g_usb_rbuff, 7);	// cmd + col_adrs + page_adrs + len = 7byte
	rom_id = g_usb_rbuff[0];
	col_adrs = (g_usb_rbuff[1] << 8) | g_usb_rbuff[2];
	page_adrs = (g_usb_rbuff[3] << 8) | g_usb_rbuff[4];
	// page_adrs = (g_usb_rbuff[3] << 8) | g_usb_rbuff[4];
	// usb_byte_write(page_adrs); //debug
	// usb_byte_write(data_size); //debug
	flash_read(rom_id, rbuff, col_adrs, page_adrs, USB_MAX_TRANSACTION_SIZE);
	tud_cdc_write(rbuff, USB_MAX_TRANSACTION_SIZE);
	tud_cdc_write_flush();
}

/**-----------------------------------------------------------------------------
 * USB Spi Rom Write
 * 
 *-----------------------------------------------------------------------------*/
#ifndef USB_UPDATE_MODE_ACTIVE

static void usb_device_rom_write(void)
{
	uint8_t mode = UPDATE_MODE_IDLE;
	uint8_t rom_id;
	uint16_t col_adrs;
	uint16_t page_adrs;
	uint32_t data_size;	// 受信ファイルの総バイト数
	uint8_t erase_auto;	// erase 処理を FW が動的に行うか選択 "1" auto, "0" free
	uint16_t wlen;		// rom への書き込みバイト数
	uint32_t timeout_time = get_time();
	bool timeout = false;

	led_blink(LED_G, 2);
	tud_cdc_read(g_usb_rbuff, 10);	// id + adrs + wdata = 8byte, Host が LSB First で送信するので、レジスタ操作時のデータ配列とは異なる点に注意
	rom_id = g_usb_rbuff[0];
	col_adrs  = (g_usb_rbuff[2] << 8)  |  g_usb_rbuff[1];
	page_adrs = (g_usb_rbuff[4] << 8)  |  g_usb_rbuff[3];
	data_size = (g_usb_rbuff[8] << 24) | (g_usb_rbuff[7] << 16) | (g_usb_rbuff[6] << 8) | g_usb_rbuff[5];
	erase_auto = g_usb_rbuff[9];

	usb_byte_write(USB_SEND_CMD_READ_ACK);
	
	do {
		switch (mode)
		{
		case UPDATE_MODE_IDLE:
			if (USB_MAX_TRANSACTION_SIZE & tud_cdc_available()) {
				mode = UPDATE_MODE_ROM_ERASE;
				timeout_time = get_time();
			}
			timeout = usb_freez_timeout(&timeout_time);		// host からの通知部分が唯一停止する処理なので、timeout を入れる
			break;

		case UPDATE_MODE_ROM_ERASE:
			if (((0x3f & page_adrs) == 0) && (col_adrs == 0)) {	// 64page 区切りで Block Erase 実行
				flash_user_block_elase(rom_id, page_adrs);
			}
			mode = UPDATE_MODE_DATA_RECEIVE;
			break;

		case UPDATE_MODE_DATA_RECEIVE:
			tud_cdc_read(g_usb_rbuff, USB_MAX_TRANSACTION_SIZE);
			usb_byte_write(USB_SEND_CMD_READ_ACK);
			mode = UPDATE_MODE_ROM_WRITE;
			break;

		case UPDATE_MODE_ROM_WRITE:
			if (data_size <= USB_MAX_TRANSACTION_SIZE) {
				wlen = data_size;
			}else{
				wlen = USB_MAX_TRANSACTION_SIZE;
			}
			flash_user_page_write(rom_id, g_usb_rbuff, col_adrs, page_adrs, wlen);
			mode = UPDATE_MODE_DONE_DETECTED;
			break;

		case UPDATE_MODE_DONE_DETECTED:
			if (data_size <= USB_MAX_TRANSACTION_SIZE) {
				mode = UPDATE_MODE_DONE;
			}else{
				data_size -= USB_MAX_TRANSACTION_SIZE;
				mode = UPDATE_MODE_ADRS_UPDATE;
			}
			break;

		case UPDATE_MODE_ADRS_UPDATE:
			col_adrs += USB_MAX_TRANSACTION_SIZE;
			col_adrs &= USB_MAX_PAGE_SIZE_MASK;

			if (col_adrs == 0) {
				page_adrs++;
			}
			timeout_time = get_time(); // IDLE に戻るときに、timeout 時間更新しておく
			mode = UPDATE_MODE_IDLE;
			break;

		case UPDATE_MODE_DONE:
			break;
		
		default:
			mode = UPDATE_MODE_DONE;
			break;
		}

		led_tmr_blink(LED_GREEN_INDEX, MTIMER_50MS);
	} while ((mode != UPDATE_MODE_DONE) && (timeout == false));

	led_light(LED_G, 1);
	usb_byte_write(USB_SEND_CMD_READ_ACK);
	tud_cdc_read(g_usb_rbuff, USB_MAX_TRANSACTION_SIZE); // ゴミデータ読み込み flash Crear
}
#endif

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

/**-----------------------------------------------------------------------------
 * usb 通信時の timeout 処理
 *-----------------------------------------------------------------------------*/
static bool usb_freez_timeout(uint32_t *time)
{
	if (false == timer_compare(time, MTIMER_3S)) {
		return false;
	}

	return true;
}