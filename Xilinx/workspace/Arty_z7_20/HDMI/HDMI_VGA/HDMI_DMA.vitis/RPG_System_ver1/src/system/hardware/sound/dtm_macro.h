#ifndef dtm_macro_h   /* prevent circular inclusions */
#define dtm_macro_h   /* by using protection macros */


/*
 * GP_AUDIO_DATA
 * 32bit固定、音源データをFPGAに送信
 * 
 * GP_STATUS
 * 32bit固定、データの取得状況と音量調整のデータを送信
 * 
 * GP_RESPONSE
 * FPGAが音源データを保存したか確認を行うポート
 */
#define GP_AUDIO_DATA	*((volatile uint32_t *)(XPAR_SIMPLE_ADDER_0_S00_AXI_BASEADDR))
#define GP_STATUS		*((volatile uint32_t *)(XPAR_SIMPLE_ADDER_1_S00_AXI_BASEADDR))
#define GP_RESPONSE		*((volatile uint32_t *)(XPAR_GPIO_1_BASEADDR))


/*
 * 受信完了bitの位置を定義
 * FPGA側のリングバッファサイズ変更を行った時にBit位置の変更を行うこと
 */
#define RESPONSE_BIT_POS	(0x00000020)			//リングバッファのサイズを2の乗数に設定
#define WP_BIT_LENGTH		(RESPONSE_BIT_POS - 1)	//モノラルで音源再生を行う時に使用、LRチャンネルの判定に使う
#define SOUND_DATA_SEND_OK	(0x00000001)			//FPGAに音源データを送信完了したか判定するbit
#define RESPONSE_REV_OK		(0x00000000)			//FPGAが音源データを受信したか判定する
#define EVEN_CHECK			(0x01)



/*
 * 同時再生音源数
 */
#define SOUND_PLAY_NUMBER (4)


/*
 * 移動平均フィルタ数
 * フィルタ数を大きくしすぎると常時ビブラートが
 * かかったようになるので気を付けること
 */
#define FILTER_SHIFT		(2)
#define FILTER_BUFFER_SIZE	(1 << FILTER_SHIFT)
#define FILTER_BUFFER_MASK	(FILTER_BUFFER_SIZE - 1)


/*
 * ver1. 2021/08/10
 * ループ再生のonoff
 */
#define SOUND_LOOP_OK	(1)
#define SOUND_LOOP_NON	(0)


/*
 * 音源再生チャンネル指定
 */
typedef enum
{
    SOUND_CH_BGM_WORK,
    SOUND_CH_KEY_WORK,
    SOUND_CH_EFFECT1_WORK,
    SOUND_CH_EFFECT2_WORK,
} DtmWorkID;


/*
 * BGM再生番号
 */
typedef enum
{
	/* BGM系統 */
	SOUND_ID_TITLE,
	SOUND_ID_KAMIGAMI,
	SOUND_ID_MINORIKO,
	SOUND_ID_SIZUHA,
	SOUND_ID_KANAKO,
	SOUND_ID_KOGASA,
	SOUND_ID_YUUKA,
	SOUND_ID_REMIRIA,
	SOUND_ID_SATORI,
	SOUND_ID_TENSI,
	SOUND_ID_ENDING,
	SOUND_ID_MURA_1,

	/* ワールドマップBGM */
	SOUND_ID_FIELD,
	SOUND_ID_FIELD_GEKAI,

	/* バトルBGM */
	SOUND_ID_BATTLE_DEFAULT,
	SOUND_ID_BATTLE_FANFARE,

	/* エフェクト系統 */
	SOUND_ID_BOMB,
	SOUND_ID_JUMP,
	SOUND_ID_COIN,
	SOUND_ID_PITYUN,

	/* 戦闘基本効果音 */
	SOUND_ID_BATTLE_ENCOUNT,
	SOUND_ID_BATTLE_TRUN,
	SOUND_ID_BATTLE_DAMEGE,
	SOUND_ID_BATTLE_KNIFE,
	SOUND_ID_BATTLE_SPEAR,
	SOUND_ID_BATTLE_PUNCH,
	SOUND_ID_BATTLE_MISS,
	SOUND_ID_BATTLE_DEFEAT1,
	SOUND_ID_BATTLE_DEFEAT2,
	SOUND_ID_BATTLE_RUN,
	SOUND_ID_BATTLE_BRAW_1,
	SOUND_ID_BATTLE_MAGIC_1,

	/* ステータス */
	SOUND_ID_BATTLE_POWER_UP,
	SOUND_ID_BATTLE_POWER_DOWN,
	SOUND_ID_BATTLE_DEF_1,
	SOUND_ID_BATTLE_HEST_1,
	SOUND_ID_BATTLE_SLOW_1,

	/* 回復 */
	SOUND_ID_BATTLE_HEAL_1,
	SOUND_ID_BATTLE_ESNA_1,
	SOUND_ID_BATTLE_RISE_1,

	/* 状態異常 */
	SOUND_ID_BATTLE_CONFIG_1,
	SOUND_ID_BATTLE_POISON_1,
	SOUND_ID_BATTLE_PARARAI_1,

	/* 専用技 */
	SOUND_ID_BATTLE_KANAKO_8,
	//SOUND_ID_BATTLE_REMIRIA_7,	def1と同じ効果音にする


	/* アクション効果音 */
	SOUND_ID_CMD_ENTER,
	SOUND_ID_CMD_DOOR1,
	SOUND_ID_CMD_DOOR2,
	SOUND_ID_CMD_CHEST,
	SOUND_ID_CMD_SWITCH,
	SOUND_ID_CMD_GOLD,
	SOUND_ID_CMD_KAIDAN,
	SOUND_ID_CMD_TAKARA,
	SOUND_ID_CMD_SUCCESS,
	SOUND_ID_CMD_FAIL,
	SOUND_ID_CMD_CANSEL,

	/* キー入力系統 */
	SOUND_ID_CMD_BUTTON,
	SOUND_ID_CMD_BUTTON2,

	SOUND_ID_END,
} DtmIDNumber;


#endif
