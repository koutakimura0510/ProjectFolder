/**
 * Create 2021/09/20
 * Author koutakimura
 * Editor VSCode ver1.57.1
 * Build  Vitis20.2
 * Borad  ArtyZ7-20
 * -
 * @brief npcの操作に関する処理を管理するファイル
 */
#include "../../wrapper/game_wrapper.h"
#include "npc_struct.h"
#include "xil_cache.h"


/* npc_draw関数内で実行 */
static void npc_position_update(GameWrapper *const game);
static void npc_mapchip_update(GameWrapper *const game);
static void npc_pixel_draw(GameWrapper *const game);

/* 次の行動パターンを決定 */
static void npc_random_update(GameWrapper *const game, uint8_t index);

/* 現在座標から描画方法を決定 */
static bool isNpc_edge(GameWrapper *const game, SDL_Rect *const lsbEdge, SDL_Rect *const msbEdge, uint8_t index);
static void npc_side_edge(GameWrapper *const game, SDL_Rect *const lsbEdge, SDL_Rect *const msbEdge, uint8_t index);
static void npc_vertical_edge(GameWrapper *const game, SDL_Rect *const lsbEdge, SDL_Rect *const msbEdge, uint8_t index);

/* NPCのアニメーション処理時の座標・向き更新 */
static void npc_dir_update(GameWrapper *const game, uint8_t index);
static void npc_pixel_update(GameWrapper *const game, uint8_t index);


/**
 * @brief  NPCのアニメーション状態によってメンバの更新関数を変更する関数ポインタ
 * @note   
 * @retval None
 */
typedef struct
{
	void (*const npc_position[NPC_ACTIVE_NUMBER])(GameWrapper *const game, uint8_t index);
} NpcPosition;

static const NpcPosition npc_position = {
	{npc_dir_update, npc_pixel_update},
};



/**
 * @brief  DRAMに保存されているNPCのデータをラッパー構造体に保存
 * @note   構造体に保存しておくと、DRAMアクセスの時間を減らせるため作った
 * @retval None
 */
void npc_config(GameWrapper *const game)
{
    for (uint8_t i = 0; i < NPC_MAX_DRAW_NUM; i++)
    {
        uint32_t map_npcid = fetch_dram_db(game, MEMORY_NPC_MAP_ID, game->conf.map.name, NPC_SUB_MEMBER_MAP_NPC_NUM_0 + i);

        if (map_npcid == 0)
        {
            game->npc.number = i;
            break;
        }

        game->npc.map_npcid[i]    = map_npcid;
        game->npc.id[i]           = fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, map_npcid,       NPC_SUB_MEMBER_PATTERN_NPCID);
        game->npc.mapchip_id[i]   = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID,  game->npc.id[i], NPC_SUB_MEMBER_BITMAP_MAPCHIPID);
        game->npc.cut_pos[i]      = 0;
        game->npc.dir[i]          = NPC_DIR_DOWN;
        game->npc.cut_dir[i]      = 0;
        game->npc.anime_time[i]   = 0;
        game->npc.dir_time[i]     = 0;
        game->npc.active_state[i] = NPC_ACTIVE_STAND;
        game->npc.map_pos[NPC_INDEX_X][i] = 0;
        game->npc.map_pos[NPC_INDEX_Y][i] = 0;
    }

    int32_t xsize = get_mapsize('w');
    int32_t size  = xsize * get_mapsize('h');

    for (uint8_t j = 0; j < game->npc.number; j++)  /* 初期位置のインデックスを保存 */
    {
        uint32_t *buffer = DRAM_MAPDATA_NPC_ADDR_START;

        for (int32_t i = 0; i < size; i++, buffer++)
        {
            if (*buffer == game->npc.map_npcid[j])
            {
                int32_t div = i / xsize;    /* 整数部の取得 */
                game->npc.ypos[j] = div << MAPCHIP_SHIFT;   /* 整数部からy座標を検出 */
                game->npc.xpos[j] = (i - (div * xsize)) << MAPCHIP_SHIFT;  /* 整数部から残りのx座標を検出 */
                game->npc.dram_index[j] = i;
                break;
            }
        }
    }
}


/**
 * @brief  NPCのメッセージイベント発生処理
 * @note   
 * @retval 
 */
bool isNpc_event(GameWrapper *const game)
{
    SDL_Rect point = {
        .x = game->unit.pos.eventx >> MAPCHIP_SHIFT,
        .y = (game->unit.pos.eventy >> MAPCHIP_SHIFT) * get_mapsize('w'),
    };

    point.h = point.x + point.y;

	for (uint32_t i = 0; i < game->npc.number; i++)
    {
        if (game->npc.dram_index[i] == point.h)
        {
            // game->npc.dir[index]          = NPC_DIR_EDGE * rand_number;
            // game->npc.cut_dir[index]      = (game->npc.dir[index] == NPC_DIR_DOWN) ? 0 : game->npc.dir[index] + NPC_DIR_EDGE;
			game->conf.display.system   = SYSTEM_MSG_WINDOW;
			game->conf.display.drawtype = DISPLAY_FIELD_CENTER_DRAW;
            game->conf.msg.type         = MSG_TYPE_NPC;
            game->conf.msg.access_func  = MSG_FUNC_INDEX_1;
			return ON_DIRECT;
        }
    }

    return NON_DIRECT;
}


/**
 * @brief  npcの座標・向き更新・描画処理
 * 
 * @note
 * それぞれのデータ設定と現在座標のNPC描画関数を分けて考えた
 * 座標やマップチップ更新関数を一定期間ごとに実行し、
 * 描画関数内で設定されたデータに基づき処理を行うようにした
 * 
 * @retval None
 */
void npc_draw(GameWrapper *const game)
{
    npc_position_update(game);
    npc_mapchip_update(game);
    npc_pixel_draw(game);
}


/**
 * @brief  現在のNPCの状態によって座標・向きメンバの更新関数を実行する
 * 
 * @note   関数ポインタテーブル実行関数について
 * NPC_ACTIVE_ANIMATION : 座標更新関数を処理する
 * NPC_ACTIVE_STAND : 次のNPCの行動パターンを決定する関数を処理
 * 
 * @retval None
 */
static void npc_position_update(GameWrapper *const game)
{
    const NpcPosition *p = &npc_position;

    for (uint8_t i = 0; i < game->npc.number; i++)
    {
        p->npc_position[game->npc.active_state[i]](game, i);
    }
}


/**
 * @brief  npcの歩行アニメーションマップチップ更新処理
 * @note
 * 下記の計算について
 * game->npc.cut_pos[i] += 2;
 * game->npc.cut_pos[i] &= 0x02;
 * 
 * マップチップの並び順が0.左足、1.直立、2.右足の順番で並んでいる
 * 直立の描画は行わないため、0.左足、2.右足のマップチップを交互に入れ替える
 * 0と2の画像データを繰り返すため、カット座標を+2してビット演算で0と2を判定している
 * 
 * @retval None
 */
static void npc_mapchip_update(GameWrapper *const game)
{
    for (uint8_t i = 0; i < game->npc.number; i++)
    {
        if (true == tmr_constant(&game->npc.anime_time[i], fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[i], NPC_SUB_MEMBER_PATTERN_MAPCHIP_SPEED)))
        {
            game->npc.cut_pos[i] += 2;
            game->npc.cut_pos[i] &= 0x02;
            game->npc.anime_time[i] = get_time();
        }

        game->npc.mapchip_id[i] = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[i], NPC_SUB_MEMBER_BITMAP_MAPCHIPID) + game->npc.cut_pos[i] + game->npc.cut_dir[i];
    }
}


/**
 * @brief  npcとキャラクターの現在座標から描画幅の設定をしNPCの描画データ設定を行う
 * @note   
 * @retval None
 */
static void npc_pixel_draw(GameWrapper *const game)
{
    SDL_Rect lsbEdge = {
        /* キャラクターの座標から表示幅の端の座標を計算 */
        .x = game->unit.pos.unitx + game->unit.pos.fieldx - VIDEO_WIDTH_HALF,
        .y = game->unit.pos.unity + game->unit.pos.fieldy - VIDEO_HEIGHT_HALF_POS,

        /* キャラクターの座標からNPCの描画調整座標を計算 */
        .w = (game->unit.pos.fieldx < VIDEO_WIDTH_HALF) ? XRGB((VIDEO_WIDTH_HALF - (VIDEO_WIDTH_HALF - game->unit.pos.fieldx))) : XRGB((VIDEO_WIDTH_HALF + (game->unit.pos.fieldx - VIDEO_WIDTH_HALF))),
        .h = YRGB(game->unit.pos.fieldy),
    };

    SDL_Rect msbEdge = {
        /* キャラクターの座標から表示幅の端の座標を計算 */
        .x = game->unit.pos.unitx + game->unit.pos.fieldx + VIDEO_WIDTH_HALF,
        .y = game->unit.pos.unity + game->unit.pos.fieldy + VIDEO_HEIGHT_HALF_POS,
    };

    game->mapchip.frame_size = VIDEO_WIDTH;
    game->mapchip.alpha		 = COLOR_ALPHA_MAX;

    /* もし、NPC毎のに使用する画像データが異なればfor文内に移動する */
    game->mapchip.srcin      = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_SRCIN);
    game->mapchip.maxwidth	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_XSIZE);
    game->mapchip.maxheight	 = fetch_dram_db(game, MEMORY_NPC_BITMAP_ID, game->npc.id[0], NPC_SUB_MEMBER_BITMAP_YSIZE);

    for (uint8_t i = 0; i < game->npc.number; i++)
    {
        if (true == isNpc_edge(game, &lsbEdge, &msbEdge, i))
        {
            msbEdge.w = lsbEdge.w;
            msbEdge.h = lsbEdge.h;
            npc_side_edge(game, &lsbEdge, &msbEdge, i);
            npc_vertical_edge(game, &lsbEdge, &msbEdge, i);
            game->mapchip.id     = game->npc.mapchip_id[i];
            game->mapchip.dstin  = game->conf.work.adr + XRGB(game->npc.xpos[i]) + YRGB(game->npc.ypos[i]) - msbEdge.w - msbEdge.h;
            game->mapchip.dstout = game->mapchip.dstin;
            png_mapchip(game);
        }
    }
}


/**
 * @brief  キャラクターとNPCの座標から、NPCが描画可能か判定を行う
 * @note   
 * @param  lsb_edge: 左と上端の座標を保存している構造体のアドレス
 * @param  msb_edge: 右と下端の座標を保存している構造体のアドレス
 * @param  index: アクセスするNPCのインデックス番号
 * @retval 
 */
static bool isNpc_edge(GameWrapper *const game, SDL_Rect *const lsbEdge, SDL_Rect *const msbEdge, uint8_t index)
{
    if ((game->npc.xpos[index] < lsbEdge->x) && ((game->npc.xpos[index] + MAPCHIP_WIDTH) <= lsbEdge->x))
    {
        return false;
    }

    if (msbEdge->x <= game->npc.xpos[index])
    {
        return false;
    }

    if ((game->npc.ypos[index] < lsbEdge->y) && ((game->npc.ypos[index] + MAPCHIP_HEIGHT) <= lsbEdge->y))
    {
        return false;
    }

    if (msbEdge->y <= game->npc.ypos[index])
    {
        return false;
    }

    return true;
}



/**
 * @brief  X軸の描画幅の設定を行う
 * @note   
 * @param  lsbEdge: 左と上端の座標を保存している構造体のアドレス
 * @param  msbEdge: 右と下端の座標を保存している構造体のアドレス
 * @param  index: アクセスするNPCのインデックス番号
 * @retval None
 */
static void npc_side_edge(GameWrapper *const game, SDL_Rect *const lsbEdge, SDL_Rect *const msbEdge, uint8_t index)
{
    if ((game->npc.xpos[index] < msbEdge->x) && ((msbEdge->x - MAPCHIP_HEIGHT) <= game->npc.xpos[index])) /* 右端の描画処理 */
    {
        game->mapchip.xstart_pos = 0;
        game->mapchip.draw_xsize = msbEdge->x - game->npc.xpos[index];
        return;
    }

    if ((game->npc.xpos[index] < lsbEdge->x) && ((lsbEdge->x - MAPCHIP_WIDTH) <= game->npc.xpos[index])) /* 左端の描画処理 */
    {
        game->mapchip.xstart_pos = lsbEdge->x - game->npc.xpos[index];
        game->mapchip.draw_xsize = MAPCHIP_WIDTH - game->mapchip.xstart_pos;
        msbEdge->w -= XRGB(game->mapchip.xstart_pos);   /* 何故か描画がずれるため表示座標を調整している */
        return;
    }

    game->mapchip.xstart_pos = 0;
    game->mapchip.draw_xsize = MAPCHIP_WIDTH;
}


/**
 * @brief  Y軸の描画幅の設定を行う
 * @note   
 * @param  lsbEdge: 左と上端の座標を保存している構造体のアドレス
 * @param  msbEdge: 右と下端の座標を保存している構造体のアドレス
 * @param  index: アクセスするNPCのインデックス番号
 * @retval None
 */
static void npc_vertical_edge(GameWrapper *const game, SDL_Rect *const lsbEdge, SDL_Rect *const msbEdge, uint8_t index)
{
    if ((game->npc.ypos[index] < lsbEdge->y) && ((lsbEdge->y - MAPCHIP_HEIGHT) <= game->npc.ypos[index])) /* 上端の描画処理 */
    {
        game->mapchip.ystart_pos = lsbEdge->y - game->npc.ypos[index];
        game->mapchip.draw_ysize = MAPCHIP_WIDTH - game->mapchip.ystart_pos;
        msbEdge->h -= YRGB(game->mapchip.ystart_pos); /* 何故か描画がずれるため表示座標を調整している */
    }
    else
    {
        game->mapchip.ystart_pos = 0;
        game->mapchip.draw_ysize = MAPCHIP_HEIGHT;
    }
}


/**
 * @brief  npcの向きの更新処理
 * 
 * @note   
 * データベースから向きを変更する周期を取得し、前回の時間から一定時間経過していたら
 * NPCの行動パターンによってNPCの現在の座標を更新する
 * 
 * @retval None
 */
static void npc_dir_update(GameWrapper *const game, uint8_t index)
{
    if (false == tmr_constant(&game->npc.dir_time[index], fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[index], NPC_SUB_MEMBER_PATTERN_UPDATE_SPEED)))
    {
        return;
    }

    switch (fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[index], NPC_SUB_MEMBER_PATTERN_ACTION_PATTERN))
    {
    case NPC_PATTERN_RANDOM:
        npc_random_update(game, index);
        break;

    case NPC_PATTERN_ROULETTE:
        break;

    case NPC_PATTERN_STEP:
        break;

    case NPC_PATTERN_FAST_STEP:
        break;

    case NPC_PATTERN_STAND:
        break;
    
    default:
        break;
    }

    game->npc.dir_time[index] = get_time();
}


/**
 * @brief  状態NPC_ACTIVE_ANIMATIONのpixel座標更新処理
 * 
 * @note   
 * 移動数の重み分向きの方向にpixel座標の更新を行い、重みが0になればNPC_ACTIVE_STAND状態に移行する
 * 
 * @retval None
 */
static void npc_pixel_update(GameWrapper *const game, uint8_t index)
{
    switch (game->npc.dir[index])
    {
    case NPC_DIR_DOWN:
        game->npc.ypos[index] += game->unit.pos.animation_pixel_y;
        break;

    case NPC_DIR_UP:
        game->npc.ypos[index] -= game->unit.pos.animation_pixel_y;
        break;

    case NPC_DIR_RIGHT:
        game->npc.xpos[index] += game->unit.pos.animation_pixel_x;
        break;

    case NPC_DIR_LEFT:
        game->npc.xpos[index] -= game->unit.pos.animation_pixel_x;
        break;
    
    default:
        break;
    }

    game->npc.move_weight[index]--;

    if (game->npc.move_weight[index] == 0)
    {
        game->npc.active_state[index] = NPC_ACTIVE_STAND;
    }
}



/**
 * @brief  ランダム方向に行動するNPCの座標更新処理
 * @note   
 * npc.map_pos[][]の二次元配列参照計算方法
 * right,left時はx座標を更新しなければならない
 * up,down時はy座標を更新しなければならない
 * 
 * x = Index[0], right,left = 0,1
 * y = Index[1], up,down = 2,3
 * 1bitシフトすると0,もしくは1が残るためindexを参照できる
 * 
 * @retval None
 */
static void npc_random_update(GameWrapper *const game, uint8_t index)
{
    uint8_t rand_number = get_random(0x03); /* 上下左右の要素の合計が3のため 0 ~ 3の値を取得 */
    int8_t  range       = fetch_dram_db(game, MEMORY_NPC_PATTERN_ID, game->npc.map_npcid[index], NPC_SUB_MEMBER_PATTERN_RANGE_LEFT + rand_number);
    uint8_t range_bit   = rand_number >> 1;
    int32_t sign        = 0;

    if (range < game->npc.map_pos[range_bit][index]) /* 左、上移動の判定 */
    {
        sign = -1;
    }

    if (game->npc.map_pos[range_bit][index] < range) /* 右、下移動の判定 */
    {
        sign = 1;
    }

    if (sign != 0)
    {
        uint32_t *buffer = DRAM_MAPDATA_NPC_ADDR_START;

        /* npcの状態・向き・座標データ更新 */
        game->npc.dir[index]          = NPC_DIR_EDGE * rand_number;
        game->npc.cut_dir[index]      = (game->npc.dir[index] == NPC_DIR_DOWN) ? 0 : game->npc.dir[index] + NPC_DIR_EDGE;
        game->npc.active_state[index] = NPC_ACTIVE_ANIMATION;
        game->npc.map_pos[range_bit][index] += sign;

        /* 残り移動数の重みづけを行う (移動量 x 移動回数) = 32 / (移動量x / 2) */
        game->npc.move_weight[index] = MAPCHIP_WIDTH >> (game->unit.pos.animation_pixel_x >> 1);

        /* npcマップの移動前の座標を初期化 */
        buffer[game->npc.dram_index[index]] = 0;
        Xil_DCacheFlushRange((uint32_t)(buffer + game->npc.dram_index[index]), 4);

        /* 移動後の座標に番号を保存 */
        game->npc.dram_index[index] += (range_bit == 0) ? sign : get_mapsize('w') * sign;
        buffer[game->npc.dram_index[index]] = game->npc.map_npcid[index];
        Xil_DCacheFlushRange((uint32_t)(buffer + game->npc.dram_index[index]), 4);
    }
}