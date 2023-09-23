# 2023-09-23
#
#   U        A
# L   R    B   C
#   D        D

from machine import Pin

SW_A = Pin(4, Pin.IN)
SW_B = Pin(6, Pin.IN)
SW_Y = Pin(5, Pin.IN)
SW_X = Pin(7, Pin.IN)
SW_U = Pin(21, Pin.IN)
SW_L = Pin(20, Pin.IN)
SW_R = Pin(19, Pin.IN)
SW_D = Pin(18, Pin.IN)

# ------------------------------------------------------------------------------
# Push Sw の値取得
# pin name : A,B,C,D,U,L,R,D の Push SW 文字コード
# ------------------------------------------------------------------------------
def get_sw():
    a = SW_A.value()
    b = SW_B.value()
    y = SW_Y.value()
    x = SW_X.value()
    u = SW_U.value()
    l = SW_L.value()
    r = SW_R.value()
    d = SW_D.value()

    result = (a << 7) | (b << 6) | (y << 5) | (x << 4) | (u << 3) | (l << 2) | (r << 1) | d
    return result