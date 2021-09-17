/*
 * Create 2021/09/17
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 *
 * 可変式のイベントメッセージについて管理するファイル
 */
#ifndef event_variable_msg_db_h   /* prevent circular inclusions */
#define event_variable_msg_db_h   /* by using protection macros */


/*
 * 文字列管理データベースの要素数
 */
#define EVENT_VARIABLE_MSG_DB_SIZE ((sizeof (variable_msg_db)) / (sizeof (VariableMsgDB)))

static const char *npc_1[] = {"ロメンの村へようこそ・・・", "ロメンの村へようこそ！"};
static const char *npc_2[] = {"いらっしゃいまし～", "いらっしゃいまし！",};
static const char *npc_3[] = {"森にでっかい鳥が居座っちゃって、\n食べ物を取りに行けないのよ", "どうしましょう・・・", "誰かが鳥を追っ払ってくれたの！\nこれで食べ物を取りに行けるわ！"};


/**
 * @brief  のメッセージデータに関するデータを管理するデータベース
 * @note   ロメンの村を例としてイベントメッセージについて残しておく
 * 
 * [NPC番号1,2の場合]
 * ロメンのイベント判定は森の雷鳥を倒したらフラグ回収とする。
 * event_flagにフラグ検出用の定数を指定して、NPCに話しかけた時にフラグを確認しメッセージの切り替え判定をする。
 * 
 * [NPC単独にフラグ管理方法]
 * NPC番号3に話しかけた時に、DRAMのNPCフラグ管理開始アドレスから、アドレスを3つ進めたアドレスにフラグのデータを保存する
 * 
 * @param msg_event_id direct_macro.hに定義されているイベントIDを指定
 * @param *msg_event[] イベント後のメッセージを保存
 * @retval None
 */
typedef struct variable_msg_db
{
	uint32_t msg_event_id;
	char **msg_event;
	uint32_t len;
} VariableMsgDB;

static const VariableMsgDB variable_msg_db[] = {
	{ROMEN_NPC_ID_1, (char **)npc_1, NUM(npc_1)},
	{ROMEN_NPC_ID_2, (char **)npc_2, NUM(npc_2)},
	{ROMEN_NPC_ID_3, (char **)npc_3, NUM(npc_3)},

	/*TODO
	 * 仲間の戦闘中のメッセージなども連番にする
	 * 障害物などのメッセージも連番にしてしまう
	 */
};


/*
 * npcの画像データのデータを書き出し
 */
void variable_msg_write(FILE *fp, FILE *byte)
{
	const VariableMsgDB *p = variable_msg_db;

	for (uint32_t i = 0; i < EVENT_VARIABLE_MSG_DB_SIZE; i++, p++)
	{
		fprintf(fp, "0x%08x,\n", p->msg_event_id);
		fprintf(fp, "0x%08x,\n", p->len);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", 1);

		for (uint32_t j = 0; j < p->len; j++)
		{
			fprintf(byte, "0x%08x,\n", sjis_write(fp, p->msg_event[j]));
		}
	}

	printf("VARIABLE MSG TOTAL NUMBER = %ld\n", EVENT_VARIABLE_MSG_DB_SIZE);
}



#endif
