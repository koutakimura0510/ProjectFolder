/*
 * FUNCTION.h
 *
 *  Created on: Feb 13, 2021
 *      Author: koutakimura
 */

#ifndef INC_FUNCTION_H_
#define INC_FUNCTION_H_

/**-------------------------------------------------
 * timer.c
 * -------------------------------------------------*/
void i2s_dma_setting(void);
void tim2_init(void);
void tim3_init(void);
void tim7_init(void);
bool comparater_time(uint32_t *com_timer, uint32_t time, char s);
uint32_t get_time(void);
void wait_time(uint32_t time);


/**-------------------------------------------------
 * dtm.c
 * -------------------------------------------------*/
void set_operator_status(void);
uint32_t wave_smpling(void);
void music_update(void);
void music_set_info(uint8_t id);
void music_timer_cnt(void);


#endif /* INC_FUNCTION_H_ */
