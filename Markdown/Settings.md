# 【設定内容まとめ】
Linuxを操作していて設定で調べた内容を残しておく。</br>
記述の仕方は下記の通りである。</br>

1.どういった操作で詰まったかの説明</br>
2.解決策</br>
</br>

---

## 「VSCode Platformio プロジェクト先変更」
vscodeでplatformioのプロジェクトを作成する時、デフォルトでは下記のパスに作成される。</br>
**`「/home/UserName/Documents/PlatformIo/Projects/project_name」`**</br>
workspaceのディレクトリは統一したかったため、デフォルトの設定を変更したかったため方法を調べた。</br>
</br>
- vscode上でCtrl + shift + PにてPlatformIOと検索すると履歴に「New Terminal」が存在するので実行する。
- pioのターミナル上でコマンドを実行する **pio settings set projects_dir 新規プロジェクト作成の絶対パス**
</br>
</br>
## 「Ubuntu GPU認識」
デフォルトの設定ではCPUのグラフィックを使用していたためGPUを認識させて切り替えたかった。</br>
下記の順番でコマンドを実行して認識させた。</br>
- lspci | grep -i nvidia
- sudo add-apt-repository ppa:graphics-drivers/ppa
- sudo apt update
- sudo ubuntu-drivers autoinstall
- sudo reboot 
- nvidia-smi