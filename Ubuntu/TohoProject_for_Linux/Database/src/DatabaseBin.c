/*
 * Create 2021/07/13
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * Editor VSCode ver1.57.1
 * -
 * 構造体のデータをrawファイルに書き出すソースファイル
 */
#include "include/MyLIB.h"


/**
 * @brief  ファイル書き出しテーブル
 * @note   
 * @retval None
 */
static const FuncFile funcfile[] = {
	{"./raw/enemy.raw",				enemy_write				},
	{"./raw/enemy_name.raw",		enemy_name_write		},
	{"./raw/build_config.raw",		build_config_write		},
	{"./raw/build_file.raw",		build_file_write		},
	{"./raw/map_all.raw",			map_all_write			},
	{"./raw/world_direct.raw",		world_direct_write		},
	{"./raw/build_loop.raw",		build_loop_write		},
	{"./raw/build_pos.raw",			build_pos_write			},
	{"./raw/build_event.raw",		build_event_write		},
	{"./raw/build_submap.raw",		build_submap_write		},
	{"./raw/build_msg.raw",			build_msg_write			},
	{"./raw/item.raw",				item_write				},
	{"./raw/weapon.raw",			weapon_write			},
	{"./raw/armor.raw",				armor_write				},
	{"./raw/amulet.raw",			amulet_write			},
	{"./raw/cook.raw",				cooking_write			},
	{"./raw/mini.raw",				minigame_write			},
	{"./raw/cmd.raw",				cmd_write				},
	{"./raw/score.raw",				score_write				},
	{"./raw/magic.raw",				magic_write				},
	{"./raw/level.raw",				level_write				},
	{"./raw/skill.raw",				hero_skill_write		},
	{"./raw/region.raw",			region_write			},
	{"./raw/formation.raw",			formation_write			},
	{"./raw/animation.raw",			anime_effect_write		},
	{"./raw/status.raw",			status_write			},
	{"./raw/atk_element.raw",		atk_element_write		},
	{"./raw/weapon_element.raw",	weapon_element_write	},
	{"./raw/armor_element.raw",		armor_element_write		},
	{"./raw/amulet_element.raw",	amulet_element_write	},
	{"./raw/condition.raw",			condition_write			},
	{"./raw/condition_anime.raw",	anime_condition_write	},
	{"./raw/dtm.raw",				dtm_write				},
	{"./raw/item_enchant.raw",		item_enchant_write		},
	{"./raw/item_condition.raw",	item_condition_write	},
	{"./raw/npc_map.raw",			npc_map_write	 		},
	{"./raw/npc_pattern.raw",		npc_pattern_write		},
	{"./raw/npc_event.raw",			npc_event_write			},
	{"./raw/npc_bitmap.raw",		npc_bitmap_write 		},
	{"./raw/npc_msg.raw",			npc_msg_write	 		},
	{"./raw/sin.raw",				sin_write				},
	{"./raw/cos.raw",				cos_write				},
	{"./raw/type_bit.raw",			type_bit_write			},
};


/*
 * ver1. 2021/07/13
 * sjisフォント取得
 */
uint32_t sjis_write(FILE *fp, const char *msg)
{
	uint32_t count = 0;

	while (msg[0] != '\0')
	{
		uint32_t sjis = *msg & 0xff;
		sjis = (sjis << 8) | (*(msg + 1) & 0xff);
		msg += 2;
		fprintf(fp, "0x%08x,\n", sjis);
		count++;
		// printf("0x%04x\n", sjis);

		while (*msg == '\n')
		{
			fprintf(fp, "0x%08x,\n", *msg & 0xff);
			msg++;
			count++;
		}
	}
	// printf("count = %d\n", count);

	return count;
}


/*
 * ver1. 2021/07/13
 * 文字列数取得
 */
uint32_t sjis_length(const char *msg)
{
	uint32_t count = 0;

	while (msg[0] != '\0')
	{
		uint32_t sjis = *msg & 0xff;
		sjis = (sjis << 8) | (*(msg + 1) & 0xff);
		msg += 2;
		count++;

		while (*msg == '\n')
		{
			msg++;
			count++;
		}
	}

	return count;
}



/*
 * ver1. 2021/07/13
 * データベースのデータをrawファイルに書き出す
 */
int main(int argc, char **argv)
{
	const FuncFile *p = funcfile;
	FILE *fp = NULL;
	FILE *byte = NULL;
	byte = fopen("./raw/byte.raw", "wb");

	for (int i = 0; i < FUNC_FILE_SIZE; i++, p++)
	{
		fp = fopen(p->path, "wb");

		if (fp == NULL)
		{
			printf("open error\n");
			fclose(byte);
			return 0;
		}

		p->file_func(fp, byte);
		fclose(fp);
	}

	// void (*func)(FILE * fp, FILE * byte);
	// func = npc_pattern_write;
	// printf("FUNCFUNC             = %p byte\n",  func);
	// printf("FUNCFUNC             = %p byte\n",  npc_pattern_write);

	/* 確認用に東方ゲームシステムのメモリ容量の書き出し */
	fprintf(stderr, "\n");
	fprintf(stderr, "-------------System Memory RAM Size-----------------\n");
	fprintf(stderr, "GameWrapper Ram Size = %5ld byte\n", sizeof(game_wrapper));
	fprintf(stderr, "\n");
	fprintf(stderr, "-------------System Memory ROM Size-----------------\n");
	fprintf(stderr, "BitmapDB    Rom Size = %5ld byte\n", sizeof(bitmap_db));
	fprintf(stderr, "SoundDB     Rom Size = %5ld byte\n", sizeof(sound_db));
	fprintf(stderr, "SystemFile  Rom Size = %5ld byte\n", sizeof(system_file));
	fprintf(stderr, "SystemLen   Rom Size = %5ld byte\n", sizeof(system_length));
	fprintf(stderr, "Total       Rom Size = %5ld byte\n", sizeof(bitmap_db) + sizeof(sound_db) + sizeof(system_file) + sizeof(system_length));
	fprintf(stderr, "\n");

	/* 音源データのバイト数書き出し */
	printf("-------------Sound Memory Size-----------------\n");
	dtm_rom();

	return 0;
}
