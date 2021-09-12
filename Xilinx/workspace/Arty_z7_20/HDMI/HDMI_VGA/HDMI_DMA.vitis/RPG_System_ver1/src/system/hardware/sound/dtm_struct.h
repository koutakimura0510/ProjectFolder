/*
 * 音源再生データベース構造体管理ヘッダーファイル
 *
 * 同時音源再生数4つまでとする
 *
 * 1. BGM
 * 2. スイッチ操作音
 * 3. エフェクト音1
 * 4. エフェクト音2
 */

#ifndef dtm_struct_h   /* prevent circular inclusions */
#define dtm_struct_h   /* by using protection macros */

/*
 * 音源再生動作の作業領域
 *
 * 再生する音源が保存されているアドレスを指定
 * *soundp
 * 
 * 再生する音源のバイト数を保存
 * len
 * 
 * 再生する音源のループ判定
 * true : ループ処理
 * false: ループ処理をしない
 * sound_loop
 * 
 * 再生中の音源のシーク箇所を保存
 * seek
 * 
 * 再生中か停止中か判定
 * true : 再生
 * false: 停止
 * play
 *
 * 再生音量
 * volume
 * 
 * 32bit音源データ
 * sounddata
 * 
 * 移動平均フィルタ
 * buffer
 * total
 * average_cnt
 */
typedef struct dtmwork
{
    uint32_t *soundp;
    uint32_t *backup;
    uint32_t len;
    bool     sound_loop;
    uint32_t seek;
    bool     play;
    uint32_t volume;
    uint32_t sounddata;
    uint32_t buffer[FILTER_BUFFER_SIZE];
    uint32_t total;
    uint8_t  average_cnt;
} DtmWork;


#endif
