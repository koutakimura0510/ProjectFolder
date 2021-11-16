# 【Ubuntuエラー処理まとめ】
Linuxを操作していてエラー処理に詰まった内容を残しておく。</br>
記述の仕方は下記の通りである。</br>

1.エラー内容</br>
2.どういった操作をして起きたエラーか記入</br>
3.解決策</br>

---

## 「sudo apt update」

: http://ppa.launchpad.net/js-reynaud/kicad-5.1/ubuntu/dists/focal/InRelease の取得に失敗しました  403  Forbidden [IP: 91.189.95.85 80]</br>
E: リポジトリ http://ppa.launchpad.net/js-reynaud/kicad-5.1/ubuntu focal InRelease は署名されていません。</br>
N: このようなリポジトリから更新を安全に行うことができないので、デフォルトでは更新が無効になっています。</br>
N: リポジトリの作成とユーザ設定の詳細は、apt-secure(8) man ページを参照してください。</br>
</br>
update時に下記のエラーが出た。</br>
</br>
解決の参考URL -> https://hombre-nuevo.com/linux/linux0020/</br>
/etc/apt/source.listをダブルクリックして開く。</br>
アップデート項目にてエラーが出ている箇所のチェックを外す、もしくは削除する。</br>
</br>

**fix：**</br>