# 2024-08-12
# Author kimura
# Trypad v1 シリアル通信制御 プログラム
import os
import struct
import serial
import serial.tools.list_ports
import threading
import time
import signal
import sys
from tkinter import Tk
from tkinter.filedialog import askopenfilename

#-------------------------------------------------------------------------------
# データを送信
#-------------------------------------------------------------------------------
def serial_write():
    global Serial_Port
    global cmd_input
    
    while(1):
        if Serial_Port !='':
            # data=input()+'\r\n'
            # data=data.encode('utf-8')
            cmd_input=input('5:End  4:Rom Write  3:Rom Read  2:Reg File  1:Reg Read:  0:Reg Write: ')
            if cmd_input  == '0':
                try:
                    hex_input=input('[W] Adrs+Data (exa: 00 06 00 57, 00 00 00 00): ')
                    hex_input_cleaned = hex_input.replace(' ', '').replace(',', '') # スペースとカンマを削除してからバイト列に変換
                    data=bytes.fromhex(hex_input_cleaned)
                    send_data = bytes([0x88]) + data
                    Serial_Port.write(send_data)
                except:
                    print(f'数値が不正です\n')
                    pass
            elif cmd_input  == '1':
                try:
                    hex_input=input('[R] Adrs (exa: 00 06 00 57): ')
                    hex_input_cleaned = hex_input.replace(' ', '').replace(',', '') # スペースとカンマを削除してからバイト列に変換
                    data=bytes.fromhex(hex_input_cleaned)
                    send_data = bytes([0xef]) + data
                    Serial_Port.write(send_data)
                except:
                    print(f'数値が不正です\n')
                    pass
            elif cmd_input  == '2':
                send_file_data()
                # print(f'未対応です\n')
            elif cmd_input  == '3':
                try:
                    hex_input=input('[R] RomId(1byte) + ColAdrs(2byte) + PageAdrs(2byte) (exa: 00, 00,00, 00,01): ')
                    hex_input_cleaned = hex_input.replace(' ', '').replace(',', '') # スペースとカンマを削除してからバイト列に変換
                    data=bytes.fromhex(hex_input_cleaned)
                    send_data = bytes([0x99]) + data
                    Serial_Port.write(send_data)
                except:
                    print(f'数値が不正です\n')
                    pass
            elif cmd_input  == '4':
                send_file_binary()
                pass
            elif cmd_input  == '5':
                print("\thread 0 end")
                if Serial_Port and Serial_Port.is_open:
                    Serial_Port.close()
                sys.exit(0)
            else:
                print(f'数値が不正です\n')

            time.sleep(0.20)  # 20ms待機してから再チェック

#-------------------------------------------------------------------------------
# シリアルからデータを受信
#-------------------------------------------------------------------------------
def serial_verify_read(expected_length):
    global Serial_Port
    # 受信データが期待される長さに満たない場合、すべてのデータを読み取る
    received_data = bytearray()
    while len(received_data) < expected_length:
        if Serial_Port.in_waiting > 0:
            chunk = Serial_Port.read(expected_length - len(received_data))
            received_data.extend(chunk)
    return received_data

def serial_read():
    global Serial_Port
    
    if Serial_Port.in_waiting >= 4:
        rd = Serial_Port.read(4)
        return int.from_bytes(rd, byteorder='big') 
    
    return 0

def serial_thread_read():
    global Serial_Port
    global cmd_input
    
    while(1):
        if Serial_Port !='':
            if cmd_input == '3':
                if Serial_Port.in_waiting >= 16:
                    rd = Serial_Port.read(16)
                    print(f'0x{rd.hex()}')
            elif cmd_input == '0':
                if Serial_Port.in_waiting >= 4:
                    rd = Serial_Port.read(4)
                    print(f'0x{rd.hex()}')
            elif cmd_input == '1':
                if Serial_Port.in_waiting >= 4:
                    rd = Serial_Port.read(4)
                    print(f'0x{rd.hex()}')
            elif cmd_input  == '5':
                print("\nthread 1 end")
                sys.exit(0)

#-------------------------------------------------------------------------------
# シグナルハンドラー
#-------------------------------------------------------------------------------
def signal_handler(sig, frame):
    global Serial_Port
    print("\nCtrl+C detected! Closing serial port and exiting...")
    if Serial_Port and Serial_Port.is_open:
        Serial_Port.close()
    sys.exit(0)

#-------------------------------------------------------------------------------
# シリアルポートをOpen
#-------------------------------------------------------------------------------
def serial_open():
    global Serial_Port
    
    #portリストを取得
    serial_ports={}
    for i,port in enumerate(serial.tools.list_ports.comports()):
        serial_ports[str(i)]=port.device
    
    #RaspberryPiのminiUART検出できないので、/dev/ttyAMA0があれば自動的に/dev/ttyS0を追加
    if '/dev/ttyAMA0' in serial_ports.values():
        serial_ports[str(len(serial_ports))]='/dev/ttyS0'

    port_val = serial_ports[ input(f'ポート番号を選んでください。{serial_ports}:') ]
    # boud_val = int(input('ボーレートbpsを数値で入力してください。:'))
    boud_val = int(921600)
    # prty_val = input(f'パリティーを選んでください。[N:None, O:Odd, E:Even]:')
    prty_val = 'N'
    
    Serial_Port=serial.Serial(port=port_val, baudrate=boud_val, parity= prty_val)
    print(f'open{port_val}/{boud_val}bps/parity:{prty_val}')

#-------------------------------------------------------------------------------
# ファイルから16進数データを送信
#-------------------------------------------------------------------------------
def send_file_data():
    global Serial_Port
    last_file_path = None

    if not Serial_Port:
        print("シリアルポートが開かれていません。")
        return

    root = Tk() # ファイル選択ダイアログを表示
    screen_width = root.winfo_screenwidth() # ウィンドウを画面の指定位置に移動する
    screen_height = root.winfo_screenheight() # ここでは、画面の中央に表示するためのコード例です
    window_width = 300  # ウィンドウの幅
    window_height = 200  # ウィンドウの高さ
    position_top = int(screen_height / 2 - window_height / 2)
    position_right = int(screen_width / 2 - window_width / 2)
    root.geometry(f'{window_width}x{window_height}+{position_right}+{position_top}')
    root.attributes('-topmost', True)   # ウィンドウを最前面にするために、`top` 属性を設定
    root.withdraw()

    try:
        with open("filepath.log", 'r', encoding='utf-8') as file: #次アプリ起動時にファイルを選択状態にするためにログ出力
            last_file_path = file.read()
    except:
        pass

    file_path = askopenfilename(
        parent=root,
        title="送信するファイルを選択してください",
        initialfile=last_file_path
    )

    if not file_path:
        print("ファイルが選択されませんでした。")
        return

    with open("filepath.log", 'w', encoding='utf-8') as file: #次アプリ起動時にファイルを選択状態にするためにログ出力
        file.write(file_path)

    last_file_path = file_path  # パスを一時保存し、次にも実行可能にしておく(マウス操作削減)

    with open(file_path, 'r', encoding='utf-8') as file:
        in_comment_block = False
        for line in file:
            line = line.strip()
            
            # コメントブロックの開始と終了を処理
            if line.startswith('/**'):
                in_comment_block = True
                continue
            elif line.endswith('*/'):
                in_comment_block = False
                continue
            elif in_comment_block:
                continue
            
            # コメント行をスキップ
            if line.startswith('//') or line.startswith('#') or not line:
                continue

            if line.startswith('wt'):
                # 'wt' で始まる行は待機時間
                try:
                    wait_time = int(line[2:])
                    # print(f'Waiting for {wait_time} ms...')
                    time.sleep(wait_time/1000)  # ms order
                except ValueError:
                    print(f'Invalid wait time: {line}')
            else:
                # データ行
                try:
                    hex_data = [data.strip() for data in line.split(',')] # カンマで区切られたデータを処理し、各データの前後のスペースを削除
                    data = bytes.fromhex(''.join(hex_data)) # カンマ区切りのデータをバイト列に変換
                    final_data = bytes([0x88]) + data
                    Serial_Port.write(final_data)
                    # print(f'Sent: {final_data.hex()}')
                except ValueError:
                    print(f'Invalid data: {line}')

#-------------------------------------------------------------------------------
# ファイルからバイナリデータを送信
#-------------------------------------------------------------------------------
def send_file_binary(chunk_size=128):
    global Serial_Port
    last_file_path = None

    root = Tk() # ファイル選択ダイアログを表示
    screen_width = root.winfo_screenwidth() # ウィンドウを画面の指定位置に移動する
    screen_height = root.winfo_screenheight() # ここでは、画面の中央に表示するためのコード例です
    window_width = 300  # ウィンドウの幅
    window_height = 200  # ウィンドウの高さ
    position_top = int(screen_height / 2 - window_height / 2)
    position_right = int(screen_width / 2 - window_width / 2)
    root.geometry(f'{window_width}x{window_height}+{position_right}+{position_top}')
    root.attributes('-topmost', True)   # ウィンドウを最前面にするために、`top` 属性を設定
    root.withdraw()

    try:
        with open("filebin.log", 'r', encoding='utf-8') as file: #次アプリ起動時にファイルを選択状態にするためにログ出力
            last_file_path = file.read()
    except:
        pass

    file_path = askopenfilename(
        parent = root,
        title = "送信するファイルを選択してください",
        initialfile = last_file_path
    )

    if not file_path:
        print("ファイルが選択されませんでした。")
        return

    with open("filebin.log", 'w', encoding='utf-8') as file: #次アプリ起動時にファイルを選択状態にするためにログ出力
        file.write(file_path)

    last_file_path = file_path  # パスを一時保存し、次にも実行可能にしておく(マウス操作削減)

    try:
        # 0x55 コマンドとアドレス、データサイズを含むヘッダーを送信
        command = 0x55
        rom_id = 0x00
        address = 0x00000000  # 初期アドレス（必要に応じて変更）
        file_size = os.path.getsize(file_path)	# ファイルサイズを取得
        erase_cmd = 0x00
        print("command", command)
        print("rom id", rom_id)
        print("address", address)
        print("file_size", file_size)
        print("erase_cmd", erase_cmd)
        header = struct.pack('<BBIIB', command, rom_id, address, file_size, erase_cmd) #B:1byte, I:4byte
        Serial_Port.write(header)
        ack_wait()
        print("Ack OK")
        
        with open(file_path, 'rb') as file:
            total = 0
            start_time = time.time()
            try:
                while True:
                    chunk = file.read(chunk_size)
                    if not chunk:
                        print(f'not chunk')
                        break
                    
                    if len(chunk) < 256:  # chunkが256バイトより少ない場合、0でパディングする
                        chunk = chunk.ljust(256, b'\x00')
                        # print(f'Chunk Padding')
                    Serial_Port.write(chunk)
                    total = total + 256
                    if time.time() - start_time >= 1:
                        start_time = time.time()
                        print(f'Sent {len(chunk)}')
                        print(f'Total Sent', total)
                        
                    if file_size <= total:
                        break
                    else:
                        ack_wait()
            except KeyboardInterrupt:
                pass
        print("File transfer completed.")

        # # verify
        # command = 0x55
        # rom_id = 0x00
        # address = 0x00000000  # 初期アドレス（必要に応じて変更）
        # file_size = os.path.getsize(file_path)	# ファイルサイズを取得
        # erase_cmd = 0x00
        # header = struct.pack('<BBIIB', command, rom_id, address, file_size, erase_cmd) #B:1byte, I:4byte
        # Serial_Port.write(header)

        # with open(file_path, 'rb') as file:
        #     while True:
        #         chunk = file.read(chunk_size)
        #         if not chunk:
        #             break
                
        #         if len(chunk) < 256:  # chunkが256バイトより少ない場合、0でパディングする
        #             chunk = chunk.ljust(256, b'\x00')
        #             print(f'Chunk Padding')

        #         received_data = serial_verify_read(len(chunk))
        #         if received_data == chunk:
        #             print('Received data matches sent data.')
        #         else:
        #             print('Data mismatch detected.')
        #             break
        # print("File Verify completed.")

    except Exception as e:
        print(f"An error occurred: {e}")
    except KeyboardInterrupt:
        print(f"end: {e}")

# シリアル wait
def ack_wait():
    try:
        while True:
            rd = serial_read()
            if rd & 0x01:
                break
    except:
        pass


#-------------------------------------------------------------------------------
# main
#-------------------------------------------------------------------------------
if __name__ == '__main__':
    # シグナルハンドラーの設定
    signal.signal(signal.SIGINT, signal_handler)

    Serial_Port=''
    cmd_input=''
    
    #port open
    serial_open()
    
    thread_1 = threading.Thread(target=serial_write)
    thread_2 = threading.Thread(target=serial_thread_read)
    # thread_3 = threading.Thread(target=send_file_data)

    thread_1.start()
    thread_2.start()
    # thread_3.start()

    thread_1.join()
    thread_2.join()
    # thread_3.join()