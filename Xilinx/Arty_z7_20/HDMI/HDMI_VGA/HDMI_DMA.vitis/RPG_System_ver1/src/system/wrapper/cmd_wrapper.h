#ifndef cmd_wrapper_h   /* prevent circular inclusions */
#define cmd_wrapper_h   /* by using protection macros */


/*
 * ver1. 2021/07/20
 *
 * sub_id
 * カーソルのサブウィンドウの管理
 * 決定時のコマンドによってサブウィンドウを表示するか判定するため、
 * コマンド決定時にコマンドに対応したIDを保存する
 * 
 * system
 * サブウィンドウ内で状態遷移を使用する場合に利用
 * 
 * effect
 * サブウィンドウ内でコマンド確定時にエフェクトの描画が必要ならばエフェクトのIDを保存し利用する
 * 
 * anime
 * サブウィンドウ内でコマンド確定時にアニメーションの処理を行う必要があれば
 * モードに対応した定数を保存し利用する
 */
typedef struct
{
    uint8_t sub_id;
    uint8_t system;
    uint8_t effect;
    uint8_t anime;
} CursolWindow;


/**
 * @brief  カーソルの座標を管理する
 * @note   基本的にx,y,xend,yendメンバを利用する。
 *         特殊な動作が必要な場合にoldx, oldy, y_enter, finishメンバを利用する
 * @retval None
 */
typedef struct
{
    int32_t x;          /* カーソルの現在のx座標 */
    int32_t y;          /* カーソルの現在のy座標 */
    uint8_t xend;       /* カーソルの最大x移動幅 */
    uint8_t yend;       /* カーソルの最大y移動幅 */
    int32_t oldx;       /* カーソルの前回のx座標を使用する時に使用 */
    int32_t oldy;       /* カーソルの前回のy座標を使用する時に使用 */
    int32_t y_enter;    /* 決定時のカーソルの現在のy座標を保存する時に使用 */
    bool    finish;     /* コマンド操作時に、最後の状態の決定処理判定時に使用 */
} CursolCmd;

/*
 * ver2. 2021/08/16
 * コメント追加
 * 
 * ver1. 2021/06/27
 * ウィンドウのイベント処理に必要なメンバを管理
 * 
 * system       コマンド操作時のキー入力の親モードを管理するメンバ
 *              メニューモード、戦闘モード、イベントモードなどのモード変数を保存しキー操作の処理を行う
 * 
 * sub_system   親モードのサブ画面の構成を管理
 *              メニュー画面であれば、
 *              ・メニュー画面
 *              ・はなす画面
 *              ・パーティ画面
 *              ・料理画面
 *              などの状態があるため、これらの状態遷移を処理するために親モードとは別に状態遷移のIDを保存しておく必要がある。
 */
typedef struct cmd 
{
    CursolWindow window;
    CursolCmd cursol;
    uint8_t system;
    uint8_t sub_system;
} CmdWrapper;


#endif
