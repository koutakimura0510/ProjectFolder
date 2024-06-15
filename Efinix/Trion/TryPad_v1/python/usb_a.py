"""
Create 	2024-06-04
Ver 	Python 3.14.2, VSCode 1.81.0
Author 	Kouta Kimura
Borad	TRYPAD V1.0

TRYPAD 搭載の XIAO RP2040 と USB 通信を行い、ボード搭載の SPIROM に対して R/W や、
FPGA レジスタ対して R/W を行うための PC ホスト側の Python コード

"""

# coding: UTF-8

#-------------------------------------------------------------------------------
# import 宣言
#-------------------------------------------------------------------------------
import serial
import time
import serial.tools.list_ports

# PORT = 'COM14'
BAUD = 115200

ports = list(serial.tools.list_ports.comports())
for p in ports:
    print(p)
    print(" device       :", p.device)
    print(" name         :", p.name)
    print(" description  :", p.description)
    print(" hwid         :", p.hwid)
    print(" vid          :", p.vid)
    print(" pid          :", p.pid)
    print(" serial_number:", p.serial_number)
    print(" location     :", p.location)
    print(" manufactuer  :", p.manufacturer)
    print(" product      :", p.product)
    print(" interface    :", p.interface)
    print("")

ser = serial.Serial(p.device, baudrate=BAUD, timeout=1)
# ser.open()
d = 0

try:
    while True:
        d = d + 1
        send_bytes = bytes('0x{:08x}'.format(d) + '\r\n', 'utf-8')
        ser.write(send_bytes)
        ser.flush()
        # buf = ser.readlines()
        # buf = [i.decode().strip() for i in buf]
        receive_bytes = ser.readall()
        print(receive_bytes)
        # ser.close()
        # time.sleep(1)

except KeyboardInterrupt:
    ser.close()
    print('stop')
    pass

# def main():

# if __name__ == "__main__":
# 	main()