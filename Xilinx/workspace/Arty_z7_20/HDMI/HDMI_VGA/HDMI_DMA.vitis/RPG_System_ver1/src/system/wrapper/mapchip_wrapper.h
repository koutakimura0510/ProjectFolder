#ifndef mapchip_wrapper_h   /* prevent circular inclusions */
#define mapchip_wrapper_h   /* by using protection macros */


/**
 * @brief FPGAによる描画の処理を行うデータを管理する
 * 
 * @note 簡単な使い方
 * 横32pixelの画像データを貼り付けるとする
 * xstart_posを1に設定
 * draw_xsizeを31に設定すると
 * すると0pixel目のデータを切り抜いて描画する
 * 
 * 
 * @version 2.0 アフィン変換のメンバ追加
 */
typedef struct mapchip
{
    uint32_t srcin;         /* 描画を行うマップチップデータが保存されているDRAMの開始アドレス */
    uint32_t dstin;         /* 合成処理を行うマップチップデータが保存されているDRAMの開始アドレス */
    uint32_t dstout;        /* データを保存するフレームバッファ領域のアドレス */
    uint32_t maxwidth;      /* 描画を行うマップチップの最大横幅 */
    uint32_t maxheight;     /* 描画を行うマップチップの最大縦幅 */
    uint32_t draw_xsize;    /* 最大横幅に対しての描画を行う横幅を指定 */
    uint32_t draw_ysize;    /* 最大縦幅に対しての描画を行う縦幅を指定 */
    uint32_t xstart_pos;    /* 最大横幅に対しての開始pixelを指定 */
    uint32_t ystart_pos;    /* 最大縦幅に対しての開始pixelを指定 */
    uint32_t frame_size;    /* VIDEO_WIDTHのサイズを指定 */
    uint32_t com;           /* comと一致した色データをfillで塗りつぶす */
    uint32_t fill;          /* comと一致した色の塗りつぶし色を指定 */
    uint32_t alpha;         /* 透過の数値を指定 */
    uint32_t id;            /* マップチップのIDを指定 */
    uint32_t cut_color;     /* 切り取りを行う色データを指定 */
    int32_t a;              /* 行列1列目の基底ベクトル1 a 横拡大縮小*/
    int32_t b;              /* 行列2列目の基底ベクトル2 b +だと右に引っ張られる、-だと左に引っ張られる*/
    int32_t c;              /* 行列1列目の基底ベクトル1 c +だと左上に引っ張られる、-だと左下に引っ張られる*/
    int32_t d;              /* 行列2列目の基底ベクトル2 d 縦拡大縮小*/
    int32_t m;              /* 平行移動量m 横移動*/
    int32_t n;              /* 平行移動量n 縦移動*/
    int32_t rad;            /* 回転量のベクトル */
} ChipWrapper;


#endif
