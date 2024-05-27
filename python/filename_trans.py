# -*- coding: utf-8 -*-
import os

def remove_spaces_and_brackets(folder_path):
    # フォルダ内のファイルを走査する
    for filename in os.listdir(folder_path):
        # ファイルのフルパスを作成
        full_path = os.path.join(folder_path, filename)
        
        # 新しいファイル名を作成する
        new_filename = filename.replace(' ', '').replace('(', '').replace(')', '')
        
        # 古いファイル名と新しいファイル名が異なる場合にのみ変更する
        if new_filename != filename:
            try:
                # ファイル名を変更する
                os.rename(full_path, os.path.join(folder_path, new_filename))
                print(f"{filename} を {new_filename} に変更しました。")
            except Exception as e:
                print(f"エラーが発生しました: {e}")

if __name__ == "__main__":
	folder_path = "D:/Game/Character/minoriko/PNG/"
	remove_spaces_and_brackets(folder_path)