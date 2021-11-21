/*
 * FUNCTION.h
 *
 *  Created on: Dec 27, 2020
 *      Author: koutakimura
 */

#ifndef INC_FUNCTION_H_
#define INC_FUNCTION_H_

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
uint8_t key_read(uint32_t time);
bool key_check(uint8_t jugekey, uint32_t time);


/**-------------------------------------------------
 * tft.c
 * -------------------------------------------------*/
void tft_display_init(void);
void tft_display_flash(uint16_t color);


/**-------------------------------------------------
 * dtm.c
 * -------------------------------------------------*/
void gain_align(char updown);
void fm_align(char updown);
void output_align(char updown);

void filter_start(uint8_t n);
void set_operator_status(void);
uint32_t wave_smpling(void);
void music_update(void);
void music_set_info(uint8_t id);
void music_timer_cnt(void);


/**-------------------------------------------------
 * ssd1306.c
 * -------------------------------------------------*/
void lcd_init(void);
void lcd_hex_flash(int32_t disp_data, uint8_t y, uint8_t x, uint8_t yini, uint8_t xini);
void lcd_ascii_flash(char *str, uint8_t y, uint8_t x, uint8_t yini, uint8_t xini);
void lcd_clear(void);


/**-------------------------------------------------
 * string.c
 * -------------------------------------------------*/
void ascii_change(int32_t change_data, char *buff, uint8_t len);
void s_copy(char *s1, char *s2);
void s_number_push(char *s1, uint8_t n, char s);
void s_cp(char *s1, char *s2, uint8_t n, uint8_t m);
void s_exchange(char *s1, char *s2);
uint8_t s_len(char *s);

#endif /* INC_FUNCTION_H_ */
