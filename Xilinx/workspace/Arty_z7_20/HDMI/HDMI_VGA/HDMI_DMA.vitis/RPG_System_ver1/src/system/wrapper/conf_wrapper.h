/*
 * Create 2021/07/04
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
 * ゲームモードのシステム動作に使用するデータを管理するファイル
 */
#ifndef conf_wrapper_h   /* prevent circular inclusions */
#define conf_wrapper_h   /* by using protection macros */


#include "battle_conf.h"


/*
 * 描画データを保存するDRAMのアドレスを管理
 */
typedef struct work
{
    uint32_t adr;
} WorkArea;


/*
 * ver1. 2021/07/04
 * ファイルアクセスに必要なデータを管理
 * -
 * mapdata  ファイル構造体にアクセスするマップデータのIDを保存
 * object   ファイル構造体にアクセスするマップのオブジェクトデータのIDを保存
 * bgm      ファイル構造体にアクセスするマップに対応したBGMデータのIDを保存
 * mapchip  マップデータの描画に使用するマップチップデータにアクセスするためのIDを保存
 */
typedef struct file
{
    uint32_t mapdata;
    uint32_t object;
    uint32_t region;
    uint32_t npc;
    uint32_t bgm;
    uint32_t mapchip;
} FileAccses;



/*
 * ver1. 2021/07/04
 * マップの描画や動作内容に関するデータを管理
 * 
 * back         マップのバックグラウンドに描画するデータのアドレスを保存
 * obj          マップのオブジェクトに描画するデータのアドレスを保存
 * canpass_id   通行可能なオブジェクトのIDを保存
 * obj_startid  オブジェクトの画像データの開始番号を指定、通常0から開始
 * obj_endid    オブジェクトの画像データの終了番号を指定
 * name         現在表示中、または表示させるマップ名のIDを保存
 */
typedef struct map
{
    uint32_t *back;
    uint32_t *obj;
    uint8_t  canpass_id;
    uint8_t  obj_startid;
    uint8_t  obj_endid;
    uint32_t name;
} MapConf;


/*
 * ver1. 2021/07/04
 * ゲームモード中に発生するイベントIDとそのタイプを管理
 */
typedef struct event
{
    uint32_t id;
    uint32_t type;
} EventConf;


/*
 * ver1. 2021/07/04
 * ゲームの表示システムに関するデータを管理
 * -
 * system           ウィンドウ描画の状態遷移IDを保存する
 *                  イベントの状況に応じてウィンドウの状態遷移を変更する必要があるため、このメンバを用いて様々なウィンドウのモード管理を行う
 * 
 * sub_state        メニュー表示などのサブディスプレイを操作する時に使用するメンバ。状態変数の保存などに使う
 * drawtype         暗転表示や通常表示などの表示モードのIDを保存
 * uncommon_window  特定の条件下でウィンドウを表示させるときや、window描画のデータ処理に使用
 *                  例、バトル中のわざめい表示、ゲージの管理など
 */
typedef struct display
{
    uint32_t system;
    uint32_t sub_state;
    uint8_t  drawtype;
    uint32_t uncommon_window;
} DisplayConf;


/*
 * ver1. 2021/07/04
 * ゲームモードのフラグや仲間の人数などのシステム動作処理のメンバを管理
 * 
 * paty_member  現在の仲間の人数を保存
 * money        現在の所持金
 */
typedef struct system
{
    uint32_t romen_flag;
    uint8_t  paty_member;
    uint32_t money;
} SystemConf;


/*
 * ver2. 2021/07/30
 * oldメンバ追加
 * 処理速度向上のためファイルデータにアクセスしたIDやメンバ定数を保持しておき
 * 次回同じIDにアクセスしたときに、アドレスを更新しなくてもよい処理にした
 * -
 *
 * ver1. 2021/07/20
 * ファイルデータのアドレスを参照しデータとデータの長さを取得し保存する
 */
typedef struct
{
    uint32_t *data;
    uint32_t *len;
    uint32_t *old_data;
    uint32_t *old_len;
    uint8_t old_main_member;
    uint32_t old_sub_id;
    uint32_t old_sub_member;
} DBConf;


/*
 * ver2. 2021/07/05
 * conf構造体のメンバに変更
 *
 * ver1. 2021/06/22
 * 前回のIDとカウント数を保存
 * 
 * 処理速度の改善のため、前回アクセスしたデータベースの列カウントとIDを保存しておき、
 * 今回のIDが前回と一致した場合に列カウント分、一度にデータベースのアドレスを進める
 */
typedef struct old_access
{
    /* マップの前回のID操作用メンバ */
	uint32_t startid;
	uint32_t start_row_count;
	uint32_t nextmap;
	uint32_t row_count;

    /* 戦闘用の前回のID操作用メンバ */
    uint8_t id;
    uint8_t cnt;
} OldAccess;


/*
 * ver1. 2021/07/25
 * アニメーションの座標処理メンバを管理
 * 
 * vel      移動量の重みを指定
 * acc      移動量やアニメーションの最大値を指定
 * y        移動後のy座標計算用に使用
 * -
 * 下記のメンバは必要な時に使用する
 * 
 * state    指定座標移動した場合の状態遷移に使用
 * count    状態を変更する時の判定用に使用
 */
typedef struct
{
    int32_t vel;
    int32_t acc;
    int32_t y;
    uint8_t state;
    uint32_t count;
} AnimationConf;


/*
 * ver1. 2021/08/17
 * 料理に関するデータを管理する構造体
 * 
 * master[] 覚えた料理のIDをIDに対応したインデックスに保存していく
 * level[]  料理の熟練度を保存
 * count[]  料理の使用回数を保存。熟練度判定に利用する
 * isCook   true 料理可能 false 料理不可
 */
typedef struct
{
    uint8_t master[COOK_MAX];
    uint8_t level[COOK_MAX];
    uint8_t count[COOK_MAX];
    bool isCook;
} CookingConf;


/**
 * @brief   アイテムの所持を管理するデータベース
 * 
 * @note    アイテムのIDと配列のインデックスは等しい。
 *          ゲームでよくある、99個までアイテムを持てたりするシステムはやめて、すべてのアイテムは売ることができずに
 *          一つだけ所持が可能とした、なので同じアイテムは存在しない
 *          装備選択時には仲間の装備のIDを参照し、既に誰かが使用中であれば文字書記を灰色にするなどする
 *
 * @version 1.0 2021/08/29
 */
typedef struct
{
    uint8_t weapon[WEAPON_NAME_ID_END];
    uint8_t armor[ARMOR_NAME_ID_END];
    uint8_t amulet[AMULET_NAME_ID_END];
    uint8_t tool[ITEM_NAME_ID_END];
} ItemConf;


/**
 * @brief  色データを生成しアニメーションなどの操作をする時に使用
 * @note   Xilinxの映像出力の仕様上、ARBGの色データの並び順になっている
 * 
 * @param alpha 透過値
 * @param r 赤
 * @param b 青
 * @param g 緑
 * @param update_time[] 時間経過で色データの変更を行う時に利用する
 * @retval None
 */
typedef struct
{
    uint32_t alpha;
    uint32_t r;
    uint32_t b;
    uint32_t g;
    uint32_t update_time[COLOR_NUMBER_ARBG];
} ColorConf;


/*
 * ver2. 2021/07/04
 * メンバの要素を親子関係に分けて管理するように変更
 * -
 * ver1
 * システムの設定状況を管理
 */
typedef struct conf
{
    OldAccess   old;
    SystemConf  system;
    DBConf      db;
    DisplayConf display;
    WorkArea    work;
    FileAccses  file;
    MapConf     map;
    EventConf   event;
    BattleConf  battle;
    AnimationConf animation;
    CookingConf cook;
    ItemConf    item;
    ColorConf   color;
} ConfWrapper;

#endif
