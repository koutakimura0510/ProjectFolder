/*
 * timer.c
 *
 *  Created on: Feb 13, 2021
 *      Author: koutakimura
 */

#include "../Inc/MYLIB.h"


/*--------------------------------------------------
 * データ取得数
 *--------------------------------------------------*/
#define OUTPUT_BUFFERSIZE (2) //need 2^n


/*--------------------------------------------------
 * time		:カウントアップ値を保存、時間を取得する場合この変数の値を取得する
 * ---------
 * dayover		:24時間経過したらインクリメントする
 *--------------------------------------------------*/
typedef struct {
	uint32_t time;
	uint32_t dayover;
} t_tmr;


/**-------------------------------------------------
 * I2S送信用バッファを管理する構造体
 * -------------------------------------------------*/
typedef struct{
	uint16_t buffer[OUTPUT_BUFFERSIZE];
} t_i2sbuffer;


/**-------------------------------------------------
 * 構造体の確保
 * -------------------------------------------------*/
volatile static t_tmr timer = {0, 0,};
static t_i2sbuffer i2sbuffer;

I2S_HandleTypeDef hi2s3;
DMA_HandleTypeDef hdma_spi3_tx;


/**-------------------------------------------------
 * I2S通信のDMA送信設定
 * -------------------------------------------------*/
void i2s_dma_setting(void)
{
	HAL_I2S_Transmit_DMA(&hi2s3, i2sbuffer.buffer, OUTPUT_BUFFERSIZE);
}


/**-------------------------------------------------
 * Timer2 Interrupt Start Init
 * -------------------------------------------------
 * timer 5ms
 * -------------------------------------------------*/
void tim2_init(void)
{
	RCC->APB1ENR |= RCC_APB1ENR_TIM2EN; 		// Clock supply Enable
	TIM2->CR1  |= (TIM_CR1_CEN | TIM_CR1_ARPE);	// Counter/ARR Enable
	TIM2->DIER |= TIM_DIER_CC1IE;				// CC1 Interrupt Enable
	TIM2->PSC   = TIM2_PSC_CLK;					// CLK = ((SystemClk) / PSC)
	TIM2->ARR   = TIM2_ARR;						// replace and reset value(whole time)
	TIM2->EGR |= TIM_EGR_UG;					// timer restart
	NVIC_EnableIRQ(TIM2_IRQn);
}


/**-------------------------------------------------
 * Timer3 Interrupt Start Init
 * -------------------------------------------------
 * timer サンプリング周期の速度で割り込み
 * -------------------------------------------------*/
void tim3_init(void)
{
	RCC->APB1ENR |= RCC_APB1ENR_TIM3EN; 		// Clock supply Enable
	TIM3->CR1  |= (TIM_CR1_CEN | TIM_CR1_ARPE);	// Counter/ARR Enable
	TIM3->DIER |= TIM_DIER_CC1IE;		// CC1 Interrupt Enable
	TIM3->PSC   = TIM3_PSC_CLK;			// CLK = ((SystemClk) / PSC)
	TIM3->ARR   = TIM3_ARR;				// replace and reset value(whole time)
	TIM3->EGR  |= TIM_EGR_UG;			// timer restart
	NVIC_EnableIRQ(TIM3_IRQn);
}


/**-------------------------------------------------
 * Timer2 Interrupt Start Init
 * -------------------------------------------------
 * timer 1ms
 * -------------------------------------------------*/
void tim7_init(void)
{
	RCC->APB1ENR |= RCC_APB1ENR_TIM7EN; 		// Clock supply Enable
	TIM7->CR1  |= (TIM_CR1_CEN | TIM_CR1_ARPE);	// Counter/ARR Enable
	TIM7->DIER |= TIM_DIER_UIE;		// CC1 Interrupt Enable
	TIM7->PSC   = TIM7_PSC_CLK;		// CLK = ((SystemClk) / PSC)
	TIM7->ARR   = TIM7_ARR;			// replace and reset value(whole time)
	TIM7->EGR  |= TIM_EGR_UG;		// timer restart
	NVIC_EnableIRQ(TIM7_IRQn);
}


/**-------------------------------------------------
 * Timer2 Interrupt
 * -------------------------------------------------*/
void TIM2_IRQHandler(void)
{
	volatile t_tmr *p = &timer;
	p->time++;

	if (p->time >= MAX_TOTAL) {
		p->dayover++;
		p->time &= 0;
	}
	TIM2->SR &= ~(TIM_SR_CC1IF);	//software flag clear
}


/**-------------------------------------------------
 * Timer3 Interrupt
 * -------------------------------------------------*/
void TIM3_IRQHandler(void)
{
	i2sbuffer.buffer[0] = wave_smpling();
	i2sbuffer.buffer[1] = i2sbuffer.buffer[0];

	TIM3->SR &= ~(TIM_SR_CC1IF);
}


/**-------------------------------------------------
 * Timer7 Interrupt
 * -------------------------------------------------*/
void TIM7_IRQHandler(void)
{
	music_timer_cnt();
	TIM7->SR &= 0;
}


/**-----------------------------------------------------------
 * 指定時間が経過したか確認を行う
 * -----------------------------------------------------------
 * *com_timer : 比較用タイマーのアドレスを指定
 * time       : 経過時間を指定
 * s          : 分[M]:秒[S]選択
 *-----------------------------------------------------------*/
bool comparater_time(uint32_t *com_timer, uint32_t time, char s)
{
	volatile t_tmr *p = &timer;
	uint32_t t;

	if (s == 'M') {
		t = *com_timer + (time * TM_1MIN);
	}else{
		t = *com_timer + time;
	}

	if (t >= MAX_TOTAL) {
		*com_timer = 0;
	}

	if (t <= p->time) {
		return true;
	}

	return false;
}


/**-------------------------------------------------
 * 割り込み周期でカウントアップしている変数の値を取得
 * -------------------------------------------------*/
uint32_t get_time(void)
{
	volatile t_tmr *p = &timer;

	return p->time;
}


/**-------------------------------------------------
 * 一定時間処理を待つ
 * -------------------------------------------------
 * arg1: wait_time
 *-------------------------------------------------*/
void wait_time(uint32_t time)
{
	uint32_t t = get_time();

	while (1U) {
		if (true == comparater_time(&t, time, 'S')) {
			return;
		}
	}
}
