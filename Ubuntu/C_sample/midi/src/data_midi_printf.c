#include <stdio.h>
#include <stdlib.h>

typedef struct {
    // トラックチャンクのデータを格納する構造体
    char type[4]; // チャンクタイプを示す文字列を格納。「MTrk」が入るはず。[4byte]
    int size;     // トラックチャンクデータのサイズ [4byte]
    char *data;   // トラックデータ（イベントの羅列）へのポインタ
} TrackChunk;

short mergeChar7bit(char x, char y){
    // charの下7bitずつを結合してshort型で出力
    // 【引数】：結合対象となる2つのchar型変数x, y
    short s;
    s = (unsigned char)x; // 上位バイトを先に入れておく
    s <<= 7;              // 7bit左シフト
    s = (s | (unsigned char)(y & 0x7f));   // 下位バイトの下7bitを合成。。。
    return s;
}

int convertEndian(void *input, size_t s){
    // エンディアン変換をおこなう関数
    // stdlib.hをインクルードしてください。
    // 【引数】: void *input...エンディアン変換対象へのポインタ
    // 【引数】: size_t    s...変換対象のバイト数

    int i;   // カウンタ
    char *temp;   // 変換時に用いる一時的配列

    if((temp = (char *)calloc(s, sizeof(char))) == NULL){
        perror("Error: Cannot get memory for temp.");
        return 0;   // 領域確保できず（失敗）
    }

    for(i=0; i<s; i++){   // inputデータをtempに一時保管
        temp[i] = ((char *)input)[i];
    }

    for(i=1; i<=s; i++){   // tempデータを逆方向にしてinputへ代入
        ((char *)input)[i-1] = temp[s-i];
    }

    free(temp);   // 確保した領域を解放

    return 1;   // 正常終了
}

int main(int argc, char **argv)
{
    int i, j, k, cnt;   // カウンタ
    FILE *fp;         // ファイルポインタ生成
    int endian; //   エンディアン判定にいろいろ使用（0:BigEndian, 1:LittleEndian）

    // ヘッダチャンク情報
    char  header_chunk_type[4]; // チャンクタイプを示す文字列を格納。「MThd」が入るはず。[4byte]
    int   header_chunk_size;    // ヘッダチャンクデータのサイズ [4byte]
    short smf_format;     // SMFのフォーマットタイプ（0か1か2） [2byte]
    short tracks;         // トラックチャンク総数 [2byte]
    short division;       // 四分音符あたりの分解能（ここではデルタタイム） [2byte]

    // トラックチャンク情報
    TrackChunk *track_chunks;   // トラックチャンク情報を格納する配列のためのポインタ
    unsigned char c;   // イベント解析の際に使用する一時保存用変数
    unsigned char status;   // ステータスバイト用の一時変数
    unsigned int delta;   // デルタタイム


    // エンディアン判定
    endian = 1;
    if(*(char *)&endian){   // リトルエンディアンなら...
        endian = 1;   // Little Endian
    } else {   // ビッグエンディアンなら...
        endian = 0;   // Big Endian
    }

    // MIDIファイルを開く
    if((fp = fopen(argv[1], "rb")) == NULL){   // バイナリ読み取りモードでファイルを開く
        perror("Error: Cannot open the file.");   // 失敗したらエラーを吐く
        return 0;
    }

    // ヘッダチャンク取得
    fread(header_chunk_type, 1, 4, fp);   // チャンクタイプ
    fread(&header_chunk_size, 4, 1, fp);  // チャンクデータサイズ
    fread(&smf_format, 2, 1, fp);   // SMFフォーマットタイプ
    fread(&tracks, 2, 1, fp);       // トラックチャンク総数
    fread(&division, 2, 1, fp);     // 分解能（デルタタイム）

    // 必要ならエンディアン変換
    if(endian){   // リトルエンディアンなら要変換
        // エンディアン変換処理
        convertEndian(&header_chunk_size, sizeof(header_chunk_size));
        convertEndian(&smf_format, sizeof(smf_format));
        convertEndian(&tracks, sizeof(tracks));
        convertEndian(&division, sizeof(division));
    }

    // 読み取ったヘッダチャンク情報を出力
    printf("# Header ========================\r\n"); 
    printf("header_chunk_type : %c%c%c%c\r\n", header_chunk_type[0], header_chunk_type[1], header_chunk_type[2], header_chunk_type[3]);
    printf("header_chunk_size : %d\r\n", header_chunk_size);
    printf("smf_format : %hd\r\n", smf_format);
    printf("tracks     : %hd\r\n", tracks);
    printf("DIV%hd \r\n", division);


    // トラックチャンク取得
    if((track_chunks = (TrackChunk *)calloc(tracks, sizeof(TrackChunk))) == NULL){   // トラック数に応じて領域確保
        perror("Error: Cannot get memory for track_chunks.\r\n");
        return 0;   // 領域確保できず（失敗）
    }
    for(i=0; i<tracks; i++){   // トラック数だけ繰返し
        fread(track_chunks[i].type, 1, 4, fp);   // チャンクタイプ
        fread(&track_chunks[i].size, 4, 1, fp);   // チャンクデータサイズ
        if(endian){   // リトルエンディアンなら要変換
            convertEndian(&track_chunks[i].size, sizeof(track_chunks[i].size));
        }
        if((track_chunks[i].data = (char *)calloc(track_chunks[i].size, sizeof(char))) == NULL){   // データサイズに応じて領域確保
            perror("Error: Cannot get memory for track_chunks[i].data .\r\n");
            return 0;   // 領域確保できず（失敗）
        }
        fread(track_chunks[i].data, track_chunks[i].size, sizeof(char), fp);   // データ（イベントの羅列）
    }

    // 読み取ったトラックチャンク情報を出力
    for(i=0; i<tracks; i++){   // トラック数だけ繰返し
        printf("# Track[%02d] =====================\r\n", i+1);
        printf("track_chunks[%d].type : %c%c%c%c\r\n", i, track_chunks[i].type[0], track_chunks[i].type[1], track_chunks[i].type[2], track_chunks[i].type[3]);
        printf("track_chunks[%d].size : %d\r\n", i, track_chunks[i].size);
        printf("track_chunks[%d].data\r\n", i);
        for(j=0; j<track_chunks[i].size; j++){   // データ分だけ繰返し

            delta = 0;   // 初期化
            while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                delta = delta | (c & 0x7F);   // 合成
                delta <<= 7;   // 7bit左シフト
            }
            delta = delta | c;   // 合成
            printf("DELTA%d ", delta);   // デルタタイム出力
            
            // ランニングステータスルールに対する処理
            if((track_chunks[i].data[j] & 0x80) == 0x80){
                // ランニングステータスルールが適用されない場合は、ステータスバイト用変数を更新。
                status = (unsigned char)track_chunks[i].data[j];   // ステータスバイトを保持しておく
            } else {
//                printf("");   // ランニングステータスルール適用のしるし
                j--;   // データバイトの直前のバイト（デルタタイムかな？）を指すようにしておく。
                       // 次の処理でj++するはずなので、そうすればデータバイトにアクセスできる。
            }

            // データ判別
            if((status & 0xf0) == 0x80){
                // ノート・オフ【ボイスメッセージ】
                //printf("NoteOff%d ", (status & 0x0f));
                //j++;
                //printf("Note%d ", (unsigned char)track_chunks[i].data[j]);
                //printf("%d \r\n", (unsigned char)track_chunks[i].data[j]);
                printf("%d ", (status & 0x0f));
                j++;
                printf("%d ", (unsigned char)track_chunks[i].data[j]);
				j++;
                printf("%d \r\n", (unsigned char)track_chunks[i].data[j]);
            } else if((status & 0xf0) == 0x90){
                // ノート・オン【ボイスメッセージ】
                //printf("NoteOn%d ", (status & 0x0f));
                //j++;
                //printf("Note%d ", (unsigned char)track_chunks[i].data[j]);
                //printf("%d \r\n", (unsigned char)track_chunks[i].data[j]);
                printf("%d ", (status & 0x0f));
                j++;
                printf("%d ", (unsigned char)track_chunks[i].data[j]);
				j++;
                printf("%d \r\n", (unsigned char)track_chunks[i].data[j]);
            } else if((status & 0xf0) == 0xa0){
                // ポリフォニック・キー・プレッシャー【ボイスメッセージ】
                //printf("Polyphonic Key Pressure [%02dch] : \r\n", (status & 0x0f));
                //j++;
                //printf("Note%d\r\n", (unsigned char)track_chunks[i].data[j]);
                //printf("[0x%02x] \r\n", (unsigned char)track_chunks[i].data[j++]);
                //printf("Pressure / %d\r\n", (unsigned char)track_chunks[i].data[j]);
                printf("%d ", (status & 0x0f));
                j++;
                printf("%d ", (unsigned char)track_chunks[i].data[j]);
				j++;
                //printf("[0x%02x] \r\n", (unsigned char)track_chunks[i].data[j++]);
                printf("%d \r\n", (unsigned char)track_chunks[i].data[j]);
            } else if((status & 0xf0) == 0xb0){
                // コントロールチェンジ【ボイスメッセージ】、【モードメッセージ】
                printf("Control Change [%02dch] : ", (status & 0x0f));
                j++;
                c = (unsigned char)track_chunks[i].data[j++];
                if(c<=63){   // 連続可変タイプのエフェクトに関するコントロール情報（MSBもLSBも）
                    // （ホントは「0<=c && c<=63」と書きたいけど、warningが出るので「c<=63」にする）
                    printf("VariableEffect( ");
                    switch(c){
                        case 0:    // 上位バイト[MSB]
                        case 32:   // 下位バイト[LSB]
                            printf("BankSelect[%s]", (c==0)?"MSB":"LSB");   // バンク・セレクト
                            break;
                        case 1:
                        case 33:
                            printf("ModulationDepth[%s]", (c==1)?"MSB":"LSB");   // モジュレーション・デプス
                            break;
                        case 2:
                        case 34:
                            printf("BreathType[%s]\r\n", (c==2)?"MSB":"LSB");   // ブレス・タイプ
                            break;
                        case 4:
                        case 36:
                            printf("FootType[%s]", (c==4)?"MSB":"LSB");   // フット・タイプ
                            break;
                        case 5:
                        case 37:
                            printf("PortamentoTime[%s]", (c==5)?"MSB":"LSB");   // ポルタメント・タイム
                            break;
                        case 6:
                        case 38:
                            printf("DataEntry[%s]", (c==6)?"MSB":"LSB");   // データ・エントリー
                            break;
                        case 7:
                        case 39:
                            printf("MainVolume[%s]", (c==7)?"MSB":"LSB");   // メイン・ボリューム
                            break;
                        case 8:
                        case 40:
                            printf("BalanceControl[%s]", (c==8)?"MSB":"LSB");   // バランス・コントロール
                            break;
                        case 10:
                        case 42:
                            printf("Panpot[%s]", (c==10)?"MSB":"LSB");   // パンポット
                            break;
                        case 11:
                        case 43:
                            printf("Expression[%s]", (c==11)?"MSB":"LSB");   // エクスプレッション
                            break;
                        case 16:
                        case 17:
                        case 18:
                        case 19:
                        case 48:
                        case 49:
                        case 50:
                        case 51:
                            printf("SomethingElse_No.%d[%s]", c, (c==16)?"MSB":"LSB");   // 汎用操作子
                            break;
                        default:
                            printf("##UndefinedType_No.%d[%s]", (c<32)?c:c-32, (c<32)?"MSB":"LSB");   // よくわからないコントロール
                    }

                    printf(" ) / %d\r\n", (unsigned char)track_chunks[i].data[j]);
                } else if(64<=c && c<=95){   // 連続可変でないタイプのエフェクトに関するコントロール情報
                    printf("InvariableEffect( ");
                    switch(c){
                        case 64:
                            printf("Hold1(Damper)");   // ホールド１（ダンパー）
                            break;
                        case 65:
                            printf("Portamento");   // ポルタメント
                            break;
                        case 66:
                            printf("Sostenuto");   // ソステヌート
                            break;
                        case 67:
                            printf("SoftPedal");   // ソフト・ペダル
                            break;
                        case 69:
                            printf("Hold2(Freeze)");   // ホールド２（フリーズ）
                            break;
                        case 71:
                            printf("HarmonicIntensity");   // ハーモニック・インテンシティ
                            break;
                        case 72:
                            printf("ReleaseTime");   // リリース・タイム
                            break;
                        case 73:
                            printf("AttackTime");   // アタック・タイム
                            break;
                        case 74:
                            printf("Brightness");   // ブライトネス
                            break;
                        case 80:
                        case 81:
                        case 82:
                        case 83:
                            printf("SomethingElse_No.%d", c);   // 汎用操作子
                            break;
                        case 91:
                            printf("ExternalEffect");   // 外部エフェクト
                            break;
                        case 92:
                            printf("Tremolo");   // トレモロ
                            break;
                        case 93:
                            printf("Chorus");   // コーラス
                            break;
                        case 94:
                            printf("Celeste");   // セレステ
                            break;
                        case 95:
                            printf("Phaser");   // フェイザー
                            break;
                        default:
                            printf("##UndefinedType_No.%d", c);   // よくわからないコントロール
                    }
                    printf( ") / %d\r\n", (unsigned char)track_chunks[i].data[j]);
                } else if(96<=c && c<=119){   // 特殊な情報
                    printf("SpecialPurpose( ");
                    switch(c){
                        case 96:
                            printf("DataIncrement");   // データ・インクリメント
                            break;
                        case 97:
                            printf("DataDecrement");   // デクリメント
                            break;
                        case 98:
                            printf("NRPN[LSB]");   // NRPNのLSB
                            break;
                        case 99:
                            printf("NRPN[MSB]");   // NRPNのMSB
                            break;
                        case 100:
                            printf("RPN[LSB]");   // RPNのLSB
                            break;
                        case 101:
                            printf("RPN[MSB]");   // RPNのMSB
                            break;
                        default:
                            printf("##UndefinedType_No.%d", c);   // よくわからないコントロール
                    }
                    printf(" ) / %d\r\n", (unsigned char)track_chunks[i].data[j]);
                } else if(120<=c && c<=127){   // モード・メッセージ
                    printf("ModeMessage( ");
                    switch(c){
                        case 120:
                            printf("AllSoundOff");   // オール・サウンド・オフ
                            break;
                        case 121:
                            printf("ResetAllController");   // リセット・オール・コントローラー
                            break;
                        case 122:
                            printf("LocalControl");   // ローカル・コントロール
                            break;
                        case 123:
                            printf("AllNoteOff");   // オール・ノート・オフ
                            break;
                        case 124:
                            printf("OmniOn");   // オムニ・オン
                            break;
                        case 125:
                            printf("OmniOff");   // オムニ・オフ
                            break;
                        case 126:
                            printf("MonoModeOn");   // モノモード・オン（ポリモード・オフ）
                            break;
                        case 127:
                            printf("PolyModeOn");   // ポリモード・オン（モノモード・オフ）
                            break;
                        default:
                            printf("##UndefinedType_No.%d", c);   // よくわからないコントロール
                    }
                    printf(" ) / %d\r\n", (unsigned char)track_chunks[i].data[j]);
                }
                //printf(" ");
            } else if((status & 0xf0) == 0xc0){
                // プログラム・チェンジ【ボイスメッセージ】
                printf("Program Change [%02dch] : ", (status & 0x0f));
                j++;
                printf("ToneNo / %d \r\n", (unsigned char)track_chunks[i].data[j]);
            } else if((status & 0xf0) == 0xd0){
                // チャンネル・プレッシャー【ボイスメッセージ】
                printf("Channel Pressure [%02dch] : ", (status & 0x0f));
                j++;
                printf("Pressure / %d\r\n", (unsigned char)track_chunks[i].data[j]);
            } else if((status & 0xf0) == 0xe0){
                // ピッチ・ベンド・チェンジ【ボイスメッセージ】
                printf("Pitch Bend Change [%02dch] : ", (status & 0x0f));
                j++;
                printf("Bend / %hd", mergeChar7bit(track_chunks[i].data[j+1], track_chunks[i].data[j]) - 8192);
                printf(" (LSB:%d", (unsigned char)track_chunks[i].data[j++]);
                printf(", MSB:%d)\r\n", (unsigned char)track_chunks[i].data[j]);
            } else if((status & 0xf0) == 0xf0){
                // 【システム・メッセージ】
                switch(status & 0x0f){
                    case 0x00:   // エクスクルーシブ・メッセージ
                        printf("F0 Exclusive Message : ");
                        j++;

                        // SysExのデータ長を取得
                        cnt = 0;   // 初期化
                        while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){   // フラグビットが1の間はループ
                            cnt = cnt | c;   // 合成
                            cnt <<= 7;   // 7bit左シフト
                        }
                        cnt = cnt | c;   // 合成
                        printf(" Length / %u", (unsigned int)cnt);   // SysExのデータ長を取得

                        for(k=1; k<=cnt; k++){   // 長さの分だけデータ取得
                            printf("[%02x]", (unsigned char)track_chunks[i].data[j++]);
                        }
						printf("\r\n");
                        j--;   // 行き過ぎた分をデクリメント

                        break;
                    case 0x01:   // MIDIタイムコード
                        printf("MIDI Time Code : ");
                        j++;
                        printf("(frame/sec/min/hour) / %d", (unsigned char)track_chunks[i].data[j]);
                        break;
                    case 0x02:   // ソング・ポジション・ポインタ
                        printf("Song Position Pointer : ");
                        j++;
                        printf("Position / %hd[MIDI beat]", mergeChar7bit(track_chunks[i].data[j+1], track_chunks[i].data[j]));
                        printf(" (LSB:%d", (unsigned char)track_chunks[i].data[j++]);
                        printf(", MSB:%d)", (unsigned char)track_chunks[i].data[j]);
                        break;
                    case 0x03:   // ソング・セレクト
                        printf("Song Select : ");
                        j++;
                        printf("SelectNo / %d", (unsigned char)track_chunks[i].data[j]);
                        break;
                    case 0x06:   // チューン・リクエスト
                        printf("Tune Request");
                        break;
                    case 0x07:   // エンド・オブ・エクスクルーシブでもあるけども...
                                 // F7ステータスの場合のエクスクルーシブ・メッセージ
                        //printf("@End of Exclusive");
                        printf("F7 Exclusive Message : ");
                        j++;

                        // SysExのデータ長を取得
                        cnt = 0;   // 初期化
                        while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){   // フラグビットが1の間はループ
                            cnt = cnt | c;   // 合成
                            cnt <<= 7;   // 7bit左シフト
                        }
                        cnt = cnt | c;   // 合成
                        printf(" Length / %u", (unsigned int)cnt);   // SysExのデータ長を取得

                        for(k=1; k<=cnt; k++){   // 長さの分だけデータ取得
                            printf("[%02x]", (unsigned char)track_chunks[i].data[j++]);
                        }
                        j--;   // 行き過ぎた分をデクリメント

                        break;
                    case 0x08:   // タイミング・クロック
                        printf("Timing Clock");
                        break;
                    case 0x0A:   // スタート
                        printf("Start");
                        break;
                    case 0x0B:   // コンティニュー
                        printf("Continue");
                        break;
                    case 0x0C:   // ストップ
                        printf("Stop");
                        break;
                    case 0x0E:   // アクティブ・センシング
                        printf("Active Sensing");
                        break;
                    //case 0x0F:   // システムリセット（何か間違っている気がする。。。）
                    //    printf("System Reset");
                    case 0x0F:   // メタイベント
                        printf("Meta Ivent : ");
                        j++;
                        switch((unsigned char)track_chunks[i].data[j]){
                            case 0x00:   // シーケンス番号
                                printf("Sequence Number = ");
                                j += 2;   // データ長の分を通り越す
                                cnt = (unsigned char)track_chunks[i].data[j++];
                                cnt <<= 8;   // 8bit左シフト
                                cnt = cnt | (unsigned char)track_chunks[i].data[j];
                                printf("%d\r\n", cnt);
                                break;
                            case 0x01:   // テキスト[可変長]
                                printf("Text = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x02:   // 著作権表示[可変長]
                                printf("Copyright = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x03:   // シーケンス名（曲タイトル）・トラック名[可変長]
                                printf("Title = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", (unsigned char)track_chunks[i].data[j++]);
                                }
								//printf("%s", track_chunks[i].data);
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x04:   // 楽器名[可変長]
                                printf("InstName = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x05:   // 歌詞[可変長]
                                printf("Words = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x06:   // マーカー[可変長]
                                printf("Marker = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x07:   // キューポイント[可変長]
                                printf("CuePoint = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x08:   // プログラム名（音色名）[可変長]
                                printf("ProgramName / ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x09:   // デバイス名（音源名）[可変長]
                                printf("DeviceName / ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("%c", track_chunks[i].data[j++]);
                                }
								printf("\r\n");
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            case 0x20:   // MIDIチャンネルプリフィックス[1byte]
                                printf("MidiChannelPrefix / ");
                                j += 2;   // データ長の分を通り越す
                                cnt = (unsigned char)track_chunks[i].data[j];
                                printf("%d\r\n", cnt);
                                break;
                            case 0x21:   // ポート指定[1byte]
                                printf("Port = ");
                                j += 2;   // データ長の分を通り越す
                                cnt = (unsigned char)track_chunks[i].data[j];
                                printf("%d\r\n", cnt);
                                break;
                            case 0x2F:   // トラック終端[0byte]
                                printf("End of Track\r\n");
                                j += 1;   // データ長の分を通り越す
                                break;
                            case 0x51:   // テンポ設定[3byte]
                                printf("Temp");
                                j += 2;   // データ長の分を通り越す
                                cnt = (unsigned char)track_chunks[i].data[j++];
                                cnt <<= 8;   // 8bit左シフト
                                cnt = cnt | (unsigned char)track_chunks[i].data[j++];
                                cnt <<= 8;   // 8bit左シフト
                                cnt = cnt | (unsigned char)track_chunks[i].data[j];
                                printf("%d \r\n", cnt);
                                break;
                            case 0x54:   // SMPTEオフセット[5byte]
                                printf("SMPTE_Offset = ");
                                j += 2;   // データ長の分を通り越す
                                cnt = (unsigned char)track_chunks[i].data[j++];
                                switch(cnt & 0xC0){   // フレーム速度
                                    case 0x00:
                                        printf("24fps");
                                        break;
                                    case 0x01:
                                        printf("25fps");
                                        break;
                                    case 0x10:
                                        printf("30fps(DropFrame)");
                                        break;
                                    case 0x11:
                                        printf("30fps");
                                        break;
                                }
                                printf(",Hour:%d", (cnt & 0x3F));   // 時間
                                printf(",Min:%d", (unsigned char)track_chunks[i].data[j++]);   // 分
                                printf(",Sec:%d", (unsigned char)track_chunks[i].data[j++]);   // 秒
                                printf(",Frame:%d", (unsigned char)track_chunks[i].data[j++]);   // フレーム
                                printf(",SubFrame:%d", (unsigned char)track_chunks[i].data[j]);   // サブフレーム
                                break;
                            case 0x58:   // 拍子設定[4byte]
                                printf("Rhythm = ");
                                j += 2;   // データ長の分を通り越す
                                printf("%d", (unsigned char)track_chunks[i].data[j++]);
                                cnt = 1;
                                for(k=0; k<=(int)track_chunks[i].data[j]; k++){   // 拍子の分母を算出する
                                    cnt *= 2;   // 2の累乗
                                }
                                printf("/%d\r\n", cnt);
                                j++;
                                printf("ClockPerBeat=%d\r\n", (unsigned char)track_chunks[i].data[j++]);
                                printf("32NotePer4Note=%d\r\n", (unsigned char)track_chunks[i].data[j]);
                                break;
                            case 0x59:   // 調設定[2byte]
                                printf("Key = ");
                                j += 2;   // データ長の分を通り越す
                                cnt = (int)track_chunks[i].data[j++];
                                if(c > 0){
                                    printf("Sharp[%d]", c);
                                } else if(c == 0){
                                    printf("C");
                                } else {
                                    printf("Flat[%d]", c);
                                }
                                cnt = (int)track_chunks[i].data[j];
                                if(c == 0){
                                    printf("_Major");
                                } else {
                                    printf("_Minor");
                                }
								printf("\r\n");

                                break;
                            case 0x7F:   // シーケンサ特定メタイベント
                                printf("SpecialIvent = ");
                                cnt = 0;
                                j += 1;
                                while((c = (unsigned char)track_chunks[i].data[j++]) & 0x80){
                                    cnt = cnt | (c & 0x7F);   // 合成
                                    cnt <<= 7;   // 7bit左シフト
                                }
                                cnt = cnt | (c & 0x7F);   // 合成
                                for(k=1; k<=cnt; k++){
                                    printf("[%02x]", (unsigned char)track_chunks[i].data[j++]);
                                }
                                j--;   // 行き過ぎた分をデクリメント
                                break;
                            default :
                                ;
                        }
                        break;
                    default:
                        printf("# SysEx (Something else...[Status:%02x])", status);   // 見知らぬステータスなら
                }
                //printf(" ");
            } else {
                printf("## Something else...[Status:%02x]", status);   // 見知らぬステータスなら
            }
        }
        //printf(" ");
    }

    // track_chunks,track_chunks[i].dataはcalloc()で領域確保しているので解放し忘れないように！

    return 1;
}
