- [概要](#概要)
- [src](#src)
- [sch](#sch)
- [Makefile](#makefile)

## 概要
下記から、一式をインストールしてください。
https://github.com/raspberrypi/pico-setup-windows

- 使用環境
SDK バージョン 1.5.1
VSCode 1.91.1
Extensions Unit から Cortex-Debug, CMake 関連を install してください。

## プロジェクト作成
コマンドパレットから CMake: Configure を実行してください</br>

## Build & Write 方法
tasks.json の Build RP2040 コマンド実行します。</br>
USBドライブとして認識させたときは、Pico Build and Write か、Pico USB Memory uf2 Write コマンド実行します。</br>
この時、WIndows の設定で、USB接続時のエクスプローラを開く動作を OFF にしておくと、操作を奪われるのを防げます。</br>
SWD を接続している場合は、Pico SWD Flash Write を実行します。</br>
**なお、通常の開発時は SWD デバッグ方法で動作確認を行ってください。**


## SWD デバッグ方法
外部フラッシュは書き込み上限があるので、なるべく RAM 書き込みデバッグを使用して開発を進めた方が良いです。</br>
F5 キーでデバッグを実行できます。</br>
なお、通常の openocd では XIAO RP2040 に搭載しているフラッシュへ書き込みはできないため、</br>
ディレクトリ直下の openocd/openocd.exe を使用してください。</br>

## ディレクトリ・ツリー
src - ソースコード</br>
CMakeLists - Makefile</br>
pico_sdk_import - 公式からダウンロード</br>
pico_extras_import_optional.cmake - 公式からダウンロード</br>
build - elf, uf2 ファイル</br>
openocd - SWD 経由でのデバッグと Flash 書き込み</br>

## コーディング規則
[Linux kernel](https://www.kernel.org/doc/html/v4.10/process/coding-style.html)
[Google C++ コーディングガイドl](https://ttsuki.github.io/styleguide/cppguide.ja.html#Inline_Functions)