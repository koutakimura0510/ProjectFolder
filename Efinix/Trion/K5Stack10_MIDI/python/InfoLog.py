# ------------------------------------------------------------------------------
# 2023-05-29
# Python 3.10.4
# Kimura
#
# Efinity 合成時に出力される Log ファイルから、Error/Warning/Info の項目で別ファイルに出力するプログラム
# 経緯として、Efinity Log 出力は、前回のファイルの最終行から追記される形で出力される。(何故このような仕様なのかは不明)
# そのため、何度か合成を行うとファイルサイズがドンドンと増加していく。
# デバッグがとてもやりにくいため、確認したい行を抽出し、参照元の Log は毎回削除することとした。
#
# v1.00 new relaese
# v1.01 ファイル関数を共通化
# ------------------------------------------------------------------------------
# coding: UTF-8


#-------------------------------------------------------------------------------
# import 宣言
#-------------------------------------------------------------------------------
import os

#-------------------------------------------------------------------------------
# 標準出力 関数
#-------------------------------------------------------------------------------
BLACK     = '\033[30m'
RED       = '\033[31m'
GREEN     = '\033[32m'
YELLOW    = '\033[33m'
BLUE      = '\033[34m'
PURPLE    = '\033[35m'
CYAN      = '\033[36m'
WHITE     = '\033[37m'
END       = '\033[0m'

def paint(color, str):
    return color + str + END

#-------------------------------------------------------------------------------
# Efinity が生成する log ファイル削除
#-------------------------------------------------------------------------------
def file_remove(file):
	try:
		os.remove(file)
	except FileNotFoundError as err:
		print(err)
		
#-------------------------------------------------------------------------------
# Efinity が生成する log を読み込み、Info,Warning,Err に分けて出力する
#-------------------------------------------------------------------------------
def file_export(rf, wf, exce, color):
	with open(wf, "w") as fw:
		try:
			with open(rf, "r") as f:
				try:
					for line in f:
						if exce in line:
							fw.write(line.rstrip("\n")+"\n")
							print(paint(color, line))
				except FileNotFoundError as err:
					print(err)
		except FileNotFoundError as err:
			print(err)
	file_remove(rf)

#-------------------------------------------------------------------------------
# F5 の場合は python 実行ファイルではなく、フォルダからのパスアクセスになるため注意
#-------------------------------------------------------------------------------
# import file
r_log_err = "./outflow/K5Stack10_MIDI.err.log"
r_log_War = "./outflow/K5Stack10_MIDI.warn.log"
r_log_inf = "./outflow/K5Stack10_MIDI.info.log"
# export file
w_log_err = "./outflow/Info_Error.log"
w_log_war = "./outflow/Info_Warning.log"
w_log_inf = "./outflow/Info_Info.log"

file_export(r_log_inf, w_log_inf, "INFO",	CYAN)
file_export(r_log_War, w_log_war, "WARNING",GREEN)
file_export(r_log_err, w_log_err, "ERROR",	YELLOW)
file_remove("./outflow/EFX.err.log")
file_remove("./outflow/EFX.info.log")
file_remove("./outflow/EFX.warn.log")