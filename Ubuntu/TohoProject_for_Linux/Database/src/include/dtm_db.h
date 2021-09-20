/*
 * Create 2021/08/10
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * Build  gcc
 * debug  gdb
 * -
 * File Process to Comment
 */

#ifndef dtm_db_h   /* prevent circular inclusions */
#define dtm_db_h   /* by using protection macros */

/* 構造体の要素数 */
#define DTM_DB_SIZE ((sizeof (dtmdb))/(sizeof (DtmDB)))

/* 配列の要素数 */
#define FREAD_BUF   (3841)


/*
 * 各モードで使用するBGMを管理
 *
 * id           サウンド番号
 * fileid       外部ROMにアクセスするときに使用するファイルID
 * bgmadr       DRAMのアドレス
 * sound_loop   ループ再生するか判定
 * volume       音量値をビットシフトで行う
 * 
 * SOUND_ID_xxxの定数の数とデータベースの行の数は一致していなければならない
 */
typedef struct
{
    uint32_t id;
    uint32_t fileid;
    uint32_t bgmadr;
    uint8_t  sound_loop;
    uint8_t  volume;
} DtmDB;

static const DtmDB dtmdb[] =
{
    /* BGM */
    {SOUND_ID_TITLE,            FILE_ACCESS_BGM_TITLE,              DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_KAMIGAMI,         FILE_ACCESS_BGM_KAMIGAMI,           DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_MINORIKO,         FILE_ACCESS_BGM_MINORIKO,           DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  11},
    {SOUND_ID_SIZUHA,           FILE_ACCESS_BGM_SIZUHA,             DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_KOGASA,           FILE_ACCESS_BGM_KOGASA,             DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_YUUKA,            FILE_ACCESS_BGM_YUUKA,              DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_REMIRIA,          FILE_ACCESS_BGM_REMIRIA,            DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_SATORI,           FILE_ACCESS_BGM_SATORI,             DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_TENSI,            FILE_ACCESS_BGM_TENSI,              DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_ENDING,           FILE_ACCESS_BGM_ENDING,             DRAM_SOUND_SPARE_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_MURA_1,           FILE_ACCESS_BGM_MURA_1,             DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  11},
    {SOUND_ID_FIELD,            FILE_ACCESS_BGM_FIELD,              DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_FIELD_GEKAI,      FILE_ACCESS_BGM_FIELD_GEKAI,        DRAM_SOUND_FIELD_ADDR_BASE,   SOUND_LOOP_OK,  12},
    {SOUND_ID_BATTLE_DEFAULT,   FILE_ACCESS_BGM_BATTLE_DEFAULT,     DRAM_SOUND_BATTLE_ADDR_BASE,  SOUND_LOOP_OK,  12},
    {SOUND_ID_BATTLE_FANFARE,   FILE_ACCESS_BGM_BATTLE_FANFARE,     DRAM_SOUND_FANFARE_ADDR_BASE, SOUND_LOOP_NON, 12},

    /* ミニゲーム */
    {SOUND_ID_BOMB,             FILE_ACCESS_BGM_BOM,                DRAM_BGM_BOM_ADDR_BASE,                    SOUND_LOOP_NON, 13},
    {SOUND_ID_JUMP,             FILE_ACCESS_BGM_JUMP,               DRAM_BGM_JUMP_ADDR_BASE,                   SOUND_LOOP_NON, 13},
    {SOUND_ID_COIN,             FILE_ACCESS_BGM_COIN,               DRAM_BGM_COIN_ADDR_BASE,                   SOUND_LOOP_NON, 13},
    {SOUND_ID_PITYUN,           FILE_ACCESS_BGM_PITYN,              DRAM_BGM_PITYN_ADDR_BASE,                  SOUND_LOOP_NON, 12},

    /* バトル基本 */
    {SOUND_ID_BATTLE_ENCOUNT,   FILE_ACCESS_BGM_BATTLE_ENCOUNT,     DRAM_BGM_BATTLE_ENCOUNT_ADDR_BASE,         SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_TRUN,      FILE_ACCESS_BGM_BATTLE_TRUN,        DRAM_BGM_BATTLE_TRUN_ADDR_BASE,            SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_DAMEGE,    FILE_ACCESS_BGM_BATTLE_DAMAGE,      DRAM_BGM_BATTLE_DAMAGE_ADDR_BASE,          SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_KNIFE,     FILE_ACCESS_BGM_BATTLE_KNIFE,       DRAM_BGM_BATTLE_KNIFE_ADDR_BASE,           SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_SPEAR,     FILE_ACCESS_BGM_BATTLE_SPEAR,       DRAM_BGM_BATTLE_SPEAR_ADDR_BASE,           SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_PUNCH,     FILE_ACCESS_BGM_BATTLE_PUNCH,       DRAM_BGM_BATTLE_PUNCH_ADDR_BASE,           SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_MISS,      FILE_ACCESS_BGM_BATTLE_MISS,        DRAM_BGM_BATTLE_MISS_ADDR_BASE,            SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_DEFEAT1,   FILE_ACCESS_BGM_BATTLE_DEFEAT1,     DRAM_BGM_BATTLE_DEFEAT1_ADDR_BASE,         SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_DEFEAT2,   FILE_ACCESS_BGM_BATTLE_DEFEAT2,     DRAM_BGM_BATTLE_DEFEAT2_ADDR_BASE,         SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_RUN,       FILE_ACCESS_BGM_BATTLE_RUN,         DRAM_BGM_BATTLE_RUN_ADDR_BASE,             SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_BRAW_1,    FILE_ACCESS_BGM_BATTLE_BRAW_1,      DRAM_BGM_BATTLE_BRAW1_ADDR_BASE,           SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_MAGIC_1,   FILE_ACCESS_BGM_EFFECT_MAGIC_1,     DRAM_BGM_EFFECT_MAGIC_1_ADDR_BASE,         SOUND_LOOP_NON, 13},

    /* ステータス */
    {SOUND_ID_BATTLE_POWER_UP,      FILE_ACCESS_BGM_EFFECT_POWER_UP,    DRAM_BGM_EFFECT_POWER_UP_ADDR_BASE,    SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_POWER_DOWN,    FILE_ACCESS_BGM_EFFECT_POWER_DOWN,  DRAM_BGM_EFFECT_POWER_DOWN_ADDR_BASE,  SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_DEF_1,         FILE_ACCESS_BGM_EFFECT_DEF_1,       DRAM_BGM_EFFECT_DEF_1_ADDR_BASE,       SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_HEST_1,        FILE_ACCESS_BGM_EFFECT_HEST_1,      DRAM_BGM_EFFECT_HEST_1_ADDR_BASE,      SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_SLOW_1,        FILE_ACCESS_BGM_EFFECT_SLOW_1,      DRAM_BGM_EFFECT_SLOW_1_ADDR_BASE,      SOUND_LOOP_NON, 13},

    /* 回復 */
    {SOUND_ID_BATTLE_HEAL_1,    FILE_ACCESS_BGM_EFFECT_HEAL_1,      DRAM_BGM_EFFECT_HEAL_1_ADDR_BASE,          SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_ESNA_1,    FILE_ACCESS_BGM_EFFECT_ESNA_1,      DRAM_BGM_EFFECT_ESNA_1_ADDR_BASE,          SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_RISE_1,    FILE_ACCESS_BGM_EFFECT_RISE_1,      DRAM_BGM_EFFECT_RISE_1_ADDR_BASE,          SOUND_LOOP_NON, 13},

    /* 状態異常 */
    {SOUND_ID_BATTLE_CONFIG_1,  FILE_ACCESS_BGM_EFFECT_CONFIG_1,    DRAM_BGM_EFFECT_CONFIG_1_ADDR_BASE,        SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_POISON_1,  FILE_ACCESS_BGM_EFFECT_POISON_1,    DRAM_BGM_EFFECT_POISON_1_ADDR_BASE,        SOUND_LOOP_NON, 13},
    {SOUND_ID_BATTLE_PARARAI_1, FILE_ACCESS_BGM_EFFECT_PARARAI_1,   DRAM_BGM_EFFECT_PARARAI_1_ADDR_BASE,       SOUND_LOOP_NON, 13},
    
    /* 専用技 */
    {SOUND_ID_BATTLE_KANAKO_8,  FILE_ACCESS_BGM_EFFECT_KANAKO_8,    DRAM_BGM_EFFECT_KANAKO_8_ADDR_BASE,        SOUND_LOOP_NON, 13},

    /* コマンド */
    {SOUND_ID_CMD_ENTER,        FILE_ACCESS_BGM_CMD_ENTER,          DRAM_BGM_CMD_ENTER_ADDR_BASE,              SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_DOOR1,        FILE_ACCESS_BGM_CMD_DOOR1,          DRAM_BGM_CMD_DOOR1_ADDR_BASE,              SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_DOOR2,        FILE_ACCESS_BGM_CMD_DOOR2,          DRAM_BGM_CMD_DOOR2_ADDR_BASE,              SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_CHEST,        FILE_ACCESS_BGM_CMD_CHEST,          DRAM_BGM_CMD_CHEST_ADDR_BASE,              SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_SWITCH,       FILE_ACCESS_BGM_CMD_SWITCH,         DRAM_BGM_CMD_SWITCH_ADDR_BASE,             SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_GOLD,         FILE_ACCESS_BGM_CMD_GOLD,           DRAM_BGM_CMD_GOLD_ADDR_BASE,               SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_KAIDAN,       FILE_ACCESS_BGM_CMD_KAIDAN,         DRAM_BGM_CMD_KAIDANE_ADDR_BASE,            SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_TAKARA,       FILE_ACCESS_BGM_CMD_TAKARA,         DRAM_BGM_CMD_TAKARA_ADDR_BASE,             SOUND_LOOP_NON, 13},
    {SOUND_ID_CMD_SUCCESS,      FILE_ACCESS_BGM_CMD_SUCCESS,        DRAM_BGM_CMD_SUCCESS_ADDR_BASE,            SOUND_LOOP_NON, 14},
    {SOUND_ID_CMD_FAIL,         FILE_ACCESS_BGM_CMD_FAIL,           DRAM_BGM_CMD_FAIL_ADDR_BASE,               SOUND_LOOP_NON, 14},
    {SOUND_ID_CMD_CANSEL,       FILE_ACCESS_BGM_CMD_CANSEL,         DRAM_BGM_CMD_CANSEL_ADDR_BASE,             SOUND_LOOP_NON, 14},

    /* キー入力音 */
    {SOUND_ID_CMD_BUTTON,       FILE_ACCESS_BGM_CMD_SELECT1,        DRAM_BGM_CMD_SELECT1_ADDR_BASE,            SOUND_LOOP_NON, 14},
    {SOUND_ID_CMD_BUTTON2,      FILE_ACCESS_BGM_CMD_SELECT2,        DRAM_BGM_CMD_SELECT2_ADDR_BASE,            SOUND_LOOP_NON, 14},
};


/* データ数を調べたい音源ファイルのパスを記述 */
static const char *filename[] = {
    "./include/MusicSD/effect/button/button.raw"
    
};


/*
 * ver1. 2021/08/21
 * 音源データのバイト数をを出力する
 */
void dtm_rom(void)
{
    FILE *fp = NULL;
    uint32_t bytes;
    uint32_t count = 0;
    char buf[FREAD_BUF];

    for (uint32_t i = 0; i < NUM(filename); i++)
    {
        fp = fopen(filename[i], "r");

        if (fp == NULL)
        {
            fprintf(stderr, "open error %s\n", filename[i]);
            return;
        }

        do
        {
            bytes = fread(buf, 1, FREAD_BUF, fp);

            for (uint32_t i = 0; i < bytes - 1; i = i + 4)
            {
                count++;
            }
        } while (bytes == FREAD_BUF);

        fclose(fp);
        fprintf(stderr, "[%s] bytes = 0x%08x\n", filename[i], count*4);
        count = 0;
    }
}



/*
 * ver1. 2021/08/10
 * サウンドデータ書き出し
 */
void dtm_write(FILE *fp, FILE *byte)
{
	const DtmDB *p = dtmdb;

	for (uint32_t i = 0; i < DTM_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->id);
		fprintf(fp, "0x%08x,\n", p->fileid);
		fprintf(fp, "0x%08x,\n", p->bgmadr);
		fprintf(fp, "0x%08x,\n", p->sound_loop);
		fprintf(fp, "0x%08x,\n", p->volume);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);
	}

    if (DTM_DB_SIZE != SOUND_ID_END)
    {
        printf("--- ERROR --- SOUND_ID_END or DTM_DB_SIZE");
    }

    printf("DTM DB TOTAL NUMBER = %ld, %d\n", DTM_DB_SIZE, SOUND_ID_END);
}


#endif