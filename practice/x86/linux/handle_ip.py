from pwn import *

if len(sys.argv) < 3:
    print('Usage: handle_ip <IP> <PORT>')
    exit()

key = b'\xff'*4
ip = socket.inet_aton(sys.argv[1])
port = p16(int(sys.argv[2]),endian='big')
ip = bytes(a^b for a,b in zip(key,ip))

print(hex(u32(ip)))
print(hex(u16(port)))
