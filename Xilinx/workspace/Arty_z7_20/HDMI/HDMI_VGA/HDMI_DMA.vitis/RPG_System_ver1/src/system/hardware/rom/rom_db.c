/*
 * Create 2021/07/17
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
 * ver1
 * システム動作に必要なファイル操作の関数を管理するファイル
 * 
 * ver2 2021/07/17
 * 構造体の共有がしやすくなるためsystemフォルダ内にromファオダを移行
 */

/*
 * データベース管理ファイル
 */
#include "../../wrapper/game_wrapper.h"
#include <stdlib.h>
#include <string.h>
#include "xsdps.h"
#include "ff.h"
#include "rom_db_struct.h"
#include "xil_cache.h"


/* マップサイズ操作構造体の確保 */
static MapSize_DB mapsize_db;

/* ファイル操作時のアドレス管理構造体確保 */
static SystemAddress system_address;
static SoundLength sound_length;


/* SDカードFATシステム領域の確保 */
static FATFS fatfs;

/* SDデータ読み込みの音源データ一時保存用配列 */
static char sound_buffer[F_READ_SIZE];

/* SDデータ読み込みのファイル名一時保存用配列 */
static char filename[FILENAME_BUFFER_SIZE];


/*
 * ファイル内関数宣言
 */
static void bitmap_work_update(BitmapWork *const bitmap_work, uint32_t id);
static bool image_property_road(FIL *fil, uint32_t id);
static bool image_rgb_road(FIL *fil, BitmapWork *const bitmap_work, uint32_t id);
static void mapsize_db_write(MapSize_DB *p, uint32_t *wbuff);
static uint32_t str_hex(char *str, uint8_t slen);
static const SoundDB *search_sound_db(uint32_t fileid);
static bool file_database_load(void);
static void system_address_update(uint32_t id, uint32_t *p);
static void filename_update(char *file, const char *path);


/*
 * 描画を行っているマップのサイズを取得
 *
 * wh
 * 'w'  : Widthを取得
 * 'h'  : Heightを取得
 */
uint32_t get_mapsize(char wh)
{
    MapSize_DB *p = &mapsize_db;

    switch (wh)
    {
    case 'w':
        return p->map_width;

    default:
        return p->map_height;
    }
}


/*
 * 起動時にSDカード内のデータを読み込んでDRAMに保存を行う
 *
 * 1. FATシステムの構造体をインスタンス
 * 2. IDに応じたファイル名を取得
 * 3. SDカードマウント処理
 * 4. SDカードオープン処理
 * 5. データの読み込みを行う
 * 6. 読み込みデータが16進数の文字列で保存されているため、変換を行いDRAMに保存する
 * 7. ファイルの最後まで読み込みを行い、指定読み込みバイト数と
 *    読み込んだバイト数が異なっていたら処理を終える
 */
bool sdread_image_init(void)
{
    TCHAR *Path = "0:/";

#ifdef MYDEBUG
    if (FR_OK != f_mount(&fatfs, Path, 0))
    {
        xil_printf("SD mount Error\r\n");
        return false;
    }

    xil_printf("SD mount OK\r\n");

    if (false == file_database_load())
    {
        return false;
    }
    xil_printf("SD read OK\r\n");
#else
    f_mount(&fatfs, Path, 0);
    file_database_load();
#endif

    return true;
}


/*
 * 画像データ読み込み動作
 * 指定したidに対応したファイル名を検索し、そのデータを読み込む
 */
bool sd_fread(uint32_t id)
{
    FIL fil;
    BitmapWork bitmap_work;

    /* ファイル名を取得して作成 */
    bitmap_work_update(&bitmap_work, id);
    filename_update(filename, bitmap_work.filename);

    if (FR_OK != f_open(&fil, filename, FA_READ))
    {
        msg_fprintf("Error f_open", filename, __func__, __LINE__);
        return false;
    }

    /* ファイルのヘッダー情報読み込み */
    if (false == image_property_road(&fil, id))
    {
        return false;
    }

    /* ファイルのデータ部分の読み込み */
    if (false == image_rgb_road(&fil, &bitmap_work, id))
    {
        return false;
    }

    if (FR_OK != f_close(&fil))
    {
        msg_fprintf("Error f_close", filename, __func__, __LINE__);
        return false;
    }

    return true;
}


/*
 * rawファイルの情報部分の読み込み
 *
 * ヘッダーファイル構成
 * 1行目     Width
 * 2行目     Height
 * 3行目以降 RGBデータ
 */
static bool image_property_road(FIL *fil, uint32_t id)
{
    UINT bytes;                                 // 読み込んだファイルのバイト数を保存
    MapSize_DB *p = &mapsize_db;                // ヘッダー情報を保存する構造体
    char image_property[RAW_FILE_STATS];        // ヘッダー情報読み込み配列
    uint32_t property[MAPSIZE_DB_MEMBA_NUM];    // ヘッダー情報を数値に変換したデータを保存

    /* マップデータでなければヘッダー情報を読み込まない */
    if ((id < FILE_WORLDMAP_ID_START) || (FILE_WORLDMAP_ID_END < id))
    {
        return true;
    }

    for (uint8_t i = 0; i < MAPSIZE_DB_MEMBA_NUM; i++)
    {
        if (FR_OK != f_read(fil, image_property, RAW_FILE_STATS, &bytes))
        {
            msg_fprintf("Error Property f_read", filename, __func__, __LINE__);
            f_close(fil);
            return false;
        }
        property[i] = (uint32_t)strtol(image_property, 0, 0);
    }

    mapsize_db_write(p, property);

    return true;
}


/*
 * ver2. 2021/07/17
 * 毎データキャッシュのフラッシュを行っていた処理を、
 * データ数をカウントしておきファイルのデータを全て読み込んだらフラッシュするように変更
 *
 * ver1
 * rawファイルのRGBデータ部分の読み込み
 *
 * 1. 読み込み指定バイト数と実際に読み込んだバイト数が異なった時、
 *    ファイルの末尾まで読み込んだと判断し、ループを抜ける
 * 2. ARGB16進数データを文字列として読み込むため、4byteデータに変換を行う
 */
static bool image_rgb_road(FIL *fil, BitmapWork *const bitmap_work, uint32_t id)
{
    uint32_t *p = bitmap_work->dram_p;
    uint32_t len = 0;
    uint32_t total_size = 0;
    int32_t bytes;
    uint8_t read_size;
    char heap[12];

    do
    {
        if (bitmap_work->len - NUM(heap) == len)
        {
            read_size = NUM(heap);
            len = 0;
        }
        else
        {
            read_size = RAW_FILE_STATS;
			len += RAW_FILE_STATS;
        }

#ifdef MYDEBUG
        if (FR_OK != f_read(fil, heap, read_size, (UINT *)&bytes))
        {
            msg_fprintf("Error RGB f_read", filename, __func__, __LINE__);
            f_close(fil);
            return false;
        }
#else
        f_read(fil, heap, read_size, (UINT *)&bytes);
#endif
        *p = str_hex(heap, 8);
        p++;
        total_size++;
    } while (bytes == read_size);

#ifdef MYDEBUG
    xil_printf("Read File = %s, 0x%08x ~ 0x%08x\n", filename, (uint32_t)bitmap_work->dram_p, (uint32_t)p);
#endif
    Xil_DCacheFlushRange((uint32_t)bitmap_work->dram_p, total_size << 2);   // 1アドレスがbyteのため2bitシフトさせる

    return true;
}


/*
 * 8桁16進数の文字列を数値に変換
 * *str 0xから始まる文字列のアドレスを指定
 */
static uint32_t str_hex(char *str, uint8_t slen)
{
    uint32_t d;     // 計算結果保存
    char *p = str;  // アドレスを取得

    if (slen != 2) {
    	p = p + 2;  // 0xの文字列を飛ばす
    }
    d = 0;

    for (uint8_t i = 0; i < slen; i++, p++)
    {
        d <<= 4;
        if (('0' <= *p) && (*p <= '9'))
        {
            d |= (*p - '0');
        }else{
            d |= (*p - 'a' + 10);
        }
    }

    return d;
}


/*
 * 画像データのプロパティ保存
 */
static void mapsize_db_write(MapSize_DB *p, uint32_t *wbuff)
{
    uint32_t *ptr;

    for (uint32_t i = 0; i < MAPSIZE_DB_MEMBA_NUM; i++)
    {
        ptr = (uint32_t *)p + i;
        *ptr = wbuff[i];
    }
}


/*
 * ビットマップデータベース操作関数
 */
static void bitmap_work_update(BitmapWork *const bitmap_work, uint32_t id)
{
    const BitmapDB *p = bitmap_db;

    for (uint32_t i = 0; i < BITMAP_DB_SIZE; i++, p++)
    {
        if (p->fileid == id)
        {
            break;
        }
    }

    bitmap_work->xsize    = p->xsize;
    bitmap_work->ysize    = p->ysize;
    bitmap_work->filename = p->filename;
    bitmap_work->dram_p   = p->dram_p;
    bitmap_work->len      = p->len;
}


/*
 * 音源ファイル管理データベースのアドレスを更新
 */
static const SoundDB *search_sound_db(uint32_t fileid)
{
    const SoundDB *p = sound_db;

    for (uint32_t i = 0; i < BGM_DB_SIZE; i++, p++)
    {
        if (p->fileid == fileid)
        {
            break;
        }
    }

    return p;
}


/*
 * ver3. 2021/07/17
 * 音源を符号無し8bitから符号あり16bitに変更
 * 音源データの各部分の処理を変更
 *
 * ver2. 2021/07/17
 * 毎データキャッシュのフラッシュを行っていた処理を、
 * データ数をカウントしておきファイルのデータを全て読み込んだらフラッシュするように変更
 *
 * ver1
 * 指定した音源データの読み込み
 * 
 * * fileid : FILE_ACCESS_BGM_xxx系統の定数を指定
 */
bool file_sound_load(uint32_t fileid)
{
    const SoundDB *db = search_sound_db(fileid);
    SoundLength *soundp = &sound_length;
    FIL fil;
	UINT bytes;
    uint32_t total_size = 0;
    uint32_t *p = db->dram_p;

    filename_update(filename, db->filename);

#ifdef MYDEBUG
    if (FR_OK != f_open(&fil, filename, FA_READ))
    {
        xil_printf("Sound Open Error %s\r\n", filename);
        return false;
    }
#else
    f_open(&fil, filename, FA_READ);
#endif

    do
    {
#ifdef MYDEBUG
		if (FR_OK != f_read(&fil, sound_buffer, F_READ_SIZE, &bytes))
		{
			xil_printf("Sound Read Error %s\r\n", filename);
			return false;
		}
#else
        f_read(&fil, sound_buffer, F_READ_SIZE, &bytes);
#endif
        for (uint32_t i = 0; i < bytes - 1; i = i + STR_BYTE + STR_BYTE)
		{
            uint32_t d1 = str_hex(&sound_buffer[i], STR_BYTE) & 0x000000ff;             // 音源データの下位8bit取得
            uint32_t d2 = (str_hex(&sound_buffer[i + 2], STR_BYTE) << 8) & 0x0000ff00;  // 音源データの上位8bit取得
            int32_t sound_data = d2 | d1;

            if (32767 < sound_data)     //16bitの範囲は-32768 ~ 32867
            {
                sound_data = sound_data - 32768;    //整数のシリアルデータで送信するため、負の値を正の値に変換する
            }
            else
            {
                sound_data += 32768;
            }
			*p = sound_data;
			p++;
		}
        total_size += F_READ_SIZE;
	} while (bytes == F_READ_SIZE);

#ifdef MYDEBUG
    if (FR_OK != f_close(&fil))
    {
        msg_fprintf("Error f_close", filename, __func__, __LINE__);
        return false;
    }

    xil_printf("Sound File [0x%08x ~ 0x%08x], [total = 0x%08x] %s\r\n", (uint32_t)db->dram_p, (uint32_t)p, (uint32_t)p - (uint32_t)db->dram_p, filename);
#else
    f_close(&fil);
#endif
    soundp->len[FILE_BGM_ID_END - fileid - 1] = ((uint32_t)p - (uint32_t)db->dram_p) >> 2;  //ステレオからモノラルに容量を変更
    Xil_DCacheFlushRange((uint32_t)db->dram_p, total_size << 2);

	return true;
}


/*
 * 音源ファイルのバイト数を取得
 *
 * fileid : FILE_ACCESS_BGM_xxx系統の定数を指定
 */
uint32_t get_sound_length(uint32_t fileid)
{
    SoundLength *p = &sound_length;

    return p->len[FILE_BGM_ID_END - fileid - 1];
}


/*
 * ver1. 2021/07/15
 * システムbinファイル読み込み処理
 */
/*
 * rawファイルのRGBデータ部分の読み込み
 *
 * 1. 読み込み指定バイト数と実際に読み込んだバイト数が異なった時、
 *    ファイルの末尾まで読み込んだと判断し、ループを抜ける
 * 2. ARGB16進数データを文字列として読み込むため、4byteデータに変換を行う
 * 3. マップチップデータは連番としてデータの保存を行うため、前回のアドレスを保存しておく
 */
static bool file_database_load(void)
{
    FIL fil;
    const SystemFile *system = system_file;
    uint32_t *p = DRAM_SYSTEM_BIN_ADDR_START;
    uint32_t total_size = 0;
    int32_t bytes;
    char heap[12];

    for (uint8_t i = 0; i < FILE_SYSTEM_DB_SIZE; i++, system++)
    {
        filename_update(filename, system->filename);

#ifdef MYDEBUG
        if (FR_OK != f_open(&fil, filename, FA_READ))
        {
            xil_printf("Init Open Error %s\r\n", filename);
            return false;
        }
        system_address_update(i, p);
        xil_printf("Init File %s, 0x%8x ~ ", filename, (uint32_t)p);
#else
        f_open(&fil, filename, FA_READ);
        system_address_update(i, p);
#endif
        while (1)
        {
#ifdef MYDEBUG
            if (FR_OK != f_read(&fil, heap, RAW_INIT_FILE_READ_SIZE, (UINT *)&bytes))
            {
                msg_fprintf("Error Database Init File", filename, __func__, __LINE__);
                return false;
            }
#else
            f_read(&fil, heap, RAW_INIT_FILE_READ_SIZE, (UINT *)&bytes);
#endif
            if (bytes != 0)
            {
                *p = str_hex(heap, 8);
                p++;
                total_size++;
            }
            else
            {
                break;
            }
        }
        f_close(&fil);
#ifdef MYDEBUG
        xil_printf("0x%8x\r\n", (uint32_t)p);
#endif
    }

    Xil_DCacheFlushRange(DRAM_SYSTEM_BIN_ADDR_BASE, total_size << 2);

    return true;
}


/*
 * ver1. 2021/07/15
 * システムデータの各メンバのアクセスアドレスを保存する
 */
static void system_address_update(uint32_t id, uint32_t *p)
{
    SystemAddress *system = &system_address;
    const SystemLength *len = system_length;

    system->start_adr[id] = p;

    if (id == (FILE_ACCESS_TOTAL_BYTE - FILE_SYSTEM_ID_START - 1))  //ファイルIDが最後まで読み込まれたら情報を書き出す
    {

        for (uint8_t i = 0; i < FILE_SYSTEM_LENGTH_SIZE; i++, len++)
        {
            system->p[i] = p;
            p = p + (len->id_len * len->member_len);
        }
    }
}


/**
 * @brief  データの開始アドレスの順番はrom_db_strunc.hのメンバを参照
 * @note   
 * @param  main_member: MEMORY_xxx_IDと名の付く番号を指定
 * @param  sub_id: データベースの行の先頭のIDを指定
 * @param  sub_member: xxxSUB_MEMBER_xxx_xxx sub_idと一致した行の取得するメンバ名を指定
 * @retval 
 */
uint32_t fetch_dram_db(GameWrapper *const game, uint8_t main_member, uint32_t sub_id, uint32_t sub_member)
{
    const SystemLength *length = system_length;
    SystemAddress *system      = &system_address;
    uint32_t *main_adr         = system->start_adr[main_member];    /* データベースのメンバのデータが保存されているアドレスを取得 */
    uint32_t *sub_adr          = system->p[main_member];            /* データベースのメンバの長さが保存されているアドレスを取得 */

    for (uint32_t i = 0; i < FILE_SYSTEM_LENGTH_SIZE; i++, length++)
    {
        if (main_member == length->system_member)   /* アクセスしたいファイルデータが保存されている先頭アドレスまで進む */
        {
            break;
        }
    }

    for (uint32_t i = 0; i < length->id_len; i++)
    {
        if (sub_id == *main_adr)    /* データベースの形で保存されているため、IDでテーブルの検索を行う */
        {
            break;
        }
        else
        {
            for (uint32_t j = 0; j < length->member_len; j++)    /* IDが一致していなければ、列のデータ数分アドレスを進める */
            {
                main_adr = main_adr + *sub_adr;
                sub_adr++;
            }
        }
    }

    for (uint32_t i = 0; i < sub_member; i++)    /* 一致したIDの列の取得したいメンバまでアドレスを進める */
    {
        main_adr = main_adr + *sub_adr;
        sub_adr++;
    }

    game->conf.db.data     = main_adr;  /* 呼び出し元で戻り値以外でもデータを利用する場合があるため保存しておく */
    game->conf.db.len      = sub_adr;
    game->conf.db.old_data = game->conf.db.data;
    game->conf.db.old_len  = game->conf.db.len;

    return *main_adr;
}


/**
 * @brief  メッセージデータベースのデータを取得する
 * @note   sub_idに指定するIDについて
 * 
 * NPCのメッセージを取得したい場合は、NpcMsgDBのmap_npcidを指定する
 * 仲間のメッセージについては、後日考える
 * 
 * @param  main_member: フィルデータにアクセスするための定数値を指定、MEMORY_xxx
 * @param  sub_id: 取得したいメッセージに対応したIDを指定、例　NPCならば ROMEN_NPC_xxxなど
 * @retval 
 */
uint32_t fetch_dram_msg(GameWrapper *const game, uint8_t main_member, uint32_t sub_id)
{
    const SystemLength *length = system_length;
    SystemAddress *system      = &system_address;
    uint32_t *main_adr         = system->start_adr[main_member];    /* データベースのメンバのデータが保存されているアドレスを取得 */
    uint32_t *sub_adr          = system->p[main_member];            /* データベースのメンバの長さが保存されているアドレスを取得 */
    uint32_t *event_flag       = DRAM_FLAG_EVENT_ADDR_START;
    uint32_t row;

    for (uint32_t i = 0; i < FILE_SYSTEM_LENGTH_SIZE; i++, length++)
    {
        if (main_member == length->system_member)   /* アクセスしたいファイルデータが保存されている先頭アドレスまで進む */
        {
            break;
        }
    }

    for (uint32_t i = 0; i < length->id_len; i++)
    {
        if (sub_id == *main_adr)    /* データベースの形で保存されているため、IDでテーブルの検索を行う */
        {
            break;
        }
        else
        {
            main_adr++;                         /* 行数が保存されているアドレスまで進める */
            sub_adr++;
            row = *main_adr + 1;                /* メッセージの行数 + 1アドレスを進めると、データベースの次の行に行ける */

            for (uint32_t j = 0; j < row; j++)  /* 列のデータ数分アドレスを進める */
            {
                main_adr = main_adr + *sub_adr; /* 文字の行数と文字列分アドレスを進めてデータベースの次の行まで進む */
                sub_adr++;
            }
        }
    }

    for (uint8_t i = 0; i < 2; i++) /* ポインタが文字列を指す箇所までアドレスを進める */
    {
        main_adr++;
        sub_adr++;
    }

    event_flag = event_flag + sub_id; /* アドレスがNPCのIDが保存されている領域を指しているため、IDを取得しNPCのイベント情報領域のDRAMのアドレスにアクセスする */

    for (uint32_t i = 0; i < *event_flag; i++) /* 一致したIDの列の取得したいメンバまでアドレスを進める */
    {
        main_adr = main_adr + *sub_adr;
        sub_adr++;
    }

    game->conf.db.data     = main_adr; /* 呼び出し元で戻り値以外でもデータを利用する場合があるため保存しておく */
    game->conf.db.len      = sub_adr;
    game->conf.db.old_data = game->conf.db.data;
    game->conf.db.old_len  = game->conf.db.len;

    return *main_adr;
}


/*
 * ver1. 2021/07/14
 * ファイルのパスを取得し、ファイル名を作成する関数
 */
static void filename_update(char *file, const char *path)
{
    for (uint8_t i = 0; i < FILENAME_BUFFER_SIZE; i++)
    {
        file[i] = '\0';
    }

    strcat(file, path);
    strcat(file, ".raw");
}
