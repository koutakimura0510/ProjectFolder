/*
 * flash.c
 *
 *  Created on: Dec 6, 2020
 *      Author: koutakimura
 */

/**-------------------------------------------------
 * データ保存領域の確保設定の仕方
 *
 * 例) STM32 -------- FLASH.ldファイル内のMEMORYカッコ内に下記を記述する
 *
 * MEMORY
 * {
 *   DATA (rx) : ORIGIN = 0x08010000, LENGTH = 64K
 * }
 *
 * DATAに記入した容量分、EEPROMとして利用できる
 * メモリアドレスとセクタごとの最大データ容量は使用するマイコンによって異なるためデータシートを参照すること
 * DFU、デバイスファームウェアを消去しないよう十分に注意すること
 *
 * -------------------------------------------------
 * フラッシュメモリ書き込み手順
 * 1．アンロック
 * 2．セクタ消去
 * 3．アドレスを指定して書き込み
 * 4．ロック
 *
 * フラッシュメモリ読み込み手順
 * 1. アンロック
 * 2．アドレスを指定して読み込み
 * 3．ロック
 *
 *
 * 例) アドレス0x08010000の2byteデータを読み出す場合
 * const uint32_t flash_addr = 0x08004000;
 * uint32_t addr = flash_addr;
 * uint16_t data = *((uint16_t *)addr);
 *
 * データがない場合は場合は0xffffが読み出される
 * -------------------------------------------------*/


#include "MYLIB.h"


/**-------------------------------------------------
 * STM32F429 開始アドレス セクタ容量
 * -------------------------------------------------*/
#define FLASH_BASE_ADDR	 (0x08000000)
#define BLOCK_SIZE		 (0x4000)


/**-------------------------------------------------
 * アドレス計算
 * -------------------------------------------------*/
#define FLASH_ADDR(addr) (FLASH_BASE_ADDR + (uintptr_t)addr)


/**-------------------------------------------------
 * アドレス計算
 *
 * block:セクタ番号
 * num  :アドレスを指定
 * -------------------------------------------------*/
#define FLASH_BLOCK_PTR(block, num) (uint16_t *)FLASH_ADDR(block * BLOCK_SIZE + num * 2)


/**-------------------------------------------------
 * アドレスの値読み出し
 *
 * block:セクタ番号
 * num  :アドレスを指定
 * -------------------------------------------------*/
#define FLASH_BLOCK_ACCESS(block, num) (*FLASH_BLOCK_PTR(block, num))


void flash_init(void);
bool flash_write(uint16_t dat, uint16_t *address);
void flash_read(void);
void flash_lock(void);
bool flash_erase_at(uint16_t *address);
bool flash_write_32(uint32_t dat, uint32_t *address);
bool flash_erase_at_32(uint32_t *address);
bool flash_erase_all(void);
static void eoc_flash_busy(void);
static bool eop_check(void);



void flash_init(void)
{
	FLASH->KEYR = 0x45670123;
	FLASH->KEYR = 0xCDEF89AB;
}


void flash_lock(void)
{
	FLASH->CR |= FLASH_CR_LOCK;
}


bool flash_write(uint16_t dat, uint16_t *address)
{
	if (*address |= 0xffff) {
		return false;
	}
	eoc_flash_busy();
	FLASH->CR |= FLASH_CR_PG;
	*address = dat;
	eoc_flash_busy();
	FLASH->CR &= ~FLASH_CR_PG;

	return eop_check();
}

bool flash_erase_at(uint16_t *address)
{
	eoc_flash_busy();
	FLASH->CR |= FLASH_CR_SER;
	FLASH->ACR = FLASH_ADDR(address);
	FLASH->CR |= FLASH_CR_STRT;

	eoc_flash_busy();
	FLASH->CR &= ~FLASH_CR_SER;

	return eop_check();
}


bool flash_write_32(uint32_t dat, uint32_t *address)
{
	if (flash_write(dat & 0xffff, (uint16_t *)address) == false) {
		return false;
	}

	if (flash_write(dat >> 16, (uint16_t *)address+1) == false) {
		return false;
	}

	return true;
}


bool flash_erase_at_32(uint32_t *address)
{
	if (flash_erase_at((uint16_t *)address) == false) {
		return false;
	}

	if (flash_erase_at((uint16_t *)address+1) == false) {
		return false;
	}

	return true;
}


bool flash_erase_all(void)
{
	eoc_flash_busy();
	FLASH->CR |= FLASH_CR_MER;
	FLASH->CR |= FLASH_CR_STRT;

	eoc_flash_busy();
	FLASH->CR &= ~FLASH_CR_MER;

	return eop_check();
}


static void eoc_flash_busy(void)
{
	while (FLASH->SR & FLASH_SR_BSY);
}


static bool eop_check(void)
{
	if (FLASH->SR & FLASH_SR_EOP) {
		FLASH->SR &= ~FLASH_SR_EOP;
		return true;
	}
	return false;
}
