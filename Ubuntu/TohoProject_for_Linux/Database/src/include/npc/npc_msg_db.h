/*
 * Create 2021/09/17
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 *
 * NPCのメッセージ管理ファイル
 */
#ifndef event_msg_db_h   /* prevent circular inclusions */
#define event_msg_db_h   /* by using protection macros */


/*
 * 文字列管理データベースの要素数
 */
#define NPC_MSG_DB_SIZE ((sizeof (npc_msg)) / (sizeof (NpcMsg)))


/**
 * @brief  イベントのメッセージデータに関するデータを管理するデータベース
 *         イベントIDに対応した宝箱や会話のメッセージデータを保存
 * 
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
 * @param *msg_event[] メッセージを保存
 * @retval None
 */
typedef struct npc_msg
{
	uint32_t msg_event_id;
	const char *msg_event[10];
} NpcMsg;

static const NpcMsg npc_msg[] = {
	{ROMEN_NPC_ID_1, {"ロメンの村へようこそ・・・", "ロメンの村へようこそ！", "\0"}},
	{ROMEN_NPC_ID_2, {"いらっしゃいまし～", "いらっしゃいまし！", "\0"}},
	{ROMEN_NPC_ID_3, {"森にでっかい鳥が居座っちゃって、\n食べ物を取りに行けないのよ", "どうしましょう・・・", "誰かが鳥を追っ払ってくれたの！\nこれで食べ物を取りに行けるわ！", "\0"}},
	{ROMEN_NPC_ID_4, {"トレーニングの邪魔すんじゃねぇ！", "はなしかけんじゃねぇ！", "\0"}},
};


/*
 * npcのメッセージデータのデータを書き出し
 */
void npc_msg_write(FILE *fp, FILE *byte)
{
	const NpcMsg *p = npc_msg;

	for (uint32_t i = 0; i < NPC_MSG_DB_SIZE; i++, p++)
	{
		uint32_t count = 0;
		fprintf(fp, "0x%08x,\n", p->msg_event_id);
		fprintf(byte, "0x%08x,\n", 1);

		for (uint32_t j = 0; j < NUM(p->msg_event); j++, count++)
		{
			if ("\0" == p->msg_event[j])
			{
				fprintf(fp, "0x%08x,\n", count);
				fprintf(byte, "0x%08x,\n", 1);
				break;
			}
		}

		for (uint32_t j = 0; j < count; j++)
		{
			fprintf(byte, "0x%08x,\n", sjis_write(fp, p->msg_event[j]));
		}
	}

	printf("NPC MSG TOTAL NUMBER = %ld\n", NPC_MSG_DB_SIZE);
}



#endif
