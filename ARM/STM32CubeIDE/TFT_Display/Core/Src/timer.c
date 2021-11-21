/*
 * timer.c
 *
 *  Created on: Dec 6, 2020
 *      Author: koutakimura
 */


/**-------------------------------------------------
 * include
 * -------------------------------------------------*/
#include "../Inc/MYLIB.h"
#include "../Inc/DTM.h"
#include "stm32f4xx_hal.h"

/*--------------------------------------------------
 - 構造体サイズ定義
 ---------------------------------------------------*/
#define BGM_SIZE  ((sizeof (bgmstatus))/(sizeof (t_bgmstatus)))

#define OUTPUT_BUFFERSIZE (1024) //need 2^n


/**-------------------------------------------------
 * BGMを管理するデータベース
 * -------------------------------------------------
 * id		:音源の番号を指定、呼び出す関数でIDを指定し、この番号と一致したデータを取得する
 * ---------
 * *bgm	:音階データのアドレスを指定
 * ---------
 * *delta	:デルタタイムの配列アドレスを指定
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	const uint8_t  *bgm;
	const uint16_t *delta;
	const uint8_t  *subbgm;
	const uint16_t *subdelta;
	const uint16_t bgmsize;
	const uint16_t subbgmsize;
} t_bgmstatus;

static const t_bgmstatus bgmstatus[] = {
		{	INADA,  inada_bgm,  inada_delta,	inada_bgm_sub,	inada_delta_sub,		NUM(inada_bgm),	NUM(inada_bgm_sub)},
		{	KOUROU, kourou_bgm, kourou_delta,	kourou_bgm_sub,	kourou_delta_sub,		NUM(kourou_bgm),	NUM(kourou_bgm_sub)},
};

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


/**-------------------------------------------------
 * bgm再生に必要なデータを核の保存する構造体
 * -------------------------------------------------
 * bgm_pos    : BGMデータの配列を参照する変数
 * -----------
 * buffpos    : 鳴らす音源データの配列番号を指定する変数
 * -----------
 * loop		  : 和音の場合2～3回loop処理を行う
 * -----------
 * time       : 1msカウントアップ用変数
 * -----------
 * envcycle   : エンベローブのタイミングを調整
 * -----------
 * envcnt     : エンベローブ配列参照用
 * -------------------------------------------------*/
typedef struct {
	uint16_t bgm_pos;
	uint16_t buff_pos;
	uint8_t  loop;
	uint16_t time;
	uint8_t  envcycle;
	uint8_t  envcnt;
} t_bgmcounter;


/**-------------------------------------------------
 * sin波のデータ配列を参照するための変数をまとめた構造体
 * -------------------------------------------------
 * integer	:計算結果の整数部保存
 * ---------
 * dec		:計算結果の小数部保存
 * ---------
 * sin_pos	:sin配列のデータを取得するポジションを指定
 * -------------------------------------------------*/
typedef struct {
	uint32_t integer;
	uint32_t dec;
	uint32_t sin_pos;
} t_sinwave;


/**-------------------------------------------------
 * BGMのデータを一時保存する構造体
 * -------------------------------------------------
 * *bgm		:音源データが保存されている配列の先頭アドレスを指定
 * ----------
 * *deltatime	:デルタタイムが保存されている配列の先頭アドレスを指定
 * ----------
 * bgmsize		:*bgmに指定した配列の容量を保存
 * -------------------------------------------------*/
typedef struct {
	const uint8_t  *bgm;
	const uint16_t *deltatime;
	uint16_t bgmsize;
} t_bgminfo;


/**-------------------------------------------------
 * I2S送信用バッファを管理する構造体
 * -------------------------------------------------*/
typedef struct{
	uint16_t buffer[OUTPUT_BUFFERSIZE * 2];
	volatile uint16_t idx;
	uint8_t started_flag;
	int16_t err_distance;
} t_i2sbuffer;



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
 * 構造体の確保
 * -------------------------------------------------*/
volatile static t_tmr timer  = {0, 0,};
static t_key key = {0, 0, 0, 0, 0, 0, 0, 0};
static t_bgmcounter bgmcounter[2] = {0};
static t_bgminfo bgminfo[2];
static t_sinwave sinwave[MAX_CHORD*2] = {0};
static t_i2sbuffer i2sbuffer;

I2S_HandleTypeDef hi2s2;
DMA_HandleTypeDef hdma_spi2_tx;


/**-------------------------------------------------
 * 関数宣言
 * -------------------------------------------------*/
static void bgm_count(void);
static void bgm_main_eoc(t_bgmcounter *cnt_p, t_bgminfo *bgm_p);
static uint8_t bgm_sub_eoc(t_bgmcounter *cnt_p, t_bgminfo *bgm_p);
static uint8_t get_sw(void);


/**-------------------------------------------------
 * I2S通信のDMA送信設定/Timer8を使用
 * -------------------------------------------------*/
void i2s_dma_setting(void)
{	
	i2sbuffer.idx = 0;
	i2sbuffer.started_flag = 0;
	i2sbuffer.err_distance = 0;
	HAL_I2S_Transmit_DMA(&hi2s2, i2sbuffer.buffer, OUTPUT_BUFFERSIZE*2);
	//hdma_spi2_tx.Instance->CR &= 0xffffffef;
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
 * timer 32.250us
 * -------------------------------------------------*/
/*void tim3_init(void)
{
	RCC->APB1ENR |= RCC_APB1ENR_TIM3EN; 					//クロック供給有効
	TIM3->CR1    |= (TIM_CR1_CEN | TIM_CR1_ARPE);			//カウンター有効
	TIM3->DIER   |= TIM_DIER_CC1IE;							//割り込み有効
	TIM3->CCMR1  |= (TIM_CCMR1_OC1M_2 | TIM_CCMR1_OC1M_1);	//PWMモード1
	TIM3->CCMR1  |= TIM_CCMR1_OC1PE_Msk;					//出力プリロード有効
	//TIM3->CCMR1  |= TIM_CCMR1_OC1FE_Msk;					//出力比較高速化
	TIM3->PSC     = TIM3_PSC_CLK;							// CLK = ((SystemClk) / PSC)
	TIM3->ARR     = TIM3_ARR;								// replace and reset value(whole time)
	TIM3->CCER   |= TIM_CCER_CC1E_Msk;
	TIM3->EGR    |= TIM_EGR_UG;								//timer restart
	NVIC_EnableIRQ(TIM3_IRQn);
}
*/

void tim3_init(void)
{
	RCC->APB1ENR |= RCC_APB1ENR_TIM3EN; 					//クロック供給有効
	TIM3->CR1    |= (TIM_CR1_CEN | TIM_CR1_ARPE);			//カウンター有効
	TIM3->DIER   |= TIM_DIER_CC2IE;							//割り込み有効
	TIM3->CCMR1  &= ~TIM_CCMR1_CC2S_Msk;
	TIM3->CCMR1  |= (TIM_CCMR1_OC2M_2 | TIM_CCMR1_OC2M_1);	//PWMモード1
	TIM3->CCMR1  |= TIM_CCMR1_OC2PE_Msk;					//出力プリロード有効
	TIM3->CCMR1  |= TIM_CCMR1_OC2FE_Msk;					//出力比較高速化
	TIM3->PSC     = TIM3_PSC_CLK;							// CLK = ((SystemClk) / PSC)
	TIM3->ARR     = TIM3_ARR;								// replace and reset value(whole time)
	TIM3->CCER   |= TIM_CCER_CC2E_Msk;
	TIM3->EGR    |= TIM_EGR_UG;								//timer restart
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

	/*if ((keyp->now_value == keyp->last_value) && ((~SW() & SW_BIT_SET) != 0)){
		keyp->count++;
	}else{
		keyp->count = 0;
	}*/

	TIM2->SR &= ~(TIM_SR_CC1IF);	//software flag clear
}


/**-------------------------------------------------
 * Timer3 Interrupt
 * -------------------------------------------------*/
void TIM3_IRQHandler(void)
{
	bgm_count();
	TIM3->SR &= ~(TIM_SR_CC2IF);
}


/**-------------------------------------------------
 * Timer6 Interrupt
 * エンベローブカウンタ更新
 * BGMバッファ参照用カウンタ更新
 * -------------------------------------------------*/
void TIM7_IRQHandler(void)
{
	t_bgmcounter *p = bgmcounter;
	static uint8_t i = 0;

	for (i = 0; i < MAX_SOUND; i++) {
		p->envcycle++;
		p->time++;
		p++;
	}
	TIM7->SR &= 0;
}


/**-------------------------------------------------
 * Timer8 DMA通信割り込み処理
 * -------------------------------------------------*/
void HAL_I2S_TxHalfCpltCallback(I2S_HandleTypeDef *hi2s)
{
	if (hi2s->Instance == SPI2) {
		i2sbuffer.err_distance -= OUTPUT_BUFFERSIZE;
	}
}


/**------------------------------------------------- 
 * Timer8 DMA通信割り込み処理
 * -------------------------------------------------*/
void HAL_I2S_TxCpltCallback(I2S_HandleTypeDef *hi2s)
{
	if (hi2s->Instance == SPI2) {
		i2sbuffer.err_distance -= OUTPUT_BUFFERSIZE;
	}
}


void monitoring_buffer(void)
{
	if(i2sbuffer.err_distance < -1 * OUTPUT_BUFFERSIZE){ //if buffer under-run error occurs.
		i2sbuffer.idx += OUTPUT_BUFFERSIZE;
		i2sbuffer.err_distance += OUTPUT_BUFFERSIZE;
	}else if (OUTPUT_BUFFERSIZE < i2sbuffer.err_distance){ //if buffer over-run error occurs.
		i2sbuffer.idx -= OUTPUT_BUFFERSIZE;
		i2sbuffer.err_distance -= OUTPUT_BUFFERSIZE;
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
 - 押されたキーの立ち上がり値を取得
 ------------------------------------------------------*/
uint8_t key_read(void)
{
	t_key *p = &key;

	if (p->sw_up != 0) {	//* SWの立ち上がりを検出
		p->sw = p->sw_up;
		p->sw_up = 0;
		return p->sw;
	}

	return 0;
}


/**--------------------------------------------------------------------------------
 * 音源データを参照する変数を更新する関数
 *
 * タイマの値がデルタタイムの時間を過ぎていたら、音源参照用の変数を更新する
 * 次に鳴らす音源が和音かチェックをし、和音の数だけループを行う変数を更新する
 * --------------------------------------------------------------------------------*/
void music_update(void)
{
	t_bgmcounter *cnt_p = bgmcounter;
	t_bgminfo *bgm_p = bgminfo;
	uint8_t i, j, len;

	bgm_main_eoc(cnt_p, bgm_p);
	len = bgm_sub_eoc(cnt_p, bgm_p);

	for (i = len; i < MAX_SOUND; i++, cnt_p++, bgm_p++) {
		if (cnt_p->envcycle > 30) {
			if (cnt_p->envcnt != (SOUND_BUFFER-1)) {
				cnt_p->envcnt++;
			}
			cnt_p->envcycle = 0;
		}

		if (cnt_p->time > bgm_p->deltatime[cnt_p->bgm_pos]) {
			for (j = 0; j < MAX_CHORD; j++) {
				if (bgm_p->deltatime[++cnt_p->bgm_pos] != 0) {
					break;
				}
			}
			cnt_p->buff_pos = cnt_p->bgm_pos - j;
			cnt_p->loop = j + 1;
			cnt_p->envcnt = 0;
			cnt_p->envcycle = 0;
			cnt_p->time = 0;
		}
	}
}


/**------------------------------------------------------------------------------
 * 指定したIDに対応する音源データのステータスを取得する
 * ------------------------------------------------------------------------------
 * id:ヘッダーファイル定義してあるIDを指定する
 * ------------------------------------------------------------------------------*/
void music_set_info(uint8_t id)
{
	t_bgminfo *bgm_p = bgminfo;
	const t_bgmstatus *p = bgmstatus;

	for (uint8_t i = 0; i < BGM_SIZE; i++, p++) {
		if (p->id == id) {
			break;
		}
	}
	bgm_p->bgmsize = p->bgmsize;
	bgm_p->bgm = p->bgm;
	bgm_p->deltatime = p->delta;

	bgm_p++;
	bgm_p->bgmsize = p->subbgmsize;
	bgm_p->bgm = p->subbgm;
	bgm_p->deltatime = p->subdelta;
}



/**-------------------------------------------------
 * 音階テーブルを参照しsinカーブを求める
 * 求めたsinカーブに応じてPWMの出力を変更する
 * -------------------------------------------------*/
static void bgm_count(void)
{
	t_sinwave *p = sinwave;
	t_bgminfo *bgm_p = bgminfo;
	t_bgmcounter *cnt_p = bgmcounter;

	static uint32_t d = 0;
	static uint8_t i = 0;
	static uint8_t j = 0;
	static uint8_t len = 0;

	len = bgm_sub_eoc(cnt_p, bgm_p);

	for (i = len; i < MAX_SOUND; i++, cnt_p++, bgm_p++) {
		for (j = 0; j < cnt_p->loop; j++, p++) {
			p->integer += bgm_integer[bgm_p->bgm[cnt_p->buff_pos+j]];
			p->dec     += bgm_decimal[bgm_p->bgm[cnt_p->buff_pos+j]];
			p->sin_pos  = p->integer + (p->dec >> PWM_RES);
			if (p->sin_pos > PWM_SIZE) {
				p->integer = 0;
				p->sin_pos = 0;
				p->dec = 0;
			}
			d += ((bgm_sin[p->sin_pos] * bgm_envelope[cnt_p->envcnt]) >> ENV_RES);
		}
		p = (p+(MAX_CHORD-j));
		d >>= 1;
	}

	i2sbuffer.buffer[i2sbuffer.idx]   = d;
	i2sbuffer.buffer[i2sbuffer.idx+1] = d;
	//i2sbuffer.buffer[i2sbuffer.idx] = 0xfaaa;
	//i2sbuffer.buffer[i2sbuffer.idx+1] = 0x0000;
	i2sbuffer.idx += 2;
	i2sbuffer.idx &= ((OUTPUT_BUFFERSIZE << 1) -1);
	i2sbuffer.err_distance += 2;
	TIM3->CCR2 = d;
	d = 0;
}


/**--------------------------------------------------------------------------------
 * メイン音源が最後の演奏データに達したかチェックを行い、配列のサイズ数を変数の値が超えていたら
 * メインとサブの配列参照用の変数をクリアする
 * --------------------------------------------------------------------------------*/
static void bgm_main_eoc(t_bgmcounter *cnt_p, t_bgminfo *bgm_p)
{
	if (cnt_p->bgm_pos > bgm_p->bgmsize) {
		for (uint8_t i = 0; i < MAX_SOUND; i++, cnt_p++) {
			cnt_p->bgm_pos = 0;
			cnt_p->buff_pos = 0;
		}
	}
}


/**--------------------------------------------------------------------------------
 * サブ音源の最後の演奏データに達したかチェックを行う
 * --------------------------------------------------------------------------------
 * return : サブ音源が最後まで演奏されていたら、サブのループ処理を行わない
 * --------------------------------------------------------------------------------*/
static uint8_t bgm_sub_eoc(t_bgmcounter *cnt_p, t_bgminfo *bgm_p)
{
	cnt_p++;
	bgm_p++;

	if (cnt_p->bgm_pos > bgm_p->bgmsize) {
		return 1;
	}
	return 0;
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
