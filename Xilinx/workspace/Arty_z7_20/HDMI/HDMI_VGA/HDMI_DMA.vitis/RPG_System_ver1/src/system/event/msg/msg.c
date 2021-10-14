/*
 * Create 2021/06/20
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
 * メッセージ関連の関数をまとめたファイル
 * 12dotサイズのフォントを使用する、sjis規格のためファイルの文字コードをsjisに変更する
 * Index参照URL https://www.eonet.ne.jp/~kotobukispace/ddt/jisx0213/sjis8xxx.html
 */ 
#include "../../wrapper/game_wrapper.h"


/**
 * @brief  DRAMのメッセージデータアクセス関数操作、関数ポインタテーブル
 * @note   可変と不変のメッセージ参照関数が異なるため、関数テーブルを利用して処理を分岐させることとした
 * @param  fetch_dram_db: メッセージ内容が変わらない場合の関数処理
 * @param  fetch_dram_msg: メッセージ内容が変わる場合の関数処理
 * @retval 
 */
static const uint32_t (*const funcMsg[])(GameWrapper *const game, uint8_t main_member, uint32_t sub_id, uint32_t sub_member) {
    fetch_dram_db,
    fetch_dram_msg,
};


/**
 * @brief  メッセージの種類に対応するデータベースアクセスIDを管理する
 * 
 * @note  データの並び順と実行関数は以下の通りである
 * MSG_TYPE_UNVARIABLE fetch_dram_db
 * MSG_TYPE_NPC fetch_dram_msg
 * MSG_TYPE_HERO fetch_dram_msg
 * MSG_TYPE_EVENT fetch_dram_db
 * MSG_TYPE_STORY fetch_dram_msg
 * 
 * @retval None
 */
typedef struct msg_type
{
    uint8_t system_member;
    uint32_t sub_member;
} Msg_Type;

static const Msg_Type msg_type[] = {
    {0, 0,}, /* 0で固定 */
    {MEMORY_NPC_MSG_ID, 0,},
    {0, 0,}, /* まだDBを作成していない */
    {MEMORY_BUILD_MSG_ID, EVENT_MSG_SUB_MSG,},
    {0, 0,}, /* まだDBを作成していない */
};

/*
 * ファイル内関数宣言
 */
static uint32_t sjis_index(uint32_t lsb, uint32_t msb);
static uint32_t get_result(uint32_t result, uint8_t *buff);


/*
 * ver1. 2021/07/25
 * comment
 */
void damege_font_draw(GameWrapper *const game, uint32_t pos, uint32_t result, uint32_t srcin)
{
    uint8_t d[8];
    uint32_t count = get_result(result, d);

    game->mapchip.srcin      = srcin;
    game->mapchip.maxwidth	 = SIZE_FONT_DAMEGE_WIDTH;
    game->mapchip.maxheight	 = SIZE_FONT_DAMEGE_HEIGHT;
    game->mapchip.draw_xsize = SIZE_FONT_DAMEGE_WIDTH;
    game->mapchip.draw_ysize = SIZE_FONT_DAMEGE_HEIGHT;
    game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = 255;

    for (uint32_t i = 0; i < count; i++)
    {
        game->mapchip.id         = d[count - i - 1];
        game->mapchip.dstin      = game->conf.work.adr + pos + (i * SIZE_FONT_DAMEGE_WIDTH_SHIFT);
        game->mapchip.dstout     = game->mapchip.dstin;
        png_mapchip(game);
    }
}


/*
 * ver1. 2021/07/03
 * 数字データからフォントの検索を行い指定座標に描画
 * 
 * 開始座標をpixel単位で指定
 * xstart, ystart
 * 
 * 表示させる数字データを指定
 * result
 * 
 * ゼロサプレスの動作方法を指定
 * zero_sup
 */
void result_font_draw(GameWrapper *const game, uint32_t xstart, uint32_t ystart, uint32_t result, uint8_t zero_sup)
{
    uint8_t d[8];
    uint32_t count = get_result(result, d);

    switch (zero_sup)
    {
    case ZERO_SUP_ON:
        if (count < HP_MAX_NUMBER)
        {
            xstart += SIZE_FONT_SJIS_WIDTH;
        }
        break;

    case ZERO_SUP_STATUS:
        for (uint8_t i = 0; i < NUM(d) - count; i++)
        {
            xstart += SIZE_FONT_SJIS_WIDTH;
        }
        break;

    default:
        break;
    }

    for (uint32_t i = 0; i < count; i++)
    {
        font_dram_draw(game, xstart + (i * SIZE_FONT_SJIS_WIDTH), ystart, MEMORY_CMD_MSG_ID, d[count - i - 1], EVENT_MSG_SUB_MSG, COLOR_WHITE);
    }
}


/**
 * @brief  メッセージウィンドウの描画処理
 * @note   発生するメッセージイベントの種類に応じてDRAMにアクセスするデータをを変更する
 * @retval None
 */
void event_msg_draw(GameWrapper *const game)
{
    const Msg_Type *p = &msg_type[game->conf.msg.type];

    patblt(game->conf.work.adr, MSG_WINDOW_WHITE_FRAME_XSTART, MSG_WINDOW_WHITE_FRAME_YSTART, MSG_WINDOW_WHITE_FRAME_XEND, MSG_WINDOW_WHITE_FRAME_YEND, COLOR_WHITE);
    patblt(game->conf.work.adr, MSG_WINDOW_BLACK_FRAME_XSTART, MSG_WINDOW_BLACK_FRAME_YSTART, MSG_WINDOW_BLACK_FRAME_XEND, MSG_WINDOW_BLACK_FRAME_YEND, COLOR_BLACK);
    font_dram_draw(game, EVENT_MSG_XSTRAT, EVENT_MSG_YSTRAT, p->system_member, game->conf.event.id, p->sub_member, COLOR_WHITE);
}


/*
 * ver1. 2021/07/15
 * DRAMに保存されている文字列データを描画する
 * 
 * xstart 画面サイズ 0~639の値を指定
 * ystart 画面サイズ 0~479の値を指定
 * 
 * 引数例
 * DRAMに保存されているアイテムデータの内、アイテム番号がITEM_OUGONDANGO(2)で、nameを取得したい場合
 * 
 * system_member = MEMORY_ITEM_ID
 * file_id       = ITEM_OUGONDANGO、データベースのID
 * sub_member    = ITEM_SUB_MEMBER_NAME、メンバ名
 */
void font_dram_draw(GameWrapper *const game, uint32_t xstart, uint32_t ystart, uint8_t system_member, uint32_t file_id, uint32_t sub_member, uint32_t color)
{
    uint32_t msg_count = 0; // 文字数カウント
    uint32_t line = 0;      // 改行計算用

    funcMsg[game->conf.msg.access_func](game, system_member, file_id, sub_member);


    game->mapchip.maxwidth	 = SIZE_FONT_SJIS_WIDTH;
	game->mapchip.maxheight	 = SIZE_FONT_SJIS_HEIGHT;
	game->mapchip.draw_xsize = SIZE_FONT_SJIS_WIDTH;
	game->mapchip.draw_ysize = SIZE_FONT_SJIS_HEIGHT;
	game->mapchip.xstart_pos = 0;
    game->mapchip.ystart_pos = 0;
	game->mapchip.frame_size = VIDEO_WIDTH;
	game->mapchip.com        = COLOR_WHITE;
	game->mapchip.fill       = color;
	game->mapchip.alpha		 = 255;
    game->mapchip.id         = 0;

    for (uint32_t i = 0; i < *game->conf.db.len; i++)
    {
        uint32_t xpos  = XRGB((xstart + (msg_count * SIZE_FONT_SJIS_WIDTH)));
        uint32_t ypos  = YRGB((line + ystart));
        uint32_t lsb    = (*game->conf.db.data >> 8) & 0x000000ff;
        uint32_t msb    = *game->conf.db.data & 0x000000ff;
        uint32_t index = sjis_index(lsb, msb);
        game->mapchip.srcin  = DRAM_FONT_SJIS_ADDR_BASE + (index * SIZE_FONT_SJIS_ADDRSIZE);
        game->mapchip.dstin  = xpos + ypos + game->conf.work.adr;
        game->mapchip.dstout = game->mapchip.dstin;
        color_mapchip(game);
        game->conf.db.data++;
        msg_count++;

        while (*game->conf.db.data == '\n')
        {
            i++;
            game->conf.db.data++;
            line += SIZE_FONT_SJIS_HEIGHT;
            msg_count = 0;
        }
    }
}


/*
 * ver1. 2021/07/15
 * sjisの文字列の文字コードを計算処理を行う
 */
static uint32_t sjis_index(uint32_t lsb, uint32_t msb)
{
    uint32_t index = ((lsb - 129) * 188) + msb;
    index -= (msb < 0x80) ? 64 : 65;

    return index;
}


/*
 * ver1. 2021/07/25
 * 10進数データを1桁に分解して配列の中に保存し桁数を取得
 */
static uint32_t get_result(uint32_t result, uint8_t *buff)
{
    uint32_t count = 0;

    do
    {
        buff[count] = result % 10;
        result /= 10;
        count++;
    } while (result != 0);

    return count;
}
