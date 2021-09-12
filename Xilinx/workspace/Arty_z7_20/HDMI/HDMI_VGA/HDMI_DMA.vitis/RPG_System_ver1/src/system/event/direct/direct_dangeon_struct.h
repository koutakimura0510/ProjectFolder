/*
 * ダンジョン内の当たり判定を管理
 */

#ifndef direct_dongeon_struct_h   /* prevent circular inclusions */
#define direct_dongeon_struct_h   /* by using protection macros */


/*
 * 構造体の要素数
 */
#define ROMEN_DANGEON_DB_SIZE ((sizeof (romen_dangeon))/(sizeof (RomenDangeon)))


/*
 * サブマップ内の固定座標でイベントが起こる個所のID名を指定
 * event_id
 *
 * イベントの種類を指定
 * event_type
 * 
 * 次のシステムの動作方法を指定
 * next_gamesystem
 * 
 * 次の描画方法を指定
 * next_drawtype
 * 
 * マップの当たり判定座標
 * direct_xpos
 * direct_ypos
 */

typedef struct romen_dangeon
{
	uint32_t event_id;
	uint32_t event_type;
	uint32_t next_gamesystem;
	uint8_t next_drawtype;
	uint8_t direct_xpos;
	uint8_t direct_ypos;
} RomenDangeon;

static const RomenDangeon romen_dangeon[] =
{
	{0, 0, 0, 0, 0, 0,},
};


/*
 * ダンジョンの当たり判定データベースを管理するラッパー
 */
typedef struct dangeon_wrapper
{
	const RomenDangeon *romen;
} DangeonWrapper;

static const DangeonWrapper dangeon_wrapper = 
{
	romen_dangeon,
};


#endif
