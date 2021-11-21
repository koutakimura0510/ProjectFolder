/*
 * dtm.c
 *
 *  Created on: Dec 31, 2020
 *      Author: koutakimura
 */

#include <stdlib.h>

#include "../Inc/MYLIB.h"
#define ARM_MATH_CM4
#include "arm_math.h"
#include "arm_const_structs.h"
#include "../Inc/SOUND.h"
#include "../Inc/MIDI.h"
#include "../Inc/DTM.h"


/**-------------------------------------------------
 * bgm再生に必要なデータを核の保存する構造体
 * -------------------------------------------------
 * bgm_pos    : BGMデータの配列を参照する変数
 * -----------
 * time       : 1msカウントアップ用変数
 * -------------------------------------------------*/
typedef struct {
	uint16_t bgm_pos;
	uint16_t time;
	uint16_t envcnt[MAX_MUSICAL_NUMBER];
} t_bgmcounter;


/**-------------------------------------------------
 * BGMのデータを一時保存する構造体
 * -------------------------------------------------*/
typedef struct {
	const uint8_t *musical;
	const uint8_t *program_change;
	const uint16_t *deltatime;
	const uint8_t *ch;
	const uint8_t *tone;
	const uint8_t *velocity;
	uint16_t bgmsize;
	uint8_t  chsize;
	float32_t ch_velo[MAX_MUSICAL_NUMBER];
	float32_t ch_freq[MAX_MUSICAL_NUMBER];
	uint8_t tone_box[MAX_MUSICAL_NUMBER];
	float32_t envlope[MAX_MUSICAL_NUMBER];
	int32_t a[MAX_MUSICAL_NUMBER];
	int32_t d[MAX_MUSICAL_NUMBER];
	float32_t s[MAX_MUSICAL_NUMBER];
	int32_t r[MAX_MUSICAL_NUMBER];
} t_bgminfo;


/**--------------------------------------------------------------------------------
 * 構造体の確保
 * --------------------------------------------------------------------------------*/
volatile static t_bgmcounter bgmcounter = {0, 0};
static t_bgminfo bgminfo;


/**--------------------------------------------------------------------------------
 * ファイル内グローバル変数
 * --------------------------------------------------------------------------------*/
static float32_t offset_gain = INIT_GAIN;
static float32_t fm_level = INIT_RATIO;
static float32_t output_level = INIT_OUTLEVEL;
static uint8_t fil = 0;


/**--------------------------------------------------------------------------------
 * ファイル内関数宣言
 * --------------------------------------------------------------------------------*/
static void bgm_eoc(volatile t_bgmcounter *cnt_p, t_bgminfo *bgm_p);
static float32_t adsr(int32_t n, int32_t a, int32_t d, float32_t s, int32_t r);
static float32_t fm_generate(float32_t ac, float32_t fc, int32_t n, uint8_t type);
static float32_t saw_generate(float32_t freq, int32_t *sawcnt, float32_t gain);
static float32_t white_noize(uint32_t n);
static float32_t rc_filter(float32_t fm_out);
static float32_t mav_filter(float32_t fm_out);


void filter_start(uint8_t n)
{
	fil = n;
}


/**--------------------------------------------------------------------------------
 * ゲインの調整
 * --------------------------------------------------------------------------------*/
void gain_align(char updown)
{
	if (updown == '+') {
		offset_gain += GAIN_ALIGN;
		if (offset_gain > MAX_GAIN) {
			offset_gain = MAX_GAIN;
		}
	}else if (updown == '-') {
		offset_gain -= GAIN_ALIGN;
		if (offset_gain < MIN_GAIN) {
			offset_gain = MIN_GAIN;
		}
	}

	lcd_ascii_flash("GAIN", FONT12_H, FONT12_W, 0, 1);
	lcd_ascii_flash("    ", FONT12_H, (FONT12_W * 5) + 8, 0, 1);
	lcd_hex_flash((int32_t)offset_gain, FONT12_H, (FONT12_W * 5) + 8, 0, 1);
}

/**--------------------------------------------------------------------------------
 * fmの調整
 * --------------------------------------------------------------------------------*/
void fm_align(char updown)
{
	if (updown == '+') {
		fm_level += RATIO_ALIGN;
		if (fm_level > MAX_RATIO) {
			fm_level = MAX_RATIO;
		}
	}else if (updown == '-') {
		fm_level -= RATIO_ALIGN;
		if (fm_level < MIN_RATIO) {
			fm_level = MIN_RATIO;
		}
	}

	lcd_ascii_flash("FM", FONT12_H*2, FONT12_W, 0, 1);
	lcd_ascii_flash("    ", FONT12_H*2, (FONT12_W * 5) + 8, 0, 1);
	lcd_hex_flash((int32_t)(fm_level*10.0f), FONT12_H*2, (FONT12_W * 5) + 8, 0, 1);
}

/**--------------------------------------------------------------------------------
 * アウトプットレベルの調整
 * --------------------------------------------------------------------------------*/
void output_align(char updown)
{
	if (updown == '+') {
		output_level += OUTLEVEL_ALIGN;
		if (output_level > MAX_OUTLEVEL) {
			output_level = MAX_OUTLEVEL;
		}
	}else if (updown == '-') {
		output_level -= OUTLEVEL_ALIGN;
		if (output_level < MIN_OUTLEVEL) {
			output_level = MIN_OUTLEVEL;
		}
	}

	lcd_ascii_flash("OUT", FONT12_H*3, FONT12_W, 0, 1);
	lcd_ascii_flash("    ", FONT12_H*3, (FONT12_W * 5) + 8, 0, 1);
	lcd_hex_flash((int32_t)(output_level*10.0f), FONT12_H*3, (FONT12_W * 5) + 8, 0, 1);
}


/**--------------------------------------------------------------------------------
 * サンプリング周波数の周期で音源の生成を行う
 * タイマーが開始される前に、演奏に使用する楽器のデータを保存しておく。
 * 曲に使用する楽器の数ループを行い、オペレータの計算結果を足し合わせた音データを出力する。
 * --------------------------------------------------------------------------------*/
uint32_t wave_smpling(void)
{
	t_bgminfo *p = &bgminfo;
	static float32_t fm_out = 0.0f;
	static int32_t n = 0;
	static uint8_t i = 0;
	static uint8_t pos = 0;

	fm_out = 0.0f;

	for (i = 0; i < p->chsize; i++) {
		pos = p->program_change[i];
		fm_out += fm_generate(p->ch_velo[pos] * p->envlope[pos], p->ch_freq[pos], n, p->musical[i]);
	}
	n++;

	if (n == SAMPRING_RATE) {
		n = 0;
	}

	return fm_out;

/*	static uint32_t n = 0;
	static uint16_t d = 0;

	d = Before_48000_raw[n];
	n++;

	if (n == Before_48000_raw_len) {
		n = 0;
	}

	return d * 10;
*/
}


/**--------------------------------------------------------------------------------
 * 音源データを参照する変数を更新する関数
 *
 * タイマの値がデルタタイムの時間を過ぎていたら、音源参照用の変数を更新する
 * 次に鳴らす音源が和音かチェックをし、和音の数だけループを行う変数を更新する
 * --------------------------------------------------------------------------------*/
void music_update(void)
{
	volatile t_bgmcounter *cnt_p = &bgmcounter;
	t_bgminfo *bgm_p = &bgminfo;
	uint16_t pos;
	uint8_t i, ch, chord;

	bgm_eoc(cnt_p, bgm_p);

	for (i = 0; i < bgm_p->chsize; i++) {
		pos = bgm_p->program_change[i];
		bgm_p->envlope[pos] = adsr(cnt_p->envcnt[pos], bgm_p->a[pos], bgm_p->d[pos], bgm_p->s[pos], bgm_p->r[pos]);
	}

	if (cnt_p->time > bgm_p->deltatime[cnt_p->bgm_pos]) {
		for (i = 0; i < MAX_MUSICAL_NUMBER; i++) {
			if (bgm_p->deltatime[++cnt_p->bgm_pos] != 0) {	// 次のデルタタイムまでデータ読み込み
				break;
			}
		}
		pos = cnt_p->bgm_pos - i - 1;
		chord = i + 1;	// 和音数を取得

		for (i = 0; i < chord; i++) {
			ch = bgm_p->ch[pos];
			bgm_p->ch_velo[ch] = (float32_t)bgm_p->velocity[pos] / VELO_ADJUST;
			bgm_p->ch_freq[ch] = bgm_freq[bgm_p->tone[pos]];

			if (bgm_p->velocity[pos] == 0) {
				cnt_p->envcnt[ch] = 0;
			}
			pos++;
			cnt_p->time = 0;
		}
	}
}


/**--------------------------------------------------------------------------------
 * 音源データを参照する変数を更新する関数
 *
 * タイマの値がデルタタイムの時間を過ぎていたら、音源参照用の変数を更新する
 * 次に鳴らす音源が和音かチェックをし、和音の数だけループを行う変数を更新する
 * --------------------------------------------------------------------------------*/
void music_timer_cnt(void)
{
	volatile t_bgmcounter *p = &bgmcounter;
	t_bgminfo *bgm_p = &bgminfo;
	static uint8_t i = 0;

	p->time++;

	for (i = 0; i < bgm_p->chsize; i++) {
		p->envcnt[bgm_p->program_change[i]]++;
	}
}


/**------------------------------------------------------------------------------
 * 音源データのステータスを取得する
 * ------------------------------------------------------------------------------
 * id:ヘッダーファイル定義してあるIDを指定する
 * ------------------------------------------------------------------------------*/
void music_set_info(uint8_t id)
{
	t_bgminfo *bgm_p = &bgminfo;
	const t_bgmstatus *p = bgmstatus;
	const t_adsr_database *adsr_p = adsr_database;
	const t_adsr_database *oldp = adsr_database;

	for (uint8_t i = 0; i < BGM_SIZE; i++, p++) {
		if (p->id == id) {
			break;
		}
	}

	bgm_p->musical = p->musical;
	bgm_p->program_change = p->program_change;
	bgm_p->deltatime = p->delta;
	bgm_p->ch 		 = p->ch;
	bgm_p->tone 	 = p->tone;
	bgm_p->velocity  = p->velocity;
	bgm_p->bgmsize   = p->bgmsize;
	bgm_p->chsize    = p->chsize;

	for (uint8_t i = 0; i < bgm_p->chsize; i++) {
		for (uint8_t j = 0; j < MAX_MUSICAL_NUMBER; j++, adsr_p++) {
			if (adsr_p->id == bgm_p->musical[i]) {
				break;
			}
		}
		bgm_p->a[bgm_p->program_change[i]] = adsr_p->a;
		bgm_p->d[bgm_p->program_change[i]] = adsr_p->d;
		bgm_p->s[bgm_p->program_change[i]] = adsr_p->s;
		bgm_p->r[bgm_p->program_change[i]] = adsr_p->r;
		adsr_p = oldp;
	}
}


/**--------------------------------------------------------------------------------
 * メイン音源が最後の演奏データに達したかチェックを行い、配列のサイズ数を変数の値が超えていたら
 * メインとサブの配列参照用の変数をクリアする
 * --------------------------------------------------------------------------------*/
static void bgm_eoc(volatile t_bgmcounter *cnt_p, t_bgminfo *bgm_p)
{
	if (cnt_p->bgm_pos > bgm_p->bgmsize) {
		cnt_p->bgm_pos = 0;
	}
}


/**--------------------------------------------------------------------------------
 * ADSR処理
 * --------------------------------------------------------------------------------
 * n	: 1msでカウントアップしている変数の値を指定
 * ------
 * a	: Attack time 	鍵盤を押してから音が最大になるまでの時間を指定
 * ------
 * d	: Decay time	音が持続状態に落ち着くまでの時間
 * ------
 * s	: Sustain Level	持続状態における音の大きさを指定
 * ------
 * r	: Release time	鍵盤を離した時の音が鳴り終わるまでの時間
 * --------------------------------------------------------------------------------*/
static float32_t adsr(int32_t n, int32_t a, int32_t d, float32_t s, int32_t r)
{
	if ((a != 0) && (n < a)) {
		return CAL1_0 - expf(CAL5_0 * n / a);		//アタックからディケイまでの処理
	}

	return	s + (CAL1_0 - s) * expf(CAL5_0 * (n - a) / d);		//ディケイからサスティンまでの処理
}


/**--------------------------------------------------------------------------------
 * FM音源の生成
 * 波形(キャリア)を変調(モジュレータ)することによって様々な音源データを生成する
 * 標準の周波数比率は fc:fm = 1:1、 1:3.5などにすると金属音みたいになる
 * --------------------------------------------------------------------------------
 * FM(t) = Asin(2πfct + Bsin(2πfmt))
 * A :キャリア振幅
 * fc:キャリア周波数
 * B :変調指数
 * fm;モジュレータ周波数
 * --------------------------------------------------------------------------------
 * ac		: キャリア振幅		振幅の調整に使用する
 * ---------
 * fc		: キャリア周波数		モジュレーションを行う周波数帯を指定
 * ---------
 * n		: サンプリング周期でカウントアップしている変数の値を指定
 * ---------
 * type	: 楽器を選択
 * --------- 
 * return	: オペレータの計算結果を取得
 * --------------------------------------------------------------------------------*/
static float32_t fm_generate(float32_t ac, float32_t fc, int32_t n, uint8_t type)
{
	static float32_t modulator = 0.0f;
	static float32_t ope = 0.0f;

	if (ac == 0.0f) {
		return 0.0f;
	}

//	if ((type != Sax) && (type != Guitar)) {
//		return 0.0f;
//	}

	switch (type) {
		case Piano:
			modulator = ac * arm_sin_f32((PIS * fc * n) / FREQ_RATE);
			modulator = ac * output_level * arm_sin_f32(((PIS * fc * fm_level * n) / FREQ_RATE) + modulator);
			ope = ac * arm_sin_f32(((PIS * fc * fm_level * n) / FREQ_RATE) + modulator);
			ope = ope + (ac * arm_sin_f32((PIS * fc * n) / FREQ_RATE));
			ope = ((ope * offset_gain) + offset_gain);
			break;

		case Percussion:
			ope = 0.0f;
			break;

		case Organ:
			modulator = ac * arm_sin_f32((PIS * fc * n) / FREQ_RATE);
			modulator = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = ope + (ac * arm_sin_f32((PIS * fc * n) / FREQ_RATE));
			ope = ((ope * offset_gain) + offset_gain);
			break;

		case Guitar:
			modulator = 0.8f * arm_sin_f32((PIS * fc * 6.5f * n) / FREQ_RATE);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = (ope * offset_gain) + offset_gain;
			break;

		case Bass:
			modulator = 2.5f * arm_sin_f32((PIS * fc * 2.0f * n) / FREQ_RATE);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator) * 2.0f;
			ope = (ope * offset_gain) + offset_gain;
			break;

		case Strings:
			modulator = 3.0f * arm_sin_f32((PIS * fc * 1.5f * n) / FREQ_RATE);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = (ope * offset_gain) + offset_gain;
			break;

		case Ensamble:
			modulator = arm_sin_f32((PIS * fc * 5.0f * n) / FREQ_RATE);
			modulator = 55.0f * arm_sin_f32(((PIS * fc * 115.0f * n) / FREQ_RATE) + modulator);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = (ope * offset_gain) + offset_gain;
			break;

		case Brass:
			modulator = arm_sin_f32((PIS * fc * n) / FREQ_RATE);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = (ope * offset_gain) + offset_gain;
			break;

		case Sax:
			modulator = output_level * arm_sin_f32((PIS * fc * fm_level * n) / FREQ_RATE);
			modulator = arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope += ac * arm_sin_f32((PIS * fc*2.0f * n) / FREQ_RATE);
			ope = (ope * offset_gain) + offset_gain;
			break;

		case Pipe:
			modulator = 3.0f * arm_sin_f32((PIS * fc * n) / FREQ_RATE);
			ope = ac * arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = ((ope * offset_gain) + offset_gain) * 1.5f;
			break;

		case SyntheSax:
			modulator = arm_sin_f32((PIS * fc * n) / FREQ_RATE);
			modulator = arm_sin_f32(((PIS * fc * n) / FREQ_RATE) + modulator);
			ope = ac * arm_sin_f32(((PIS * fc * 0.5f * n) / FREQ_RATE) + modulator) * 0.5f;
			ope = (ope * offset_gain) + offset_gain;
			break;

		case SynthePad:
			ope = 0.0f;
			break;

		case SyntheEffect:
			ope = 0.0f;
			break;

		case Ethnic:
			ope = 0.0f;
			break;

		case Percussive:
			ope = 0.0f;
			break;

		case SoundEffect:
			ope = 0.0f;
			break;

		default:
			ope = 0.0f;
			break;
	}

	return ope;
}


/**--------------------------------------------------------------------------------
 * ノコギリ波 SAWの生成
 * トランペットみたいな音が鳴る
 * --------------------------------------------------------------------------------
 * freq	:音階の周波数を指定
 * ---------
 * *sawcnt	:サンプリングの周期でカウントアップしている変数のアドレスを指定
 * ---------
 * return	:音階の周波数に応じたノコギリ波の計算結果
 * --------------------------------------------------------------------------------*/
static float32_t saw_generate(float32_t freq, int32_t *sawcnt, float32_t gain)
{
	float32_t d;

	freq = FREQ_RATE / freq;
	d = ((CAL1_0 - (CAL2_0 * (float32_t)*sawcnt) / freq));

	if (*sawcnt >= freq) {
		*sawcnt = 0;
	}

	return d * gain;
}


/**--------------------------------------------------------------------------------
 * 白色雑音の生成
 * --------------------------------------------------------------------------------*/
static float32_t white_noize(uint32_t n)
{
	float32_t noize;
	float32_t te = FREQ_RATE;

	noize = (float32_t)rand() / RAND_MAX * CAL2_0 - CAL1_0;

	if (n < te) {
		noize *= ((float32_t)n / te);
	}else{
		noize *= (CAL1_0 - (((float32_t)n - te) / te));
	}

	return noize * 2000.0f;
}


/**--------------------------------------------------------------------------------
 * RCフィルターの生成
 * y[i] = A * y[i-1] + (1-A) * x[i]
 * --------------------------------------------------------------------------------
 * Aは係数、iは出力値
 * --------------------------------------------------------------------------------*/
static float32_t rc_filter(float32_t fm_out)
{
	static float32_t old = 0.0f;

	old = (RC_A * old) + ((1.0f - RC_A) * fm_out);

	return old;
}


/**--------------------------------------------------------------------------------
 * 移動平均フィルタの生成
 * --------------------------------------------------------------------------------*/
static float32_t mav_filter(float32_t fm_out)
{
	static float32_t x[20] = {0.0f};
	static float32_t out = 0.0f;

	x[MAV_SIZE] = fm_out;
	out = 0.0f;

	for (uint8_t i = 0; i < MAV_SIZE; i++) {
		x[i] = x[i+1];
		out += x[i];
	}

	return out/(float32_t)MAV_SIZE;
}

