# push :ラズパイにデータを送信
# pull :ラズパイのデータを取得
# pass :raspberry

update:
	sudo apt update #システムパッケージを管理しているリストの更新
	sudo apt full-upgrade -y	#インストールされているパッケージの最新バージョンに更新
	sudo apt autoremove -y
	sudo apt clean		#sdカードの不要なファイル削除
	sudo rpi-update		#十分にテストされていない場合があるため、確証済みのときのみ実行すること

config:
	sudo raspi-config

push:
	scp -r C_work pi@192.168.10.7:/home/pi/workspace/ProjectFolder/RaspberryPi/

pull:
	scp -r pi@192.168.10.7:/home/pi/workspace/ProjectFolder/RaspberryPi/C_work ./ 

install:
	sudo apt install sox
	sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-ttf-dev -libsdl2-mixer-dev libsdl2-net-dev
	sudo apt install gcc
	sudo apt install vim
