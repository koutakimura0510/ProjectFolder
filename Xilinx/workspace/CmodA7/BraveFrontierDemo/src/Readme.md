<h1>【FPGAゲーム】</h1>

- [1. 概要](#1-概要)
- [2. ハードウェア構成](#2-ハードウェア構成)
- [3. コーディング規則](#3-コーディング規則)
- [4. ディレクトリ構成](#4-ディレクトリ構成)
- [5. アドレス構成](#5-アドレス構成)
</br></br>

## 1. 概要
FPGA を搭載した自作基板を作成、機能を実装しイベントでの販売を目標としたプロジェクトのデモキット。</br>
昨今の半導体不足の影響で FPGA Readtime が 42week とかなので、過去に購入していた Artix7 の評価ボード</br>
CmodA7 を使用し、本番に向けたデバッグ用基板を作成した。</br>
</br>
<!-- ![](res/IMG_3552.jpg) -->
</br>

## 2. ハードウェア構成
準備中
<!-- ![回路図](https://github.com/koutakimura0510/ProjectFolder/tree/master/Xilinx\workspace\CmodA7\BraveFrontierDemo\doc\GameDemoKit.pdf) -->

## 3. コーディング規則
- parameter locparama は小文字 p, lp から開始し、なるべく詳細な命名を行う</br>
- input outputのportは小文字 i, o から開始する。</br>
- 変数のプレフィックスは、w->ネット型wire変数, q->D-FFにしないreg変数, r->D-FFにするreg変数</br>
- よく使用するハンド・シェイク信号は、Valid->Vd, Ready->Rdy, ClockEnable->Cke と省略する</br>
- module の 入出力 Port のプレフィックス S->Slave, M->Master とする</br>
</br>

## 4. ディレクトリ構成
ディレクトリ | 詳細
-|-
common | 汎用モジュール
PreProcessor | Processor で使用する CLK 信号を生成
Processor | 外部機器と通信を行い、システム駆動を司る
</br>

## 5. アドレス構成
機能名 | アドレス | 詳細
-|-|-
GPIO  | 0x01 | 汎用 GPIO の制御を司る
SPI   | 0x02 | 外部 SPI I/F のデバイス・ホスト制御を司る
I2C   | 0x03 | 外部 I2C I/F のデバイス制御を司る
VTB   | 0x04 | 外部 Display I/F のデバイス制御を司る
AGB   | 0x05 | サウンドの生成・合成など、音源データ制御を司る
RAM   | 0x06 | 外部 RAM I/F の制御を司る
USI/F | 0x10 | 汎用バスシステムの一つ、ペリフェラルのレジスタ操作と調停を行う
UFI/F | 0x11 | 専用バスシステムの一つ、メモリ操作の調停を行う
MCB   | 0x12 | Master としてプロセッサー制御を行う
</br>

</br>