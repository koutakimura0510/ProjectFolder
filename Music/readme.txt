rawファイル作成手順

1. audacity　実行
2. ステレオからモノラルにトラック変更
3. サンプリングレートを指定に変更
4. ファイル書き出し
5. RAWファイル(header-less)
6. Unsigned 8-bit PCM
7. xxd -i sample.raw >> sample.h
