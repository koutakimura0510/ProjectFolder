/*
 * timer.c
 *
 *  Created on: Dec 27, 2020
 *      Author: koutakimura
 */


/**-------------------------------------------------
 * include
 * -------------------------------------------------*/
#include "../Inc/MYLIB.h"
#include "stm32f4xx_hal.h"

/*--------------------------------------------------
 - データ取得数
 ---------------------------------------------------*/
#define OUTPUT_BUFFERSIZE (2) //need 2^n


/*--------------------------------------------------
 - 5msカウンター
 ---------------------------------------------------
 - time		:カウントアップ値を保存、時間を取得する場合この変数の値を取得する
 - ---------
 - dayover	:24時間経過したらインクリメントする
 ---------------------------------------------------*/
typedef struct {
	uint32_t time;
	uint32_t dayover;
} t_tmr;


/*--------------------------------------------------
 - チャタリング除去
 ---------------------------------------------------*/
typedef struct {
	uint8_t now_sw;		//今回のスイッチの読み取り値
	uint8_t last_sw;	//前回のスイッチの読み取り値
	uint8_t final_sw;	//前々回のスイッチの読み取り値
	uint8_t sw_up;		//スイッチのフラグ検出用
	uint8_t last_value;	//前回のスイッチの確定値
	uint8_t now_value;	//現在のスイッチの確定値
	uint8_t sw;			//戻り値用変数
	uint32_t count;		//長押し用変数
} t_key;


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
static t_key key = {0, 0, 0, 0, 0, 0, 0, 0};
static t_i2sbuffer i2sbuffer;

I2S_HandleTypeDef hi2s3;
DMA_HandleTypeDef hdma_spi3_tx;


/**-------------------------------------------------
 * ファイル内関数宣言
 * -------------------------------------------------*/
static uint8_t get_sw(void);
static uint8_t key_long_read(void);
static bool key_timer(uint32_t pushtime);


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
	t_key *keyp = &key;

	p->time++;

	if (p->time >= MAX_TOTAL) {
		p->dayover++;
		p->time &= 0;
	}

	keyp->final_sw = keyp->last_sw;	//前々回のスイッチの読み取り値保存
	keyp->last_sw  = keyp->now_sw;	//前回のスイッチの読み取り値保存
	keyp->now_sw   = get_sw();		//今回のスイッチの読み取り値保存

	if ((keyp->final_sw == keyp->last_sw) && (keyp->now_sw == keyp->last_sw)) {
		keyp->now_value = keyp->now_sw;
	}

	if (keyp->now_value != keyp->last_value) {			//スイッチの確定値が違う時
		keyp->sw_up = keyp->now_value & ~keyp->last_value;	//立ち上がり検出を行う
		keyp->last_value = keyp->now_value;				//今回のスイッチの確定値を保存
	}

	if ((keyp->now_value == keyp->last_value) && ((GPIOA->IDR & SW_BIT_SET) != 0)){
		keyp->count++;
	}else{
		keyp->count = 0;
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
 * Timer6 Interrupt
 * エンベローブカウンタ更新
 * BGMバッファ参照用カウンタ更新
 * -------------------------------------------------*/
void TIM7_IRQHandler(void)
{
	music_timer_cnt();
	TIM7->SR &= 0;
}


/**-------------------------------------------------
 * DMA通信割り込み処理
 * -------------------------------------------------*/
void HAL_I2S_TxHalfCpltCallback(I2S_HandleTypeDef *hi2s)
{
	if (hi2s->Instance == SPI2) {
	}
}


/**-------------------------------------------------
 * DMA通信割り込み処理
 * -------------------------------------------------*/
void HAL_I2S_TxCpltCallback(I2S_HandleTypeDef *hi2s)
{
	if (hi2s->Instance == SPI2) {
	}
}


/**--------------------------------------------------------------------------------
 * 押したキーのbitを取得
 * --------------------------------------------------------------------------------*/
static uint8_t get_sw(void)
{
	static uint8_t sw_bit = 0;

	sw_bit = GPIOA->IDR & SW_BIT_SET;
	return sw_bit;
}


/*-----------------------------------------------------
 - キーの長押し処理
 ------------------------------------------------------*/
static uint8_t key_long_read(void)
{
	t_key *p = &key;

	return p->now_value & SW_BIT_SET;
}


/*-----------------------------------------------------
 - 引数の時間分、キーが押されていたらtrue
 ------------------------------------------------------*/
static bool key_timer(uint32_t pushtime)
{
	t_key *p = &key;

	if (pushtime == 0) {
		return false;
	}

	if (p->count >= pushtime) {	//*　長押し処理
		return true;
	}

	return false;
}


/*-----------------------------------------------------
 - 押されたキーの立ち上がり値を取得
 ------------------------------------------------------*/
uint8_t key_read(uint32_t time)
{
	t_key *p = &key;

	if (true == key_timer(time)) {
		return p->sw;
	}

	if (p->sw_up != 0) {	//* SWの立ち上がりを検出
		p->sw = p->sw_up;
		p->sw_up = 0;
		return p->sw;
	}

	return 0;
}


/*--------------------------------------------------------------------
 - 引数で指定したキーが時間分押されていたらtrue
 - jugekey :長押し処理を行うキーのbit
 - time    :何秒間押されたらtrueを返すかの時間を指定
 ---------------------------------------------------------------------*/
bool key_check(uint8_t jugekey, uint32_t time)
{
	t_key *p = &key;

	if ((jugekey == key_long_read()) && (key_timer(time) == true)) {
		p->sw_up = 0;
		return true;
	}

	return false;
}


/**-----------------------------------------------------------
 * timer
 * -----------------------------------------------------------
 * arg1: *com_timer:比較用タイマーのアドレスを指定
 * arg2: time      :経過時間を指定
 * arg3: s         :分[M]:秒[S]選択
 *-----------------------------------------------------------*/
bool comparater_time(uint32_t *com_timer, uint16_t time, char s)
{
	volatile t_tmr *p = &timer;
	uint32_t t;

	if (s == 'M') {
		t = *com_timer + ((uint32_t)time*TM_1MIN);
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
 * get counter
 * -------------------------------------------------*/
uint32_t get_time(void)
{
	volatile t_tmr *p = &timer;

	return p->time;
}


/**-------------------------------------------------
 * wait counter
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
