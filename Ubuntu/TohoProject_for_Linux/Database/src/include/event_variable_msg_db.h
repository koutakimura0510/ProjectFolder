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
#define EVENT_VARIABLE_MSG_DB_SIZE ((sizeof (event_msg)) / (sizeof (EventMsg)))


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
 * @param map_npcid マップに登場させるNPCの番号を管理するデータベースに対応した番号を指定
 * @param msg_flag メッセージの表示パターンを指定
 * @param msg_event_1 イベント前のメッセージを保存
 * @param msg_event_2 イベント後のメッセージを保存
 * @retval None
 */
typedef struct variable_msg_db
{
	uint32_t map_npcid;
	char *msg_event[];
} VariableMsgDB;

static const VariableMsgDB variable_msg_db[] = {
	{ROMEN_NPC_ID_1, {"ここはロメンの村よ・・・", "ここはロメンの村よ！！"},},
	{ROMEN_NPC_ID_2, {"いらっしゃいまし～", "いらっしゃいまし！"},},
	{ROMEN_NPC_ID_3, {"森にでっかい鳥が居座っちゃって、\n食べ物が鳥に行けないのよ", "いらっしゃいまし！"},},

	/*TODO
	 * 仲間の戦闘中のメッセージなども連番にする
	 * 障害物などのメッセージも連番にしてしまう
	 */
};


#endif
