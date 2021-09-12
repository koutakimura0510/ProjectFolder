#ifndef bitmap_db_h   /* prevent circular inclusions */
#define bitmap_db_h   /* by using protection macros */


/*
 * ver2. 2021/06/27
 * データベースのソースコードを種類ごとに記載するよう変更
 * アクセスIDの命名に種類を付け加えるように変更
 * 
 * ver1.
 * 画像データ管理データベース
 */
typedef struct
{
    uint32_t fileid;
    uint32_t xsize;
    uint32_t ysize;
    char *filename;
    uint32_t *dram_p;
    uint32_t len;
} BitmapDB;

static const BitmapDB bitmap_db[] =
{
    /* キャラチップ */
    {FILE_ACCESS_HERO_CHIP,                     384,    256,   "/Unit/charachip",           DRAM_HERO_ADDR_START,                   FILE_BUFFER_SIZE_HERO                   },
    {FILE_ACCESS_HERO_MINIGAME_CHIP,            384,    128,   "/Unit/select",              DRAM_HERO_MINIGAME_ADDR_START,          FILE_BUFFER_SIZE_MINIGAME_HERO_SELECT   },
    {FILE_ACCESS_HERO_SHADOW_CHIP,               96,    128,   "/Unit/shadow",              DRAM_HERO_SHADOW_ADDR_START,            FILE_BUFFER_SIZE_HERO                   },
    {FILE_ACCESS_HERO_BATTLE_CHIP,              384,    384,   "/Unit/battle_chara",        DRAM_HERO_BATTLE_ADDR_START,            FILE_BUFFER_SIZE_HERO_BATTLE            },
    {FILE_ACCESS_HERO_BATTLE_WAKU,              48,      58,   "/Unit/waku",                DRAM_HERO_WAKU_ADDR_START,              RAW_FILE_STATS + 1                      },

    /* マップのマップチップ */
    {FILE_ACCESS_CHIP_MINIGAME,                 32,     96,    "/Map/chip_minigame",        DRAM_MAPCHIP_MAP_ADDR_START,            FILE_BUFFER_SIZE_CHIP                   },
    {FILE_ACCESS_CHIP_GEKAI,                    512,    1184,  "/Map/chip_gekai",           DRAM_MAPCHIP_MAP_ADDR_START,            FILE_BUFFER_SIZE_CHIP                   },
    {FILE_ACCESS_CHIP_ROMEN_VIRRAGE,            512,    448,   "/Map/chip_romen_virrage",   DRAM_MAPCHIP_MAP_ADDR_START,            FILE_BUFFER_SIZE_CHIP                   },
    {FILE_ACCESS_MAPDATA_BLOCK1,                108,    108,   "/Map/block",                DRAM_BLOCK_DRAW_ADDR_START,             FILE_BUFFER_SIZE_BLOCK                  },

    /* マップデータ */
    {FILE_ACCESS_MAPDATA_MINIGAME,              20,     15,    "/Map/minigame_map",         DRAM_MAPDATA_ADDR_START,                FILE_BUFFER_SIZE_MAPDATA_MINIGAME       },
    {FILE_ACCESS_MAPDATA_GEKAI,                 200,    200,   "/Map/map_gekai",            DRAM_MAPDATA_ADDR_START,                FILE_BUFFER_SIZE_MAPDATA_GEKAI          },
    {FILE_ACCESS_MAPDATA_GEKAI_OBJECT,          200,    200,   "/Map/obj_gekai",            DRAM_MAPDATA_OBJECT_ADDR_START,         FILE_BUFFER_SIZE_MAPDATA_GEKAI          },
    {FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE,         50,     50,    "/Map/map_romen_virrage",    DRAM_MAPDATA_ADDR_START,                FILE_BUFFER_SIZE_MAPDATA_ROMEN_VIRRAGE  },
    {FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT,  50,     50,    "/Map/obj_romen_virrage",    DRAM_MAPDATA_OBJECT_ADDR_START,         FILE_BUFFER_SIZE_MAPDATA_ROMEN_VIRRAGE  },

    /* 背景・アイコン */
    {FILE_ACCESS_BACK_GRASS,                    640,    480,   "/Back/battle_grass",        DRAM_BATTLE_BACK_ADDR_START,            RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_FOG,                      640,    480,   "/Back/fog",                 DRAM_FOG_OBJECT_ADDR_START,             RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_YUUHI,                    640,    480,   "/Back/aozora",              DRAM_BACKGROUND_ADDR_START,             RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_TITLE,                    640,    480,   "/Back/rogo",                DRAM_TITLE_MINIGAME_ADDR_START,         RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_TITLE1,                   640,    480,   "/Back/title1",              DRAM_TITLE_1_ADDR_START,                RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_ICON,                      16,     16,   "/Back/icon",                DRAM_ICON_ADDR_START,                   RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_ICON2,                     30,     34,   "/Back/cursol",              DRAM_ICON_2_ADDR_START,                 RAW_FILE_STATS + 1                      },

    /* エフェクト */
    {FILE_ACCESS_HIT_EFFECT_1,                  1080,   120,   "/Effect/hit1",              DRAM_EFFECT_HITBOX_ADDR_START,          FILE_BUFFER_SIZE_HITBOX                 },
    {FILE_ACCESS_HIT_EFFECT_2,                  2400,   240,   "/Effect/hit2",              DRAM_EFFECT_ADDR_START,                 FILE_BUFFER_SIZE_BOMB                   },
    {FILE_ACCESS_HIT_EFFECT_3,                   960,   120,   "/Effect/hit3",              DRAM_EFFECT_PITYUN_ADDR_START,          FILE_BUFFER_SIZE_PITYUN                 },

    /* バトルエフェクト */
    {FILE_ACCESS_EFFECT_BATTLE_MAGIC_1,    		480,    288,   "/Effect/magic1",            DRAM_EFFECT_BATTLE_MAGIC_1_ADDR_START,      FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_SLASH_1,        1080,    120,   "/Effect/slash1",            DRAM_EFFECT_BATTLE_SLASH_1_ADDR_START,      FILE_BUFFER_SIZE_EFFECT_BATTLE_DEFAULT      },
    {FILE_ACCESS_EFFECT_BATTLE_BROW_1,          600,    240,   "/Effect/blow1",             DRAM_EFFECT_BATTLE_BROW_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_DEFAULT      },
    {FILE_ACCESS_EFFECT_BATTLE_POWER_UP,        480,    288,   "/Effect/power_up",          DRAM_EFFECT_BATTLE_POWER_UP_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_HEAL_1,          480,    288,   "/Effect/heal1",             DRAM_EFFECT_BATTLE_HEAL_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_ESNA_1,          480,    288,   "/Effect/esna1",             DRAM_EFFECT_BATTLE_ESNA_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_RISE_1,          480,    288,   "/Effect/rise1",             DRAM_EFFECT_BATTLE_RISE_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_POISON_1,        480,    288,   "/Effect/poison",            DRAM_EFFECT_BATTLE_POISON_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_POISON_2,        480,    288,   "/Effect/poison2",           DRAM_EFFECT_BATTLE_POISON_2_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_DEATH_1,         480,    288,   "/Effect/death",             DRAM_EFFECT_BATTLE_DEATH_1_ADDR_START,      FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_CONFIG_1,        480,    192,   "/Effect/config",            DRAM_EFFECT_BATTLE_CONFIG_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_PARARAI_1,       480,    192,   "/Effect/pararai",           DRAM_EFFECT_BATTLE_PARARAI_1_ADDR_START,    FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_BUF_1,           480,    288,   "/Effect/buf",               DRAM_EFFECT_BATTLE_BUF_1_ADDR_START,        FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_BERSEK_1,        480,    288,   "/Effect/bersek",            DRAM_EFFECT_BATTLE_BERSEK_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_REFREK_1,        480,    288,   "/Effect/refrek",            DRAM_EFFECT_BATTLE_REFREK_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_ALL_ATTACK_1,    160,   1920,   "/Effect/all_atk1",          DRAM_EFFECT_BATTLE_ALL_ATTACK_1_ADDR_START, FILE_BUFFER_SIZE_EFFECT_BATTLE_ALL_ATTACK   },

    /* フォント */
    {FILE_ACCESS_FONT_SUUZI_1,                  156,    24,    "/Font/font_suuzi",          DRAM_FONT_SCORE_ADDR_START,             FILE_BUFFER_SIZE_FONT_SCORE             },
    {FILE_ACCESS_FONT_RESULT,                   624,    96,    "/Font/font_result",         DRAM_FONT_RESULT_ADDR_START,            FILE_BUFFER_SIZE_FONT_RESULT            },
    {FILE_ACCESS_FONT_SJIS,                     144,   7901,   "/Font/font_sjis",           DRAM_FONT_SJIS_ADDR_START,              FILE_BUFFER_SIZE_FONT_SJIS              },
    {FILE_ACCESS_FONT_DAMEGE,                   104,     16,   "/Font/font_damege",         DRAM_FONT_DAMEGE_ADDR_START,            FILE_BUFFER_SIZE_FONT_DAMEGE            },
    {FILE_ACCESS_FONT_HEAL,                     104,     16,   "/Font/font_heal",           DRAM_FONT_HEAL_ADDR_START,              FILE_BUFFER_SIZE_FONT_DAMEGE            },

    /* NPC */
    {FILE_ACCESS_NPC1,                           96,    128,   "/NPC/npc1",                 DRAM_NPC_1_ADDR_START,                  FILE_BUFFER_SIZE_HERO                   },
    {FILE_ACCESS_NPC2,                           96,    128,   "/NPC/npc2",                 DRAM_NPC_2_ADDR_START,                  FILE_BUFFER_SIZE_HERO                   },

    /* 敵 */
    {FILE_ACCESS_ENEMY_GURL_1,                   89,    134,   "/Enemy/gurl1",              DRAM_ENEMY_1_ADDR_START,                RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_ENEMY_HIYOKO_1,                102,    111,   "/Enemy/hiyoko1",            DRAM_ENEMY_2_ADDR_START,                RAW_FILE_STATS + 1                      },

};


#endif