#ifndef display_macro_h   /* prevent circular inclusions */
#define display_macro_h   /* by using protection macros */


/*
 * ディスプレイサイズと使用する画像データのサイズを管理
 */


/*
 * ディスプレイサイズ
 * ARGB32bit 4byte シフト値2
 */
#define RGB_SIZE		    (4)
#define RGB_BYTE_SHIFT      (2)
#define VIDEO_WIDTH		    (640)
#define VIDEO_HEIGHT	    (480)
#define MAX_V_WIDTH		    (VIDEO_WIDTH * RGB_SIZE)
#define DISPLAY_SIZE        (VIDEO_WIDTH * VIDEO_HEIGHT)


/* 原点を画面の中央 */
#define DISPLAY_CENTER_POS  ((240 * MAX_V_WIDTH) + (320 * 4))


/*
 * ディスプレイの半分の大きさを定義
 */
#define VIDEO_WIDTH_HALF    (VIDEO_WIDTH >> 1)
#define VIDEO_HEIGHT_HALF   (VIDEO_HEIGHT >> 1)


/*
 * 1マスの大きさ
 */
#define GRID_SIZE			(32)


/*
 * ストーリーモードのアニメーションの移動Pixel数を定義
 * 全画面アニメーション時に描画が遅い、又は揺れるようならば値を増やす
 */
#define ANIMATION_STORY_PIXEL_NUM	(4)
#define ANIMATION_MAX_PIXEL_NUM		(32)
#define ANIMATION_MAX_PIXEL_MASK	(31)


/*
 * ミニゲームモードのアニメーションixel数を定義
 */
#define ANIMATION_MINIGAME_PIXEL_X	(8)
#define ANIMATION_MINIGAME_PIXEL_Y	(0)



/*
 * マップチップの1マスの大きさ
 */
#define MAPCHIP_WIDTH			(32)
#define MAPCHIP_HEIGHT			(32)


/*
 * DRAMアクセス時に4byteデータのサイズでアクセス
 *
 * MAPCHIPの大きさ32 = 5bitシフト値
 */
#define MAPCHIP_HEIGHT_SHIFT 	(5 + RGB_BYTE_SHIFT)	//1を32にし、4byteに変換
#define MAPCHIP_WIDTH_SHIFT  	(5 + RGB_BYTE_SHIFT)
#define MAPCHIP_TOTAL_SIZE	 	(MAPCHIP_WIDTH * MAPCHIP_HEIGHT)
#define MAPCHIP_SHIFT			(5)


/*
 * 画面幅に対するマップチップの配置可能個数
 */
#define MAPCHIP_DRAW_MAX_WIDTH				(VIDEO_WIDTH / MAPCHIP_WIDTH)
#define MAPCHIP_DRAW_MAX_HEIGHT				(VIDEO_HEIGHT / MAPCHIP_HEIGHT)
#define MAPCHIP_DRAW_TOTAL_SIZE				(MAPCHIP_DRAW_MAX_WIDTH * MAPCHIP_DRAW_MAX_HEIGHT)
#define MAPCHIP_DRAW_MAX_WIDTH_ANIMATION	(MAPCHIP_DRAW_MAX_WIDTH - 1)
#define MAPCHIP_DRAW_MAX_HEIGHT_ANIMATION	(MAPCHIP_DRAW_MAX_HEIGHT - 1)


/*
 * マップアニメーション時の開始座標簡略
 */
#define START_RIGHT_ANIMATION_POS			(MAX_V_WIDTH * MAPCHIP_HEIGHT)
#define START_LEFT_ANIMATION_POS			(MAX_V_WIDTH * MAPCHIP_HEIGHT)
#define START_UP_ANIMATION_POS				(MAX_V_WIDTH * MAPCHIP_HEIGHT)
#define START_DOWN_ANIMATION_POS			(MAX_V_WIDTH * MAPCHIP_HEIGHT)


/*
 * キャラクターの1マスの大きさ
 */
#define SIZE_UNIT_WIDTH          		  (32)
#define SIZE_UNIT_HEIGHT         		  (32)
#define SIZE_UNIT_TOTAL_SIZE     		  (SIZE_UNIT_WIDTH * SIZE_UNIT_HEIGHT)
#define SIZE_UNIT_MASK_WIDTH     		  (SIZE_UNIT_WIDTH - 1)
#define SIZE_UNIT_SHIFT_POS      		  (5)
#define SIZE_UNIT_HALF_WIDTH     		  (SIZE_UNIT_WIDTH >> 1)
#define SIZE_UNIT_HALF_HEIGHT    		  (SIZE_UNIT_HEIGHT >> 1)

/* 原点を中央とした時のマップキャラクターの画面中央座標 */
#define CHARA_CENTER_POS	(DISPLAY_CENTER_POS - (SIZE_UNIT_HALF_WIDTH << RGB_BYTE_SHIFT) - (SIZE_UNIT_HALF_HEIGHT * MAX_V_WIDTH))


/*
 * 戦闘時のキャラクターのチップサイズ
 */
#define SIZE_UNIT_BATTLE_WIDTH              (32)
#define SIZE_UNIT_BATTLE_WIDTH_POS          (32 << RGB_BYTE_SHIFT)
#define SIZE_UNIT_BATTLE_WIDTH_HALF         (32 / 2)
#define SIZE_UNIT_BATTLE_WIDTH_HALF_POS     (SIZE_UNIT_BATTLE_WIDTH_HALF << RGB_BYTE_SHIFT)
#define SIZE_UNIT_BATTLE_HEIGHT             (48)
#define SIZE_UNIT_BATTLE_HEIGHT_HALF_POS    ((SIZE_UNIT_BATTLE_HEIGHT / 2) * MAX_V_WIDTH)
#define SIZE_UNIT_BATTLE_TOTAL_HALF_POS     (SIZE_UNIT_BATTLE_WIDTH_HALF_POS + SIZE_UNIT_BATTLE_HEIGHT_HALF_POS)
#define SIZE_UNIT_BATTLE_TOTAL_SIZE         (SIZE_UNIT_BATTLE_WIDTH * SIZE_UNIT_BATTLE_HEIGHT)



/*
 * アイコンのチップサイズ
 */
#define SIZE_ICON_WIDTH             (16)
#define SIZE_ICON_WIDTH_HALF        (SIZE_ICON_WIDTH / 2)
#define SIZE_ICON_HEIGHT            (16)
#define SIZE_ICON_HEIGHT_HALF       (SIZE_ICON_HEIGHT / 2)
#define SIZE_ICON_TOTAL_SIZE        (SIZE_ICON_WIDTH * SIZE_ICON_HEIGHT)
#define SIZE_ICON_2_WIDTH           (30)
#define SIZE_ICON_2_HEIGHT          (34)
#define SIZE_ICON_2_WIDTH_POS       (SIZE_ICON_2_WIDTH << RGB_BYTE_SHIFT)


/*
 * キャラクターのマップチップの余白の数
 */
#define RIGHT_MOD   (32 - 5)
#define LEFT_MOD    (32 - RIGHT_MOD)
#define UP_MOD		(18)
#define DOWN_MOD	(31)


/*
 * キャラクターの最大描画座標
 */
#define SIZE_UNIT_MAX_YDRAW  (VIDEO_HEIGHT - SIZE_UNIT_HEIGHT - MAPCHIP_HEIGHT)
#define SIZE_UNIT_MAX_XDRAW  (VIDEO_WIDTH - SIZE_UNIT_WIDTH)


/*
 * ミニゲームのブロックの1マスの大きさ
 */
#define SIZE_BLOCK_WIDTH         (32)
#define SIZE_BLOCK_HEIGHT        (32)
#define SIZE_BLOCK_TOTAL_SIZE    (SIZE_BLOCK_WIDTH * SIZE_BLOCK_HEIGHT)


/*
 * ミニゲームのブロックの最大移動座標
 */
#define BLOCK_MAX_XMOVE     (VIDEO_WIDTH - MAPCHIP_WIDTH - 1)
#define BLOCK_MAX_YMOVE     (VIDEO_HEIGHT - MAPCHIP_HEIGHT - MAPCHIP_HEIGHT)


/*
 * ミニゲームの踏みつけエフェクトの描画幅
 */
#define SIZE_HITBOX_WIDTH    (120)
#define SIZE_HITBOX_HEIGHT   (120)
#define SIZE_HITBOX_MAXSIZE  (SIZE_HITBOX_WIDTH * SIZE_HITBOX_HEIGHT)


/*
 * ミニゲームの爆弾エフェクトの描画幅
 */
#define SIZE_BOMB_WIDTH   (240)
#define SIZE_BOMB_HEIGHT  (240)
#define SIZE_BOMB_MAXSIZE (SIZE_BOMB_WIDTH * SIZE_BOMB_HEIGHT)


/*
 * ミニゲームの撃墜エフェクトの描画幅
 */
#define SIZE_PITYUN_WIDTH        (120)
#define SIZE_PITYUN_HEIGHT       (120)
#define SIZE_PITYUN_MAXSIZE      (SIZE_PITYUN_WIDTH * SIZE_PITYUN_HEIGHT)


/* 通常のバトルエフェクトの描画幅 */
#define SIZE_EFFECT_BATTLE_WIDTH                (120)   //通常攻撃系
#define SIZE_EFFECT_BATTLE_HEIGHT               (120)
#define SIZE_EFFECT_BATTLE_STANDERD_MAXSIZE     (SIZE_EFFECT_BATTLE_WIDTH * SIZE_EFFECT_BATTLE_HEIGHT)

#define SIZE_EFFECT_CONDITION_WIDTH             (96)   //回復系、状態異常系
#define SIZE_EFFECT_CONDITION_HEIGHT            (96)
#define SIZE_EFFECT_BATTLE_CONDITION_MAXSIZE    (SIZE_EFFECT_CONDITION_WIDTH * SIZE_EFFECT_CONDITION_HEIGHT)

#define SIZE_EFFECT_ALL_ATTACK_WIDTH            (640)
#define SIZE_EFFECT_ALL_ATTACK_HEIGHT           (480)
#define SIZE_EFFECT_ALL_ATTACK_MAXSIZE          (SIZE_EFFECT_ALL_ATTACK_WIDTH * SIZE_EFFECT_ALL_ATTACK_HEIGHT)


/*
 * ミニゲーム用数字フォントの描画幅 
 */
#define SIZE_FONT_NUMBER_WIDTH   	(12)
#define SIZE_FONT_NUMBER_HEIGHT  	(24)
#define SIZE_FONT_NUMBER_MAXSIZE    (SIZE_FONT_NUMBER_WIDTH * SIZE_FONT_NUMBER_HEIGHT)
#define SIZE_FONT_RESULT_WIDTH		(48)
#define SIZE_FONT_RESULT_HEIGHT		(96)
#define SIZE_FONT_RESULT_MAXSIZE	(SIZE_FONT_RESULT_WIDTH * SIZE_FONT_RESULT_HEIGHT)



/*
 * ver1. 2021/07/01
 * sjis 0213:2004フォントサイズ
 */
#define SIZE_FONT_SJIS_WIDTH	(12)
#define SIZE_FONT_SJIS_HALF		(12 >> 1)
#define SIZE_FONT_SJIS_HEIGHT	(12)
#define SIZE_FONT_SJIS_MAXSIZE	(SIZE_FONT_SJIS_WIDTH * SIZE_FONT_SJIS_HEIGHT)
#define SIZE_FONT_SJIS_ADDRSIZE	(SIZE_FONT_SJIS_MAXSIZE << RGB_BYTE_SHIFT)


/*
 * ver1. 2021/07/25
 * 戦闘のダメージ描画に使用する数字フォント
 */
#define SIZE_FONT_DAMEGE_WIDTH   (8)
#define SIZE_FONT_DAMEGE_WIDTH_SHIFT (8 << RGB_BYTE_SHIFT)
#define SIZE_FONT_DAMEGE_HEIGHT  (16)
#define SIZE_FONT_DAMEGE_MAXSIZE (SIZE_FONT_DAMEGE_WIDTH * SIZE_FONT_DAMEGE_HEIGHT)


/*
 * ver1. 2021/08/03
 * 戦闘中の行動可能を表すフレームのサイズ
 */
#define SIZE_BATTLE_HERO_FRAME_WIDTH	(48)
#define SIZE_BATTLE_HERO_FRAME_HEIGHT	(58)


#endif
