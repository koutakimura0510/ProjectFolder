<h1>【Nexys Video Oled demo】</h1>

- [1. 概要](#1-概要)
- [2. コーディング規則](#2-コーディング規則)
- [3. ファイル概要](#3-ファイル概要)
- [4. 使い方](#4-使い方)
</br></br>

## 1. 概要
評価ボード付属のOLEDのデモプレイを管理する。</br>
</br>
![](res/IMG_3552.jpg)
</br>

## 2. コーディング規則
- locparamaなどの定数値は全て大文字で使用</br>
- input outputの端子は小文字・大文字を混ぜたものを使用</br>
- module内のreg・wireは全て小文字で使用</br>
- input output端子に接続する変数名は同じにする</br>
</br>

## 3. ファイル概要
ファイル名 | 詳細
-|-
oledCmd | 初期設定後の描画範囲設定Romデータ
oledDisp | 設定後の描画Romデータと作業領域
oledInit | 起動時の初期設定Romデータ
oledRp | 各設定Romのアドレス参照用ポインタ
oledSend | 状況に応じて送信データを選択するステートマシン
oledState | 起動時のリセット信号などの状態遷移を管理
oledTime | 設定に必要な待機時間を生成
oledTop | 上記oled操作ファイルのwrapper
spiCtrl | oled用のSPI通信
top | プロジェクト全体のwrapper
</br>

## 4. 使い方
ソースファイルとPortの制約ファイルを読み込んでコンパイルすれば動作する。</br>
Nexys Videoではない場合、使用環境によってPortを変更する。

</br>