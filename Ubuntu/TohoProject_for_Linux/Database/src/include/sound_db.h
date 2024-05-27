#ifndef sound_db_h   /* prevent circular inclusions */
#define sound_db_h   /* by using protection macros */

typedef struct
{
    uint32_t fileid;
    char *filename;
    uint32_t *dram_p;
    uint32_t len;
} SoundDB;


/*
 * システムの起動時に全て読み込むファイルのデータ
 *
 * データベースに楽曲を追加しt場合は dtm_struct.hに読み込みのパスを追加記入する
 * 容量をモノラル、16bitから8bitにする　-2000 音源末尾のノイズ成分除去
 */
static const SoundDB sound_db[] =
{
    /* ミニゲーム　音源 */
    {FILE_ACCESS_BGM_COIN,              "/Action/200_coin",     DRAM_BGM_COIN_ADDR_START,            (0x0002bc00 >> 2)  },  // 元の音源が22050Hzのため /4とする
    {FILE_ACCESS_BGM_JUMP,              "/Action/203_jump",     DRAM_BGM_JUMP_ADDR_START,            (0x0001b580 >> 2)  },  // 元の音源が22050Hzのため /4とする
    {FILE_ACCESS_BGM_BOM,               "/Action/201_bom",      DRAM_BGM_BOM_ADDR_START,             (0x0009cbc0 >> 2)  },
    {FILE_ACCESS_BGM_PITYN,             "/Action/204_pityun",   DRAM_BGM_PITYN_ADDR_START,           (0x0002d4e4 >> 2)  },

    /* FF コマンド音源 */
    {FILE_ACCESS_BGM_CMD_ENTER,         "/Action/1_enter",      DRAM_BGM_CMD_ENTER_ADDR_START,       (0x00016a80 >> 2) },
    {FILE_ACCESS_BGM_CMD_DOOR1,         "/Action/2_door",       DRAM_BGM_CMD_DOOR1_ADDR_START,       (0x00014500 >> 2) },
    {FILE_ACCESS_BGM_CMD_DOOR2,         "/Action/3_door",       DRAM_BGM_CMD_DOOR2_ADDR_START,       (0x00008980 >> 2) },
    {FILE_ACCESS_BGM_CMD_CHEST,         "/Action/4_chest",      DRAM_BGM_CMD_CHEST_ADDR_START,       (0x00007080 >> 2) },
    {FILE_ACCESS_BGM_CMD_SWITCH,        "/Action/5_switch",     DRAM_BGM_CMD_SWITCH_ADDR_START,      (0x0000c800 >> 2) },
    {FILE_ACCESS_BGM_CMD_GOLD,          "/Action/6_gold",       DRAM_BGM_CMD_GOLD_ADDR_START,        (0x00009f58 >> 2) },
    {FILE_ACCESS_BGM_CMD_SELECT1,       "/Action/7_select",     DRAM_BGM_CMD_SELECT1_ADDR_START,     (0x00006400 >> 2) },
    {FILE_ACCESS_BGM_CMD_SELECT2,       "/Action/8_select",     DRAM_BGM_CMD_SELECT2_ADDR_START,     (0x00005780 >> 2) },
    {FILE_ACCESS_BGM_CMD_COLLAPSE,      "/Action/10_collapse",  DRAM_BGM_CMD_COLLAPSE_ADDR_START,    (0x001f7e80 >> 2) },
    {FILE_ACCESS_BGM_CMD_KAIDAN,        "/Action/11_kaidan",    DRAM_BGM_CMD_COLLAPSE_ADDR_START,    (0x00020d00 >> 2) },
    {FILE_ACCESS_BGM_CMD_TAKARA,        "/Action/205_takara",   DRAM_BGM_CMD_COLLAPSE_ADDR_START,    (0x000191a4 >> 2) },

    /* FF Battle音源 */
    {FILE_ACCESS_BGM_BATTLE_ENCOUNT,    "/Battle/11_encount",   DRAM_BGM_BATTLE_ENCOUNT_ADDR_START,  (0x0003e800 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_TRUN,       "/Battle/2_trun",       DRAM_BGM_BATTLE_TRUN_ADDR_START,     (0x00030700 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_DAMAGE,     "/Battle/3_damage",     DRAM_BGM_BATTLE_DAMAGE_ADDR_START,   (0x00017700 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_KNIFE,      "/Battle/4_knife",      DRAM_BGM_BATTLE_KNIFE_ADDR_START,    (0x0000d480 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_SPEAR,      "/Battle/5_spear",      DRAM_BGM_BATTLE_SPEAR_ADDR_START,    (0x00008980 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_PUNCH,      "/Battle/6_punch",      DRAM_BGM_BATTLE_PUNCH_ADDR_START,    (0x00009600 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_MISS,       "/Battle/7_miss",       DRAM_BGM_BATTLE_MISS_ADDR_START,     (0x00008980 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_DEFEAT1,    "/Battle/8_defeat",     DRAM_BGM_BATTLE_DEFEAT1_ADDR_START,  (0x00024b80 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_DEFEAT2,    "/Battle/9_defeat",     DRAM_BGM_BATTLE_DEFEAT2_ADDR_START,  (0x00086600 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_RUN,        "/Battle/10_run",       DRAM_BGM_BATTLE_RUN_ADDR_START,      (0x00020d00 >> 2)   },
    {FILE_ACCESS_BGM_BATTLE_BRAW_1,     "/Battle/12_braw1",     DRAM_BGM_BATTLE_BRAW1_ADDR_START,    (0x000157c0 >> 2)   },

    /* バトルエフェクト音源 */
    {FILE_ACCESS_BGM_EFFECT_MAGIC_1,    "/Battle/102_magic1",   DRAM_BGM_EFFECT_MAGIC_1_ADDR_START,  (0x000445c0 >> 2)   },
    {FILE_ACCESS_BGM_EFFECT_POWER_UP,   "/Battle/103_power_up", DRAM_BGM_EFFECT_POWER_UP_ADDR_START, (0x00061a80 >> 2)   },
    {FILE_ACCESS_BGM_EFFECT_HEAL_1,     "/Battle/101_heal1",    DRAM_BGM_EFFECT_HEAL_1_ADDR_START,   (0x0005dc00 >> 2)   },
    {FILE_ACCESS_BGM_EFFECT_ESNA_1,     "/Battle/105_esna1",    DRAM_BGM_EFFECT_ESNA_1_ADDR_START,   (0x0006f540 >> 2)   },
    {FILE_ACCESS_BGM_EFFECT_RISE_1,     "/Battle/106_rise1",    DRAM_BGM_EFFECT_RISE_1_ADDR_START,   (0x000a6040 >> 2)   },
    {FILE_ACCESS_BGM_EFFECT_POISON_1,   "/Battle/poison_181",   DRAM_BGM_EFFECT_POISON_1_ADDR_START, (0x00030d40 >> 2)   },
    {FILE_ACCESS_BGM_EFFECT_ALL_ATK_1,  "/Battle/150_all_atk1", DRAM_BGM_EFFECT_ALL_ATK_1_ADDR_START,(0x0006f540 >> 2)   },

    /* バックグラウンド　音源 */
    {FILE_ACCESS_BGM_TITLE,             "/Bgm/title",               DRAM_SOUND_FIELD_ADDR_START,     (0x005d8e00 >> 2) },
    {FILE_ACCESS_BGM_KAMIGAMI,          "/Bgm/kamigami",            DRAM_SOUND_FIELD_ADDR_START,     (0x00c3a6f4 >> 2) },
    {FILE_ACCESS_BGM_MINORIKO,          "/Bgm/minoriko",            DRAM_SOUND_FIELD_ADDR_START,     (0x007f0d00 >> 2) },
    {FILE_ACCESS_BGM_SIZUHA,            "/Bgm/sizuha",              DRAM_SOUND_FIELD_ADDR_START,     (0x00a3c500 >> 2) },
    {FILE_ACCESS_BGM_KOGASA,            "/Bgm/101_kogasa",          DRAM_SOUND_FIELD_ADDR_START,     (0x01203b80 >> 2) },
    {FILE_ACCESS_BGM_ENDING,            "/Bgm/ending",              DRAM_SOUND_BATTLE_ADDR_START,    (0x01263d00 >> 2) },
    {FILE_ACCESS_BGM_MURA_1,            "/Bgm/1_mura",              DRAM_SOUND_FIELD_ADDR_START,     (0x00a8b380 >> 2) },
    {FILE_ACCESS_BGM_FIELD,             "/Bgm/2_inada",             DRAM_SOUND_FIELD_ADDR_START,     (0x00d2d0c0 >> 2) },
    {FILE_ACCESS_BGM_FIELD_GEKAI,       "/Bgm/201_gekai_field",     DRAM_SOUND_FIELD_ADDR_START,     (0x00ca6480 >> 2) },
    {FILE_ACCESS_BGM_BATTLE_DEFAULT,    "/Bgm/100_default_battle",  DRAM_SOUND_BATTLE_ADDR_START,    (0x0106cb00 >> 2) },
    {FILE_ACCESS_BGM_BATTLE_FANFARE,    "/Bgm/800_fanfare",         DRAM_SOUND_FANFARE_ADDR_START,   (0x00203a00 >> 2) },
};


#endif