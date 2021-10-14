/*
 * Create 2021/07/06
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * IC      XC7Z020-1CLG400C
 * ROM     256KB
 * RAM     512KB
 * L1Cache 32KB
 * -
 * 外部ROMに保存しているファイルデータの取り扱いを管理するデータベースファイル
 */

#ifndef rom_db_struct_h   /* prevent circular inclusions */
#define rom_db_struct_h   /* by using protection macros */


/*
 * ファイル構造体の要素数
 */
#define BITMAP_DB_SIZE          ((sizeof (bitmap_db)) / (sizeof (BitmapDB)))
#define BGM_DB_SIZE             ((sizeof(sound_db)) / (sizeof(SoundDB)))
#define FILE_SYSTEM_DB_SIZE     ((sizeof(system_file)) / (sizeof(SystemFile)))
#define FILE_SYSTEM_LENGTH_SIZE ((sizeof(system_length)) / (sizeof(SystemLength)))


/*
 * マップファイルのサイズを管理
 *
 * total_width  : 画像の最大横幅を保存
 * total_height : 画像の最大縦幅を保存
 */
typedef struct
{
    uint32_t map_width;
    uint32_t map_height;
} MapSize_DB;


/*
 * 作業領域
 */
typedef struct
{
    uint32_t xsize;
    uint32_t ysize;
    char *filename;
    uint32_t *dram_p;
    uint32_t len;
} BitmapWork;


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
    {FILE_ACCESS_HERO_SHADOW_CHIP,               96,    128,   "/Unit/shadow",              DRAM_HERO_SHADOW_ADDR_START,            FILE_BUFFER_SIZE_HERO                   },
    {FILE_ACCESS_HERO_BATTLE_CHIP,              384,    384,   "/Unit/battle_chara",        DRAM_HERO_BATTLE_ADDR_START,            FILE_BUFFER_SIZE_HERO_BATTLE            },
    {FILE_ACCESS_HERO_BATTLE_WAKU,              48,      58,   "/Unit/waku",                DRAM_HERO_WAKU_ADDR_START,              RAW_FILE_STATS + 1                      },

    /* マップのマップチップデータ */
    {FILE_ACCESS_CHIP_MINIGAME,                 32,     128,   "/Map/chip_minigame",        DRAM_MINIGAME_FRAME_ADDR_START,         FILE_BUFFER_SIZE_CHIP                   },
    {FILE_ACCESS_CHIP_GEKAI,                    512,    1184,  "/Map/chip_gekai",           DRAM_MAPCHIP_MAP_ADDR_START,            FILE_BUFFER_SIZE_CHIP                   },
    {FILE_ACCESS_CHIP_ROMEN_VIRRAGE,            512,    448,   "/Map/chip_romen_virrage",   DRAM_MAPCHIP_MAP_ADDR_START,            FILE_BUFFER_SIZE_CHIP                   },
    {FILE_ACCESS_MAPDATA_BLOCK1,                 96,     96,   "/Map/block",                DRAM_BLOCK_DRAW_ADDR_START,             FILE_BUFFER_SIZE_BLOCK                  },

    /* マップデータ */
    {FILE_ACCESS_MAPDATA_MINIGAME,              20,     15,    "/Map/minigame_map",         DRAM_MAPDATA_ADDR_START,                FILE_BUFFER_SIZE_MAPDATA_MINIGAME       },
    {FILE_ACCESS_MAPDATA_GEKAI,                 200,    200,   "/Map/map_gekai",            DRAM_MAPDATA_ADDR_START,                FILE_BUFFER_SIZE_MAPDATA_GEKAI          },
    {FILE_ACCESS_MAPDATA_GEKAI_OBJECT,          200,    200,   "/Map/obj_gekai",            DRAM_MAPDATA_OBJECT_ADDR_START,         FILE_BUFFER_SIZE_MAPDATA_GEKAI          },
    {FILE_ACCESS_MAPDATA_GEKAI_REGION,          200,    200,   "/Map/region_gekai",         DRAM_MAPDATA_REGION_ADDR_START,         FILE_BUFFER_SIZE_MAPDATA_GEKAI          },
    {FILE_ACCESS_MAPDATA_GEKAI_NPC,             200,    200,   "/Map/npc_gekai",            DRAM_MAPDATA_NPC_ADDR_START,            FILE_BUFFER_SIZE_MAPDATA_GEKAI          },
    {FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE,         50,     50,    "/Map/map_romen_virrage",    DRAM_MAPDATA_ADDR_START,                FILE_BUFFER_SIZE_MAPDATA_ROMEN_VIRRAGE  },
    {FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_OBJECT,  50,     50,    "/Map/obj_romen_virrage",    DRAM_MAPDATA_OBJECT_ADDR_START,         FILE_BUFFER_SIZE_MAPDATA_ROMEN_VIRRAGE  },
    {FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_REGION,  50,     50,    "/Map/region_romen_virrage", DRAM_MAPDATA_REGION_ADDR_START,         FILE_BUFFER_SIZE_MAPDATA_ROMEN_VIRRAGE  },
    {FILE_ACCESS_MAPDATA_ROMEN_VIRRAGE_NPC,     50,     50,    "/Map/npc_romen_virrage",    DRAM_MAPDATA_NPC_ADDR_START,            FILE_BUFFER_SIZE_MAPDATA_ROMEN_VIRRAGE  },

    /* 背景・アイコン */
    {FILE_ACCESS_BACK_GRASS,                    640,    480,   "/Back/battle_grass",        DRAM_BATTLE_BACK_ADDR_START,            RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_FOG,                      640,    480,   "/Back/fog",                 DRAM_FOG_OBJECT_ADDR_START,             RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_YUUHI,                    640,    480,   "/Back/aozora",              DRAM_BACKGROUND_ADDR_START,             RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_TITLE,                    640,    480,   "/Back/rogo",                DRAM_TITLE_MINIGAME_ADDR_START,         RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_TITLE1,                   640,    480,   "/Back/title1",              DRAM_TITLE_1_ADDR_START,                RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_ICON,                      16,     16,   "/Back/icon",                DRAM_ICON_ADDR_START,                   RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_BACK_ICON2,                     30,     34,   "/Back/cursol",              DRAM_ICON_2_ADDR_START,                 RAW_FILE_STATS + 1                      },

    /* ミニゲームエフェクト */
    {FILE_ACCESS_HIT_EFFECT_1,                  1080,   120,   "/Effect/hit1",              DRAM_EFFECT_HITBOX_ADDR_START,          FILE_BUFFER_SIZE_HITBOX                 },
    {FILE_ACCESS_HIT_EFFECT_2,                   960,   576,   "/Effect/bomb",              DRAM_EFFECT_ADDR_START,                 FILE_BUFFER_SIZE_BOMB                   },
    {FILE_ACCESS_HIT_EFFECT_3,                   960,   120,   "/Effect/hit3",              DRAM_EFFECT_PITYUN_ADDR_START,          FILE_BUFFER_SIZE_PITYUN                 },

    /* バトルエフェクト */
    {FILE_ACCESS_EFFECT_BATTLE_MAGIC_1,    		480,    288,   "/Effect/magic1",            DRAM_EFFECT_BATTLE_MAGIC_1_ADDR_START,      FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_SLASH_1,        1080,    120,   "/Effect/slash1",            DRAM_EFFECT_BATTLE_SLASH_1_ADDR_START,      FILE_BUFFER_SIZE_EFFECT_BATTLE_DEFAULT      },
    {FILE_ACCESS_EFFECT_BATTLE_BROW_1,          600,    240,   "/Effect/blow1",             DRAM_EFFECT_BATTLE_BROW_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_DEFAULT      },

    /* ステータス操作 */
    {FILE_ACCESS_EFFECT_BATTLE_POWER_UP,        480,    288,   "/Effect/power_up",          DRAM_EFFECT_BATTLE_POWER_UP_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_POWER_DOWN,      480,    288,   "/Effect/power_down",        DRAM_EFFECT_BATTLE_POWER_DOWN_ADDR_START,   FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_POWER_DOWN_2,    480,    288,   "/Effect/power_down2",       DRAM_EFFECT_BATTLE_POWER_DOWN_2_ADDR_START, FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_DEF_1,           480,    288,   "/Effect/def1",              DRAM_EFFECT_BATTLE_DEF_1_ADDR_START,        FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_RES_1,           480,    288,   "/Effect/res1",              DRAM_EFFECT_BATTLE_RES_1_ADDR_START,        FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_HEST_1,          480,    288,   "/Effect/hest1",             DRAM_EFFECT_BATTLE_HEST_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_SLOW_1,          480,    384,   "/Effect/slow1",             DRAM_EFFECT_BATTLE_SLOW_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },

    /* 回復 */
    {FILE_ACCESS_EFFECT_BATTLE_HEAL_1,          480,    288,   "/Effect/heal1",             DRAM_EFFECT_BATTLE_HEAL_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_ESNA_1,          480,    288,   "/Effect/esna1",             DRAM_EFFECT_BATTLE_ESNA_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_RISE_1,          480,    288,   "/Effect/rise1",             DRAM_EFFECT_BATTLE_RISE_1_ADDR_START,       FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },

    /* 状態異常 */
    {FILE_ACCESS_EFFECT_BATTLE_CONFIG_1,        480,    288,   "/Effect/config1",           DRAM_EFFECT_BATTLE_CONFIG_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_POISON_1,        480,    288,   "/Effect/poison1",           DRAM_EFFECT_BATTLE_POISON_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_PARARAI_1,       480,    384,   "/Effect/pararai1",          DRAM_EFFECT_BATTLE_PARARAI_1_ADDR_START,    FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_BERSEK_1,        480,    288,   "/Effect/bersek1",           DRAM_EFFECT_BATTLE_BERSEK_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_RIGENE_1,        480,    288,   "/Effect/rigene1",           DRAM_EFFECT_BATTLE_RIGENE_1_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_DEATH_1,         480,    288,   "/Effect/death1",            DRAM_EFFECT_BATTLE_DEATH_1_ADDR_START,      FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },

    /* ループ系 */
    {FILE_ACCESS_EFFECT_BATTLE_POISON_2,        480,    288,   "/Effect/poison2",           DRAM_EFFECT_BATTLE_POISON_2_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_CONFIG_2,        480,    192,   "/Effect/config2",           DRAM_EFFECT_BATTLE_CONFIG_2_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_PARARAI_2,       480,    192,   "/Effect/pararai2",          DRAM_EFFECT_BATTLE_PARARAI_2_ADDR_START,    FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_BUF_2,           480,    288,   "/Effect/buf2",              DRAM_EFFECT_BATTLE_BUF_2_ADDR_START,        FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_BERSEK_2,        480,    288,   "/Effect/bersek2",           DRAM_EFFECT_BATTLE_BERSEK_2_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_REFREK_2,        480,    288,   "/Effect/refrek2",           DRAM_EFFECT_BATTLE_REFREK_2_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },
    {FILE_ACCESS_EFFECT_BATTLE_RIGENE_2,        480,    192,   "/Effect/rigene2",           DRAM_EFFECT_BATTLE_RIGENE_2_ADDR_START,     FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION    },

    /* 専用技 */
    {FILE_ACCESS_EFFECT_BATTLE_KANAKO_8,       3200,   1920,   "/Effect/e_kanako_8",        DRAM_EFFECT_KANAKO_8_ADDR_START,            FILE_BUFFER_SIZE_EFFECT_BATTLE_ALL_ATTACK   },
    {FILE_ACCESS_EFFECT_BATTLE_REMIRIA_7,       480,    384,   "/Effect/e_remiria_7",       DRAM_EFFECT_REMIRIA_7_ADDR_START,           FILE_BUFFER_SIZE_EFFECT_BATTLE_CONDITION   },

    /* フォント */
    {FILE_ACCESS_FONT_SUUZI_1,                  156,    24,    "/Font/font_suuzi",          DRAM_FONT_SCORE_ADDR_START,             FILE_BUFFER_SIZE_FONT_SCORE             },
    {FILE_ACCESS_FONT_RESULT,                   624,    96,    "/Font/font_result",         DRAM_FONT_RESULT_ADDR_START,            FILE_BUFFER_SIZE_FONT_RESULT            },
    {FILE_ACCESS_FONT_SJIS,                     144,   7901,   "/Font/font_sjis",           DRAM_FONT_SJIS_ADDR_START,              FILE_BUFFER_SIZE_FONT_SJIS              },
    {FILE_ACCESS_FONT_DAMEGE,                   104,     16,   "/Font/font_damege",         DRAM_FONT_DAMEGE_ADDR_START,            FILE_BUFFER_SIZE_FONT_DAMEGE            },
    {FILE_ACCESS_FONT_HEAL,                     104,     16,   "/Font/font_heal",           DRAM_FONT_HEAL_ADDR_START,              FILE_BUFFER_SIZE_FONT_DAMEGE            },

    /* NPC */
    {FILE_ACCESS_NPC_WORLD,                     192,    128,   "/NPC/npc_world",            DRAM_NPC_WORLD_ADDR_START,              FILE_BUFFER_SIZE_HERO                   },

    /* 敵 */
    {FILE_ACCESS_ENEMY_GURL_1,                   89,    134,   "/Enemy/gurl1",              DRAM_ENEMY_1_ADDR_START,                RAW_FILE_STATS + 1                      },
    {FILE_ACCESS_ENEMY_HIYOKO_1,                102,    111,   "/Enemy/hiyoko1",            DRAM_ENEMY_2_ADDR_START,                RAW_FILE_STATS + 1                      },

};


/*
 * 音源データ管理
 *
 * fileid       アクセスID
 * *filename    ファイル名
 * *dram_p      DRAMの保存アドレス
 */
typedef struct
{
    uint32_t fileid;
    char *filename;
    uint32_t *dram_p;
} SoundDB;

static const SoundDB sound_db[] =
{
    /* ミニゲーム　音源 */
    {FILE_ACCESS_BGM_COIN,              "/Action/200_coin",     DRAM_BGM_COIN_ADDR_START,               },
    {FILE_ACCESS_BGM_JUMP,              "/Action/203_jump",     DRAM_BGM_JUMP_ADDR_START,               },
    {FILE_ACCESS_BGM_BOM,               "/Action/201_bom",      DRAM_BGM_BOM_ADDR_START,                },
    {FILE_ACCESS_BGM_PITYN,             "/Action/204_pityun",   DRAM_BGM_PITYN_ADDR_START,              },

    /* FF コマンド音源 */
    {FILE_ACCESS_BGM_CMD_ENTER,         "/Action/1_enter",      DRAM_BGM_CMD_ENTER_ADDR_START,          },
    {FILE_ACCESS_BGM_CMD_DOOR1,         "/Action/2_door",       DRAM_BGM_CMD_DOOR1_ADDR_START,          },
    {FILE_ACCESS_BGM_CMD_DOOR2,         "/Action/3_door",       DRAM_BGM_CMD_DOOR2_ADDR_START,          },
    {FILE_ACCESS_BGM_CMD_CHEST,         "/Action/4_chest",      DRAM_BGM_CMD_CHEST_ADDR_START,          },
    {FILE_ACCESS_BGM_CMD_SWITCH,        "/Action/5_switch",     DRAM_BGM_CMD_SWITCH_ADDR_START,         },
    {FILE_ACCESS_BGM_CMD_GOLD,          "/Action/6_gold",       DRAM_BGM_CMD_GOLD_ADDR_START,           },
    {FILE_ACCESS_BGM_CMD_SELECT1,       "/Action/7_select",     DRAM_BGM_CMD_SELECT1_ADDR_START,        },
    {FILE_ACCESS_BGM_CMD_SELECT2,       "/Action/8_select",     DRAM_BGM_CMD_SELECT2_ADDR_START,        },
    {FILE_ACCESS_BGM_CMD_COLLAPSE,      "/Action/10_collapse",  DRAM_BGM_CMD_COLLAPSE_ADDR_START,       },
    {FILE_ACCESS_BGM_CMD_KAIDAN,        "/Action/11_kaidan",    DRAM_BGM_CMD_KAIDAN_ADDR_START,         },
    {FILE_ACCESS_BGM_CMD_TAKARA,        "/Action/205_takara",   DRAM_BGM_CMD_TAKARA_ADDR_START,         },
    {FILE_ACCESS_BGM_CMD_SUCCESS,       "/Action/success",      DRAM_BGM_CMD_SUCCESS_ADDR_START,        },
    {FILE_ACCESS_BGM_CMD_FAIL,          "/Action/fail",         DRAM_BGM_CMD_FAIL_ADDR_START,           },
    {FILE_ACCESS_BGM_CMD_CANSEL,        "/Action/cansel",       DRAM_BGM_CMD_CANSEL_ADDR_START,         },

    /* FF Battle音源 */
    {FILE_ACCESS_BGM_BATTLE_ENCOUNT,    "/Battle/11_encount",   DRAM_BGM_BATTLE_ENCOUNT_ADDR_START,     },
    {FILE_ACCESS_BGM_BATTLE_TRUN,       "/Battle/2_trun",       DRAM_BGM_BATTLE_TRUN_ADDR_START,        },
    {FILE_ACCESS_BGM_BATTLE_DAMAGE,     "/Battle/3_damage",     DRAM_BGM_BATTLE_DAMAGE_ADDR_START,      },
    {FILE_ACCESS_BGM_BATTLE_KNIFE,      "/Battle/knife1",       DRAM_BGM_BATTLE_KNIFE_ADDR_START,       },
    {FILE_ACCESS_BGM_BATTLE_SPEAR,      "/Battle/5_spear",      DRAM_BGM_BATTLE_SPEAR_ADDR_START,       },
    {FILE_ACCESS_BGM_BATTLE_PUNCH,      "/Battle/6_punch",      DRAM_BGM_BATTLE_PUNCH_ADDR_START,       },
    {FILE_ACCESS_BGM_BATTLE_MISS,       "/Battle/7_miss",       DRAM_BGM_BATTLE_MISS_ADDR_START,        },
    {FILE_ACCESS_BGM_BATTLE_DEFEAT1,    "/Battle/8_defeat",     DRAM_BGM_BATTLE_DEFEAT1_ADDR_START,     },
    {FILE_ACCESS_BGM_BATTLE_DEFEAT2,    "/Battle/9_defeat",     DRAM_BGM_BATTLE_DEFEAT2_ADDR_START,     },
    {FILE_ACCESS_BGM_BATTLE_RUN,        "/Battle/10_run",       DRAM_BGM_BATTLE_RUN_ADDR_START,         },
    {FILE_ACCESS_BGM_BATTLE_BRAW_1,     "/Battle/brow1",        DRAM_BGM_BATTLE_BRAW1_ADDR_START,       },

    /* バトルエフェクト音源 */
    {FILE_ACCESS_BGM_EFFECT_MAGIC_1,    "/Battle/102_magic1",   DRAM_BGM_EFFECT_MAGIC_1_ADDR_START,     },

    /* ステータス系 */
    {FILE_ACCESS_BGM_EFFECT_POWER_UP,   "/Battle/103_power_up", DRAM_BGM_EFFECT_POWER_UP_ADDR_START,    },
    {FILE_ACCESS_BGM_EFFECT_POWER_DOWN, "/Battle/power_down",   DRAM_BGM_EFFECT_POWER_DOWN_ADDR_START,  },
    {FILE_ACCESS_BGM_EFFECT_DEF_1,      "/Battle/def1",         DRAM_BGM_EFFECT_DEF_1_ADDR_START,       },
    {FILE_ACCESS_BGM_EFFECT_HEST_1,     "/Battle/hest1",        DRAM_BGM_EFFECT_HEST_1_ADDR_START,      },
    {FILE_ACCESS_BGM_EFFECT_SLOW_1,     "/Battle/slow1",        DRAM_BGM_EFFECT_SLOW_1_ADDR_START,      },

    /* 回復 */
    {FILE_ACCESS_BGM_EFFECT_HEAL_1,     "/Battle/101_heal1",    DRAM_BGM_EFFECT_HEAL_1_ADDR_START,      },
    {FILE_ACCESS_BGM_EFFECT_ESNA_1,     "/Battle/105_esna1",    DRAM_BGM_EFFECT_ESNA_1_ADDR_START,      },
    {FILE_ACCESS_BGM_EFFECT_RISE_1,     "/Battle/106_rise1",    DRAM_BGM_EFFECT_RISE_1_ADDR_START,      },

    /* 状態異常 */
    {FILE_ACCESS_BGM_EFFECT_CONFIG_1,   "/Battle/config1",      DRAM_BGM_EFFECT_CONFIG_1_ADDR_START,    },
    {FILE_ACCESS_BGM_EFFECT_POISON_1,   "/Battle/poison_181",   DRAM_BGM_EFFECT_POISON_1_ADDR_START,    },
    {FILE_ACCESS_BGM_EFFECT_PARARAI_1,  "/Battle/pararai1",     DRAM_BGM_EFFECT_PARARAI_1_ADDR_START,   },

    /* 専用技 */
    {FILE_ACCESS_BGM_EFFECT_KANAKO_8,   "/Battle/e_kanako_8",   DRAM_BGM_EFFECT_KANAKO_8_ADDR_START,    },

    /* バックグラウンド　音源 */
    {FILE_ACCESS_BGM_TITLE,             "/Bgm/opening",             DRAM_SOUND_FIELD_ADDR_START,        },
    {FILE_ACCESS_BGM_KAMIGAMI,          "/Bgm/kamigami",            DRAM_SOUND_FIELD_ADDR_START,        },
    {FILE_ACCESS_BGM_MINORIKO,          "/Bgm/minoriko",            DRAM_SOUND_FIELD_ADDR_START,        },
    {FILE_ACCESS_BGM_SIZUHA,            "/Bgm/sizuha",              DRAM_SOUND_FIELD_ADDR_START,        },
    {FILE_ACCESS_BGM_KOGASA,            "/Bgm/101_kogasa",          DRAM_SOUND_FIELD_ADDR_START,        },
    {FILE_ACCESS_BGM_ENDING,            "/Bgm/ending",              DRAM_SOUND_SPARE_ADDR_START,        },
    {FILE_ACCESS_BGM_MURA_1,            "/Bgm/1_mura",              DRAM_SOUND_FIELD_ADDR_START,        },
    {FILE_ACCESS_BGM_FIELD,             "/Bgm/2_inada",             DRAM_SOUND_FIELD_ADDR_START,        },
    {FILE_ACCESS_BGM_FIELD_GEKAI,       "/Bgm/201_gekai_field",     DRAM_SOUND_FIELD_ADDR_START,        },

    /* バトルBGM */
    {FILE_ACCESS_BGM_BATTLE_DEFAULT,    "/Bgm/100_default_battle",  DRAM_SOUND_BATTLE_ADDR_START,       },
    {FILE_ACCESS_BGM_BATTLE_FANFARE,    "/Bgm/fanfare1",            DRAM_SOUND_FANFARE_ADDR_START,      },
};


/*
 * ver1. 2021/08/14
 * BGM・効果音データの音源の長さを保存する
 * 
 * このlen配列にアクセスする時のindexの計算方法は、
 * 
 * FILE_BGM_ID_END - (アクセスするファイルID)FILE_ACCESS_BGM_BATTLE_FANFARE - 1とする
 */
typedef struct
{
    uint32_t len[FILE_BGM_ID_END - FILE_BGM_ID_START - 1];
} SoundLength;


/*
 * ver1. 2021/07/15
 * システムデータの各メンバのアクセスアドレスを保存するデータベース
 * -
 * 下記のSystemFile構造体の取得ファイルは武器データやレベルアップ、敵のデータなどゲームのROMデータを取り扱う。
 * ファイル内の構造やデータ数が分かっているため、各要素の開始アドレスを保存すればアドレスの計算が行える
 * -
 * start_adr    データベースのメンバのデータを保存するDRAMの開始アドレスを保存
 * p            データベースのメンバの長さを保存するDRAMの開始アドレスを保存
 */
typedef struct
{
    uint32_t *start_adr[FILE_SYSTEM_ID_END - FILE_SYSTEM_ID_START - 1];
    uint32_t *p[FILE_SYSTEM_ID_END - FILE_SYSTEM_ID_START - 1];
} SystemAddress;

/*
 * ver1. 2021/07/15
 * 文字列やアイテムなど、ゲームの進行、システム動作に必要なデータが記載してあるファイルのアクセス処理を管理するデータベース
 * ファイルを追加する場合は、ファイルの出力順番を確認する
 * sdカードに追加する場合はbyte.rawファイルも忘れずに追加すること
 */
typedef struct
{
    uint32_t fileid;
    char *filename;
} SystemFile;

static const SystemFile system_file[] =
{
    {FILE_ACCESS_ENEMY_PARA,        "/sys/enemy"                },
    {FILE_ACCESS_ENEMY_NAME,        "/sys/enemy_name"           },
    {FILE_ACCESS_BUILD_CONFIG,      "/sys/build_config"         },
    {FILE_ACCESS_BUILD_FILE,        "/sys/build_file"           },
    {FILE_ACCESS_MAP_ALL,           "/sys/map_all"              },
    {FILE_ACCESS_WORLD_DIRECT,      "/sys/world_direct"         },
    {FILE_ACCESS_BUILD_LOOP_COUNT,  "/sys/build_loop"           },
    {FILE_ACCESS_BUILD_POS,         "/sys/build_pos"            },
    {FILE_ACCESS_BUILD_EVENT,       "/sys/build_event"          },
    {FILE_ACCESS_BUILD_SUBMAP,      "/sys/build_submap"         },
    {FILE_ACCESS_BUILD_MSG,         "/sys/build_msg"            },
    {FILE_ACCESS_ITEM_BATTLE,       "/sys/item"                 },
    {FILE_ACCESS_ITEM_WEAPON,       "/sys/weapon"               },
    {FILE_ACCESS_ITEM_ARMOR,        "/sys/armor"                },
    {FILE_ACCESS_ITEM_AMULET,       "/sys/amulet"               },
    {FILE_ACCESS_COOKING,           "/sys/cook"                 },
    {FILE_ACCESS_MSG_MINIGAME,      "/sys/mini"                 },
    {FILE_ACCESS_MSG_CMD,           "/sys/cmd"                  },
    {FILE_ACCESS_MINI_SCORE,        "/sys/score"                },
    {FILE_ACCESS_MAGIC_PARA,        "/sys/magic"                },
    {FILE_ACCESS_HERO_LEVEL,        "/sys/level"                },
    {FILE_ACCESS_HERO_SKILL,        "/sys/skill"                },
    {FILE_ACCESS_ENEMY_REGION,      "/sys/region"               },
    {FILE_ACCESS_ENEMY_FORMATION,   "/sys/formation"            },
    {FILE_ACCESS_ANIMATION_EFFECT,  "/sys/animation"            },
    {FILE_ACCESS_STATUS_CONFIG,     "/sys/status"               },
    {FILE_ACCESS_ATK_ELEMENT,       "/sys/atk_element"          },
    {FILE_ACCESS_WEAPON_ELEMENT,    "/sys/weapon_element"       },
    {FILE_ACCESS_ARMOR_ELEMENT,     "/sys/armor_element"        },
    {FILE_ACCESS_AMULET_ELEMENT,    "/sys/amulet_element"       },
    {FILE_ACCESS_CONDITION,         "/sys/condition"            },
    {FILE_ACCESS_CONDITION_ANIME,   "/sys/condition_anime"      },
    {FILE_ACCESS_SOUND,             "/sys/dtm"                  },
    {FILE_ACCESS_ITEM_ENCHANT,      "/sys/item_enchant"         },
    {FILE_ACCESS_ITEM_CONDITION,    "/sys/item_condition"       },
    {FILE_ACCESS_NPC_MAP,           "/sys/npc_map"              },
    {FILE_ACCESS_NPC_PATTERN,       "/sys/npc_pattern"          },
    {FILE_ACCESS_NPC_EVENT,         "/sys/npc_event"            },
    {FILE_ACCESS_NPC_BITMAP,        "/sys/npc_bitmap"           },
    {FILE_ACCESS_NPC_MSG,           "/sys/npc_msg"              },
    {FILE_ACCESS_SIN_TABLE,         "/sys/sin"                  },
    {FILE_ACCESS_COS_TABLE,         "/sys/cos"                  },
    {FILE_ACCESS_TYPE_STR,          "/sys/type_bit"             },
    {FILE_ACCESS_TOTAL_BYTE,        "/sys/byte"                 },
};


/*
 * ver1. 2021/07/15
 * システム構造体の各メンバの長さを管理
 *
 * system_member MEMORYから開始される定数を指定
 * id_len 構造体の要素数(行)の数を指定
 * member_len メンバーの最大数(列)を指定
 */
typedef struct
{
    uint8_t system_member;
    uint32_t id_len;
    uint32_t member_len;
} SystemLength;

static const SystemLength system_length[] =
{
    {MEMORY_ENEMY_PARA_ID,      MONSTER_ID_END,                         ENEMY_SUB_MEMBER_PARA_NUMBER        },
    {MEMORY_ENEMY_NAME_ID,      MONSTER_ID_END,                         EVENT_MSG_MEMBER_NUMBER             },
    {MEMORY_BUILD_CONFIG_ID,    MAP_NAME_ID_END,                        BUILD_SUB_MEMBER_CONFIG_NUMBER      },
    {MEMORY_BUILD_FILE_ID,      MAP_NAME_ID_END,                        BUILD_SUB_MEMBER_FILE_NUMBER        },
    {MEMORY_MAP_ALL_ID,         TRY_MAP_NAME_END,                       TRY_MAP_MEMBER_NUMBER               },
    {MEMORY_WORLD_DIRECT_ID,    WORLD_DIRECT_END,                       WORLD_DIRECT_MEMBER_NUMBER          },
    {MEMORY_BUILD_LOOP_ID,      MAP_NAME_ID_END,                        BUILD_LOOPCOUNT_MEMBER_NUMBER       },
    {MEMORY_BUILD_POS_ID,       DIRECT_BUILD_END_EVENT,                 BUILD_POS_MEMBER_NUMBER             },
    {MEMORY_BUILD_EVENT_ID,     DIRECT_BUILD_END_EVENT,                 BUILD_EVENT_MEMBER_NUMBER           },
    {MEMORY_BUILD_SUBMAP_ID,    BUILD_SUBMAP_COUNT_DB_LINE,             BUILD_SUBMAP_MEMBER_NUMBER          },
    {MEMORY_BUILD_MSG_ID,       MSG_TOTAL_ID_END,                       EVENT_MSG_MEMBER_NUMBER             },
    {MEMORY_ITEM_ID,            ITEM_NAME_ID_END,                       ITEM_MEMBER_NUMBER                  },
    {MEMORY_WEAPON_ID,          WEAPON_NAME_ID_END,                     WEAPON_MEMBER_NUMBER                },
    {MEMORY_ARMOR_ID,           ARMOR_NAME_ID_END,                      ARMOR_MEMBER_NUMBER                 },
    {MEMORY_AMULET_ID,          AMULET_NAME_ID_END,                     AMULET_MEMBER_NUMBER                },
    {MEMORY_COOK_ID,            COOK_ID_END,                            COOK_SUB_MEMBER_NUMBER              },
    {MEMORY_MINIGAME_MSG_ID,    MINIGAME_TOTAL_ID_END,                  MINIGAME_MSG_MEMBER_NUMBER          },
    {MEMORY_CMD_MSG_ID,         CMD_MSG_ID_END,                         EVENT_MSG_MEMBER_NUMBER             },
    {MEMORY_MINIGAME_SCORE_ID,  MINIGAME_SCORE_TOTAL_ID_END,            MINIGAME_SCORE_MEMBER_NUMBER        },
    {MEMORY_MAGIC_ID,      		E_END,                                  MAGIC_SUB_MEMBER_NUMBER             },
    {MEMORY_HERO_LEVEL_ID,      LEVEL_MAX,                              HERO_SUB_MEMBER_LEVEL_NUMBER        },
    {MEMORY_HERO_SKILL_ID,      HERO_NUMBER,                            HERO_SUB_MEMBER_SKILL_NUMBER        },
    {MEMORY_ENEMY_REGION_ID,    1,                                      REGION_SUB_MEMBER_NUMBER            },
    {MEMORY_ENEMY_FORMATION_ID, FORMATION_TYPE_END,                     FORMATION_SUB_MEMBER_NUMBER         },
    {MEMORY_ANIME_MAGIC_ID,     A_EFFECT_END,                           ANIME_SUB_MEMBER_MAGIC_NUMBER       },
    {MEMORY_STATUS_CONFIG_ID,   E_STATUS_END-E_STATUS_START-1,          STATUS_SUB_MEMBER_CONFIG_NUMBER     },  // endid - srartid - 1 でメンバ数
    {MEMORY_ELEMENT_TYPE_ID,    E_DAMEGE_END-E_DAMEGE_START-1,          ELEMENT_SUB_MEMBER_NUMBER           },
    {MEMORY_ELEMENT_WEAPON_ID,  WEAPON_NAME_ID_END,                     WEAPON_ELEMENT_SUB_MEMBER_NUMBER    },
    {MEMORY_ELEMENT_ARMOR_ID,   ARMOR_NAME_ID_END,                      ARMOR_ELEMENT_SUB_MEMBER_NUMBER     },
    {MEMORY_ELEMENT_AMULET_ID,  AMULET_NAME_ID_END,                     AMULET_ELEMENT_SUB_MEMBER_NUMBER    },
    {MEMORY_CONDITION_ID,       E_CONDITION_END-E_CONDITION_START-1,    CONDITION_SUB_MEMBER_NUMBER         },
    {MEMORY_CONDITION_ANIME_ID, UNIT_CONDITION_END,                     CONDITION_SUB_MEMBER_ANIME_NUMBER   },
    {MEMORY_DTM_ID,             SOUND_ID_END,                           DTM_SUB_MEMBER_NUMBER               },
    {MEMORY_ITEM_ENCHANT_ID,    ENCHANT_ITEM_END,                       ITEM_SUB_MEMBER_ENCHANT_NUMBER      },
    {MEMORY_ITEM_CONDITION_ID,  CONDITION_ITEM_END,                     ITEM_SUB_MEMBER_CONDITION_NUMBER    },
    {MEMORY_NPC_MAP_ID,         MAP_NAME_ID_END,                        NPC_MAX_DRAW_NUM + 1                },
    {MEMORY_NPC_PATTERN_ID,     NPC_PATTERN_DB_COL,                     NPC_SUB_MEMBER_PATTERN_NUMBER       },
    {MEMORY_NPC_EVENT_ID,       NPC_PATTERN_DB_COL,                     NPC_SUB_MEMBER_EVENT_NUMBER         },
    {MEMORY_NPC_BITMAP_ID,      NPC_ID_END,                             NPC_SUB_MEMBER_BITMAP_NUMBER        },
    {MEMORY_NPC_MSG_ID,         NPC_EVENT_END_ID,                       MEMBER_LEN_VARIABLE                 },
    {MEMORY_SIN_ID,             SIN_TABLE_MAX,                          SIN_SUB_MEMBER_NUMBER               },
    {MEMORY_COS_ID,             COS_TABLE_MAX,                          COS_SUB_MEMBER_NUMBER               },
    {MEMORY_TYPE_STR_ID,        UNIT_RES_SIZE,                          TYPE_STR_SUB_MEMBER_NUMBER          },
};

#endif
