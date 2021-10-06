# 【wrapperディレクトリ】

ファイル名 | 機能
-|-
macro | Zynqシステムとファイル生成アプリケーションでマクロ定数を管理
battle_conf.h | バトルに関する構造体の作業領域を管理
cmd_wrapper.h | コマンドに関する構造体の作業領域を管理
conf_wrapper.h | マップ情報や所持アイテムなど設定情報に関する構造体の作業領域を管理
enemy_wrapper.h | バトル時の戦闘を行うエネミーデータに関する構造体の作業領域を管理
game_wrapper.h | システムで共有する関数と作業領域を管理するラッパー構造体を管理
hero_wrapper.h | 仲間キャラクターに関する構造体の作業領域を管理
mapchip_wrapper.h | FPGAの操作に関する構造体の作業領域を管理
npc_wrapper.h | NPCの描画設定に関する構造体の作業領域を管理
sdl_wrapper.h | ローカル変数として使用するSDL構造体を管理
unit_wrapper.h | ワールドマップで動作中のプレイヤーの描画データの作業領域を管理
main.c | メイン関数