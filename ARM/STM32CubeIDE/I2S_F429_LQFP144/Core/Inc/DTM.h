/*
 * DTM.h
 *
 *  Created on: Dec 27, 2020
 *      Author: koutakimura
 */

#ifndef INC_DTM_H_
#define INC_DTM_H_

/**-----------------------------------------------------------------------------------
 * 31.25usの間隔で割り込みを行い、出力音源の作成を行う
 * サンプリングレートは 1 / 31.25us = 32kHz、I2Sの設定も同周波数の32kHzで行う
 * 今回使用するDACのPCM5102Aは、入力BCKに合わせて内部でMCLKの生成を行ってくれるので
 * CPUのMCLK出力は行わなくてよい
 * -----------------------------------------------------------------------------------*/


/*--------------------------------------------------
 - 構造体サイズ定義
 ---------------------------------------------------*/
#define BGM_SIZE ((sizeof (bgmstatus))/(sizeof (t_bgmstatus)))


/**-------------------------------------------------
 * 最大和音数
 * -------------------------------------------------*/
#define MAX_MUSICAL_NUMBER		16



/**-------------------------------------------------
 * フィルター係数
 * -------------------------------------------------*/
#define RC_A (0.8f)	//RCフィルタ係数
#define MAV_SIZE  5


/*--------------------------------------------------
 - 周波数計算
 ---------------------------------------------------*/
#define PIS			 (2.0f * PI)
#define SAMPRING_RATE (48000)
#define FREQ_RATE		 (48000.0f)
#define CAL1_0	 	 (1.0f)
#define CAL5_0	 	 (-5.0f)
#define CAL2_0	 	 (2.0f)

/*--------------------------------------------------
 - パラメータ調整
 ---------------------------------------------------*/
#define INIT_GAIN	 	 (300.0f)
#define MAX_GAIN		 (2000.0f)
#define MIN_GAIN		 (0.0f)
#define GAIN_ALIGN	 (10.0f)

#define INIT_RATIO	 (1.0f)
#define MAX_RATIO		 (40.0f)
#define MIN_RATIO		 (0.0f)
#define RATIO_ALIGN	 (0.1f)

#define INIT_OUTLEVEL (1.0f)
#define MAX_OUTLEVEL	 (127.0f)
#define MIN_OUTLEVEL	 (0.0f)
#define OUTLEVEL_ALIGN (0.1f)

#define VELO_ADJUST	 (127.0f)


/*--------------------------------------------------
 - FM音源アルゴリズム2 定数定義
 ---------------------------------------------------*/
#define ML_OP1_AL2	(1.0f)
#define TL_OP1_AL2   ((127.0f - 0.0f) / 127.0f)
#define AR_OP1_AL2	((31.0f - 1.0f) * 5.0f)
#define DR_OP1_AL2	(0.0f)
#define SR_OP1_AL2	(1.0f)
#define RR_OP1_AL2	(0.0f)
#define SL_OP1_AL2	(0.0f)
#define DT_OP1_AL2	(0.0f)

#define ML_OP4_AL2	(1.0f)
#define TL_OP4_AL2   ((127.0f - 0.0f) / 127.0f)
#define AR_OP4_AL2	(31.0f - 28.0f)
#define DR_OP4_AL2	(3100.0f - 1600.0f)
#define SR_OP4_AL2	(1.0f)
#define RR_OP4_AL2	(10.0f)
#define SL_OP4_AL2	(2.0f)
#define DT_OP4_AL2	(0.0f)


/**-------------------------------------------------
 * 楽器のadsr値を管理するデータベース
 * -------------------------------------------------
 * id		: 音源の番号を指定、呼び出す関数でIDを指定し、この番号と一致したデータを取得する
 * ---------
 * a		: Attack time 	鍵盤を押してから音が最大になるまでの時間を指定
 * ------
 * d		: Decay time		音が持続状態に落ち着くまでの時間
 * ------
 * s		: Sustain Level	持続状態における音の大きさを指定
 * ------
 * r		: Release time	鍵盤を離した時の音が鳴り終わるまでの時間
 * -------------------------------------------------*/
typedef struct {
	uint8_t id;
	int32_t a;
	int32_t d;
	float32_t s;
	int32_t r;
} t_adsr_database;

static const t_adsr_database adsr_database[] = {
		{	Piano,			10,		2200,	0.0f,	0	},	// ピアノ系
		{	Percussion,		20,		1800,	0.0f,	0	},	// 鉄筋クロマチック・パーカッション系
		{	Organ,			1,		2800,	0.0f,	0	},	// オルガン系
		{	Guitar,			1,		1300,	0.0f,	0	},	// ギター系
		{	Bass,			1,		1800,	0.0f,	0	},	// ベース系
		{	Strings,		100,	2000,	0.0f,	0	},	// ストリングス系
		{	Ensamble,		10,		2800,	0.0f,	0	},	// アンサンブル系　オーケストラ・ヒット
		{	Brass,			200,	1000,	1.0f,	0	},	// ブラス系
		{	Sax,			200,	2000,	1.0f,	0	},	// リード系　ソプラノ・サックス
		{	Pipe,			1,		2600,	0.0f,	0	},	// パイプ系　ピッコロ・フルート
		{	SyntheSax,		1,		1800,	1.0f,	0	},	// シンセ・リード系　矩形波など
		{	SynthePad,		1,		1800,	0.0f,	0	},	// シンセ・パッド系　ベルなど
		{	SyntheEffect, 	1,		1800,	0.0f,	0	},	// シンセ・エフェクト系
		{	Ethnic,			5,		 800,	0.0f,	0	},	// エスニック系
		{	Percussive,		1,		 400,	0.0f,	0	},	// パーカッシブ系
		{	SoundEffect,	1,		1800,	0.0f,	0	},	// 効果音
};

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
	const uint8_t  *musical;
	const uint8_t  *program_change;
	const uint16_t *delta;
	const uint8_t  *ch;
	const uint8_t  *tone;
	const uint8_t  *velocity;
	const uint16_t bgmsize;
	const uint8_t  chsize;
} t_bgmstatus;

static const t_bgmstatus bgmstatus[] = {
		{	0,  bokurano_musical, bokurano_program_change, bokurano_delta, bokurano_ch, bokurano_tone, bokurano_velocity, NUM(bokurano_tone), NUM(bokurano_musical)},
		{	1,  oharai_musical, oharai_program_change, oharai_delta, oharai_ch,	oharai_tone, oharai_velocity, NUM(oharai_tone), NUM(oharai_musical)},
};


#endif /* INC_DTM_H_ */
