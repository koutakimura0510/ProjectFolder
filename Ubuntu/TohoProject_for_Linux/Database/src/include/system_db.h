#ifndef system_db_h   /* prevent circular inclusions */
#define system_db_h   /* by using protection macros */

#define CMD_DB_SIZE 		((sizeof(cmd_db)) / (sizeof(CmdDB)))

/*
 * ver1. 2021/07/03
 * システム進行に必要なコマンド系のメッセージを管理
 */
typedef struct cmd_db
{
	uint32_t id;
	const char *msg;
} CmdDB;

static const CmdDB cmd_db[] = {
	{CMD_MSG_ID_0,			 	"０",		},
	{CMD_MSG_ID_1,			 	"１",		},
	{CMD_MSG_ID_2,			 	"２",		},
	{CMD_MSG_ID_3,			 	"３",		},
	{CMD_MSG_ID_4,			 	"４",		},
	{CMD_MSG_ID_5,			 	"５",		},
	{CMD_MSG_ID_6,			 	"６",		},
	{CMD_MSG_ID_7,			 	"７",		},
	{CMD_MSG_ID_8,			 	"８",		},
	{CMD_MSG_ID_9,			 	"９",		},
	{CMD_MSG_ID_MINORIKO,		"穣子",		},
	{CMD_MSG_ID_SIZUHA,			"静葉",		},
	{CMD_MSG_ID_KANAKO,			"神奈子",	},
	{CMD_MSG_ID_KOGASA,			"小傘",		},
	{CMD_MSG_ID_YUUKA,			"幽香",		},
	{CMD_MSG_ID_REMIRIA,		"レミリア",	},
	{CMD_MSG_ID_SATORI,			"さとり",	},
	{CMD_MSG_ID_TENSI,			"天子",		},
	{CMD_MSG_ID_MAGIC_POWER,	"ＳＰ"		},
	{CMD_MSG_ID_SLASH,			"／"		},
	{CMD_MSG_ID_FIGHT,			"たたかう"	},
	{CMD_MSG_ID_MAGIC,			"わざ"		},
	{CMD_MSG_ID_ITEM,			"アイテム"	},
	{CMD_MSG_ID_CHANGE,			"いれかえ"	},
	{CMD_MSG_ID_TOLK,			"はなす"	},
	{CMD_MSG_ID_ESCAPE,			"にげる"	},
	{CMD_MSG_ID_GET_EXP,		"ＥＸＰ"	},
	{CMD_MSG_ID_GET_GOLD,		"ＧＯＬＤ"	},
	{CMD_MSG_ID_LV_UP_MINORIKO,	"穣子はＬＶがあがった"		},
	{CMD_MSG_ID_LV_UP_SIZUHA,	"静葉はＬＶがあがった"		},
	{CMD_MSG_ID_LV_UP_KANAKO,	"神奈子はＬＶがあがった"	},
	{CMD_MSG_ID_LV_UP_KOGASA,	"小傘はＬＶがあがった"		},
	{CMD_MSG_ID_LV_UP_YUUKA,	"幽香はＬＶがあがった"		},
	{CMD_MSG_ID_LV_UP_REMIRIA,	"レミリアはＬＶがあがった"	},
	{CMD_MSG_ID_LV_UP_SATORI,	"さとりはＬＶがあがった"	},
	{CMD_MSG_ID_LV_UP_TENSI,	"天子はＬＶがあがった"		},
	{CMD_MSG_ID_SKILL_MINORIKO,	"穣子はＬＶがあがった"		},
	{CMD_MSG_ID_SKILL_SIZUHA,	"静葉はＬＶがあがった"		},
	{CMD_MSG_ID_SKILL_KANAKO,	"神奈子はＬＶがあがった"	},
	{CMD_MSG_ID_SKILL_KOGASA,	"小傘はＬＶがあがった"		},
	{CMD_MSG_ID_SKILL_YUUKA,	"幽香はＬＶがあがった"		},
	{CMD_MSG_ID_SKILL_REMIRIA,	"レミリアはＬＶがあがった"	},
	{CMD_MSG_ID_SKILL_SATRI,	"さとりはＬＶがあがった"	},
	{CMD_MSG_ID_SKILL_TENSI,	"天子はＬＶがあがった"		},
	{CMD_MSG_ID_LOAD_GAME_1,	"ロード中"					},
	{CMD_MSG_ID_BATTLE_DEATH,	"戦いに敗れた"				},
	{CMD_MSG_ID_BATTLE_ESCAPE,	"逃走に成功した"			},
	{CMD_MSG_ID_MENU_SELECT,	"はなす\nなかま\nたべる"	},
	{CMD_MSG_ID_MENU_EART,		"たべる"	},
	{CMD_MSG_ID_MENU_MASTER,	"【熟練度】"	},
	{CMD_MSG_ID_MENU_MASTER_LV1,	"★"		},
	{CMD_MSG_ID_MENU_MASTER_LV2,	"★★"			},
	{CMD_MSG_ID_MENU_MASTER_LV3,	"★★★"		},
	{CMD_MSG_ID_MENU_MASTER_LV4,	"★★★★"	},
	{CMD_MSG_ID_MENU_MASTER_LV5,	"ＭＡＳＴＥＲ！"},
	{CMD_MSG_ID_MENU_COOK_SUCCESS,	"料理に成功した！"},
	{CMD_MSG_ID_MENU_COOK_FAILD,	"料理に失敗した！"},
	{CMD_MSG_ID_MENU_PATY_EQUIP,	"武器：\n帽子：\n宝飾：\n道具："},
	{CMD_MSG_ID_MENU_PATY_STATUS,	"げんざいのＬＶ\nさいだいＨＰ\nさいだいＳＰ\nちから\nみのまもり\nまほう力\nまぼう力\nすばやさ\n好感度\nげんざいのＨＰ\nげんざいのＳＰ\nけいけんち"},
	{CMD_MSG_ID_MENU_PATY_WEAPON_ATK,	"物攻：\n属性："},
	{CMD_MSG_ID_MENU_PATY_ARMOR_DEF,	"物防：\n魔防："},
};


/*
 * ver1. 2021/07/15
 * イベントメッセージrawファイル書き出し
 */
void cmd_write(FILE *fp, FILE *byte)
{
	const CmdDB *cmd = cmd_db;

	for (uint32_t i = 0; i < CMD_DB_SIZE; i++, cmd++)
	{
		fprintf(fp, "0x%08x,\n", cmd->id);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", sjis_write(fp, cmd->msg));
	}

	if (CMD_DB_SIZE != CMD_MSG_ID_END)
    {
        printf("--- ERROR --- CMD_DB_SIZE");
    }

	printf("CMD DB TOTAL NUMBER= %ld\n", CMD_DB_SIZE);
}

#endif