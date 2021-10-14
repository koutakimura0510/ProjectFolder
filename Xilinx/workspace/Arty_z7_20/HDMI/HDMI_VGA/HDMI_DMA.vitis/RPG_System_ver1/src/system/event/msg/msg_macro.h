#ifndef msg_macro_H   /* prevent circular inclusions */
#define msg_macro_H   /* by using protection macros */

/*
 * 文字フォントのバイト数
 */
#define FONT_BYTE_NUMBER    (2)


/*
 * タイトルの選択メッセージの表示箇所
 */
#define TITLE_MSG_XPOS      (160)
#define TITLE_MSG_YPOS      (((VIDEO_HEIGHT >> 1) - SIZE_FONT_SJIS_HEIGHT) * MAX_V_WIDTH)


/*
 * メッセージウィンドウの白の縁取りと黒背景の描画箇所とサイズ
 */
#define LINE_WIDTH                      (3)
#define MSG_WINDOW_WHITE_FRAME_XSTART	(80)
#define MSG_WINDOW_WHITE_FRAME_YSTART	(320)
#define MSG_WINDOW_WHITE_FRAME_XEND		(VIDEO_WIDTH - MSG_WINDOW_WHITE_FRAME_XSTART - MSG_WINDOW_WHITE_FRAME_XSTART)
#define MSG_WINDOW_WHITE_FRAME_YEND		(VIDEO_HEIGHT - MSG_WINDOW_WHITE_FRAME_YSTART - LINE_WIDTH)

#define MSG_WINDOW_BLACK_FRAME_XSTART	(MSG_WINDOW_WHITE_FRAME_XSTART + LINE_WIDTH)
#define MSG_WINDOW_BLACK_FRAME_YSTART	(MSG_WINDOW_WHITE_FRAME_YSTART + LINE_WIDTH)
#define MSG_WINDOW_BLACK_FRAME_XEND		(MSG_WINDOW_WHITE_FRAME_XEND - LINE_WIDTH - LINE_WIDTH)
#define MSG_WINDOW_BLACK_FRAME_YEND		(MSG_WINDOW_WHITE_FRAME_YEND - LINE_WIDTH - LINE_WIDTH)


/*
 * イベントメッセージの表示箇所
 */
#define EVENT_MSG_XSTRAT    (MSG_WINDOW_BLACK_FRAME_XSTART + 10)
#define EVENT_MSG_YSTRAT    (MSG_WINDOW_BLACK_FRAME_YSTART + 10)


/*
 * ver1. 2021/07/04
 * ゼロサプレス動作指定
 */
#define ZERO_SUP_ON         (0)
#define ZERO_SUP_OFF        (1)
#define ZERO_SUP_STATUS     (2)


/**
 * @brief  メッセージの種類を定義
 * @note   
 * @retval None
 */
typedef enum
{
	MSG_TYPE_UNVARIABLE, /* comment */
	MSG_TYPE_NPC,        /* NPCのメッセージデータベースアクセス */
	MSG_TYPE_HERO,       /* 仲間の会話メッセージデータベースアクセス */
	MSG_TYPE_EVENT,      /* 宝箱を開けたなどのイベントメッセージデータベースアクセス */
	MSG_TYPE_STORY,      /* ストーリー進行中のメッセージデータベースアクセス */
} MsgTypeNumber;

/**
 * @brief  メッセージDBアクセス時の利用する関数を選択するインデックスを定義
 * @note   
 * @retval None
 */
typedef enum
{
	MSG_FUNC_INDEX_0,
	MSG_FUNC_INDEX_1,
} MsgAccessNumber;

#endif
