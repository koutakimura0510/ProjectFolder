/*
 * Create 2021/07/02
 * Author koutakimura
 * OS     Ubuntu LTS 20.04
 * -
 * イベント時に発生するメッセージ描画文字列を管理するヘッダーファイル
 * sjisのフォントデータを使用するためファイルのエンコード設定をsjisに変更する
 */
#ifndef romen_msg_db_h   /* prevent circular inclusions */
#define romen_msg_db_h   /* by using protection macros */


/*
 * 文字列管理データベースの要素数
 */
#define ROMEN_MSG_DB_SIZE 	((sizeof (romen_msg)) 	/ (sizeof (RomenMsg)))


/* 
 * ver1. 2021/06/25
 * 固定座標のイベント時に発生するメッセージの管理を行う
 * event_idに一致した文字列データの取得を行う
 */
typedef struct romen_msg
{
	uint32_t event_id;
	const char *msg[3];
} RomenMsg;

static const RomenMsg romen_msg[] =
{
	{DIRECT_ROMEN_ID_ITEM1,	 	{"アルテマウェポンを手に入れた", "\0"},},
	{DIRECT_ROMEN_ID_ITEM2,	 	{"やくそうを手に入れた", "\0"},},
	{DIRECT_ROMEN_ID_ITEM3,	 	{"あああ", "\0"},},
	{DIRECT_ROMEN_ID_KANBAN1, 	{"空けるな危険", "\0"},},
	{DIRECT_ROMEN_ID_KANBAN3_1,	{"穣子へ\nお姉ちゃんは無事です。\n崖の上にある家のじじいに森で倒れている所を助けてもらいました。\n一緒に吸い込まれたから、きっと近くにいるだろうと思い、\nお姉ちゃんは穣子を探しに森に行っています。\n森は魔物がいて危険なので、\nもしこの便りを見たら、森には来ないで町に居てください。\n\n静葉より", "\0"},},
	{DIRECT_ROMEN_ID_KANBAN3_2,	{"夕方、森で雷鳥出没　注意するように", "\0"},},
	{DIRECT_ROMEN_ID_KANBAN4, 	{"道具屋", "\0"},},
	{DIRECT_ROMEN_ID_KANBAN5, 	{"武器屋", "\0"},},
};


/*
 * ver1. 2021/07/15
 * イベントメッセージrawファイル書き出し
 */
void romen_msg_write(FILE *fp, FILE *byte)
{
	const RomenMsg *p = romen_msg;

	for (uint32_t i = 0; i < EVENT_MSG_DB_SIZE; i++, event++)
	{
		const char *msg  = event->msg;
		fprintf(fp, "0x%08x,\n", event->event_id);
		fprintf(byte, "0x%08x,\n", 1);
		fprintf(byte, "0x%08x,\n", sjis_write(fp, event->msg));
	}

	printf("ENEMY MSG TOTAL NUMBER= %ld\n", EVENT_MSG_DB_SIZE);
}


#endif
