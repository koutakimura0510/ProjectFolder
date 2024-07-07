- [概要](#概要)
- [src](#src)
- [sch](#sch)
- [Makefile](#makefile)

## 概要
## Build & Write 方法
コマンドパレットから CMake: Configure を実行
tasks.json の Build RP2040 コマンド実行
USBドライブとして認識させたときは、Build and Write か、uf2 Write コマンド実行
この時、WIndows の設定で、USB接続時のエクスプローラを開く動作を OFF にしておくと、操作がフォルダに移動するのを防げる。

## ディレクトリ・ツリー
src - ソースコード
CMakeLists - Makefile
pico_sdk_import - 公式からダウンロード
pico_extras_import_optional.cmake - 公式からダウンロード

## コーディング規則
[Linux kernel](https://www.kernel.org/doc/html/v4.10/process/coding-style.html)
[Google C++ コーディングガイドl](https://ttsuki.github.io/styleguide/cppguide.ja.html#Inline_Functions)