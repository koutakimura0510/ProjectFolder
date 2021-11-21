/*
 * FUNCTION.h
 *
 *  Created on: Dec 6, 2020
 *      Author: koutakimura
 */


#ifndef FUNCTION_H_
#define FUNCTION_H_


/**-------------------------------------------------
 * timer.c
 * -------------------------------------------------*/
bool comparater_time(uint32_t *com_timer, uint16_t time, char s);
uint32_t get_time(void);
void wait_time(uint32_t time);
void i2s_dma_setting(void);
void tim2_init(void);
void tim3_init(void);
void tim7_init(void);
void music_update(void);
void music_set_info(uint8_t id);
uint8_t key_read(void);
void monitoring_buffer(void);

/**-------------------------------------------------
 * display.c
 * -------------------------------------------------*/
void display_init(void);
void write_data(uint8_t d);


/**-------------------------------------------------
 * serial.c
 * -------------------------------------------------*/
void lcd_init(void);
void lcd_write(uint8_t cmd_data, uint8_t wr_data);
void lcd_clear(void);
bool i2c_send(uint8_t *dat, uint8_t address, uint8_t len);
uint8_t spi_send(uint16_t dat);
uint16_t spi_read(void);

#endif
