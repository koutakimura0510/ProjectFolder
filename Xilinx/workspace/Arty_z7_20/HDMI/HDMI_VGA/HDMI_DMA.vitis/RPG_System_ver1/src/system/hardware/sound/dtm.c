#include "xparameters.h"
#include "../../wrapper/game_wrapper.h"
#include "dtm_struct.h"


/*
 * 音源再生作業領域の確保
 */
static DtmWork dtmwork[SOUND_PLAY_NUMBER];


/*
 * ファイル内関数宣言
 */
static uint32_t meas_filter(DtmWork *const p);


/*
 * 音源構造体のリセット
 */
bool dtmwork_init(void)
{
    DtmWork *p = dtmwork;

    for (uint8_t i = 0; i < SOUND_PLAY_NUMBER; i++, p++)
    {
        p->play         = false;
        p->sound_loop   = false;
        p->len          = 0;
        p->seek         = 0;
        p->sounddata    = 0;
        p->total        = 0;
        p->average_cnt  = 0;
        p->volume       = 0;
        for (uint8_t j = 0; j < FILTER_BUFFER_SIZE; j++)
        {
            p->buffer[j] = 0;
        }
    }

    return true;
}


/* TODO
 * FPGAが音源データをDRAMから読み込むように変更予定
 * -
 * ver1. 201/05/21
 * BGMの再生、48khzごとFPGAに音源データをFPGAに送信
 *
 */
void bgm_playback(void)
{
    DtmWork *p = dtmwork;
	static uint32_t wp = 0;
    static uint32_t d  = 0;
    static uint8_t  i  = 0;

    if ((GP_RESPONSE & RESPONSE_BIT_POS) == 0x00000000)
    {
        wp = GP_RESPONSE & WP_BIT_LENGTH;
        GP_STATUS |= SOUND_DATA_SEND_OK;
    }

    if ((GP_RESPONSE & RESPONSE_BIT_POS) == RESPONSE_BIT_POS)
    {
        GP_STATUS &= RESPONSE_REV_OK;
    }

    // if (wp != (GP_RESPONSE & WP_BIT_LENGTH)) ステレオの場合の処理
    if ((wp != (GP_RESPONSE & WP_BIT_LENGTH)) || ((wp & EVEN_CHECK) != 0))
    {
        return;
    };

    for (i = 0; i < SOUND_PLAY_NUMBER; i++, p++)
    {
        if (true == p->play)
        {
            p->sounddata = *p->soundp << p->volume;
            p->soundp++;
            p->seek++;
            if (p->seek == p->len)
            {
                if (SOUND_LOOP_OK == p->sound_loop)
                {
                    p->seek = 0;
                    p->soundp = p->backup;
                }
                else
                {
                    p->play = false;
                }
            }
        }

        if ((p->len - 1000) < p->seek)  //音源の最後あたりになったらフィルタをかけるようにする
        {
            d += p->sounddata;
        }
        else
        {
            d += meas_filter(p);
        }
    }

    GP_AUDIO_DATA = d;
    d = 0;
}


/*
 * 現在使用する音源の設定を行う
 * 引数にはdtm_macro.hに定義している定数を指定
 * 
 * 再生する音源IDを指定
 * SOUND_IDと名の付く定数を指定
 * 
 * 音源を鳴らすチャンネルを指定
 * ch1. SOUND_CH_BGM_WORK
 * ch2. SOUND_CH_KEY_WORK
 * ch3. SOUND_CH_EFFECT1_WORK
 * ch4. SOUND_CH_EFFECT2_WORK
 */
void bgm_update(GameWrapper *const game, uint8_t sound_id, uint8_t ch)
{
    DtmWork *p = &dtmwork[ch];

    p->play       = false;
    p->soundp     = (uint32_t *)fetch_dram_db(game, MEMORY_DTM_ID, sound_id, DTM_SUB_MEMBER_BGM_ADDR);  ///アドレスを取得
    p->backup     = p->soundp;
    p->sound_loop = fetch_dram_db(game, MEMORY_DTM_ID, sound_id, DTM_SUB_MEMBER_SOUND_LOOP);
    p->seek       = 0;
    p->len        = get_sound_length(fetch_dram_db(game, MEMORY_DTM_ID, sound_id, DTM_SUB_MEMBER_FILE_ID));
    p->volume     = fetch_dram_db(game, MEMORY_DTM_ID, sound_id, DTM_SUB_MEMBER_VOLUME);
    p->play       = true;
}


/*
 * ver2. 2021/08/12
 * 指定した音源データの情報をデータベースから読み込み、ファイルから読み込むように変更
 *
 * ver2 2021/06/28
 * 指定したIDに対応する音源データをSDカードから読み込み
 * 
 * id  SOUND_ID_xxxx            sound name
 */
void bgm_load(GameWrapper *const game, uint8_t sound_id)
{
    file_sound_load(fetch_dram_db(game, MEMORY_DTM_ID, sound_id, DTM_SUB_MEMBER_FILE_ID));
}


/*
 * 再生中のBGMの停止
 */
void bgm_stop(void)
{
    DtmWork *p = &dtmwork[SOUND_CH_BGM_WORK];

    p->play = false;
}


/*
 * 移動平均フィルタ
 */
static uint32_t meas_filter(DtmWork *const p)
{
	p->total = p->total + p->sounddata - p->buffer[p->average_cnt];
	p->buffer[p->average_cnt] = p->sounddata;
	p->average_cnt++;
	p->average_cnt &= FILTER_BUFFER_MASK;

    return p->total >> FILTER_SHIFT;
}
