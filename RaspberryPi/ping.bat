for /l %%i in (0,1,255) do ping -w 1 -n 1 192.168.0.%%i
arp -a | findstr "b8-27"
arp -a | findstr "dc-a6"